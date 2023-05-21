#include "AudioMetaData.h"

AudioMetaData::AudioMetaData(QObject *parent)
    : QObject{parent}
{

}

QString AudioMetaData::source() const
{
    return m_audioData.m_source;
}

void AudioMetaData::setSource(const QString &newSource)
{
    if (m_audioData.m_source == newSource)
        return;
    m_audioData.m_source = newSource;
    emit sourceChanged();
}

QString AudioMetaData::name() const
{
    return m_audioData.m_name;
}

void AudioMetaData::setName(const QString &newName)
{
    if (m_audioData.m_name == newName)
        return;
    m_audioData.m_name = newName;
    emit nameChanged();
}

QString AudioMetaData::artist() const
{
    return m_audioData.m_artist;
}

void AudioMetaData::setArtist(const QString &newArtist)
{
    if (m_audioData.m_artist == newArtist)
        return;
    m_audioData.m_artist = newArtist;
    emit artistChanged();
}

QString AudioMetaData::album() const
{
    return m_audioData.m_album;
}

void AudioMetaData::setAlbum(const QString &newAlbum)
{
    if (m_audioData.m_album == newAlbum)
        return;
    m_audioData.m_album = newAlbum;
    emit albumChanged();
}
