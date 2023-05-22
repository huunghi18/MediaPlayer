#include "VideoPlaylistModel.h"

VideoPlaylistModel::VideoPlaylistModel(QObject *parent)
    : QAbstractListModel{parent}
{

}
int VideoPlaylistModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_listVideo.size();
}

QVariant VideoPlaylistModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_listVideo.size())
        return QVariant();
    const VideoMetaData *video = m_listVideo.at(index.row());

    if(!video) {
        return QVariant();
    }
    switch (role) {
    case SourceRole:
        return video->source();
    case NameRole:
        return video->name();
    case ArtistRole:
        return video->artist();
    case AlbumRole:
        return video->album();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> VideoPlaylistModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[SourceRole] = "source";
    roles[NameRole] = "name";
    roles[ArtistRole] = "artist";
    roles[AlbumRole] = "album";
    return roles;
}

void VideoPlaylistModel::getVideoFiles()
{

    QDir m_musicPath;
    QStringList m_listVideoSong;
    m_listVideo.clear();

    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0)); //đường dẫn tới thư mục MUSIC của hệ thống
    QDir directory(m_musicPath);

    QStringList m_mp3 = directory.entryList(QStringList() << "*.mp4" << "*.MP4",QDir::Files); // list tệp âm thanh mp3 trong thư mục MUSIC

    // Lấy đường dẫn tuyệt đối của tệp mp3 mà push vào list m_listVideoSong
    for(const QString& f : m_mp3)
    {
        QString filePath = directory.absoluteFilePath(f); // Lấy đường dẫn tuyệt đối của tệp nhạc
        m_listVideoSong.push_back(filePath);

        m_content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));

    }
    for (int i = 0; i < m_listVideoSong.length(); ++i) {
        //TagLib::FileRef f(url.toLocalFile().toStdString().c_str());
        TagLib::FileRef f(m_listVideoSong[i].toStdString().c_str());
        if (f.isNull()) {
            qDebug() << "Failed to create FileRef.";
        }
        TagLib::Tag *tag = f.tag();
        VideoMetaData *video = new VideoMetaData();

        QString name = QString::fromStdString(tag->title().toCString(true));
        QString artist = QString::fromStdString(tag->artist().toCString(true));
        QString album = QString::fromStdString(tag->album().toCString(true));

        video->setSource(m_listVideoSong[i].toStdString().c_str());
        video->setName(name);
        video->setArtist(artist);
        video->setAlbum(album);

        //        TagLib::VideoProperties *properties = f.VideoProperties();
        //        Video->setDuration(properties->lengthInSeconds());

        m_listVideo.append(video);

    }
}

void VideoPlaylistModel:: openVideoFiles()
{
    QFileDialog dialog;
    QStringList m_listVideoSong = dialog.getOpenFileNames(nullptr, "Open File", "C:/Users/Huu Nghi/Music", "*.mp4;;*.MP4");
    for (int i = 0; i < m_listVideoSong.length(); ++i) {
        m_newContent.push_back(QUrl::fromLocalFile(m_listVideoSong[i]));
        //TagLib::FileRef f(url.toLocalFile().toStdString().c_str());
        TagLib::FileRef f(m_listVideoSong[i].toStdString().c_str());
        if (f.isNull()) {
            qDebug() << "Failed to create FileRef.";
        }
        TagLib::Tag *tag = f.tag();
        VideoMetaData *video = new VideoMetaData();

        QString name = QString::fromStdString(tag->title().toCString(true));
        QString artist = QString::fromStdString(tag->artist().toCString(true));
        QString album = QString::fromStdString(tag->album().toCString(true));

        video->setSource(m_listVideoSong[i].toStdString().c_str());
        video->setName(name);
        video->setArtist(artist);
        video->setAlbum(album);

        //        TagLib::VideoProperties *properties = f.audioProperties();
        //        audio->setDuration(properties->lengthInSeconds());
//        for(const QString& f:m_listAudioSong)
//        {
//            m_newContent.push_back(QUrl::fromLocalFile(f));
//        }
        m_listVideo.append(video);
    }
}

QList<QMediaContent> VideoPlaylistModel::getContent()
{
    return m_content;
}

QList<QMediaContent> VideoPlaylistModel::getNewContent()
{
    return m_newContent;

}


