import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import "../WIDGETS/"

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

    WID_Textfield{
        id: chp_first_name
        placeholderText: qsTr("Entrez votre nom ...")
        x: 10
        y: applicationwindow.height - 210
        width: applicationwindow.width - 20
    }

    WID_Textfield{
        id: chp_last_name
        placeholderText: qsTr("Entrez votre prénom ...")
        x: 10
        y: applicationwindow.height - 170
        width: applicationwindow.width - 20
    }


    WID_Button{
        x: 10
        y: applicationwindow.height - 100
        width: applicationwindow.width - 20
        visible: true
        z: 11
        button_title: qsTr("Valider")

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

    function create_user()
    {
        if ( chp_first_name.text == "" || chp_last_name == "" )
        {
            // ben la y a erreur
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
            choose_profil.x = 0
        }
    }
}
