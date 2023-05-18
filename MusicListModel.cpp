#include "MusicListModel.h"


MusicListModel::MusicListModel(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer;
    m_playlistAudio = new QMediaPlaylist;
    m_playlistVideo = new QMediaPlaylist;
    videoWidget = new QVideoWidget;
    connect(m_player, &m_player->positionChanged, this, &MusicListModel::positionChanged);
    connect(m_player, &m_player->durationChanged, this, &MusicListModel::durationChanged);
    m_player->setVolume(50);
    m_playlistAudio->setPlaybackMode(QMediaPlaylist::Loop);
    m_playlistVideo->setPlaybackMode(QMediaPlaylist::Loop);
}

void MusicListModel::getAllAudioFiles()
{
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0]);

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
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0]);

    QDir directory(m_musicPath);

    m_listVideoSong = directory.entryList(QStringList() << "*.mp4" << "*.MP4",QDir::Files);

    QList<QMediaContent> content;

    for(const QString& f:m_listVideoSong)
    {
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        qDebug() <<(QUrl::fromLocalFile(directory.path()+"/" + f));
    }
    m_playlistVideo->addMedia(content);
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
                nullptr, "Open File", "E:/Fpt_C++/QT/mediaPlayer2/video", "(*.mp4)");
//    qInfo() << "Selected file:" << m_listAudioPath;
}

void MusicListModel::play(int index)
{
    videoWidget->show();
    m_playlistAudio->setCurrentIndex(index);
    m_player->play();
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
    emit nextSignal();
}

void MusicListModel::previous()
{
    m_playlistAudio->previous();
}

void MusicListModel::setCurrentIndex(int index)
{
    m_playlistAudio->setCurrentIndex(index);
}

int MusicListModel::getCurrentMusicIndex()
{
    return m_playlistAudio->currentIndex();
}

void MusicListModel::removeFromAudioPlaylist(int index)
{
    m_playlistAudio->removeMedia(index);
    m_listAudioSong.removeAt(index);
    //    emit audioListSizeChanged();
}

void MusicListModel::setAudioPlaylist()
{
    m_player->setPlaylist(nullptr);
    m_player->setPlaylist(m_playlistAudio);
    m_player->setVideoOutput(videoWidget);
}
void MusicListModel::setVideoPlaylist()
{
    m_player->setPlaylist(nullptr);
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

void MusicListModel::onPositionChanged(qint64 position)
{
    setPosition(position);
}

void MusicListModel::onVolumeChanged(int volume)
{
    setVolume(volume);
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
