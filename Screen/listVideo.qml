import QtQuick 2.15
import "../RectangleLayout"
import "../CustomComponent"
Rectangle {
    ListView {
        id: listViewVideo
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.videoPlaylistModel
        currentIndex: -1
        delegate: Rectangle {
            id: rectDlg
            border.width: 2
            width: rectVideo.width
            height: root.width < 1000 ? 45 : 60
            color: playMusic.videoIndex === index ? "lightgray" : "antiquewhite"
            Row {
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    color: "transparent"
                    width: rectDlg.width - removeButton.width
                    height: rectDlg.height

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        text: name + "-" + artist + "-" + album
                        font {
                            family: "Arial"
                            pixelSize: 20
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
