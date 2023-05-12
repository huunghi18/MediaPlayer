import QtQuick
import "../RectangleLayout"
Rectangle {
//    width: root.width-rectMenu.width
//    height: rectMenu.height - rectCategorize.height
//    x: rectVideo.x
//    y: rectVideo.y
//    visible: false
    property alias listAudio: listAudio

    ListModel {
        id: listAudioModel
        ListElement { title: "Cong Chua Bong Bong"; audioPath: "E:/Fpt_C++/QT/mediaPlayer2/video/congchuabongbong.mp3" }
        ListElement { title: "Khi Ta Lon" ; audioPath: "E:/Fpt_C++/QT/mediaPlayer2/video/khitalon.mp3"}
        ListElement { title: "Toi Thuong Ba"; audioPath: "E:/Fpt_C++/QT/mediaPlayer2/video/toithuongba.mp3" }
    }
    ListView {
        id: listAudio
        width: rectVideo.width
        height: rectVideo.height
        model: listAudioModel
        delegate: Rectangle {
            border.width: 2
            width: parent.width
            height: 40
            color: /*index % 2 == 0 ? "beige": "bisque"*/ "antiquewhite"
                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    text: title
                    font {
                        family: "Arial"
                        pixelSize: 20
                    }
                }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("Clicked on song: " + title)
                    rectVideo.video.source = audioPath
                    rectVideo.video.play()
                    root.songTitle = title
                }
            }
        }
    }
}

