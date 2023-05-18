import QtQuick 2.15
import "../CustomComponent"

Rectangle {
    id: rectCategorize
    color: "powderblue"
    width: root.width-rectMenu.width
    height: root.height*1/7
    z: 2
    Column {
        Rectangle {
            color: "gray"
            width: rectCategorize.width
            height: rectCategorize.height/2
            Text {
                id: title
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                color:"Black"
                font {
                    pixelSize: 30
                    family: "Papyrus"
                    bold: true
                }
                text: categorizeTitle
            }
            CustomButton {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                id: addFileButton
                imgSource: "qrc:/image/AddFolder.png"
                onButtonClick: {

//                    playMusic.openAudioFolder()
                    loader1.active = false
                    loader1.active = true
                }
            }
        }
        Row {
            spacing: 30
            Rectangle {
                color: focus?"red":"transparent"
                implicitWidth: songText.implicitWidth
                implicitHeight: songText.implicitHeight
                Text {
                    id: songText
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    color:"Black"
                    font {
                        pixelSize: 20
                        family: "Segoe Print"
                        bold: focus ? true : false
                    }
                    text: "Songs"
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            parent.opacity = 1
                            parent.font.bold = true
                        }
                        onExited: {
                            parent.font.bold = false
                        }
                        onPressed: {
                            parent.scale = 0.8
                        }
                        onReleased: {
                            parent.scale = 1
                        }
                        onClicked: {
                            focus = true
                            console.log("Songs")
                        }
                    }
                }
            }
            Text {
                id: artistText
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color:"Black"
                font {
                    pixelSize: 20
                    family: "Segoe Print"
                }
                text: "Artists"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.font.bold = true
                    }
                    onExited: {
                        parent.font.bold = false
                    }
                    onPressed: {
                        parent.scale = 0.8
                    }
                    onReleased: {
                        parent.scale = 1
                    }
                    onClicked: {
                        console.log("Artists")
                    }

                }
            }
            Text {
                id: albumText
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color:"Black"
                font {
                    pixelSize: 20
                    family: "Segoe Print"
                }
                text: "Albums"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.font.bold = true
                    }
                    onExited: {
                        parent.font.bold = false
                    }
                    onPressed: {
                        parent.scale = 0.8
                    }
                    onReleased: {
                        parent.scale = 1
                    }
                    onClicked: {
                        console.log("Albums")
                    }
                }
            }
        }
    }
}
