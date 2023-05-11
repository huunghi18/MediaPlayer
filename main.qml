import QtQuick
import QtQuick.Window
import QtMultimedia
import "./RectangleLayout"
//import QtQuick.Controls
Window {
    id:root
    width: 800
    height: 500
    visible: true
    title: ("Media Player")
    property bool isOpenIcon: true // Close/Open Menu
    property bool isPlayVideo: false //Play video
    property bool isMute: false // Volume
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
                }
            }
        }
        Row {
            RectMusicInfor {
                id: rectMusicInfor
            }
            RectPlay {
                id:rectPlay
            }
        }
    }
    Loader {

    }
}
