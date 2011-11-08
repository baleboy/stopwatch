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

    width: image.width
    height: image.height

    Image {
        id: image
        width: 36
        height: 36
        source: "images/info-button.png"
    }

    Image {
        id: highlight
        width: 36
        height: 36
        source: "images/info-button-pressed.png"
        opacity: 0
    }

    MouseArea {
        id: clickable
        anchors.centerIn: parent.Center
        width: image.width + 20
        height: image.height + 20
        onClicked: query.open()
    }

    states: State {
        name: "pressed"; when: clickable.pressed === true
        PropertyChanges { target: highlight; opacity: .7 }
    }

    QueryDialog {
        id: query

        icon: "images/stopwatch.png"
        titleText: "Stopwatch 1.1"
        message: "(c) 2011 Francesco Balestrieri\n\n"
                 + "bale@balenet.com\n\n"
                 + "Icon by Oliver Scholtz (schollidesign.deviantart.com)"
        acceptButtonText: "Send Feedback"
        onAccepted: Qt.openUrlExternally("mailto:bale@balenet.com?subject=Feedback about Stopwatch 1.0")
        rejectButtonText: "Close"
    }
}
