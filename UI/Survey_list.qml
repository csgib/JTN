import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import QtQml 2.2

Item {

    property var wg_current_quest

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
                survey_list.y = applicationwindow.height
                choose_profil.x = 0
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
                    var wl_name = rs.rows.item(i).QUESTS_NAME
                    if ( wl_name === null )
                    {
                        wl_name = "..."
                    }
                    listView1.model.append({name: wl_name, questid: rs.rows.item(i).QUESTS_ID})
                }
            }
        )
    }

    function create_quest()
    {
        survey_list.x = applicationwindow.width
        survey_edit.y = 0
        wg_current_quest_id = ""
    }

    function glob_reload_quest()
    {
        survey_list.x = applicationwindow.width
        survey_edit.y = 0
        wg_current_quest_id = mylq.get(wg_current_quest).questid
        survey_edit.reload_quest(wg_current_quest_id)
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
