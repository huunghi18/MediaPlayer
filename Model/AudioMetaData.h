#ifndef AUDIOMETADATA_H
#define AUDIOMETADATA_H

#include <QObject>

typedef struct {
    QString m_source;
    QString m_name;
    QString m_artist;
    QString m_album;
    int m_id;
} AudioData;
class AudioMetaData : public QObject
{
    Q_OBJECT
public:
    explicit AudioMetaData(QObject *parent = nullptr);

    QString source() const;
    void setSource(const QString &newSource);

    QString name() const;
    void setName(const QString &newName);

    QString artist() const;
    void setArtist(const QString &newArtist);

    QString album() const;
    void setAlbum(const QString &newAlbum);

    int id() const;
    void setId(const int &id);

//signals:

//    void sourceChanged();

//    void nameChanged();

//    void artistChanged();

//    void albumChanged();

private:
    AudioData m_audioData;
};

#endif // AUDIOMETADATA_H
