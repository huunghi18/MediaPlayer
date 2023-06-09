import QtQuick 2.15
import QtQuick.Window 2.15
import QtMultimedia 5.15
import "./RectangleLayout"
import "./Screen"
import QtQuick.Controls 2.15
import MusicController 1.0
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
    property string categorizeTitle //get name of Song
    property bool isVideo: false
    property bool isShuffle: false
    property bool isRepeat: false
    property bool isFavoriteClick: false
    property int newIndex
    property bool isAudio: false //set Animation
    property bool isClickAudio: false // đã nhấn vào biểu tượng music chưa
    //    property bool isMusicPlaying: false
    property real rate: 1
    MusicController {
        id: playMusic
    }
    Column {
        Row {
            RectMenu {
                anchors.verticalCenter: parent.verticalCenter
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
                        anchors.fill: rectVideo
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

