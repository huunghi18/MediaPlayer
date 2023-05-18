import QtQuick 2.15
import "../RectangleLayout"
Rectangle {
    ListView {
        id: listViewAudio
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.listAudioSong
        delegate: Rectangle {
            border.width: 2
            width: parent.width
            height: 40
            color: listViewAudio.currentIndex === index ? "lightgray" : "antiquewhite"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: playMusic.listAudioSong[index]
                font {
                    family: "Arial"
                    pixelSize: 20
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Clicked on song: " + modelData)
                    listViewAudio.currentIndex = index
                    playMusic.play(listViewAudio.currentIndex)
                    console.log ("log: " + playMusic.getCurrentMusicIndex() )
                    isPlayVideo= true
                }
            }

        }
    }
}

