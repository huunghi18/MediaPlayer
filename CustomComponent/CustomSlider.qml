import QtQuick 2.15

Rectangle {
    property alias sldWidth: rectID.width
    property alias sldCircleWidth: circle.width
    property alias sldPosition: circle.x
    property real sldPositionMouse
    property real sldRange: sldWidth - circle.width
    signal sldDrag
    signal sldClick
    id: rectID
    color: "darkgray"
    width: root.width < 1000 ? 200 : 300
    height: 10
    radius: 5
    MouseArea {
        anchors.fill: parent
        onClicked: {
            sldPositionMouse = mouseX
            rectID.sldClick()

        }
    }
    Rectangle {
        id: circle
        color: "#ffb6c1"
        anchors.verticalCenter: parent.verticalCenter
        width: 20
        height: 20
        radius: 10
        MouseArea {
            anchors.fill: parent
            drag.target: circle
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: rectID.width - circle.width
            onPressed: {
                parent.scale = 1.2
            }
            onReleased: {
                parent.scale = 1
            }
            onPositionChanged: {
                sldDrag()
            }

        }
    }
    Rectangle {
        width: circle.x
        height:  rectID.height
        color: "darkseagreen"
        radius: 10
    }
}

