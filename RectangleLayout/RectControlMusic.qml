import QtQuick 2.15
import "../CustomComponent"
import "../Screen"
Row {
    property alias volumeSld: volumeSld
    property alias playButton: playButton

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
            text: playMusic.audioPlaylistModel.name
            color: "#191970"
            font {
                family: "Papyrus"
                pixelSize: parent.height/5
            }
            NumberAnimation {
                target: textSong
                property: "x"
                loops: Animation.Infinite
                from: 0
                to: root.width*2/8
                duration: 5000
                running: true
            }
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("rectMusicInfor Clicked")
                loader1.active = false
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
                CustomButton {
                    id: shuffleButton
                    imgSource: "qrc:/image/shuffle.png"
                    color: isShuffle? "seagreen":"transparent"
                    onButtonClick: {
                        isShuffle = playMusic.setShuffle()
                    }
                }
                CustomButton {
                    id: preButton
                    imgSource: "qrc:/image/Back.png"
                    onButtonClick: {
                        playMusic.previous()
                    }
                }
                CustomButton {
                    id: playButton
                    imgSource: isPlayVideo ? "qrc:/image/Pause.png" : "qrc:/image/Play.png"
                    onButtonClick: {
                        isPlayVideo = !isPlayVideo
                        isPlayVideo ? playMusic.resume() : playMusic.pause()
                    }
                }
                CustomButton {
                    id: nextButton
                    imgSource: "qrc:/image/next.png"
                    onButtonClick: {
                        playMusic.next()
                        mainIndex = playMusic.getCurrentAudioIndex()
                    }
                }
                CustomButton {
                    smooth: true
                    id: repeatButton
                    imgSource: "qrc:/image/Repeat.png"
                    color: isRepeat? "seagreen":"transparent"
                    onButtonClick: {
                        isRepeat = playMusic.setRepeat()
                    }
                }
            }

            Row {
                spacing: 20
                Text {
                    text: formatTime(playMusic.position)
                }
                CustomSlider {
                    id: videoSld
                    anchors.verticalCenter: parent.verticalCenter
                    sldPosition: (playMusic.position/playMusic.duration) * sldRange
                    onSldDrag:{
                        playMusic.position = (sldPosition/sldRange)*playMusic.duration
                    }
                    onSldClick: {
                        {
                            if (sldPositionMouse < sldRange) {
                                playMusic.position = (sldPositionMouse/sldRange) * playMusic.duration
                            }
                            else {
                                playMusic.position = playMusic.duration
                            }
                        }
                    }
                }
                Text {
                    text: formatTime(playMusic.duration)

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
            CustomButton {
                id: volumeButton
                imgWidth: 30
                imgHeight: 30
                imgSource : !isMute ? "qrc:/image/FullVolume.png" : "qrc:/image/Mute.png"
                onButtonClick: {
                    isMute = !isMute
                    isMute ? playMusic.volume = 0 : playMusic.volume = 50;
                }
            }
            CustomSlider {
                id: volumeSld
                anchors.verticalCenter: parent.verticalCenter
                sldWidth: 60
                sldPosition: playMusic.volume*sldRange/100
                onSldDrag: {
                    playMusic.volume = sldPosition/sldRange*100
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


