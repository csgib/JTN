import QtQuick 2.0
import QtQuick.Controls 2.0
import "../WIDGETS/"

Item {

    Rectangle{
        x: 0
        y: 0
        anchors.fill: parent
        color: "#BBFFFFFF"
    }

    Behavior on x {
        NumberAnimation {
            easing.amplitude: 0.5
            duration: 1000
            easing.type: Easing.OutBounce
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

    WID_Button {
        id: button_profil_answer
        button_title: qsTr("Répondre à un questionnaire")
        x: 10
        y: applicationwindow.height - 150
        width: applicationwindow.width - 20

        onClicked: {
        }
    }

    WID_Button {
        id: button_profil_create
        button_title: qsTr("Gérer vos questionnaires")
        x: 10
        y: applicationwindow.height - 100
        width: applicationwindow.width - 20

        onClicked: {
            show_survey_list()
        }
    }

    function show_survey_list(){
            survey_list.load_quests_database()
            choose_profil.x = -applicationwindow.width
            survey_list.y = 0
    }
}

