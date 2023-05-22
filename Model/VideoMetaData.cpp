#include "VideoMetaData.h"

VideoMetaData::VideoMetaData(QObject *parent)
    : QObject{parent}
{

}

QString VideoMetaData::source() const
{
    return m_videoData.m_source;
}

void VideoMetaData::setSource(const QString &newSource)
{
    if (m_videoData.m_source == newSource)
        return;
    m_videoData.m_source = newSource;
    emit sourceChanged();
}

QString VideoMetaData::name() const
{
    return m_videoData.m_name;
}

void VideoMetaData::setName(const QString &newName)
{
    if (m_videoData.m_name == newName)
        return;
    m_videoData.m_name = newName;
    emit nameChanged();
}

QString VideoMetaData::artist() const
{
    return m_videoData.m_artist;
}

void VideoMetaData::setArtist(const QString &newArtist)
{
    if (m_videoData.m_artist == newArtist)
        return;
    m_videoData.m_artist = newArtist;
    emit artistChanged();
}

QString VideoMetaData::album() const
{
    return m_videoData.m_album;
}

void VideoMetaData::setAlbum(const QString &newAlbum)
{
    if (m_videoData.m_album == newAlbum)
        return;
    m_videoData.m_album = newAlbum;
    emit albumChanged();
}
