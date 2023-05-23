#ifndef AUDIOPLAYLISTMODEL_H
#define AUDIOPLAYLISTMODEL_H
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
#include "AudioMetaData.h"

class AudioPlaylistModel : public QAbstractListModel
{
    Q_OBJECT
public:
    explicit AudioPlaylistModel(QObject *parent = nullptr);

    enum AudioRoles{
        SourceRole = Qt::UserRole + 1,
        NameRole,
        ArtistRole,
        AlbumRole,
    };
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    Q_INVOKABLE void getAudioFiles();
    Q_INVOKABLE void openAudioFiles();
    QList<QMediaContent> getContent();
    QList<QMediaContent> getNewContent();
    void removeAudio(int index);
    void removeAllAudio();
private:
    QVector <AudioMetaData *> m_listAudio;
    QList<QMediaContent> m_content;
    QList<QMediaContent> m_newContent;
};

#endif // AUDIOPLAYLISTMODEL_H
