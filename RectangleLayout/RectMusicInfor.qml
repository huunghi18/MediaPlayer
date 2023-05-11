import QtQuick
import "../MyComponent"

Rectangle {
    color: "thistle"
    width: root.width*1/4
    height: root.height-rectMenu.height
    Image {
        source: "qrc:/image/myMusic.png"

    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("rectMusicInfor Clicked")
        }
    }
}
