import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
import QtQuick.Controls 2.15
import "../CustomComponent"
Rectangle {
    color: "lightgoldenrodyellow"
    width: root.width < 1000 ? root.width*2/8 : 350
    height: root.height*4.2/5
    Column {
        anchors.fill: parent
        spacing: root.width < 1000 ? 20 : 50
        CustomButton {
            id: menuButton
            imgSource: "qrc:/image/MenuIcon.png"
            onButtonClick: {
                isOpenIcon = !isOpenIcon
                isOpenIcon ? (root.width < 1000 ? rectMenu.width = root.width*2/8 : rectMenu.width = 350)  : rectMenu.width = imgWidth + 10
            }
        }
        Row {
            spacing: 25
            CustomButton {
                id: searchButton
                imgSource: "qrc:/image/Search.png"
                onButtonClick: {
                    isClickAudio ? playMusic.searchAudio(textSearching.text) : playMusic.searchVideo(textSearching.text)
                }
            }
            Rectangle {
                width: root.width < 1000 ? 120 : 220
                height: searchButton.height
                border.width: 1
                TextEdit {
                    anchors.centerIn: parent
                    id: textSearching
                    focus: true
                    width: root.width < 1000 ? 100 : 200
                    height: searchButton.height
                    anchors.verticalCenter: parent.verticalCenter
                    wrapMode: TextEdit.WrapAnywhere
                    font {
                        family: "Arial"
                        pixelSize: root.width < 1000 ? 20:30
                        bold: true
                    }
                    //                            text: "My Music"
                }
            }


        }
        Row {
            spacing: 20
            CustomButton {
                color: focus ? "lightblue" : "transparent"
                id: myMusicButton
                imgSource: "qrc:/image/NoteIcon.svg"
                onButtonClick: {
                    txAudioRect.focus = true
                    isVideo = false
                    categorizeTitle = "List Audio"
                    loader1.source= "qrc:/Screen/ListAudio.qml"
                    loader1.active = false
                    loader1.active = true
                    isClickAudio = true
                }
            }
            Rectangle {
                id:txAudioRect
                color: focus ? "lightgray" : "transparent"
                implicitHeight: myMusicButton.height
                implicitWidth: txAudio.width
                Text {
                    id: txAudio
                    anchors.verticalCenter: parent.verticalCenter
                    color: "blue"
                    font {
                        family: "Papyrus"
                        pixelSize: root.width < 1000 ? 20:30
                        bold: true
                    }
                    text: "List Audio"
                }
            }
        }
        Row {
            spacing: 20
            CustomButton {
                id: myVideoButton
                imgSource: "qrc:/image/MyVideo.png"
                onButtonClick: {
                    isVideo = true
                    isClickAudio = false
                    txVideoRect.focus = true
                    categorizeTitle = "List Video"
                    loader1.source= "qrc:/Screen/ListVideo.qml"
                    loader1.active = false
                    loader1.active = true
                }
            }
            Rectangle {
                id:txVideoRect
                color: focus ? "lightgray" : "transparent"
                implicitHeight: myVideoButton.height
                implicitWidth: txVideo.width
                Text {
                    id:txVideo
                    anchors.verticalCenter: parent.verticalCenter
                    color: "blue"
                    font {
                        family: "Papyrus"
                        pixelSize: root.width < 1000 ? 20:30
                        bold: true
                    }
                    text: "List Video"
                }
            }
        }
        Row {
            spacing: 20
            CustomButton {
                id: clockButton
                color: focus ? "lightblue" : "transparent"
                imgSource: "qrc:/image/Clock.png"
                onButtonClick: {
                    txRecentRect.focus = true
                    categorizeTitle = "Recent Playing"
                    loader1.active = false
                }
            }
            Rectangle {
                id:txRecentRect
                color: focus ? "lightgray" : "transparent"
                implicitHeight: clockButton.height
                implicitWidth: txRecent.width
                Text {
                    id: txRecent
                    anchors.verticalCenter: parent.verticalCenter
                    color: "blue"
                    font {
                        family: "Papyrus"
                        pixelSize: root.width < 1000 ? 20:30
                        bold: true
                    }
                    text: "Recent Playing"
                }
            }
        }
        Row {
            spacing: 20
            CustomButton {
                id: settingButton
                color: focus ? "lightblue" : "transparent"
                imgSource: "qrc:/image/Setting.png"
                onButtonClick: {
                    txSettingRect.focus = true
                    categorizeTitle = "Setting"
                    loader1.active = false
                }
            }
            Rectangle {
                id:txSettingRect
                color: focus ? "lightgray" : "transparent"
                implicitHeight: settingButton.height
                implicitWidth: txSetting.width
                Text {
                    id: txSetting
                    anchors.verticalCenter: parent.verticalCenter
                    color: "blue"
                    font {
                        family: "Papyrus"
                        pixelSize: root.width < 1000 ? 20:30
                        bold: true
                    }
                    text: "Setting"
                }
            }
        }

    }


}
