import QtQuick

Rectangle {
    property alias sldWidth: rect.width
    property alias sldPosition: circle.x
    property real sldRange: sldWidth - circle.width
    signal sldChanged
    id: rect
    color: "darkgray"
    width: 200
    height: 10
    radius: 5
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
            drag.maximumX: rect.width - circle.width
            onPressed: {
                parent.scale = 1.2
            }
            onReleased: {
                parent.scale = 1

            }
            onPositionChanged: {
                sldChanged()
            }
        }
    }
}

