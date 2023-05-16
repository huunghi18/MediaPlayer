#include "MusicListModel.h"


MusicListModel::MusicListModel(QObject *parent) : QObject(parent)
{
    m_player = new QMediaPlayer;
    m_playlist = new QMediaPlaylist;

    m_player->setVolume(0.5);
    m_player->setPlaylist(m_playlist);

}

void MusicListModel::getAllAudioFiles()
{
    QStringList path = QStandardPaths::standardLocations(QStandardPaths::MusicLocation);
    if(path.count() > 0)
    {
        m_songFile = path.at(0);
    }
    QDirIterator it(m_songFile, QStringList() << "*.mp3");
    while(it.hasNext())
    {
        it.next();
        m_listSong.append(it.fileName());
    }
    foreach (const QString& filePath, m_listSong) {
        QMediaContent mediaContent = QMediaContent(QUrl::fromLocalFile(filePath));
        m_playlist->addMedia(mediaContent);
    }

}
void MusicListModel::openAudioFolder()
{
    QFileDialog dialog;
    m_listAudioPath = dialog.getOpenFileNames(
                nullptr, "Open File", "E:/Fpt_C++/QT/mediaPlayer2/video", "(*.mp4)");
    qInfo() << "Selected file:" << m_listAudioPath;
}

void MusicListModel::play()
{
    //    m_player->setSource(QUrl::fromLocalFile(filePath));
    m_player -> play();
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

void MusicListModel::setCurrentIndex(int index)
{
    m_playlist->setCurrentIndex(index);
}

int MusicListModel::getCurrentMusicIndex()
{
    return m_playlist->currentIndex();
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

