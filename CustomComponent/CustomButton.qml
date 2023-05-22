import QtQuick 2.15


Rectangle {
    property alias imgSource: imgID.source
    property alias imgWidth: rect.width
    property alias imgHeight: rect.height
    signal buttonClick
    id: rect
    color: "transparent"
    width: root.width < 1000 ? 40 : 60
    height: root.width < 1000 ? 40 : 60
    Image {
        anchors.fill: parent
        id: imgID
        source: ""
        fillMode: Image.PreserveAspectFit
    }
    MouseArea {
        anchors.fill: parent
        onClicked: buttonClick()
        onPressed: {
            parent.scale = 0.8
        }
        onReleased: {
            parent.scale = 1
        }
    }

}
