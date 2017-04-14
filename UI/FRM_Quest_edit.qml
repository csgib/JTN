import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0

Item {

    property int wg_current_type

    Rectangle{
        anchors.fill: parent
        color: '#FFFFFF'
    }

    id: item1

    TextInput{
        id: name_quest
        anchors.top: toolBar1.bottom
        anchors.topMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        text: qsTr("Entre un titre pour votre questionnaire ...")
    }

    ListView {
        id: listView1
        height: 160
        anchors.top: name_quest.bottom
        anchors.topMargin: 6
        anchors.left: parent.left
        anchors.leftMargin: 27
        anchors.right: parent.right
        anchors.rightMargin: 8
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
                        //console.log(index)
                        wg_current_type = index
                        page1_fieldedit.visible = true
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

    ListView {
        id: listView2
        x: 27
        width: 605
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.top: listView1.bottom
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
                    source: 'close.png'
                }

                Text {
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    font.bold: true
                }
            }
        }
        model: ListModel {}
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
                page1.rename_quest(name_quest)

                page1_edit.visible = false
            }
        }
    }


    function save_quest()
    {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('UPDATE QUESTS SET QUESTS_NAME = "' + name_quest.text + '" WHERE QUESTS_ID = ' + wg_current_quest_id);
            }
        )

    }

    function reload_quest(id)
    {
        listView2.model.clear()
        wg_current_quest_id = id
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")
        db.transaction(
            function(tx) {
                var rs = tx.executeSql('SELECT * FROM QUESTIONS WHERE QUESTS_ID = ' + id + ' ORDER BY QUESTIONS_ORDER');
                var wl_name
                for(var i = 0; i < rs.rows.length; i++) {
                    console.log(rs.rows.item(i).QUESTIONS_TYPE)
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
                    listView2.model.append({name: wl_name})
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

    function add_field()
    {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")

        db.transaction(
            function(tx) {
                tx.executeSql('INSERT INTO QUESTIONS VALUES(?, ?, ?, ?, ?, ?, ?)', [ , wg_current_quest_id, 0, mylm.get(wg_current_type).type,'','','' ])
            }
        )
        listView2.model.append({name: mylm.get(wg_current_type).name})
    }
}
