import QtQuick 2.15
import QtMultimedia 5.15
import "../CustomComponent"
import QtGraphicalEffects 1.15
Rectangle {
    property alias video: video

    border.width:1
    border.color:"red"
    color: "lightsteelblue"
    width: root.width-rectMenu.width
    height: rectMenu.height - rectCategorize.height
    Image {
        width: parent.height*2/3
        height: parent.height*2/3
        id: artImg
        source: /*"qrc:/image/coverArt.webp"*/ playMusic.songCoverArt()
        anchors.centerIn: parent
//        scale: root.width < 1000 ? 0.2 : 0.4
        fillMode: Image.PreserveAspectFit
        layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: artImg.width
                            height: artImg.height
                            radius: Math.min(artImg.width, artImg.height) / 2
                            color: "black"
                        }
                    }
        RotationAnimation on rotation {
            loops: Animation.Infinite
            from: 0
            to: 360
            duration: 5000
        }

    }

    Connections {
        target: playMusic
        function onDurationChanged() {
            artImg.source = playMusic.songCoverArt()
        }
    }

    VideoOutput {
        anchors.fill: parent
        id: video
        objectName: "videoOutput"
        source: playMusic
        fillMode: VideoOutput.PreserveAspectFit
    }
    Rectangle {
        color: "transparent"
        width: parent.width/2
        height: parent.height
        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                playMusic.seekToPrevious()
            }
        }
    }
    Rectangle {
        color: "transparent"
        anchors.right: parent.right
        width: parent.width/2
        height: parent.height
        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                playMusic.seekToNext()
            }
        }
    }
}

