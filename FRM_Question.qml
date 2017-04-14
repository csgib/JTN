import QtQuick 2.0
import QtQuick.Controls 2.0

Item {
    id: item1

    Text {
        id: question_number
        x: 31
        y: 34
        width: 51
        height: 60
        font.pixelSize: 12
    }

    Text {
        id: question_text
        x: 103
        y: 34
        width: 499
        height: 128
        font.pixelSize: 12
    }

    Button {
        id: bt_next
        x: 260
        y: 418
        width: 342
        height: 40
        text: qsTr("Button")
    }

    Button {
        id: button1
        x: 103
        y: 251
        text: qsTr("Button")
        opacity: 0
    }

    Button {
        id: button2
        x: 414
        y: 251
        text: qsTr("Button")
        opacity: 0
    }
    states: [
        State {
            name: "YesNo"

            PropertyChanges {
                target: button1
                text: qsTr("Yes")
                opacity: 1
            }

            PropertyChanges {
                target: button2
                text: qsTr("No")
                opacity: 1
            }
        }
    ]

}
