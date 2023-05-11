import QtQuick
import "../MyComponent"

Rectangle {
    id: rectCategorize
    color: "powderblue"
    width: root.width-rectMenu.width
    height: root.height*1/7
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
                text: "Title"
            }
        }
        Row {
            spacing: 30
            Text {
                id: songText
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color:"Black"
                opacity: 0.9
                font {
                    pixelSize: 20
                    family: "Papyrus"
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
                        parent.opacity = 0.9
                    }
                    onPressed: {
                        parent.scale = 0.8
                    }
                    onReleased: {
                        parent.scale = 1
                    }
                    onClicked: {
                        console.log("Songs")
                    }
                }
            }
            Text {
                id: artistText
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color:"Black"
                opacity: 0.9
                font {
                    pixelSize: 20
                    family: "Papyrus"
                }
                text: "Artists"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.opacity = 1
                        parent.font.bold = true
                    }
                    onExited: {
                        parent.font.bold = false
                        parent.opacity = 0.9
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
                opacity: 0.9
                font {
                    pixelSize: 20
                    family: "Papyrus"
                }
                text: "Albums"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        parent.opacity = 1
                        parent.font.bold = true
                    }
                    onExited: {
                        parent.font.bold = false
                        parent.opacity = 0.9
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