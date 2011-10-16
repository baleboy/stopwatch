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

    id: reflectedLabel

    property alias text: mainLabel.text
    property int pixelSize
    property alias textColor: mainLabel.color

    property real reflectRatio: 0.5
    property string fadeColor : "#000000"

    width: mainLabel.width
    height: mainLabel.height * (1 + reflectRatio )

    clip: true

    Text {
        id: mainLabel
        font.pixelSize: reflectedLabel.pixelSize
        // font.bold
        style: Text.Sunken
    }

    Text {
        id: reflection
        anchors.top: mainLabel.bottom
        font.pixelSize: reflectedLabel.pixelSize
        text: mainLabel.text
        color: mainLabel.color
        font.bold: mainLabel.font.bold
        style: mainLabel.style

        transform: Rotation {
             origin.x: reflection.width / 2
             origin.y: reflection.height / 2
             axis.x: 1; axis.y: 0; axis.z: 0
             angle: 180
         }
    }
    Rectangle {
        anchors.top: mainLabel.bottom
        width:  mainLabel.width
        height: mainLabel.height * reflectRatio + 1

        gradient: Gradient {

            GradientStop {
                position: 0.0
                color: "#00" + fadeColor.substring(1)
            }
            GradientStop {
                position: 1.0
                color: "#FF" + fadeColor.substring(1)
            }
        }
    }
}
