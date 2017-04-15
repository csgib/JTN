import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    Rectangle{
        x: 0
        y: 0
        anchors.fill: parent
        color: "#000000"

        TextInput {
            id: textInput
            x: 134
            y: 310
            width: 359
            height: 16
            color: "#ffffff"
            text: qsTr("")
            font.pixelSize: 12
        }
    }

    Image {
        x: (applicationwindow.width - 100) / 2
        y: 80
        source: "../PIXMAPS/workspace.png"
    }

    Text {
        x: 10
        y: 210
        width: applicationwindow.width - 20
        text: qsTr("Bienvenue sur JTN - Just To kNown.\nIl me semble que c'est la première fois que vous venez ici.\nFaisons d'abord connaissance, comment vous appellez vous ?")
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        color: "white"
    }

    TextField{
        background: Rectangle {
            radius: 2
            border.color: "#333333"
            border.width: 1
            color: "black"
        }
        placeholderText: qsTr("Entrez votre nom ...")
        color: "white"
        x: 10
        y: applicationwindow.height - 210
        width: applicationwindow.width - 20
    }

    TextField{
        background: Rectangle {
            radius: 2
            border.color: "#333333"
            border.width: 1
            color: "black"
        }
        placeholderText: qsTr("Entrez votre prénom ...")
        color: "white"
        x: 10
        y: applicationwindow.height - 170
        width: applicationwindow.width - 20
    }

    Button {
        id: button
        text: qsTr("Valider")
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: button.hovered ? "#d6d6d6" : "#f6f6f6"
            border.color: "#26282a"
            border.width: 1
            radius: 4
        }
        x: 10
        y: applicationwindow.height - 100
        width: applicationwindow.width - 20
    }
}
