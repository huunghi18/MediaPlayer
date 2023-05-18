import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15
import "../CustomComponent"
Rectangle {
    color: "lightgoldenrodyellow"
    width: 220
    height: root.height*4.2/5
    Column {
        anchors.fill: parent
        spacing: 10
        CustomButton {
            id: menuButton
            imgSource: "qrc:/image/MenuIcon.png"
            onButtonClick: {
                isOpenIcon = !isOpenIcon
                isOpenIcon ? rectMenu.width = 250 : rectMenu.width = imgWidth + 10
            }
        }
        Row {
            spacing: 20
            CustomButton {
                id: searchButton
                color: focus ? "lightblue" : "transparent"
                imgSource: "qrc:/image/Search.png"
                onButtonClick: {
                    focus = true
                    categorizeTitle = "Search"
                }
            }
            TextField {
                width: 150
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
            CustomButton {
                color: focus ? "lightblue" : "transparent"
                id: myMusicButton
                imgSource: "qrc:/image/NoteIcon.svg"
                onButtonClick: {
                    focus = true
                    categorizeTitle = "My Audio"
                    loader1.source= "qrc:/Screen/ListAudio.qml"
                    playMusic.getAllAudioFiles()
                    playMusic.setAudioPlaylist()
                    loader1.active = false
                    loader1.active = true
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
                text: "My Audio"
            }
        }
        Row {
            spacing: 20
            CustomButton {
                id: myVideoButton
                color: focus ? "lightblue" : "transparent"
                imgSource: "qrc:/image/MyVideo.png"
                onButtonClick: {
                    focus = true
                    categorizeTitle = "My Video"
                    playMusic.getAllVideoFiles()
                    playMusic.setVideoPlaylist()
                    loader1.source= "qrc:/Screen/ListVideo.qml"
                    loader1.active = false
                    loader1.active = true
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
            CustomButton {
                id: clockButton
                color: focus ? "lightblue" : "transparent"
                imgSource: "qrc:/image/Clock.png"
                onButtonClick: {
                    focus = true
                    categorizeTitle = "Recent Playing"
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
            CustomButton {
                id: settingButton
                color: focus ? "lightblue" : "transparent"
                imgSource: "qrc:/image/Setting.png"
                onButtonClick: {
                    focus = true
                    categorizeTitle = "Setting"
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
