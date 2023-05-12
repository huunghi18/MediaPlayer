import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQuick.Controls
import "../MyComponent"
Rectangle {
    color: "lightgoldenrodyellow"
    width: 220
    height: root.height*4.2/5
    Column {
        spacing: 10
        MyButton {
            id: menuButton
            imgSource: "qrc:/image/MenuIcon.png"
            onButtonClick: {
                isOpenIcon = !isOpenIcon
                isOpenIcon ? rectMenu.width = 250 : rectMenu.width = imgWidth + 10
            }
        }
        Row {
            spacing: 20
            MyButton {
                id: searchButton
                imgSource: "qrc:/image/Search.png"
                onButtonClick: {
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
            MyButton {
                id: myMusicButton
                imgSource: "qrc:/image/NoteIcon.svg"
                onButtonClick: {
                    categorizeTitle = "My Audio"
                    loader1.active = true
                    loader1.source= "qrc:/Screen/ListAudio.qml"
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
            MyButton {
                id: myVideoButton
                imgSource: "qrc:/image/MyVideo.png"
                onButtonClick: {
                    categorizeTitle = "My Video"
                    loader1.active = true
                    loader1.source= "qrc:/Screen/ListVideo.qml"
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
            MyButton {
                id: settingButton
                imgSource: "qrc:/image/Setting.png"
                onButtonClick: {
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
