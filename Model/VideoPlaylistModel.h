#ifndef VIDEOPLAYLISTMODEL_H
#define VIDEOPLAYLISTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QMediaPlayer>
#include <QVector>

#include <QFileDialog>
#include <QDir>
#include <QStandardPaths>
#include <QDirIterator>
#include "tag.h"
#include "fileref.h"
#include "tpropertymap.h"
#include "VideoMetaData.h"

class VideoPlaylistModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit VideoPlaylistModel(QObject *parent = nullptr);

    enum VideoRoles{
        SourceRole = Qt::UserRole + 1,
        NameRole,
        ArtistRole,
        AlbumRole,
//        Id,
    };
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void getVideoFiles();
    Q_INVOKABLE void openVideoFiles();
    QList<QMediaContent> getContent();
    QList<QMediaContent> getNewContent();
    void removeVideo(int index);
    void removeAllVideo();


private:
    QVector <VideoMetaData *> m_listVideo;
    QList<QMediaContent> m_content;
    QList<QMediaContent> m_newContent;
};

#endif // VIDEOPLAYLISTMODEL_H
