import QtQuick 2.15
import "../RectangleLayout"
Rectangle {
    ListView {
        id: listViewAudio
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.audioPlaylistModel
        Component.onCompleted: {
            listViewAudio.currentIndex = mainIndex;
        }
        delegate: Rectangle {
            border.width: 2
            width: rectVideo.width
            height: 40
            color: listViewAudio.currentIndex === index ? "lightgray" : "antiquewhite"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text:  name + " - " + artist + " - " + album
                font {
                    family: "Arial"
                    pixelSize: 20
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    playMusic.setAudioPlaylist()
                    listViewAudio.currentIndex = index
                    playMusic.playAudio(listViewAudio.currentIndex)
                    isPlayVideo= true
                    console.log(source)
                }
            }

        }
    }
}

