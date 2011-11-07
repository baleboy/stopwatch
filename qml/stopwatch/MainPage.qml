/*

Copyright (C) 2011 Francesco Balestrieri

This file is part of Stopwatch - a simple stopwatch for Nokia N9

Stopwatch is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Stopwatch is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Stopwatch.  If not, see <http://www.gnu.org/licenses/>.

*/

import QtQuick 1.1
import com.nokia.meego 1.0
import "Global.js" as Global

Page {

    id: mainPage

    property int elapsed: 0
    property int lapCount: 0
    property bool running: false
    property int lapTime: 0
    property int lapDelta: lapList.count > 0 ? lapTime - lapList.get(0).time : 0

    orientationLock: PageOrientation.LockPortrait

    Connections {
        target: platformWindow
        onVisibleChanged: if (!platformWindow.visible)
                             stopwatch.suspend()
                         else
                             stopwatch.resume()

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
        anchors {
            top: parent.top
            topMargin: 60
            horizontalCenter: parent.horizontalCenter
        }

        text: Global.toTime(elapsed)
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
                lapCount++
                lapList.insert(0, {"lap": lapCount, "time": lapTime,
                                   "totalTime": elapsed, "delta": lapDelta})

                lapTime = 0
            }

            else {
                elapsed = 0
                lapCount = 0
                lapTime = 0
                lapList.clear()
            }
        }
    }

    LapListView {
        id: lapListView
        model: lapList

        anchors {
            top: startButton.bottom
            topMargin: 50
            left: startButton.left
            bottom: parent.bottom
        }
        width: parent.width
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
                var delta = (resumeTime.getTime() - Global.suspendTime.getTime()) / 100 - 1
                elapsed += delta
                lapTime += delta
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
            lapTime++
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
