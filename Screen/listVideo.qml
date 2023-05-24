import QtQuick 2.15
import "../RectangleLayout"
import "../CustomComponent"
Rectangle {
    ListView {
        id: listViewVideo
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.videoProxy
        delegate: Rectangle {
            id: rectDlg
            border.width: 2
            width: rectVideo.width
            height: root.width < 1000 ? 50 : 70
            color: playMusic.videoIndex === index ? "lightgray" : "antiquewhite"
            Row {
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle {
                        color: "transparent"
                        width: rectDlg.width - removeButton.width
                        height: rectDlg.height/2
                        clip: true

                        Text {
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            text: name
                            color: "black"

                            font {
                                family: "Arial"
                                pixelSize: root.width < 1000 ? 20 : 30
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                isPlayVideo= true
                                isAudio = false
                                playMusic.setVideoPlaylist()
                                console.log(source)
                                playMusic.videoIndex = index
                                playMusic.playVideo(index)
                            }
                        }

                    }
                    Rectangle {
                        color: "transparent"
                        width: rectDlg.width - removeButton.width
                        height: rectDlg.height/2
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 100
                            color: "midnightblue"
                            text: "&nbsp;<b>Artist:</b>&nbsp;" + artist + " || " + "&nbsp;<b>Album:</b>&nbsp;" + album
                            font {
                                family: "Arial"
                                pixelSize: root.width < 1000 ? 15 : 25
                                italic: true
                            }
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                isPlayVideo= true
                                isAudio = false
                                playMusic.setVideoPlaylist()
                                console.log(source)
                                playMusic.videoIndex = index
                                playMusic.playVideo(index)
                            }
                        }

                    }
                }
                Rectangle {
                    color: "transparent"
                    implicitWidth: removeButton.width
                    height: rectDlg.height
                    CustomButton {
                        id: removeButton
                        anchors.verticalCenter: parent.verticalCenter
                        imgWidth: root.width < 1000 ? 45 : 60
                        imgHeight: root.width < 1000 ? 45 : 60
                        imgSource: "qrc:/image/Remove.png"
                        onButtonClick: {
                            playMusic.removeVideo(index)
                        }
                    }
                }
            }
        }
    }
}
