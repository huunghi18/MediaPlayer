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
        //        Image {
        //            id: img
        //            source: "qrc:/image/myMusic.png"
        //            anchors.bottom: parent.bottom
        //            anchors.right: parent.right
        //        }
        Column {
            anchors.fill: parent
            anchors.left: parent.left
            spacing: 15
            Text{
                id: txId
                width: parent.width
                text: isAudio ? (playMusic.audioName(playMusic.audioIndex))
                              : (playMusic.videoName(playMusic.videoIndex))
                color: "#191970"
                font {
                    family: "Segoe Print"
                    pixelSize: parent.height/5
                }
            }
            Text{
                x: 10
                id: tx2Id
                width: parent.width
                text: isAudio ? (playMusic.audioArtist(playMusic.audioIndex) )
                              : (playMusic.videoArtist(playMusic.videoIndex) )
                color: "#191970"
                font {
                    family: "Segoe Print"
                    pixelSize: parent.height/5
                }
            }
        }
        NumberAnimation {
            target: txId
            property: "x"
            loops: Animation.Infinite
            from: txId.width
            to: -txId.width
            duration: 5000
            running: /*txId.contentWidth < rectMusicInfor.width ? false :*/ true
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("rectMusicInfor Clicked")
                focus = true
                loader1.active = false
                console.log(tx2Id.contentWidth + "  " +txId.contentWidth)
            }
            hoverEnabled: true
            onEntered: rectMusicInfor.color = "pink"
            onExited: rectMusicInfor.color = "thistle"
        }

        Loader {
            id: loader2
            anchors.fill: rectMusicInfor
            active: false
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
                        //                        newIndex = playMusic.index
                        playMusic.previous()
                        //                        newIndex = newIndex - 1
                        //                        playMusic.index = newIndex
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
        Column {
            spacing: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            Row {
                spacing: 10
                CustomButton {
                    id: volumeButton
                    imgWidth: root.width < 1000 ? 30:40
                    imgHeight: root.width < 1000 ? 30:40
                    imgSource : !isMute ? "qrc:/image/FullVolume.png" : "qrc:/image/Mute.png"
                    onButtonClick: {
                        isMute = !isMute
                        isMute ? playMusic.volume = 0 : playMusic.volume = 50;
                    }
                }
                CustomSlider {
                    id: volumeSld
                    anchors.verticalCenter: parent.verticalCenter
                    sldWidth: root.width < 1000 ? 60 : 80
                    sldPosition: playMusic.volume*sldRange/100
                    onSldDrag: {
                        playMusic.volume = sldPosition/sldRange*100
                        sldPosition/sldRange === 0 ? isMute = true : isMute = false
                    }
                }
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    id: vl
                    text: playMusic.volume
                    font.pixelSize: root.width < 1000 ? 15 : 25
                }
            }

            Row {
                spacing: 10
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Speed: "
                    font.pixelSize: root.width < 1000 ? 20:30
                }
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    color: "bisque"
                    width: root.width < 1000 ? 30:50
                    height: root.width < 1000 ? 30:50
                    Text {
                        anchors.centerIn: parent
                        text: rate
                        font {
                            bold: true
                            pixelSize: root.width < 1000 ? 15:25
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            playMusic.setPlaybackRate()
                            switch(rate) {
                            case 1: {
                                rate = 1.5
                                break
                            }
                            case 1.5: {
                                rate = 0.5
                                break
                            }
                            case 0.5: {
                                rate = 1
                                break
                            }
                            }
                        }
                    }
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


