#ifndef MUSICCONTROLLER_H
#define MUSICCONTROLLER_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QFileDialog>
#include <QStandardPaths>
#include <QDirIterator>
#include <QAbstractVideoSurface>
#include "../Model/AudioPlaylistModel.h"
//#include <QQmlApplicationEngine>
#include <QDebug>
class MusicController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(AudioPlaylistModel* audioPlaylistModel READ audioPlaylistModel WRITE setAudioPlaylistModel NOTIFY audioPlaylistModelChanged)

    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface NOTIFY videoSurfaceChanged)
    Q_PROPERTY(QStringList listAudioPath READ listAudioPath WRITE setListAudioPath NOTIFY listAudioPathChanged)
    Q_PROPERTY(QStringList listAudioSong READ listAudioSong WRITE setListAudioSong NOTIFY listAudioSongChanged)
    Q_PROPERTY(QStringList listVideoSong READ listVideoSong WRITE setListVideoSong NOTIFY listVideoSongChanged)
    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
public:
    explicit MusicController(QObject *parent = nullptr);
    void getAllAudioFiles();
    Q_INVOKABLE void getAllVideoFiles();
    Q_INVOKABLE void setAudioPath(QString audioName);
    Q_INVOKABLE void openAudioFolder();
    Q_INVOKABLE void playAudio(int index);
    Q_INVOKABLE void playVideo(int index);
    Q_INVOKABLE void resume();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void setCurrentIndex(int index);
    Q_INVOKABLE int getCurrentAudioIndex();
    Q_INVOKABLE int getCurrentVideoIndex();

    Q_INVOKABLE bool setShuffle();
    Q_INVOKABLE bool setRepeat();
    //        Q_INVOKABLE void removeFromAudioPlaylist(int index);

    Q_INVOKABLE void setAudioPlaylist();
    Q_INVOKABLE void setVideoPlaylist();

    QStringList listAudioPath() const;
    void setListAudioPath(const QStringList &newListAudioPath);

    qint64 duration() const;

    qint64 position() const;

    int volume() const;

    QStringList listAudioSong() const;
    void setListAudioSong(const QStringList &newListAudioSong);

    QStringList listVideoSong() const;
    void setListVideoSong(const QStringList &newListVideoSong);

    void setPosition(qint64 newPosition);
    void setVolume(int newVolume);
    QAbstractVideoSurface *videoSurface() const;
    void setVideoSurface(QAbstractVideoSurface *newVideoSurface);


    AudioPlaylistModel *audioPlaylistModel() const;
    void setAudioPlaylistModel(AudioPlaylistModel *newAudioPlaylistModel);

signals:

    void listAudioPathChanged();

    void listSongChanged();

    void durationChanged();

    void positionChanged(qint64 position);

    void volumeChanged(int volume);

    void nextSignal();


    void listAudioSongChanged();

    void listVideoSongChanged();

    void videoSurfaceChanged();


    void audioPlaylistModelChanged();

public slots:

private:
    QMediaPlayer *m_player;
    QMediaPlaylist *m_playlistAudio;
    QMediaPlaylist *m_playlistVideo;

    QVariantList _music;
    QStringList m_listAudioPath; //list đường dẫn nằm ở hàm openFolder
    QStringList m_listAudioSong; //list đường dẫn nằm ở hàm getAllAudioFiles
    QStringList m_listVideoSong;
    QString m_audioPath;

    qint64 m_duration;
    qint64 m_position;
    int m_volume;
    bool m_isShuffle = false;
    bool m_isReapeat = false;

    QAbstractVideoSurface *m_videoSurface = nullptr;
    AudioPlaylistModel *m_audioPlaylistModel;
};

#endif // MUSICCONTROLLER_H
