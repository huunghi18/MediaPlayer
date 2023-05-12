import QtQuick
import QtQuick.Window
import QtMultimedia
import "./RectangleLayout"
import "./Screen"
import QtQuick.Controls
Window {
    id:root
    width: 800
    height: 550
    minimumWidth: 550
    minimumHeight: 450
    visible: true
    title: ("Media Player")
    property bool isOpenIcon: true // Close/Open Menu
    property bool isPlayVideo: false //Play video
    property bool isMute: false // Volume
    property string songTitle //get name of Song
    property string categorizeTitle //get name of Song
    Column {
        Row {
            RectMenu {
                id: rectMenu
            }
            Column {
                RectCategorize {
                    id: rectCategorize
                }
                RectVideo {
                    id: rectVideo
                    width: root.width-rectMenu.width
                    height: rectMenu.height - rectCategorize.height
                    Loader {
                        id: loader1
                        anchors.fill: parent
                        active: false
                    }
                }
            }
        }
        RectControlMusic {
            id: rectControlMusic
        }
    }
}
