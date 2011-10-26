import QtQuick 1.1
import com.nokia.meego 1.0
import "Global.js" as Global

ListView {

    id: listView

    clip: true

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
            text: Global.toTime(time)
            color: parent.color

            font.pixelSize: 54
        }
    }

}
