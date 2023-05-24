#ifndef MUSICCONTROLLER_H
#define MUSICCONTROLLER_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>
#include <QFileDialog>
#include <QStandardPaths>
#include <QDirIterator>
#include <QBuffer>
#include <QAbstractVideoSurface>
#include <QSortFilterProxyModel>
#include "../Model/AudioPlaylistModel.h"
#include "../Model/VideoPlaylistModel.h"
//#include <QQmlApplicationEngine>
#include <QDebug>
class MusicController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QSortFilterProxyModel* audioProxy READ audioProxy WRITE setAudioProxy NOTIFY audioProxyChanged)
    Q_PROPERTY(QSortFilterProxyModel* videoProxy READ videoProxy WRITE setVideoProxy NOTIFY videoProxyChanged)

    Q_PROPERTY(AudioPlaylistModel* audioPlaylistModel READ audioPlaylistModel WRITE setAudioPlaylistModel NOTIFY audioPlaylistModelChanged)
    Q_PROPERTY(VideoPlaylistModel* videoPlaylistModel READ videoPlaylistModel WRITE setVideoPlaylistModel NOTIFY videoPlaylistModelChanged)

    Q_PROPERTY(QAbstractVideoSurface* videoSurface READ videoSurface WRITE setVideoSurface NOTIFY videoSurfaceChanged)
//    Q_PROPERTY(QString audioName READ audioName WRITE setAudioName NOTIFY audioNameChanged)
//    Q_PROPERTY(QString audioArtist READ audioArtist WRITE setAudioArtist NOTIFY audioArtistChanged)
    Q_PROPERTY(int audioIndex READ audioIndex WRITE setAudioIndex NOTIFY audioIndexChanged)
    Q_PROPERTY(int videoIndex READ videoIndex WRITE setVideoIndex NOTIFY videoIndexChanged)


    Q_PROPERTY(QStringList listAudioPath READ listAudioPath WRITE setListAudioPath NOTIFY listAudioPathChanged)
    Q_PROPERTY(QStringList listAudioSong READ listAudioSong WRITE setListAudioSong NOTIFY listAudioSongChanged)
    Q_PROPERTY(QStringList listVideoSong READ listVideoSong WRITE setListVideoSong NOTIFY listVideoSongChanged)
    Q_PROPERTY(qint64 position READ position WRITE setPosition NOTIFY positionChanged)
    Q_PROPERTY(qint64 duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(int volume READ volume WRITE setVolume NOTIFY volumeChanged)
public:
    explicit MusicController(QObject *parent = nullptr);
    ~MusicController();
    void getAllAudioFiles();
    Q_INVOKABLE void getAllVideoFiles();
//    Q_INVOKABLE void setAudioPath(QString audioName);
    Q_INVOKABLE void openAudioFolder();
    Q_INVOKABLE void openVideoFolder();
    Q_INVOKABLE void playAudio(int index);
    Q_INVOKABLE void playVideo(int index);
    Q_INVOKABLE void resume();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();
    Q_INVOKABLE void seekToNext();
    Q_INVOKABLE void seekToPrevious();
    Q_INVOKABLE void setPlaybackRate();
    Q_INVOKABLE bool setShuffle();
    Q_INVOKABLE bool setRepeat();

    Q_INVOKABLE void sortAudioByName();
    Q_INVOKABLE void sortAudioByArtist();
    Q_INVOKABLE void sortAudioByAlbum();
    Q_INVOKABLE void searchAudio(QString text);
    Q_INVOKABLE void searchVideo(QString text);


    Q_INVOKABLE void setAudioPlaylist();
    Q_INVOKABLE void setVideoPlaylist();

    Q_INVOKABLE void removeAudio(int index);
    Q_INVOKABLE void removeVideo(int index);
    Q_INVOKABLE void removeAllAudio();
    Q_INVOKABLE void removeAllVideo();

    Q_INVOKABLE void setSource(QString);
    Q_INVOKABLE QString songCoverArt();

//    Q_INVOKABLE addFavoritePlaylist(int index) ;

    Q_INVOKABLE QString audioName(int index);
    Q_INVOKABLE QString audioArtist(int index);
    Q_INVOKABLE QString audioAlbum(int index);

    Q_INVOKABLE QString videoName(int index);
    Q_INVOKABLE QString videoArtist(int index);
    Q_INVOKABLE QString videoAlbum(int index);

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

    VideoPlaylistModel *videoPlaylistModel() const;
    void setVideoPlaylistModel(VideoPlaylistModel *newVideoPlaylistModel);

    int audioIndex() const;
    void setAudioIndex(int newAudioIndex);

    int videoIndex() const;
    void setVideoIndex(int newVideoIndex);

    QSortFilterProxyModel *audioProxy() const;
    void setAudioProxy(QSortFilterProxyModel *newAudioProxy);

    QSortFilterProxyModel *videoProxy() const;
    void setVideoProxy(QSortFilterProxyModel *newVideoProxy);

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

    void audioIndexChanged();

    void audioPlaylistModelChanged();

    void videoPlaylistModelChanged();

    void videoIndexChanged();

//    void currentIndexChanged(int index);

    void audioProxyChanged();
    void signalRemove(int index);

    void videoProxyChanged();

public slots:
    void handleAudioIndexChanged();
    void handleVideoIndexChanged();
    void slotRemove(int index);

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
    VideoPlaylistModel *m_videoPlaylistModel = nullptr;
    AudioMetaData *m_audioMetadata = nullptr;

    int m_audioIndex;
    int m_videoIndex;
    QSortFilterProxyModel *m_audioProxy = nullptr;
    QImage m_currentCoverArt;

    QSortFilterProxyModel *m_videoProxy = nullptr;
};

#endif // MUSICCONTROLLER_H
