#include "Media.h"
#include "tag.h"
#include "fileref.h"
#include <QDebug>


Media::Media(QString filePath, QObject *parent)
    : QObject{parent}
{

    TagLib::FileRef f(filePath.toStdString().data());
    TagLib::Tag *tag = f.tag();
    mediaMeta.artist = QString(tag->artist().toCString());
}

mediaMeta Media::data()
{
    return mediaMeta;
}

