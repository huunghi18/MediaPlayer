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
public:
    explicit MusicListModel(QObject *parent = nullptr);
    Q_INVOKABLE void getAllAudioFiles();
    Q_INVOKABLE void openAudioFolder();
    Q_INVOKABLE void play();
    Q_INVOKABLE void pause();
    Q_INVOKABLE void next();
    Q_INVOKABLE void previous();

    Q_INVOKABLE void setCurrentIndex(int index);
    Q_INVOKABLE int getCurrentMusicIndex();
    QStringList listAudioPath() const;
    void setListAudioPath(const QStringList &newListAudioPath);


//    Q_INVOKABLE void setVolume(int volume);
//    Q_INVOKABLE int getDuration();
//    Q_INVOKABLE void preMusic();
//    Q_INVOKABLE bool setPosition(int position);
//    Q_INVOKABLE void setPlayingState(bool state);

signals:

    void listAudioPathChanged();

private:
    QMediaPlayer *m_player;
    QMediaPlaylist *m_playlist;
    QDir m_musicPath;
    QVariantList _music;
    QStringList m_listAudioPath;
    QString m_songFile;
    QStringList m_listSong;

//    QList<QString> m_listPath;

//    bool m_isMusicPlaying = false, m_isMusicPaused = false, m_isShuffleEnabled = false;
};

#endif // MUSICLISTMODEL_H
