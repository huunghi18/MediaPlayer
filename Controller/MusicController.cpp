#include "MusicController.h"

MusicController::MusicController(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer;
    m_playlistAudio = new QMediaPlaylist;
    m_playlistVideo = new QMediaPlaylist;
    m_audioPlaylistModel = new AudioPlaylistModel;
    m_videoPlaylistModel = new VideoPlaylistModel;
    m_audioMetadata = new AudioMetaData;
    m_audioProxy = new QSortFilterProxyModel;
    m_videoProxy = new QSortFilterProxyModel;

    getAllAudioFiles();
    getAllVideoFiles();
    connect(m_player, &QMediaPlayer::positionChanged, this, &MusicController::positionChanged);
    connect(m_player, &QMediaPlayer::durationChanged, this, &MusicController::durationChanged);
    connect(m_player, &QMediaPlayer::volumeChanged, this, &MusicController::volumeChanged);
    //    connect(m_player,&QMediaPlayer::mediaStatusChanged,this, &MusicController::handleMediaStatusChanged);
    connect(m_playlistAudio, &QMediaPlaylist::currentIndexChanged, this, &MusicController::handleAudioIndexChanged);
    connect(m_playlistVideo, &QMediaPlaylist::currentIndexChanged, this, &MusicController::handleVideoIndexChanged);
    connect(this,&MusicController::signalRemove,this,&MusicController::slotRemove);
    m_player->setVolume(50);
    //    m_player->setPlaylist(m_playlistVideo);
    m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
    m_playlistVideo->setPlaybackMode(QMediaPlaylist::Loop);
    m_player->setPlaybackRate(1);
    m_audioProxy->setSourceModel(m_audioPlaylistModel);
    m_videoProxy->setSourceModel(m_videoPlaylistModel);

}

MusicController::~MusicController()
{
    delete m_player;
    delete m_playlistAudio ;
    delete m_playlistVideo ;
    delete m_audioPlaylistModel ;
    delete m_videoPlaylistModel ;
}

void MusicController::getAllAudioFiles()
{
    m_audioPlaylistModel->getAudioFiles();

    m_playlistAudio->addMedia(m_audioPlaylistModel->getContent());
}
void MusicController::getAllVideoFiles()
{
    m_videoPlaylistModel->getVideoFiles();
    m_playlistVideo->addMedia(m_videoPlaylistModel->getContent());
}
void MusicController::openAudioFolder()
{
    m_audioPlaylistModel->openAudioFiles();
    m_playlistAudio->addMedia(m_audioPlaylistModel->getNewContent());
    m_player->setPlaylist(m_playlistAudio);
}
void MusicController::openVideoFolder()
{
    m_videoPlaylistModel->openVideoFiles();
    m_playlistVideo->addMedia(m_videoPlaylistModel->getNewContent());
    m_player->setPlaylist(m_playlistVideo);
}
void MusicController::playAudio(int index)
{
    m_playlistAudio->setCurrentIndex(index);

    m_player->play();
}
void MusicController::playVideo(int index)
{
    m_playlistVideo->setCurrentIndex(index);
    m_player->play();
}

bool MusicController::setShuffle()
{
    m_isShuffle = !m_isShuffle;
    if(m_isShuffle)
    {
        m_playlistAudio->setPlaybackMode(QMediaPlaylist::Random);
        m_playlistVideo->setPlaybackMode(QMediaPlaylist::Random);
        return true;
    }
    else
    {
        m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
        m_playlistVideo->setPlaybackMode(QMediaPlaylist::Loop);
        return false;
    }
}

bool MusicController::setRepeat()
{
    {
        m_isReapeat = !m_isReapeat;
        if(m_isReapeat)
        {
            m_playlistAudio->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
            m_playlistVideo->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
            return true;
        }
        else
        {
            m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
            m_playlistVideo->setPlaybackMode(QMediaPlaylist::Loop);
            return false;
        }
    }
}

void MusicController::sortAudioByName()
{
    m_audioProxy->setSortRole(AudioPlaylistModel::AudioRoles::NameRole);
    m_audioProxy->sort(0, Qt::AscendingOrder);
//    m_player->setPlaylist(m_playlistAudio);
}

void MusicController::sortAudioByArtist()
{
    m_audioProxy->setSortRole(AudioPlaylistModel::AudioRoles::ArtistRole);
    m_audioProxy->sort(0, Qt::AscendingOrder);
    //    m_player->setPlaylist(m_playlistAudio);
}

void MusicController::sortAudioByAlbum()
{
    m_audioProxy->setSortRole(AudioPlaylistModel::AudioRoles::AlbumRole);
    m_audioProxy->sort(0, Qt::AscendingOrder);
}

