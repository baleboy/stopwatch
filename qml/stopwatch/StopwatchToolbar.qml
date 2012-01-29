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

ToolBarLayout {

    property alias switchChecked: screenSaverSwitch.checked

    LabeledSwitch {
        id: screenSaverSwitch
        text: "Disable Screensaver"
        opacity: 0 // only visible when stopwatch is running

        anchors {
            verticalCenter: parent.verticalCenter
            horizontalCenter: parent.horizontalCenter
        }

        states: State {
            name: "active"
            when: stopwatch.running
            PropertyChanges { target: screenSaverSwitch; opacity: 1 }
        }

        transitions: Transition {
            NumberAnimation { property: "opacity"; easing.type: Easing.Linear; duration: 100 }
        }
    }

    AboutButton {
        id: about
        anchors {
             verticalCenter: parent.verticalCenter
             right: parent.right
        }
    }
}
