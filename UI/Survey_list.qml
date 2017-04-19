import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import QtQml 2.2

Item {

    property var wg_current_quest

    ToolBar {
        id: toolBar1
        height: 40
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        z: 1

        ToolButton {
            id: toolButton1
            x: 12
            y: 0
            width: 84
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: 10
            enabled: true
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false
            text: qsTr("Ajouter")
            onClicked: {
                create_quest()
                page1_edit.visible = true
            }
        }

        ToolButton {
            id: toolButton2
            x: 12
            y: 0
            width: 84
            height: 40
            anchors.right: toolButton1.left
            anchors.rightMargin: 10
            enabled: true
            autoExclusive: false
            checked: false
            checkable: false
            highlighted: false
            text: qsTr("Fermer")
            onClicked: {
                choose_profil.y = 0
            }
        }
    }

    ListView {
        id: listView1
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: toolBar1.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 436
        height: 133
        z: 0
        boundsBehavior: Flickable.StopAtBounds
        delegate: Item {
            x: 5
            width: parent.width
            height: 40
            Quest_Item{
            }
        }
        model: ListModel {
            id: mylq
        }
    }

    function load_quests_database() {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database");

        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM QUESTS ORDER BY QUEST_DATE DESC');

                var r = ""
                for(var i = 0; i < rs.rows.length; i++) {
                    console.log("A = " + rs.rows.item(i).QUESTS_ID + " " + rs.rows.item(i).QUESTS_NAME);
                    listView1.model.append({name: rs.rows.item(i).QUESTS_NAME, questid: rs.rows.item(i).QUESTS_ID})
                }
            }
        )
    }

    function create_quest() {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database");

        db.transaction(
            function(tx) {
                tx.executeSql('INSERT INTO QUESTS VALUES(?, ?, ?)', [ , 'COUCOU', Qt.formatDate(new Date(),"yyyyMMdd") ])
                var result = tx.executeSql('SELECT QUESTS_ID FROM QUESTS ORDER BY QUESTS_ID DESC LIMIT 1')
                wg_current_quest_id = result.rows.item(0).QUESTS_ID
            }
        )

        survey_edit.visible = true
    }

    function glob_reload_quest()
    {
        survey_edit.visible = true
        survey_edit.reload_quest(mylq.get(wg_current_quest).questid)
    }

    function rename_quest(wl_name)
    {
        listView1.model.clear()
        load_quests_database()
        //mylq.set(wg_current_quest).name = wl_name
        //mylq.setProperty(wg_current_quest, "name", wl_name)
        //listView1.contentItem.children[wg_current_quest].name = wl_name
    }

    //Component.onCompleted: load_database()

}
