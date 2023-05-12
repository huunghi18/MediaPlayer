import QtQuick
import "../MyComponent"
import "../Screen"
Row {
    property alias volumeSld: volumeSld

    Rectangle {
        id: rectMusicInfor
        color: "thistle"
        width: root.width*2/8
        height: root.height-rectMenu.height

        Image {
            source: "qrc:/image/myMusic.png"
            anchors.bottom: parent.bottom
        }
        Text{
            id: textSong
            width: parent.width
            text: songTitle
            color: "#191970"
            font {
                family: "Papyrus"
                pixelSize: parent.height/5
            }
            NumberAnimation {
                target: textSong
                property: "x"
                loops: Animation.Infinite
                from: textSong.width
                to: - textSong.width
                duration: 5000
                running: true
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("rectMusicInfor Clicked")
                loader1.active = true
                loader1.source = rectVideo.video.source
            }
        }
    }


    Rectangle {
        id:rectPlay
        //    property alias volumeSld: volumeSld
        width: root.width*4.5/8
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
                    onSldClick: {
                        {
                            if (sldPositionMouse < sldRange) {
                                rectVideo.video.position = (sldPositionMouse/videoSld.sldRange) * rectVideo.video.duration
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

    }
    Rectangle {
        id: rectVolume
        color: "beige"
        width: root.width*1.5/8
        height: rectMusicInfor.height
        Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            spacing: -0
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

    function formatTime(millis) {
        var minutes = Math.floor(millis / 60000);
        var seconds = ((millis % 60000) / 1000).toFixed(0);
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }
}


