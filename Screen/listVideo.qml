import QtQuick 2.15
import "../RectangleLayout"
Rectangle {
    ListView {
        id: listViewVideo
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.videoPlaylistModel
        delegate: Rectangle {
            border.width: 2
            width: parent.width
            height: 40
            color: playMusic.index === index ? "lightgray" : "antiquewhite"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: name + "-" + artist + "-" + album
                font {
                    family: "Arial"
                    pixelSize: 20
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    isPlayVideo= true
                    isAudio = false
                    playMusic.setVideoPlaylist()
                    console.log(source)
                    playMusic.index = index
                    playMusic.playVideo(index)
                }
            }
        }
    }
}
