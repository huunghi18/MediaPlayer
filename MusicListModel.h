#ifndef MUSICLISTMODEL_H
#define MUSICLISTMODEL_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QFileDialog>
#include <QStandardPaths>
#include <QDirIterator>
//#include <QQmlApplicationEngine>
#include <QDebug>
class MusicListModel : public QObject
{
    Q_OBJECT
    //    Q_PROPERTY(QDir path MEMBER m_musicPath)
    Q_PROPERTY(QStringList listAudioPath READ listAudioPath WRITE setListAudioPath NOTIFY listAudioPathChanged)
    Q_PROPERTY(QStringList listSong READ listSong WRITE setListSong NOTIFY listSongChanged)
    Q_PROPERTY(qint64 position READ position NOTIFY positionChanged)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
public:
    explicit MusicListModel(QObject *parent = nullptr);
    Q_INVOKABLE void getAllAudioFiles();
    Q_INVOKABLE void setAudioPath(QString audioName);
    Q_INVOKABLE void openAudioFolder();
    Q_INVOKABLE void play(int index);
    Q_INVOKABLE void resume();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void setVolume();
    Q_INVOKABLE void setCurrentIndex(int index);
    Q_INVOKABLE int getCurrentMusicIndex();
    Q_INVOKABLE void removeFromAudioPlaylist(int index);
    QStringList listAudioPath() const;
    void setListAudioPath(const QStringList &newListAudioPath);

    QStringList listSong() const;
    void setListSong(const QStringList &newListSong);

    qint64 position() const;

    qint64 duration() const;

signals:

    void listAudioPathChanged();

    void listSongChanged();
    void positionChange();
//slots:
    //    void onPositionChange();
    void positionChanged();

    void durationChanged();

private:
    QMediaPlayer *m_player;
    QMediaPlaylist *m_playlist;
    QDir m_musicPath;
    QVariantList _music;
    QStringList m_listAudioPath; //list đường dẫn nằm ở hàm openFolder
    QString m_audioPath;
    QStringList m_listAudio; //list đường dẫn nằm ở hàm getAllAudioFiles
        //    QList<QString> m_listPath;

    //    bool m_isMusicPlaying = false, m_isMusicPaused = false, m_isShuffleEnabled = false;

    qint64 m_position;
    qint64 m_duration;
};

#endif // MUSICLISTMODEL_H
