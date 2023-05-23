import QtQuick 2.15
import "../RectangleLayout"
import "../CustomComponent"
Rectangle {
    ListView {
        id: listViewAudio
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.proxy
        currentIndex: -1
        delegate: Rectangle {
            id: rectDlg
            border.width: 2
            width: rectVideo.width
            height: root.width < 1000 ? 45 : 60
            color:  playMusic.index === index ? "lightgray" : "antiquewhite"
            Row {
                anchors.verticalCenter: parent.verticalCenter
                Rectangle {
                    color: "transparent"
                    width: rectDlg.width - removeButton.width
                    height: rectDlg.height
                    Text {
                        //                        anchors.leftMargin: 20
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        text:  " " + name + " - " + artist + " - " + album
                        font {
                            family: "Arial"
                            pixelSize: 20
                        }
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            isPlayVideo= true
                            isAudio = true
                            playMusic.setAudioPlaylist()
                            console.log(source)
                            playMusic.index = index
                            playMusic.playAudio(index)
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
                            playMusic.removeAudio(index)
                        }
                    }
                }
            }

        }
    }
}

