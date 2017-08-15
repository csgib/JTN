import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0

import "../WIDGETS/"

Item {

    property int wl_update_status: 0
    property int wg_current_question_id

    Behavior on y {
        NumberAnimation {
            easing.amplitude: 0.5
            duration: 1000
            easing.type: Easing.OutBounce
        }
    }

    Behavior on x {
        NumberAnimation {
            easing.amplitude: 0.5
            duration: 1000
            easing.type: Easing.OutBounce
        }
    }

    Rectangle{
        anchors.fill: parent
        color: '#FFFFFF'
    }

    ToolBar {
        id: toolBar1
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        Row{
            width: parent.width
            layoutDirection: Qt.RightToLeft
            ToolButton {
                id: toolButton2
                y: 0
                width: 90
                height: 40
                text: qsTr("Annuler")
                onClicked: {
                    edit_field.y = applicationwindow.height
                }
            }

            ToolButton {
                id: toolButton1
                y: 0
                width: 90
                height: 40
                text: qsTr("Valider")
                onClicked: {
                    fn_valide_question()
                }
            }
        }
    }

    WID_Textarea {
        id: chp_question_libelle
        height: 193
        placeholderText: qsTr("Entrez votre question ...")
        anchors.top: toolBar1.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: 12
    }

    WID_Button{
        id: bt_add_answer
        x: 10
        y: chp_question_libelle.y + 200
        width: applicationwindow.width - 20
        visible: true
        button_title: qsTr("Ajouter")

        onClicked: {
            fn_add_answer()
        }
    }

    ListView {
        id: lv_answers_possible
        x: 0
        y: bt_add_answer.y + 50
        width: parent.width
        height: parent.height - (bt_add_answer.y + 50)
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        delegate: Item {
            property int indexOfThisDelegate: index
            x: 5
            width: parent.width
            height: 100

            WID_Textarea {
                y: 5
                text: name
                height: 90
                placeholderText: qsTr("Entrez le descriptif de la réponse possible")
                anchors.verticalCenter: parent.verticalCenter
                onTextChanged: {
                    mylm_answers_possible.set(indexOfThisDelegate,{"name": this.text})
                }
            }

            Button{
                text: "Supprimer"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.right
                onClicked: {
                    mylm_answers_possible.remove(1)
                }
            }
        }
        model: ListModel {
            id: mylm_answers_possible
        }
        add: Transition {
            NumberAnimation { properties: "y"; from: applicationwindow.height; duration: 400 }
        }
    }

    function fn_add_answer()
    {
        mylm_answers_possible.append({"name":"" })
    }

    function fn_valide_question()
    {
        var wl_idx = 0
        var wl_params = "";
        while ( wl_idx < mylm_answers_possible.rowCount() )
        {
            wl_params += mylm_answers_possible.get(wl_idx).name + "$%SPLIT%$";
            wl_idx++
        }

        if ( wl_update_status == 1 )
        {
            survey_edit.update_field(chp_question_libelle.text, wl_params)
        }
        else
        {
            survey_edit.add_field(chp_question_libelle.text, wl_params)
        }


        edit_field.y = applicationwindow.height
    }

    function reload_field(rp_quest_id, pr_current_quest_id)
    {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")

        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM QUESTIONS WHERE QUESTS_ID = ' + pr_current_quest_id + ' AND QUESTIONS_ID = ' + rp_quest_id);

                chp_question_libelle.text = rs.rows.item(0).QUESTIONS_TITLE
            }
        )
        wg_current_question_id = rp_quest_id
        wl_update_status = 1
    }
}
