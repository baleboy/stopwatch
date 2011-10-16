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

Item {
    id: button
    signal clicked
    property alias text: buttonText.text
    property alias imageSource: image.source
    width: 190
    height: 78

    Image {
        id: image
        source: "images/black-button.png"
        anchors.fill:  parent
    }

    Image {
        id: highlight
        source: "images/pressed-button.png"
        anchors.fill:  parent
        opacity: 0
    }
    Label {
        id: buttonText
        text:  "Text"
        color: "white"
        font.pointSize: 56

        anchors.centerIn: parent
    }

    MouseArea {
        id: clickable
        anchors.fill: parent
        onClicked: button.clicked()
    }

    states: State {
        name: "pressed"; when: clickable.pressed === true
        PropertyChanges { target: highlight; opacity: .7 }
    }
}

