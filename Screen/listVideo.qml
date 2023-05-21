import QtQuick 2.15
import "../RectangleLayout"
Rectangle {
    ListView {
        id: listViewVideo
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.listVideoSong
        delegate: Rectangle {
            border.width: 2
            width: parent.width
            height: 40
            color: listViewVideo.currentIndex === index ? "lightgray" : "antiquewhite"
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    text: playMusic.listVideoSong[index]
                    font {
                        family: "Arial"
                        pixelSize: 20
                    }
                }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    playMusic.setVideoPlaylist()
                    listViewVideo.currentIndex = index
                    playMusic.playVideo(listViewVideo.currentIndex)
                    isPlayVideo= true

                }
            }
        }
    }
}
