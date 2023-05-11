import QtQuick
import "../MyComponent"
Rectangle {
    property alias volumeSld: volumeSld
    id: rectPlay
    width: root.width-rectMusicInfor.width
    height: rectMusicInfor.height
    color: "slategray"

    Column {
        anchors.centerIn: parent
        spacing: 10
        //                    anchors.verticalCenter: parent.verticalCenter
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 25
            MyButton {
                id: shuffleButton
                imgSource: "qrc:/image/shuffle.png"
                onButtonClick: {

                }
            }
            MyButton {
                id: preButton
                imgSource: "qrc:/image/Back.png"
                onButtonClick: {

                }
            }
            MyButton {
                id: playButton
                imgSource: isPlayVideo ? "qrc:/image/Pause.png" : "qrc:/image/Play.png"
                onButtonClick: {
                    isPlayVideo = !isPlayVideo
                    rectVideo.video.focus = true
                    isPlayVideo ? rectVideo.video.play() : rectVideo.video.pause()
                }
            }
            MyButton {
                id: nextButton
                imgSource: "qrc:/image/next.png"
                onButtonClick: {
                    rectVideo.video.source = "qrc:/video/videoplayback.mp4"
                    isPlayVideo = false
                }
            }
            MyButton {
                smooth: true
                id: repeatButton
                imgSource: "qrc:/image/Repeat.png"
                onButtonClick: {

                }
            }
            Rectangle {
                color: "transparent"
                width: (root.width-rectMusicInfor.width)/15
                height: rectMusicInfor.height/10
                Row {
                    anchors.left: parent.right
                    MyButton {
                        id: volumeButton
                        imgWidth: 30
                        imgHeight: 30
                        imgSource : !isMute ? "qrc:/image/FullVolume.png" : "qrc:/image/Mute.png"
                        onButtonClick: {
                            isMute = !isMute
                            isMute ? rectVideo.video.volume = 0 : rectVideo.video.volume = 0.5;
                        }
                    }
                    MySlider {
                        id: volumeSld
                        anchors.verticalCenter: parent.verticalCenter
                        sldWidth: 60
                        sldPosition: rectVideo.video.volume*sldRange
                        onSldDrag: {
                            rectVideo.video.volume = (sldPosition/sldRange)
                            sldPosition/sldRange === 0 ? isMute = true : isMute = false
                        }
                    }
                }
            }
        }

        Row {
            spacing: 20
            Text {
                text: formatTime(rectVideo.video.position)
            }
            MySlider {
                id: videoSld
                anchors.verticalCenter: parent.verticalCenter
                sldPosition: (rectVideo.video.position/rectVideo.video.duration) * sldRange
                onSldDrag:{
                    rectVideo.video.position = (sldPosition/sldRange) * rectVideo.video.duration
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (mouseX < videoSld.sldRange) {
                            rectVideo.video.position = (mouseX/videoSld.sldRange) * rectVideo.video.duration
                            //                                    videoSld.sldPosition = mouseX-rectVideo.videoSld.sldCircleWidth/4
                        }
                        else {
                            rectVideo.video.position = rectVideo.video.duration
                        }
                    }
                }
            }
            Text {
                text: formatTime(rectVideo.video.duration)
            }
        }
    }
    function formatTime(millis) {
        var minutes = Math.floor(millis / 60000);
        var seconds = ((millis % 60000) / 1000).toFixed(0);
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }
}
