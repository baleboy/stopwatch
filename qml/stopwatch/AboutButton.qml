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
        titleText: "Stopwatch 1.0"
        message: "(c) 2011 Francesco Balestrieri\n\n"
                 + "bale@balenet.com\n\n"
                 + "Icon by Oliver Scholtz (schollidesign.deviantart.com)"
        acceptButtonText: "Send Feedback"
        onAccepted: Qt.openUrlExternally("mailto:bale@balenet.com?subject=Feedback about Stopwatch 1.0")
        rejectButtonText: "Close"
    }
}
