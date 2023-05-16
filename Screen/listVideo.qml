import QtQuick 2.15
import "../RectangleLayout"
import QtQuick.Controls 2.15
Rectangle {
    id: rectListVideo
    property alias listVideo: listVideo
    ListModel {
        id: listVideoModel
        ListElement { title: "Rewrite The Stars"; videoPath: "E:/Fpt_C++/QT/mediaPlayer2/video/RewriteTheStars.mp4" }
        ListElement { title: "Hay Trao Cho Anh" ; videoPath: "E:/Fpt_C++/QT/mediaPlayer2/video/haytraochoanh.mp4"}
        ListElement { title: "The Orange Cat"; videoPath: "E:/Fpt_C++/QT/mediaPlayer2/video/videoplayback.mp4" }
    }
    ListView {
        id: listVideo
        property alias songIndex: listVideo.currentIndex
        width: rectVideo.width
        height: rectVideo.height
        model: listVideoModel
        currentIndex: -1
        delegate: Rectangle {
            border.width: 2
            width: parent.width
            height: 40
            color: listVideo.currentIndex === index ? "lightgray" : "antiquewhite"
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
                    rectVideo.video.source = videoPath
                    rectVideo.video.play()
                    root.songTitle = title
                    listVideo.currentIndex = index

                }
            }
        }
    }
}
