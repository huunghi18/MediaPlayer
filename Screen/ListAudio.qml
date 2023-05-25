import QtQuick 2.15
import "../RectangleLayout"
import "../CustomComponent"
Rectangle {
    ListView {
        id: listViewAudio
        width: rectVideo.width
        height: rectVideo.height
        model: playMusic.audioProxy
        currentIndex: -1
        delegate: Rectangle {
            id: rectDlg
            border.width: 2
            width: rectVideo.width
            height: root.width < 1000 ? 50 : 70
            color:  playMusic.audioIndex === index ? "lightgray" : "antiquewhite"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    isPlayVideo= true
                    isAudio = true
                    playMusic.setSource(source)
                    console.log(source)

                    playMusic.setAudioPlaylist()
                    playMusic.audioIndex = index
                    playMusic.playAudio(id)
                    console.log("id: " + id);
                }
            }
            Row {
                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    Rectangle {
                        color: "transparent"
                        width: rectDlg.width - removeButton.width - favoriteButton.width
                        height: rectDlg.height/2
                        clip: true

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            text: name
                            color: "black"
                            font {
                                family: "Arial"
                                pixelSize: root.width < 1000 ? 20 : 30
                            }
                        }

                    }
                    Rectangle {
                        color: "transparent"
                        width: rectDlg.width - removeButton.width - favoriteButton.width
                        height: rectDlg.height/2
                        clip: true
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
                    }
                }
                Rectangle {
                    color: "transparent"
                    implicitWidth: favoriteButton.width
                    height: rectDlg.height
                    CustomButton {
                        id: favoriteButton
                        anchors.verticalCenter: parent.verticalCenter
                        imgWidth: root.width < 1000 ? 45 : 60
                        imgHeight: root.width < 1000 ? 45 : 60
                        imgSource: /*isFavoriteClick? "qrc:/image/FavouriteColor.png" :*/ "qrc:/image/Favorite (1).png"
                        onButtonClick: {
                            isFavoriteClick = !isFavoriteClick
                            console.log("favourite click")
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
        //                        Connections {
        //                            target: playMusic
        //                            onSignalIndexChanged: {
        //                               //do sth
        //                            }
        //                        }
    }
}


