import QtQuick
import QtQuick.Window
import QtMultimedia
import QtQuick.Controls
import "../MyComponent"
Rectangle {
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
