import QtQuick
import QtQuick.Controls
import QtMultimedia
import QtQuick.Layouts
import QtQuick.Dialogs

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: "Video Player"

    // global variable for the selected video file path
    property string videoFilePath: ''


    // The Media Player Component
        MediaPlayer {
            id: mediaPlayer
            source: videoFilePath
            audioOutput: AudioOutput{}
            videoOutput: videoOutput
        }

        VideoOutput {
            id: videoOutput
            anchors.fill: parent
        }





    // Seek bar element
    Slider {
        id: seekBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        from: 0
        to: mediaPlayer.duration
        value: mediaPlayer.position

        // seek the video to the seek bar changeed value
        onMoved:{
            mediaPlayer.setPosition(value)
        }
    }

    Row {
        id: controlsRow
        anchors {
            left: parent.left
            right: parent.right
            bottom: seekBar.top
        }

        Button {
            id: playButton
            text: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "Pause" : "Play"
            onClicked: {
                           if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                               mediaPlayer.pause()
                           } else {
                               mediaPlayer.play()
                           }
                       }
        }

        Button {
                    id: selectButton
                    text: "Select Video"
                    onClicked: {
                       fileDialog.open()
                    }
                }
    }

    // open dialog for file selection
    FileDialog {
       id: fileDialog
       // select only video files
       nameFilters: ["Video Files (*.mp4 *.avi *.mov)"]
       onAccepted: {
           videoFilePath = fileDialog.selectedFile
           mediaPlayer.play()
       }
    }

}
