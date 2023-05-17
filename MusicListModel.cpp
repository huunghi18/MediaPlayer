#include "MusicListModel.h"


MusicListModel::MusicListModel(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer;
    m_playlist = new QMediaPlaylist;

    connect(m_player, &QMediaPlayer::positionChanged, this, &MusicListModel::positionChanged);
    connect(m_player, &QMediaPlayer::durationChanged, this, &MusicListModel::positionChanged);
    m_player->setVolume(0.5);
    m_player->setPlaylist(m_playlist);
}

void MusicListModel::getAllAudioFiles()
{
    //    QStringList path = QStandardPaths::standardLocations(QStandardPaths::MusicLocation);
    //    if(path.count() > 0)
    //    {
    //        m_audioPath = path.at(0);
    //    }
    //    QDirIterator it(m_audioPath, QStringList() << "*.mp3");
    //    while(it.hasNext())
    //    {
    //        it.next();
    //        m_listAudio.append(it.fileName());
    //    }
    //    foreach (const QString& filePath, m_listAudio) {
    //        QMediaContent mediaContent = QMediaContent(QUrl::fromLocalFile(filePath));
    //        m_playlist->addMedia(mediaContent);
    //    }
    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation)[0]);

    QDir directory(m_musicPath);

    m_listAudio = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files);

    QList<QMediaContent> content;

    for(const QString& f:m_listAudio)
    {
        content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        qDebug() <<(QUrl::fromLocalFile(directory.path()+"/" + f));
    }
    m_playlist->addMedia(content);
    setVolume();
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
    qInfo() << "Selected file:" << m_listAudioPath;
}

void MusicListModel::play(int index)
{
    m_playlist->setCurrentIndex(index);
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
    m_playlist->next();
}

void MusicListModel::previous()
{
    m_playlist->previous();
}

void MusicListModel::setVolume()
{
    m_player->setVolume(50);
}

//qint64 MusicListModel::getDuration()
//{
//    qDebug() << m_player->duration();
//    return m_player->duration();

//}

//qint64 MusicListModel::getPosition()
//{
//    qDebug() << m_player->position();
//    return m_player->position();
//}

void MusicListModel::setCurrentIndex(int index)
{
    m_playlist->setCurrentIndex(index);
}

int MusicListModel::getCurrentMusicIndex()
{
    return m_playlist->currentIndex();
}

void MusicListModel::removeFromAudioPlaylist(int index)
{
    m_playlist->removeMedia(index);
    m_listAudio.removeAt(index);
//    emit audioListSizeChanged();
}

//void MusicListModelTest::setPlayingState(bool state)
//{
//    if(state == true) {
//        m_isMusicPlaying = true;
//    }
//    else {
//        m_isMusicPlaying = false;
//    }
//}
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


QStringList MusicListModel::listSong() const
{
    return m_listAudio;
}

void MusicListModel::setListSong(const QStringList &newListSong)
{
    if (m_listAudio == newListSong)
        return;
    m_listAudio = newListSong;
    emit listSongChanged();
}

qint64 MusicListModel::position() const
{
    return m_player->position();
}

qint64 MusicListModel::duration() const
{
    return m_duration;
}
