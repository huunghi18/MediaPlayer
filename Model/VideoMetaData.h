#ifndef VIDEOMETADATA_H
#define VIDEOMETADATA_H

#include <QObject>

typedef struct {
    QString m_source;
    QString m_name;
    QString m_artist;
    QString m_album;
} VideoData;
class VideoMetaData : public QObject
{
    Q_OBJECT
public:
    explicit VideoMetaData(QObject *parent = nullptr);

    QString source() const;
    void setSource(const QString &newSource);

    QString name() const;
    void setName(const QString &newName);

    QString artist() const;
    void setArtist(const QString &newArtist);

    QString album() const;
    void setAlbum(const QString &newAlbum);

signals:

    void sourceChanged();

    void nameChanged();

    void artistChanged();

    void albumChanged();

private:
    VideoData m_videoData;
};

#endif // VIDEOMETADATA_H
