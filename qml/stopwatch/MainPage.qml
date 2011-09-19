import QtQuick 1.1
import com.nokia.meego 1.0
import "Global.js" as Global

Page {

    id: mainPage

    property int elapsed: 0
    property int lapCount: 0
    property bool running: false

    orientationLock: PageOrientation.LockPortrait

    Connections {
        target: platformWindow
        onVisibleChanged: if (!platformWindow.visible)
                             stopwatch.suspend()
                         else
                             stopwatch.resume()

    }

    function zeroPad(n) {
        var s = n.toString()
        if (s.length === 1)
            s = '0' + s
        return s
    }

    function toTime(msec) {
        return (msec >= 36000 ? Math.floor(msec / 36000) + ':' : '') +
                      zeroPad(Math.floor((msec % 36000) / 600)) + ':' +
                      zeroPad(Math.floor((msec % 600) / 10)) + '.' +
                      msec % 10
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
                 GradientStop { position: 0.0; color: "grey" }
                 GradientStop { position: 0.15; color: "black" }
             }
    }

    ReflectedLabel {
        id: timerText
        pixelSize: 90
        textColor: "white"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter

        text: toTime(elapsed)
    }

    ListModel {
        id: lapList
    }

    BigButton {
        id: startButton

        anchors.top: timerText.bottom
        anchors.topMargin: 60
        anchors.left: parent.left
        anchors.leftMargin: 30

        text:  "Start"
        imageSource: "images/green-button.png"

        onClicked: {
            running = !running
            if (!running)
                stopwatch.stop()
            else
                stopwatch.start()
        }
    }

    BigButton {
        id: clearButton

        anchors.top: startButton.top
        anchors.right: parent.right
        anchors.rightMargin: 30

        text:  "Reset"

        onClicked: {
            if (stopwatch.running) {
                console.log("lap: " + lapCount)
                lapCount++
                lapList.insert(0, {"lap": lapCount, "time": timerText.text})
            }
            else {
                elapsed = 0
                lapCount = 0
                lapList.clear()
            }
        }
    }

    ListView {

        id: listView
        anchors.top: startButton.bottom
        anchors.topMargin: 50
        clip: true
        anchors.bottom: parent.bottom
        width: parent.width

        model: lapList

        delegate: Item {
            id: root
            property string color
            color: if (index === 0)
                       "white"
                   else
                       "gray"
            height: 85
            width:  parent.width

            ListView.onAdd: SequentialAnimation {
                PropertyAction { target: root; property: "opacity"; value: 0 }
                NumberAnimation { target: root; property: "height"; from: 0; to: 85 ; duration: 150 ; easing.type: Easing.InOutQuad }
                NumberAnimation { target: root; property: "opacity"; from: 0; to: 1; duration: 100 }
            }

            Label {
                id: lapNumber
                anchors.left: parent.left
                anchors.leftMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                text: "Lap " + lap
                color: parent.color

                font.pixelSize: 34
            }
            Label {
                id: lapTime
                anchors.left: parent.left
                anchors.leftMargin: 200
                anchors.verticalCenter: parent.verticalCenter
                text: time
                color: parent.color

                font.pixelSize: 54
            }
        }

    }

    AboutButton {
        id: about
        anchors.bottom: mainPage.bottom
        anchors.right: mainPage.right
        anchors.margins: 5
    }

    Timer {
        function suspend() {
            if (mainPage.running) {
                console.log("suspended")
                Global.suspendTime = new Date
                stopwatch.stop()
            }
        }

        function resume() {
            if (mainPage.running) {
                var resumeTime = new Date
                elapsed += (resumeTime.getTime() - Global.suspendTime.getTime()) / 100 - 1
                console.log("resumed")
                stopwatch.start()
            }
        }

        id: stopwatch

        interval:  100
        repeat:  true
        running: false
        triggeredOnStart: true

        onTriggered: {
            elapsed++
        }
    }

    states: State {
        name:  "running"
        when:  mainPage.running
        PropertyChanges { target: startButton; imageSource: "images/red-button.png"}
        PropertyChanges { target: startButton; text: "Stop" }
        PropertyChanges { target: clearButton; text: "Lap" }
    }
}
