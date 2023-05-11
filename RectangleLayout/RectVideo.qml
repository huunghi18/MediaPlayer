import QtQuick
import QtMultimedia
import "../MyComponent"

Rectangle {
    property alias video: video
    border.width:1
    border.color:"red"
    color: "gainsboro"
    width: root.width-rectMenu.width
    height: /*width*9/16//*/rectMenu.height - rectCategorize.height
    Video {
        id: video
        anchors {
            left: parent.left
            top: parent.top
            leftMargin: 5
            topMargin: 5
        }
        width: parent.width-10
        height: parent.height-10
        source: "qrc:/video/RewriteTheStars.mp4"
        volume: 0.5

        //                        onStopped: {
        //                                console.log("Video has ended")
        //                            video.stop()
        //                            }
        Keys.onUpPressed: {
            video.volume += 0.05
            rectPlay.volumeSld.sldPosition/rectPlay.volumeSld.sldRange === 0 ? isMute = true : isMute = false

        }
        Keys.onDownPressed: {
            video.volume -= 0.05
            rectPlay.volumeSld.sldPosition/rectPlay.volumeSld.sldRange === 0 ? isMute = true : isMute = false
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                video.play()
                isPlayVideo = true
            }
        }
        focus: true
        Keys.onSpacePressed: {
            isPlayVideo = !isPlayVideo
            video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
        }
        Keys.onLeftPressed: {
            focus: true
            video.position = video.position - 5000
        }
        Keys.onRightPressed: {
            focus: true
            video.position = video.position + 5000
        }
    }
}
