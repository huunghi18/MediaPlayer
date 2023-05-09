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
    property bool isPlayImg: false
    property bool isOpenIcon: true
    property bool isMute: false
    function formatTime(millis) {
        var minutes = Math.floor(millis / 60000);
        var seconds = ((millis % 60000) / 1000).toFixed(0);
        return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }
    Column {
        Row {
            Rectangle {
                id: rectSetting
                color: "lightgoldenrodyellow"
                width: root.width*1/4
                height: root.height*4/5
                Column {
                    spacing: 20
                    MyButton {
                        id: menuButton
                        imgSource: "qrc:/image/MenuIcon.png"
                        onButtonClick: {
                            isOpenIcon = !isOpenIcon
                            isOpenIcon ? rectSetting.width = root.width*1/4 : rectSetting.width = imgWidth + 10
                        }
                    }
                    Row {
                        spacing: 20
                        MyButton {
                            id: noteButton
                            imgSource: "qrc:/image/NoteIcon.svg"
                            onButtonClick: {

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
                            id: clockButton
                            imgSource: "qrc:/image/Clock.png"
                            onButtonClick: {

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
                    id: rectOptions
                    color: "darkseagreen"
                    width: root.width-rectSetting.width
                    height: root.height*1/7
                }

                Rectangle {
                    id: rectVideo
                    border.width:1
                    border.color:"red"
                    color: "gainsboro"
                    width: root.width-rectSetting.width
                    height: rectSetting.height - rectOptions.height
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
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                video.play()
                            }
                        }
                        focus: true
                        Keys.onSpacePressed: {
                            isPlayImg = !isPlayImg
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
                height: root.height-rectSetting.height
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
                            imgSource: isPlayImg ? "qrc:/image/Pause.png" : "qrc:/image/Play.png"
                            onButtonClick: {
                                isPlayImg = !isPlayImg
                                video.focus = true
                                isPlayImg ? video.play() : video.pause ()
                            }
                        }
                        MyButton {
                            id: nextButton
                            imgSource: "qrc:/image/next.png"
                            onButtonClick: {

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
                                        isMute ? volumeSlider.sldPosition = 0 : volumeSlider.sldPosition =video.volume*volumeSlider.sldRange
                                    }
                                }
                                MySlider {
                                    id: volumeSlider
                                    anchors.verticalCenter: parent.verticalCenter
                                    sldWidth: 60
                                    sldPosition: video.volume*sldRange
                                    onSldChanged: {
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
                            id: sldVideoPosition
                            anchors.verticalCenter: parent.verticalCenter
                            onSldChanged:
                                video.position = (sldPosition/sldRange) * video.duration
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
