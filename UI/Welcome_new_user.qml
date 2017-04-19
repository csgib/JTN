import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0

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
            color: button_valide_profil.hovered ? "#d6d6d6" : "#f6f6f6"
            border.color: "#26282a"
            border.width: 1
            radius: 4
        }
        x: 10
        y: applicationwindow.height - 100
        width: applicationwindow.width - 20

        onClicked: {
            create_user()
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
