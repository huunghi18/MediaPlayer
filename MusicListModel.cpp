#include "MusicListModel.h"


MusicListModel::MusicListModel(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer;
    m_playlistAudio = new QMediaPlaylist;
    m_playlistVideo = new QMediaPlaylist;
    getAllVideoFiles();
    getAllAudioFiles();
    connect(m_player, &QMediaPlayer::positionChanged, this, &MusicListModel::positionChanged);
    connect(m_player, &QMediaPlayer::durationChanged, this, &MusicListModel::durationChanged);
    connect(m_player, &QMediaPlayer::volumeChanged, this, &MusicListModel::volumeChanged);
    m_player->setVolume(50);
    //    m_player->setPlaylist(m_playlistVideo);
}

void MusicListModel::getAllAudioFiles()
{
    QDir m_musicPath;
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0));

    QDir directory(m_musicPath);

    m_listAudioSong = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files);

    QList<QMediaContent> content;

    for(const QString& f:m_listAudioSong)
    {
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        qDebug() <<(QUrl::fromLocalFile(directory.path()+"/" + f));
    }
    m_playlistAudio->addMedia(content);
}

void MusicListModel::getAllVideoFiles()
{
    QDir m_musicPath;
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0));
    QDir directory(m_musicPath);

    m_listVideoSong = directory.entryList(QStringList() << "*.mp4" << "*.MP4",QDir::Files);

    QList<QMediaContent> content;

    for(const QString& f:m_listVideoSong)
    {
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        qDebug() <<(QUrl::fromLocalFile(directory.path()+"/" + f));
    }
    m_playlistVideo->addMedia(content);
    m_playlistVideo->setPlaybackMode(QMediaPlaylist::Loop);
}

void MusicListModel::setAudioPath(QString audioName)
{
    QString audioFullPath = m_audioPath + "/" + audioName;
    m_player->setMedia(QUrl::fromLocalFile(audioFullPath));
}
void MusicListModel::openAudioFolder()
{
    QFileDialog dialog;
    m_listAudioPath = dialog.getOpenFileNames(
                nullptr, "Open File", "E:/Fpt_C++/QT/mediaPlayer2/video", "(*.mp3)");
    //    m_listAudioSong.append(m_listAudioPath);
    for(const QString& f:m_listAudioPath)
    {
        m_listAudioSong.append(f);
        m_playlistAudio->addMedia(QUrl::fromLocalFile(f));
    }
    m_player->setPlaylist(m_playlistAudio);

    //    qInfo() << "Selected file:" << m_listAudioPath;
}

void MusicListModel::playAudio(int index)
{
    //    videoWidget->show();
    m_playlistAudio->setCurrentIndex(index);
    m_player->play();
}
void MusicListModel::playVideo(int index)
{
    m_playlistVideo->setCurrentIndex(index);
    m_player->play();
}

bool MusicListModel::setShuffle()
{
    m_isShuffle = !m_isShuffle;
    if(m_isShuffle)
    {
        m_playlistAudio->setPlaybackMode(QMediaPlaylist::Random);
        return true;
    }
    else
    {
        m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
        return false;
    }
}

bool MusicListModel::setRepeat()
{
    {
        m_isReapeat = !m_isReapeat;
        if(m_isReapeat)
        {
            m_playlistAudio->setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
            return true;
        }
        else
        {
            m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
            return false;
        }
    }
}
void MusicListModel::resume()
{
    m_player->play();
}
void MusicListModel::pause()
{
    m_player -> pause();
}

void MusicListModel::next()
{
    m_playlistAudio->next();
    m_playlistVideo->next();
    //    emit nextSignal();
}

void MusicListModel::previous()
{
    m_playlistAudio->previous();
    m_playlistVideo->previous();

}

void MusicListModel::setCurrentIndex(int index)
{
    m_playlistAudio->setCurrentIndex(index);
    //    m_playlistVideo->setCurrentIndex(index);
}

int MusicListModel::getCurrentAudioIndex()
{
    return m_playlistAudio->currentIndex();
}
int MusicListModel::getCurrentVideoIndex()
{
    return m_playlistVideo->currentIndex();
}
//void MusicListModel::removeFromAudioPlaylist(int index)
//{
//    m_playlistAudio->removeMedia(index);
//    m_listAudioSong.removeAt(index);
//    //    emit audioListSizeChanged();
//}

void MusicListModel::setAudioPlaylist()
{
    m_player->setPlaylist(m_playlistAudio);
}
void MusicListModel::setVideoPlaylist()
{
    m_player->setPlaylist(m_playlistVideo);
}
QStringList MusicListModel::listAudioPath() const
{
    return m_listAudioPath;
}
void MusicListModel::setListAudioPath(const QStringList &newListAudioPath)
{
    if (m_listAudioPath == newListAudioPath)
        return;
    m_listAudioPath = newListAudioPath;
    emit listAudioPathChanged();
}

qint64 MusicListModel::duration() const
{
    return m_player->duration();
}

qint64 MusicListModel::position() const
{
    return m_player->position();
}

void MusicListModel::setPosition(qint64 position)
{
    if (m_position == position)
        return;
    m_position = position;
    emit positionChanged(position);
    m_player->setPosition(position);
}

int MusicListModel::volume() const
{
    return m_player->volume();
}

void MusicListModel::setVolume(int volume)
{
    if (m_volume == volume)
        return;
    m_volume = volume;
    emit volumeChanged(volume);
    m_player->setVolume(volume);
}

QStringList MusicListModel::listAudioSong() const
{
    return m_listAudioSong;
}

void MusicListModel::setListAudioSong(const QStringList &newListAudioSong)
{
    if (m_listAudioSong == newListAudioSong)
        return;
    m_listAudioSong = newListAudioSong;
    emit listAudioSongChanged();
}

QStringList MusicListModel::listVideoSong() const
{
    return m_listVideoSong;
}

void MusicListModel::setListVideoSong(const QStringList &newListVideoSong)
{
    if (m_listVideoSong == newListVideoSong)
        return;
    m_listVideoSong = newListVideoSong;
    emit listVideoSongChanged();
}

QAbstractVideoSurface *MusicListModel::videoSurface() const
{
    return m_videoSurface;
}

void MusicListModel::setVideoSurface(QAbstractVideoSurface *newVideoSurface)
{
    if (m_videoSurface == newVideoSurface)
        return;
    m_videoSurface = newVideoSurface;
    m_player->setVideoOutput(m_videoSurface);
    emit videoSurfaceChanged();
}
