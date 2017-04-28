import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1.0

Item {


    Rectangle{
        x: 0
        y: 0
        anchors.fill: parent
        color: "#BBFFFFFF"
    }

    Image {
        source: "../PIXMAPS/workspace.png"
    }

    Text {
        x: 10
        y: 210
        width: applicationwindow.width - 20
        text: qsTr("Bienvenue sur JTN - Just To kNown.\nIl me semble que c'est la première fois que vous venez ici.\nFaisons d'abord connaissance, comment vous appellez vous ?")
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        color: "#141424"
    }

    TextField{
        id: chp_first_name
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
        id: chp_last_name
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
        id: button_valide_profil
        text: qsTr("Valider")
        background: Rectangle {

            implicitWidth: 100
            implicitHeight: 40
            LinearGradient {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0; color: "#fffea444" }
                    GradientStop { position: 1; color: "#ffe76d17" }
                }
                start: Qt.point(0, 0)
                end: Qt.point(0, parent.height)
            }
            border.color: "#c4721c"
            border.width: 2
            radius: 8
        }
        x: 10
        y: applicationwindow.height - 100
        width: applicationwindow.width - 20

        onClicked: {
            create_user()
        }
    }

    Behavior on y {
        NumberAnimation {
            easing.amplitude: 0.5
            duration: 1000
            easing.type: Easing.OutBounce
        }
    }



    MessageDialog {
        id: new_user_error
        visible: false
        title: qsTr("Erreur")
        text: qsTr("Vous devez renseigner votre nom et votre prénom pour continuer")
    }

    function create_user()
    {
        if ( chp_first_name.text == "" || chp_last_name == "" )
        {
            new_user_error.visible = true
        }
        else
        {
            var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")

            db.transaction(
                function(tx) {
                    tx.executeSql('INSERT INTO USERS VALUES(?, ?)', [ chp_first_name.text, chp_last_name.text ])
                }
            )

            wg_full_name = chp_first_name.text + " " + chp_last_name.text
            welcome_new_user.y = applicationwindow.height
        }
    }
}
