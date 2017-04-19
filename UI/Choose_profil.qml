import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.1
import QtGraphicalEffects 1.0

Item {

    Behavior on y {
        NumberAnimation {
            easing.amplitude: 0.5
            duration: 1000
            easing.type: Easing.OutBounce
        }
    }

    Rectangle{
        x: 0
        y: 0
        anchors.fill: parent
        color: "#000000"
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

    Button {
        id: button_profil_answer
        text: qsTr("Répondre à un questionnaire")
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: button_profil_answer.hovered ? "#d6d6d6" : "#f6f6f6"
            border.color: "#26282a"
            border.width: 1
            radius: 4
        }
        x: 10
        y: applicationwindow.height - 150
        width: applicationwindow.width - 20

        onClicked: {
        }
    }

    Button {
        id: button_profil_create
        text: qsTr("Créer un questionnaire")
        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 40
            color: button_profil_create.hovered ? "#d6d6d6" : "#f6f6f6"
            border.color: "#26282a"
            border.width: 1
            radius: 4
        }
        x: 10
        y: applicationwindow.height - 100
        width: applicationwindow.width - 20

        onClicked: {
            show_survey_list()
        }
    }

    function show_survey_list(){
            survey_list.load_quests_database()
            choose_profil.y = applicationwindow.height
    }
}

