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
