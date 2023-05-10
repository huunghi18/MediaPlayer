import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtMultimedia
Window {
    id:root
    width: 800
    height: 500
    visible: true
    title: ("Media Player")
    property bool isPlayVideo: false
    property bool isOpenIcon: true // đóng mở value
    property bool isMute: false // âm thanh
    function formatTime(millis) {
        var minutes = Math.floor(millis / 60000);
        var seconds = ((millis % 60000) / 1000).toFixed(0);
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }
    Column {
        Row {
            Rectangle {
                id: rectMenu
                color: "lightgoldenrodyellow"
                width: root.width*1/3
                height: root.height*4/5
                Column {
                    spacing: 10
                    MyButton {
                        id: menuButton
                        imgSource: "qrc:/image/MenuIcon.png"
                        onButtonClick: {
                            isOpenIcon = !isOpenIcon
                            isOpenIcon ? rectMenu.width = root.width*1/3 : rectMenu.width = imgWidth + 10
                        }
                    }
                    Row {
                        spacing: 20
                        MyButton {
                            id: searchButton
                            imgSource: "qrc:/image/Search.png"
                            onButtonClick: {

                            }
                        }
                        TextField {
                            width: 200
                            anchors.verticalCenter: parent.verticalCenter
                            placeholderText: "Search"
                            //                            color: "cornflowerblue"
                            font {
                                family: "Papyrus"
                                pixelSize: 15
                                bold: true
                            }
                            //                            text: "My Music"
                        }
                    }
                    Row {
                        spacing: 20
                        MyButton {
                            id: myMusicButton
                            imgSource: "qrc:/image/NoteIcon.svg"
                            onButtonClick: {
                               title.text = "My Music"
                            }
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: "cornflowerblue"
                            font {
                                family: "Papyrus"
                                pixelSize: 15
                                bold: true
                            }
                            text: "My Music"
                        }
                    }
                    Row {
                        spacing: 20
                        MyButton {
                            id: myVideoButton
                            imgSource: "qrc:/image/MyVideo.png"
                            onButtonClick: {
                                title.text = "My Video"
                            }
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: "cornflowerblue"
                            font {
                                family: "Papyrus"
                                pixelSize: 15
                                bold: true
                            }
                            text: "My Video"
                        }
                    }
                    Row {
                        spacing: 20
                        MyButton {
                            id: clockButton
                            imgSource: "qrc:/image/Clock.png"
                            onButtonClick: {
                                title.text = "Recent Playing"
                            }
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: "cornflowerblue"
                            font {
                                family: "Papyrus"
                                pixelSize: 15
                                bold: true
                            }
                            text: "Recent Playing"
                        }
                    }
                    Row {
                        spacing: 20
                        MyButton {
                            id: settingButton
                            imgSource: "qrc:/image/Setting.png"
                            onButtonClick: {
                                title.text = "Setting"
                            }
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: "cornflowerblue"
                            font {
                                family: "Papyrus"
                                pixelSize: 15
                                bold: true
                            }
                            text: "Setting"
                        }
                    }

                }


            }
            Column {
                Rectangle {
                    id: rectCategorize
                    color: "powderblue"
                    width: root.width-rectMenu.width
                    height: root.height*1/7
                    Column {
                        Rectangle {
                            color: "gray"
                            width: rectCategorize.width
                            height: rectCategorize.height/2
                            Text {
                                id: title
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                color:"Black"
                                font {
                                    pixelSize: 30
                                    family: "Papyrus"
                                    bold: true
                                }
                                text: "Title"
                            }
                        }
                        Row {
                            spacing: 30
                            Text {
                                id: songText
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                color:"Black"
                                opacity: 0.9
                                font {
                                    pixelSize: 20
                                    family: "Papyrus"
                                }
                                text: "Songs"
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        parent.opacity = 1
                                        parent.font.bold = true
                                    }
                                    onExited: {
                                        parent.font.bold = false
                                        parent.opacity = 0.9
                                    }
                                    onPressed: {
                                        parent.scale = 0.8
                                    }
                                    onReleased: {
                                        parent.scale = 1
                                    }
                                    onClicked: {
                                        console.log("Songs")
                                    }

                                }


                            }
                            Text {
                                id: artistText
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                color:"Black"
                                opacity: 0.9
                                font {
                                    pixelSize: 20
                                    family: "Papyrus"
                                }
                                text: "Artists"
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        parent.opacity = 1
                                        parent.font.bold = true
                                    }
                                    onExited: {
                                        parent.font.bold = false
                                        parent.opacity = 0.9
                                    }
                                    onPressed: {
                                        parent.scale = 0.8
                                    }
                                    onReleased: {
                                        parent.scale = 1
                                    }
                                    onClicked: {
                                        console.log("Artists")
                                    }

                                }
                            }
                            Text {
                                id: albumText
                                anchors.leftMargin: 10
                                anchors.verticalCenter: parent.verticalCenter
                                color:"Black"
                                opacity: 0.9
                                font {
                                    pixelSize: 20
                                    family: "Papyrus"
                                }
                                text: "Albums"
                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        parent.opacity = 1
                                        parent.font.bold = true
                                    }
                                    onExited: {
                                        parent.font.bold = false
                                        parent.opacity = 0.9
                                    }
                                    onPressed: {
                                        parent.scale = 0.8
                                    }
                                    onReleased: {
                                        parent.scale = 1
                                    }
                                    onClicked: {
                                        console.log("Albums")
                                    }

                                }


                            }

                        }
                    }
                }

                Rectangle {
                    id: rectVideo
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
                        source: "qrc:/video/haytraochoanh.mp4"
                        volume: 0.5

                        //                        onStopped: {
                        //                                console.log("Video has ended")
                        //                            video.stop()
                        //                            }
                        Keys.onUpPressed: {
                            video.volume += 0.05
                            volumeSld.sldPosition/volumeSld.sldRange === 0 ? isMute = true : isMute = false

                        }
                        Keys.onDownPressed: {
                            video.volume -= 0.05
                            volumeSld.sldPosition/volumeSld.sldRange === 0 ? isMute = true : isMute = false
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
            }
        }
        Row {
            Rectangle {
                id: rectMusicInfor
                color: "thistle"
                width: root.width*1/4
                height: root.height-rectMenu.height
                Image {
                    source: "qrc:/image/myMusic.png"

                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("rectMusicInfor Clicked")
                    }
                }
            }
            Rectangle {
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
                                video.focus = true
                                isPlayVideo ? video.play() : video.pause ()
                            }
                        }
                        MyButton {
                            id: nextButton
                            imgSource: "qrc:/image/next.png"
                            onButtonClick: {
                                video.source = "qrc:/video/videoplayback.mp4"
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
                                        isMute ? video.volume = 0 : video.volume = 0.5;
                                        //                                        isMute ? volumeSlider.sldPosition = 0 : volumeSlider.sldPosition =video.volume*volumeSlider.sldRange
                                    }
                                }
                                MySlider {
                                    id: volumeSld
                                    anchors.verticalCenter: parent.verticalCenter
                                    sldWidth: 60
                                    sldPosition: video.volume*sldRange
                                    onSldDrag: {
                                        video.volume = (sldPosition/sldRange)
                                        sldPosition/sldRange === 0 ? isMute = true : isMute = false
                                    }
                                }
                            }
                        }
                    }

                    Row {
                        spacing: 20
                        Text {
                            text: formatTime(video.position)
                        }
                        MySlider {
                            id: videoSld
                            anchors.verticalCenter: parent.verticalCenter
                            sldPosition: (video.position/video.duration) * sldRange
                            onSldDrag:{
                                video.position = (sldPosition/sldRange) * video.duration
                            }
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    if (mouseX < videoSld.sldRange) {
                                        video.position = (mouseX/videoSld.sldRange) * video.duration
                                        //                                    videoSld.sldPosition = mouseX-videoSld.sldCircleWidth/4
                                    }
                                    else {
                                        video.position = video.duration
                                    }
                                }
                            }
                        }
                        Text {
                            text: formatTime(video.duration)
                        }
                    }


                }

            }
        }
    }
}
