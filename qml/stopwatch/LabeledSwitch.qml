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

    property alias checked: onOff.checked
    property alias text: switchText.text

    width: switchText.width + onOff.width + 8
    height: onOff.height

    Label {
        id: switchText
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }

    Switch {
        id: onOff
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
}

