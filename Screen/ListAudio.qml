import QtQuick 2.15
import "../RectangleLayout"
Rectangle {
    id:rectListAudio
    property alias listAudio: listAudio
    //    ListModel {
    //        id: listAudioModel
    //        ListElement { title: "Cong Chua Bong Bong"; audioPath: "E:/Fpt_C++/QT/mediaPlayer2/video/congchuabongbong.mp3" }
    //        ListElement { title: "Khi Ta Lon" ; audioPath: "E:/Fpt_C++/QT/mediaPlayer2/video/khitalon.mp3"}
    //        ListElement { title: "Toi Thuong Ba"; audioPath: "E:/Fpt_C++/QT/mediaPlayer2/video/toithuongba.mp3" }
    //    }
    ListView {
        id: listAudio
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.listSong
        currentIndex: -1
        delegate: Rectangle {
            border.width: 2
            width: parent.width
            height: 40
            color: listAudio.currentIndex === index ? "lightgray" : "antiquewhite"
            Text {
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: playMusic.listSong[index]
                font {
                    family: "Arial"
                    pixelSize: 20
                }
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Clicked on song: " + modelData)
                    //                    rectVideo.video.source = playMusic.listAudioPath[index]
                    //                    rectVideo.video.play()
                    //                    root.songTitle = title
                    listAudio.currentIndex = index
                    playMusic.play(listAudio.currentIndex)
                    console.log ("log: " + playMusic.getCurrentMusicIndex() )
                    isPlayVideo= true
                }
            }
        }
    }
}

