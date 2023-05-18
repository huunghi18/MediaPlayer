#ifndef MUSICLISTMODEL_H
#define MUSICLISTMODEL_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QFileDialog>
#include <QStandardPaths>
#include <QDirIterator>
#include <QVideoWidget>

//#include <QQmlApplicationEngine>
#include <QDebug>
class MusicListModel : public QObject
{
    Q_OBJECT
    //    Q_PROPERTY(QDir path MEMBER m_musicPath)
    Q_PROPERTY(QStringList listAudioPath READ listAudioPath WRITE setListAudioPath NOTIFY listAudioPathChanged)
    Q_PROPERTY(QStringList listAudioSong READ listAudioSong WRITE setListAudioSong NOTIFY listAudioSongChanged)
    Q_PROPERTY(QStringList listVideoSong READ listVideoSong WRITE setListVideoSong NOTIFY listVideoSongChanged)
    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged)

    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
public:
    explicit MusicListModel(QObject *parent = nullptr);
    Q_INVOKABLE void getAllAudioFiles();
    Q_INVOKABLE void getAllVideoFiles();
    Q_INVOKABLE void setAudioPath(QString audioName);
    Q_INVOKABLE void openAudioFolder();
    Q_INVOKABLE void play(int index);
//    Q_INVOKABLE void playVideo(int index);

    Q_INVOKABLE void resume();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void setCurrentIndex(int index);
    Q_INVOKABLE int getCurrentMusicIndex();
    Q_INVOKABLE void removeFromAudioPlaylist(int index);
    Q_INVOKABLE void setAudioPlaylist();
    Q_INVOKABLE void setVideoPlaylist();

    QStringList listAudioPath() const;
    void setListAudioPath(const QStringList &newListAudioPath);


    qint64 duration() const;

    qint64 position() const;
    void setPosition(qint64 newPosition);

    int volume() const;
    void setVolume(int newVolume);



    QStringList listAudioSong() const;
    void setListAudioSong(const QStringList &newListAudioSong);

    QStringList listVideoSong() const;
    void setListVideoSong(const QStringList &newListVideoSong);

signals:

    void listAudioPathChanged();

    void listSongChanged();

    void durationChanged();

    void positionChanged(qint64 position);

    void volumeChanged(int volume);

    void nextSignal();


    void listAudioSongChanged();

    void listVideoSongChanged();

public slots:
    void onPositionChanged(qint64 position);
    void onVolumeChanged(int volume);
private:
    QMediaPlayer *m_player;
    QMediaPlaylist *m_playlistAudio;
    QMediaPlaylist *m_playlistVideo;
    QVideoWidget *videoWidget ;

    QDir m_musicPath;
    QVariantList _music;
    QStringList m_listAudioPath; //list đường dẫn nằm ở hàm openFolder
    QString m_audioPath;
    QStringList m_listAudio; //list đường dẫn nằm ở hàm getAllAudioFiles

    qint64 m_duration;
    qint64 m_position;
    int m_volume;
    QStringList m_listAudioSong;
    QStringList m_listVideoSong;
};

#endif // MUSICLISTMODEL_H