void MusicController::searchAudio(QString text)
{
    m_audioProxy->setFilterRole(AudioPlaylistModel::AudioRoles::NameRole);
    m_audioProxy->setFilterFixedString(text);
    m_audioProxy->filterRole();
}
void MusicController::searchVideo(QString text)
{
    m_videoProxy->setFilterRole(VideoPlaylistModel::VideoRoles::NameRole);
    m_videoProxy->setFilterFixedString(text);
    m_videoProxy->filterRole();
}
void MusicController::resume()
{
    m_player->play();
}
void MusicController::pause()
{
    m_player -> pause();
}

void MusicController::next()
{
    m_playlistAudio->next();
    m_playlistVideo->next();
}

void MusicController::previous()
{
    m_playlistAudio->previous();
    m_playlistVideo->previous();
}

void MusicController::seekToNext()
{
    m_player->setPosition(m_player->position()+5000);
}

void MusicController::seekToPrevious()
{
    m_player->setPosition(m_player->position()-5000);
}

void MusicController::setPlaybackRate()
{
    if(m_player->playbackRate() == 1) {
        m_player->setPlaybackRate(1.5);
    }
    else if(m_player->playbackRate() == 1.5) {
        m_player->setPlaybackRate(0.5);
    }
    else if(m_player->playbackRate() == 0.5) {
        m_player->setPlaybackRate(1);
    }
}

void MusicController::setAudioPlaylist()
{
    m_player->setPlaylist(m_playlistAudio);
}
void MusicController::setVideoPlaylist()
{
    m_player->setPlaylist(m_playlistVideo);
}

void MusicController::removeAudio(int index)
{
    if(0 <= index && index <= m_playlistAudio->mediaCount() -1) {
        m_playlistAudio->removeMedia(index);
        m_audioPlaylistModel->removeAudio(index);
        emit signalRemove(index);
    }
}

void MusicController::removeVideo(int index)
{
    if(0 <= index && index <= m_playlistVideo->mediaCount() -1) {
        m_playlistVideo->removeMedia(index);
        m_videoPlaylistModel->removeVideo(index);
    }
}

void MusicController::removeAllAudio()
{
    m_playlistAudio->clear();
    m_audioPlaylistModel->removeAllAudio();

}

void MusicController::removeAllVideo()
{
    m_playlistVideo->clear();
    m_videoPlaylistModel->removeAllVideo();
}

void MusicController::setSource(QString source)
{
    m_currentCoverArt = m_audioPlaylistModel->imageForTag(source);
}

QString MusicController::songCoverArt()
{
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);

    m_currentCoverArt.save(&buffer, "png");

    QString base64 = buffer.data().toBase64();
    if(base64==""){
        return"qrc:/image/coverArt.webp";
    }
    QString ret = QString("data:image/png;base64,") + base64;
    qDebug()<<__LINE__<<ret.size()<<"ret.size()";
    return ret;
}

QStringList MusicController::listAudioPath() const
{
    return m_listAudioPath;
}
void MusicController::setListAudioPath(const QStringList &newListAudioPath)
{
    if (m_listAudioPath == newListAudioPath)
        return;
    m_listAudioPath = newListAudioPath;
    emit listAudioPathChanged();
}

qint64 MusicController::duration() const
{
    return m_player->duration();
}

qint64 MusicController::position() const
{
    return m_player->position();
}

void MusicController::setPosition(qint64 position)
{
    if (m_position == position)
        return;
    m_position = position;
    emit positionChanged(position);
    m_player->setPosition(position);
}

int MusicController::volume() const
{
    return m_player->volume();
}

void MusicController::setVolume(int volume)
{
    if (m_volume == volume)
        return;
    m_volume = volume;
    emit volumeChanged(volume);
    m_player->setVolume(volume);
}

QStringList MusicController::listAudioSong() const
{
    return m_listAudioSong;
}

void MusicController::setListAudioSong(const QStringList &newListAudioSong)
{
    if (m_listAudioSong == newListAudioSong)
        return;
    m_listAudioSong = newListAudioSong;
    emit listAudioSongChanged();
}

QStringList MusicController::listVideoSong() const
{
    return m_listVideoSong;
}

void MusicController::setListVideoSong(const QStringList &newListVideoSong)
{
    if (m_listVideoSong == newListVideoSong)
        return;
    m_listVideoSong = newListVideoSong;
    emit listVideoSongChanged();
}

QAbstractVideoSurface *MusicController::videoSurface() const
{
    return m_videoSurface;
}

void MusicController::setVideoSurface(QAbstractVideoSurface *newVideoSurface)
{
    if (m_videoSurface == newVideoSurface)
        return;
    m_videoSurface = newVideoSurface;
    m_player->setVideoOutput(m_videoSurface);
    emit videoSurfaceChanged();
}


AudioPlaylistModel *MusicController::audioPlaylistModel() const
{
    return m_audioPlaylistModel;
}

void MusicController::setAudioPlaylistModel(AudioPlaylistModel *newAudioPlaylistModel)
{
    if (m_audioPlaylistModel == newAudioPlaylistModel)
        return;
    m_audioPlaylistModel = newAudioPlaylistModel;
    emit audioPlaylistModelChanged();
}

