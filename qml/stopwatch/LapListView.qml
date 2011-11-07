import QtQuick 1.1
import com.nokia.meego 1.0

import "Global.js" as Global

ListView {

    id: listView

    clip: true

    delegate: Item {
        id: root

        property string color: index === 0 ? "white" : "gray"
        property int maxHeight: 70

        width:  parent.width
        height: maxHeight

        // appear and disappear animations for list items
        ListView.onAdd: SequentialAnimation {
            PropertyAction { target: root; property: "opacity"; value: 0 }
            NumberAnimation { target: root; property: "height"; from: 0; to: maxHeight ; duration: 150 ; easing.type: Easing.InOutQuad }
            NumberAnimation { target: root; property: "opacity"; from: 0; to: 1; duration: 100 }
        }

        ListView.onRemove: SequentialAnimation {
            PropertyAction { target: root; property: "ListView.delayRemove"; value: true }
            ParallelAnimation {
                NumberAnimation { target: root; property: "height"; from: maxHeight; to: 0 ; duration: 150 ; easing.type: Easing.InOutQuad }
                NumberAnimation { target: root; property: "opacity"; from: 1; to: 0; duration: 200 }
            }
            PropertyAction { target: root; property: "ListView.delayRemove"; value: false }
        }

        Row {
            MyLabel {
                id: lapNumberLabel
                width: 65
                text: lap + ":"
                color: root.color
            }

            MyLabel {
                id: totalTimeLabel
                width: 140
                text: Global.toTime(totalTime)
                color: root.color
            }

            MyLabel {
                id: lapTimeLabel
                width: 140
                text: Global.toTime(time)
                color: root.color
            }

            MyLabel {
                id: deltaLabel
                width: 80
                text: lap > 1 ? Global.toDelta(delta) : ""
                color: root.color
            }

        }
    }
}
