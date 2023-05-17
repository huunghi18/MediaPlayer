#ifndef MEDIA_H
#define MEDIA_H
#include <QObject>
#include <QDateTime>

struct mediaMeta
{
    mediaMeta() {}
    QString fileName;
    QString artist;
    QDateTime releaseDate;
};

//class Tag;
class Media : public QObject
{
    Q_OBJECT
public:
    explicit Media(QString path, QObject *parent = nullptr);
    QString songName();
    mediaMeta data();
signals:

private:
    mediaMeta mediaMeta;
//    Tag *m_tag;
};

#endif // MEDIA_H
