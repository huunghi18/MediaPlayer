import QtQuick 2.15
import "../RectangleLayout"
Rectangle {
    ListView {
        id: listViewAudio
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.audioPlaylistModel
        currentIndex: -1
        delegate: Rectangle {
            id: rect1
            border.width: 2
            width: rectVideo.width
            height: 40
            color:  playMusic.index === index ? "lightgray" : "antiquewhite"
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
                    isPlayVideo= true
                    isAudio = true
                    playMusic.setAudioPlaylist()
                    console.log(source)
                    playMusic.index = index
                    //                    console.log("index:" + index)
                    //                    console.log("playMusic.index: " + playMusic.index)
                    playMusic.playAudio(index)
                }
            }
        }
    }
}

