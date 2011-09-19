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

