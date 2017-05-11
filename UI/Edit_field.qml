import QtQuick 2.0
import QtQuick.Controls 2.0
import "../WIDGETS/"

Item {

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
        delegate: Item {
            x: 5
            width: parent.width
            height: 100
            WID_Textarea {
                y: 5
                text: name
                height: 90
                placeholderText: qsTr("Entrez le descriptif de la réponse possible")
                anchors.verticalCenter: parent.verticalCenter
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
        mylm_answers_possible.append({"name":"Pizza"})
    }

    function fn_valide_question()
    {
        var wl_idx = 0
        while ( wl_idx < mylm_answers_possible.rowCount() )
        {
            console.log( mylm_answers_possible.get(wl_idx).attributes.get(0).value )
            wl_idx++
        }

        survey_edit.add_field(chp_question_libelle.text)
        edit_field.y = applicationwindow.height
    }
}
