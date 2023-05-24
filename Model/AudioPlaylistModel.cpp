#include "AudioPlaylistModel.h"
#include <QDebug>
AudioPlaylistModel::AudioPlaylistModel(QObject *parent)
    : QAbstractListModel{parent}
{
}
int AudioPlaylistModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_listAudio.size();
}

QVariant AudioPlaylistModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() < 0 || index.row() >= m_listAudio.size())
        return QVariant();
    const AudioMetaData *audio = m_listAudio.at(index.row());

    if(!audio) {
        return QVariant();
    }
    switch (role) {
    case SourceRole:
        return audio->source();
    case NameRole:
        return audio->name();
    case ArtistRole:
        return audio->artist();
    case AlbumRole:
        return audio->album();
    case IdRole:
        return audio->id();
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> AudioPlaylistModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[SourceRole] = "source";
    roles[NameRole] = "name";
    roles[ArtistRole] = "artist";
    roles[AlbumRole] = "album";
    roles[IdRole] = "id";
    return roles;
}

void AudioPlaylistModel::getAudioFiles()
{

    QDir m_musicPath;
    QStringList m_listAudioSong;
    m_listAudio.clear();

    m_musicPath.setPath(QStandardPaths::standardLocations(QStandardPaths::MusicLocation).at(0)); //đường dẫn tới thư mục MUSIC của hệ thống
    QDir directory(m_musicPath);

    QStringList m_mp3 = directory.entryList(QStringList() << "*.mp3" << "*.MP3",QDir::Files); // list tệp âm thanh mp3 trong thư mục MUSIC

    // Lấy đường dẫn tuyệt đối của tệp mp3 mà push vào list m_listAudioSong
    for(const QString& f : m_mp3)
    {
        m_content.push_back(QUrl::fromLocalFile(directory.path()+"/" + f));
        QString filePath = directory.absoluteFilePath(f); // Lấy đường dẫn tuyệt đối của tệp nhạc
        m_listAudioSong.push_back(filePath);
    }
    for (int i = 0; i < m_listAudioSong.length(); ++i) {
        //TagLib::FileRef f(url.toLocalFile().toStdString().c_str());
        TagLib::FileRef f(m_listAudioSong[i].toStdString().c_str());
        if (f.isNull()) {
            qDebug() << "Failed to create FileRef.";
        }
        TagLib::Tag *tag = f.tag();
        AudioMetaData *audio = new AudioMetaData();


        QString name = QString::fromStdString(tag->title().toCString(true));
        QString artist = QString::fromStdString(tag->artist().toCString(true));
        QString album = QString::fromStdString(tag->album().toCString(true));

        audio->setSource(m_listAudioSong[i].toStdString().c_str());
        audio->setName(name);
        audio->setArtist(artist);
        audio->setAlbum(album);

        //        TagLib::AudioProperties *properties = f.audioProperties();
        //        audio->setDuration(properties->lengthInSeconds());
        audio->setId(i);

        m_listAudio.append(audio);

    }
}

void AudioPlaylistModel::openAudioFiles()
{
    QFileDialog dialog;
    QStringList m_listAudioSong = dialog.getOpenFileNames(nullptr, "Open File", "/home", "*.mp3;;*.MP3");
    for (int i = 0; i < m_listAudioSong.length(); ++i) {
        m_newContent.push_back(QUrl::fromLocalFile(m_listAudioSong[i]));
        //TagLib::FileRef f(url.toLocalFile().toStdString().c_str());
        TagLib::FileRef f(m_listAudioSong[i].toStdString().c_str());
        if (f.isNull()) {
            qDebug() << "Failed to create FileRef.";
        }
        TagLib::Tag *tag = f.tag();
        AudioMetaData *audio = new AudioMetaData();

        QString name = QString::fromStdString(tag->title().toCString(true));
        QString artist = QString::fromStdString(tag->artist().toCString(true));
        QString album = QString::fromStdString(tag->album().toCString(true));

        audio->setSource(m_listAudioSong[i].toStdString().c_str());
        audio->setName(name);
        audio->setArtist(artist);
        audio->setAlbum(album);
        m_listAudio.append(audio);
    }
}

QList<QMediaContent> AudioPlaylistModel::getContent()
{
    return m_content;
}

QList<QMediaContent> AudioPlaylistModel::getNewContent()
{
    return m_newContent;

}

void AudioPlaylistModel::removeAudio(int index)
{
    beginRemoveRows(QModelIndex(),index,index);
    m_listAudio.removeAt(index);
    endRemoveRows();
}

void AudioPlaylistModel::removeAllAudio()
{
    beginResetModel();
    m_listAudio.clear();
    endResetModel();
}

QImage AudioPlaylistModel::imageForTag(QString mediasource)
{
    QImage image;
        TagLib::FileRef taglib_file(mediasource.toLocal8Bit().data());
        if (taglib_file.isNull())
            std::cerr << "TagLib can't read the file." << std::endl;
        TagLib::ID3v2::Tag tagObject = TagLib::ID3v2::Tag(taglib_file.file(), 0);
        TagLib::ID3v2::Tag* tag = &tagObject;
        TagLib::ID3v2::FrameList l = tag->frameList("APIC");
        if(l.isEmpty()) {
            return image;
        }
        TagLib::ID3v2::AttachedPictureFrame *f =
                static_cast<TagLib::ID3v2::AttachedPictureFrame *>(l.front());
        image.loadFromData((const uchar *) f->picture().data(), f->picture().size());
        return image;
}


