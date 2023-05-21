#include "MusicController.h"

MusicController::MusicController(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer;
    m_playlistAudio = new QMediaPlaylist;
    m_playlistVideo = new QMediaPlaylist;
    m_audioPlaylistModel = new AudioPlaylistModel;
    //    getAllVideoFiles();
    getAllAudioFiles();
    connect(m_player, &QMediaPlayer::positionChanged, this, &MusicController::positionChanged);
    connect(m_player, &QMediaPlayer::durationChanged, this, &MusicController::durationChanged);
    connect(m_player, &QMediaPlayer::volumeChanged, this, &MusicController::volumeChanged);
    m_player->setVolume(50);
    //    m_player->setPlaylist(m_playlistVideo);
    m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);

}

void MusicController::getAllAudioFiles()
{
    m_audioPlaylistModel->getAudioFiles();

    m_playlistAudio->addMedia(m_audioPlaylistModel->getContent());
}
void MusicController::getAllVideoFiles()
{
    QDir m_musicPath;
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0));
    QDir directory(m_musicPath);

    m_listVideoSong = directory.entryList(QStringList() << "*.mp4" << "*.MP4",QDir::Files);

    QList<QMediaContent> content;

    for(const QString& f:m_listVideoSong)
    {
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        //        qDebug() <<(QUrl::fromLocalFile(directory.path()+"/" + f));
    }
    m_playlistVideo->addMedia(content);
    m_playlistVideo->setPlaybackMode(QMediaPlaylist::Loop);
}

void MusicController::setAudioPath(QString audioName)
{
    QString audioFullPath = m_audioPath + "/" + audioName;
    m_player->setMedia(QUrl::fromLocalFile(audioFullPath));
}
void MusicController::openAudioFolder()
{
    m_audioPlaylistModel->openAudioFiles();
    m_playlistAudio->addMedia(m_audioPlaylistModel->getNewContent());
    m_player->setPlaylist(m_playlistAudio);
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
        return true;
    }
    else
    {
        m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
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
            return true;
        }
        else
        {
            m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
            return false;
        }
    }
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
    //    emit nextSignal();
}

void MusicController::previous()
{
    m_playlistAudio->previous();
    m_playlistVideo->previous();

}

void MusicController::setCurrentIndex(int index)
{
    m_playlistAudio->setCurrentIndex(index);
    //    m_playlistVideo->setCurrentIndex(index);
}

int MusicController::getCurrentAudioIndex()
{
    return m_playlistAudio->currentIndex();
}
int MusicController::getCurrentVideoIndex()
{
    return m_playlistVideo->currentIndex();
}
//void MusicController::removeFromAudioPlaylist(int index)
//{
//    m_playlistAudio->removeMedia(index);
//    m_listAudioSong.removeAt(index);
//    //    emit audioListSizeChanged();
//}

void MusicController::setAudioPlaylist()
{
    m_player->setPlaylist(m_playlistAudio);
}
void MusicController::setVideoPlaylist()
{
    m_player->setPlaylist(m_playlistVideo);
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
