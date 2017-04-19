import QtQuick 2.7

Item {
    width: parent.width
    height: parent.height
    id: toto

    Rectangle{
        id: rectangle2
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#EEEEEE"

        Image {
            id: image1
            x: parent.width - 50
            y: 0
            width: parent.height
            height: parent.height
            source: "../PIXMAPS/delete.png"
            opacity: 1
        }

        Image {
            id: image2
            x: parent.width - 110
            y: 0
            width: parent.height
            height: parent.height
            source: "../PIXMAPS/edit.png"
            opacity: 1

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    glob_reload_quest()
                }
            }
        }
    }

    Rectangle{
        id: rectangle1
        color: "#FFFFFF"
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        z: 1

        Text {
            text: name
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
        }

        Text {
            text: questid
            visible: false
        }

        Rectangle{
            color: "#EAEAEA"
            x: 0
            y: parent.height -1
            width: parent.width
            height: 1
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                wg_current_quest = index
                toto.state == 'State1' ? toto.state = "" : toto.state = 'State1'
            }
        }
    }

    states: [
        State {
            name: "State1"

            PropertyChanges {
                target: rectangle1
                z: 1
                width: parent.width - 120
            }
        }
    ]

    transitions: [
        Transition {
            NumberAnimation { properties: "x, y, width"
                duration: 600
                easing.type: Easing.OutBounce
            }
        }
    ]
}
