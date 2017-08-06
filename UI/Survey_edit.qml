import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import QtQml.Models 2.1
import "../WIDGETS/"

Item {

    property int wg_current_type

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
        x: 0
        y: 0
        anchors.fill: parent
        color: "#BBFFFFFF"
    }

    ToolBar {
        id: tb_survey_edit
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        ToolButton {
            id: toolButton1
            x: 12
            y: 0
            width: 84
            height: 40
            text: qsTr("Valider")
            anchors.right: parent.right
            anchors.rightMargin: 10
            enabled: true
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false
            onClicked: {
                save_quest()
            }
        }

        ToolButton {
            id: toolButton2
            x: 12
            y: 0
            width: 84
            height: 40
            text: qsTr("Annuler")
            anchors.right: toolButton1.left
            anchors.rightMargin: 10
            enabled: true
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false
            onClicked: {
                survey_list.x = 0
                survey_edit.y = applicationwindow.height
            }
        }
    }

    WID_Textfield{
        id: name_quest
        anchors.top: tb_survey_edit.bottom
        anchors.topMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        placeholderText: qsTr("Entrez ici le titre de votre questionnaire ...")
    }

    Rectangle{
        id: support_lv_field_type
        z: 2
        x: applicationwindow.width
        y: 0
        width: applicationwindow.width
        height: applicationwindow.height

        ListView {
            id: lv_field_type
            anchors.fill: parent
            boundsBehavior: Flickable.StopAtBounds
            delegate: Item {
                x: 5
                width: parent.width
                height: 40
                    Text {
                        text: name
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                    }
                    Text {
                        text: type
                        visible: false
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            wg_current_type = index
                            support_lv_field_type.x = applicationwindow.width
                            edit_field.y = 0
                            bt_add_field.visible = true
                        }
                    }

            }
            model: ListModel {
                id: mylm
                ListElement {
                    name: "Réponse OUI / NON"
                    type: 0
                }

                ListElement {
                    name: "Choix simple"
                    type: 1
                }

                ListElement {
                    name: "Choix multiple"
                    type: 2
                }

                ListElement {
                    name: "Valeur / Notation"
                    type: 3
                }
            }
        }
    }

    Component {
        id: dragDelegate

        MouseArea {
            id: dragArea
            property bool held: false

            anchors { left: parent.left; right: parent.right }
            height: content.height

            drag.target: held ? content : undefined
            drag.axis: Drag.YAxis

            onPressAndHold: {
                held = true
            }
            onReleased: held = false

            Rectangle {
                id: content

                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                width: dragArea.width; height: column.implicitHeight + 4

                border.width: 1
                border.color: "lightsteelblue"
                color: dragArea.held ? "lightsteelblue" : "white"
                Behavior on color { ColorAnimation { duration: 100 } }
                radius: 2

                Drag.active: dragArea.held
                Drag.source: dragArea
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2

                states: State {
                    when: dragArea.held

                    ParentChange { target: content; parent: dragArea }
                    AnchorChanges {
                        target: content
                        anchors { horizontalCenter: undefined; verticalCenter: undefined }
                    }
                }

                Column {
                    id: column
                    anchors { fill: parent; margins: 2 }

                    Text { text: 'Type : ' + name }
                    Text { text: 'Quest : ' + question }
                }
            }

            DropArea {
                anchors { fill: parent; margins: 10 }


                onEntered: {

                    //console.log(drag.source.DelegateModel.itemsIndex + " " + dragArea.DelegateModel.itemsIndex)

                    if ( drag.source.DelegateModel.itemsIndex != dragArea.DelegateModel.itemsIndex )
                    {
                        contactmodel.move(drag.source.DelegateModel.itemsIndex, dragArea.DelegateModel.itemsIndex, 1)
                    }

                    visualModel.items.move(
                            drag.source.DelegateModel.itemsIndex,
                            dragArea.DelegateModel.itemsIndex)

                }
            }
        }
    }

    ListModel {
        id: contactmodel
    }

    DelegateModel {
        id: visualModel

        model: contactmodel
        delegate: dragDelegate
    }

    ListView {
        id: mylv
        model: visualModel
        x: 0
        z: 1
        spacing: 4
        cacheBuffer: 50
        width: applicationwindow.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: name_quest.bottom
        anchors.topMargin: 10
        boundsBehavior: Flickable.StopAtBounds
        delegate: Item {
            x: 5
            width: parent.width
            height: 40
            Row {
                id: row1
                spacing: 10
                Image {
                    source: '../PIXMAPS/close.png'
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }

                Text {
                    text: question
                    font.italic: true
                }
            }
        }
    }

    Image{
        id: bt_add_field
        source: "../PIXMAPS/button_add.png"
        y: applicationwindow.height - 70
        x: applicationwindow.width - 70
        z: 2
        width: 50
        height: 50
        fillMode: Image.PreserveAspectFit
        MouseArea{
            anchors.fill: parent
            onClicked: {
                support_lv_field_type.x = 0
                bt_add_field.visible = false
            }
        }
    }

    function init_quest()
    {
        name_quest.text = ""
        lv2model.clear()
    }

    function save_quest()
    {
        var wl_idx = 0
        while ( wl_idx < contactmodel.rowCount() )
        {
            console.log(contactmodel.get(wl_idx).name )

            wl_idx++
        }


        /*var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database");

        if ( wg_current_quest_id == "" )
        {
            db.transaction(
                function(tx) {
                    tx.executeSql('INSERT INTO QUESTS VALUES(?, ?, ?)', [ , name_quest.text, Qt.formatDate(new Date(),"yyyyMMdd") ])
                }
            )
        }
        else
        {
            db.transaction(
                function(tx) {
                    var rs = tx.executeSql('UPDATE QUESTS SET QUESTS_NAME = "' + name_quest.text + '" WHERE QUESTS_ID = ' + wg_current_quest_id);
                }
            )
        }
        survey_edit.y = applicationwindow.height
        survey_list.x = 0
        survey_list.rename_quest()*/
    }

    function reload_quest(id)
    {
        //mylv.model.clear()
        wg_current_quest_id = id

        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM QUESTIONS WHERE QUESTS_ID = ' + id + ' ORDER BY QUESTIONS_ORDER');
                var wl_name
                for(var i = 0; i < rs.rows.length; i++) {
                    switch(rs.rows.item(i).QUESTIONS_TYPE)
                    {
                        case 0:
                            wl_name = "Réponse OUI / NON"
                            break
                        case 1:
                            wl_name = "Choix simple"
                            break
                        case 2:
                            wl_name = "Choix multiple"
                            break
                        case 3:
                            wl_name = "Valeur / Notation"
                            break
                    }
                    contactmodel.append({name: wl_name, question: rs.rows.item(i).QUESTIONS_TITLE})
                    //mylv.model.append({name: wl_name, question: rs.rows.item(i).QUESTIONS_TITLE})
                }
            }
        )
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM QUESTS WHERE QUESTS_ID = ' + id);

                name_quest.text = rs.rows.item(0).QUESTS_NAME
            }
        )
    }

    function add_field(wl_question_title)
    {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")

        db.transaction(
            function(tx) {
                tx.executeSql('INSERT INTO QUESTIONS VALUES(?, ?, ?, ?, ?, ?, ?)', [ , wg_current_quest_id, 0, mylm.get(wg_current_type).type, wl_question_title, '', '' ])
            }
        )
        mylv.model.append({name: mylm.get(wg_current_type).name, question: wl_question_title})
    }
}