VideoPlaylistModel *MusicController::videoPlaylistModel() const
{
    return m_videoPlaylistModel;
}

void MusicController::setVideoPlaylistModel(VideoPlaylistModel *newVideoPlaylistModel)
{
    if (m_videoPlaylistModel == newVideoPlaylistModel)
        return;
    m_videoPlaylistModel = newVideoPlaylistModel;
    emit videoPlaylistModelChanged();
}

QString MusicController::audioName(int index)
{
    QModelIndex model = m_audioPlaylistModel->index(index,0);
    QVariant data = m_audioPlaylistModel->data(model, m_audioPlaylistModel->AudioRoles::NameRole);
    QString m_name = data.toString();
    return m_name;
}

QString MusicController::audioArtist(int index)
{
    QModelIndex model = m_audioPlaylistModel->index(index,0);
    QVariant data = m_audioPlaylistModel->data(model, m_audioPlaylistModel->AudioRoles::ArtistRole);
    QString m_artist = data.toString();
    return m_artist;
}
QString MusicController::audioAlbum(int index)
{
    QModelIndex model = m_audioPlaylistModel->index(index,0);
    QVariant data = m_audioPlaylistModel->data(model, m_audioPlaylistModel->AudioRoles::AlbumRole);
    QString m_album = data.toString();
    return m_album;
}

QString MusicController::videoName(int index)
{
    QModelIndex model = m_videoPlaylistModel->index(index,0);
    QVariant data = m_videoPlaylistModel->data(model, m_videoPlaylistModel->VideoRoles::NameRole);
    QString m_name = data.toString();
    return m_name;
}

QString MusicController::videoArtist(int index)
{
    QModelIndex model = m_videoPlaylistModel->index(index,0);
    QVariant data = m_videoPlaylistModel->data(model, m_videoPlaylistModel->VideoRoles::ArtistRole);
    QString m_artist = data.toString();
    return m_artist;
}

QString MusicController::videoAlbum(int index)
{
    QModelIndex model = m_videoPlaylistModel->index(index,0);
    QVariant data = m_videoPlaylistModel->data(model, m_videoPlaylistModel->VideoRoles::AlbumRole);
    QString m_album = data.toString();
    return m_album;
}

int MusicController::audioIndex() const
{
    return m_audioIndex;
}

void MusicController::setAudioIndex(int newAudioIndex)
{
    if (m_audioIndex == newAudioIndex)
        return;
    if(newAudioIndex > m_playlistAudio->mediaCount() - 1) {
        m_audioIndex = newAudioIndex - m_playlistAudio->mediaCount();
    }
    else if(newAudioIndex < 0) {
        m_audioIndex = m_playlistAudio->mediaCount()-1 ;
    }
    else {
        m_audioIndex = newAudioIndex;
    }
    emit audioIndexChanged();
}

int MusicController::videoIndex() const
{
    return m_videoIndex;
}

void MusicController::setVideoIndex(int newVideoIndex)
{
    if (m_videoIndex == newVideoIndex)
        return;
    if(newVideoIndex > m_playlistVideo->mediaCount() - 1) {
        m_videoIndex = newVideoIndex - m_playlistVideo->mediaCount();
    }
    else if(newVideoIndex < 0) {
        m_videoIndex = m_playlistVideo->mediaCount()-1 ;
    }
    else {
        m_videoIndex = newVideoIndex;
    }
    emit videoIndexChanged();
}

QSortFilterProxyModel *MusicController::audioProxy() const
{
    return m_audioProxy;
}

void MusicController::setAudioProxy(QSortFilterProxyModel *newAudioProxy)
{
    if (m_audioProxy == newAudioProxy)
        return;
    m_audioProxy = newAudioProxy;
    emit audioProxyChanged();
}

//void MusicController::handleMediaStatusChanged(QMediaPlayer::MediaStatus status)
//{
//    if(status == QMediaPlayer::xEndOfMedia ) {
//        emit signalIndexChanged();
//    }
//}

void MusicController::handleAudioIndexChanged()
{
    setAudioIndex(m_playlistAudio->currentIndex());
    QModelIndex index = m_audioPlaylistModel->index(m_playlistAudio->currentIndex(),0);  // tao mot index trong model
            QVariant data = m_audioPlaylistModel->data(index,m_audioPlaylistModel->AudioRoles::SourceRole);
            QString source = data.toString();
            setSource(source);
}
void MusicController::handleVideoIndexChanged()
{
    setVideoIndex(m_playlistVideo->currentIndex());
}

void MusicController::slotRemove(int index)
{
    if(index == m_playlistAudio->currentIndex()) {
        m_player->stop();
    }
}


QSortFilterProxyModel *MusicController::videoProxy() const
{
    return m_videoProxy;
}

void MusicController::setVideoProxy(QSortFilterProxyModel *newVideoProxy)
{
    if (m_videoProxy == newVideoProxy)
        return;
    m_videoProxy = newVideoProxy;
    emit videoProxyChanged();
}
