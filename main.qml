import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.LocalStorage 2.0

ApplicationWindow {

    visible: true
    width: 480
    height: 640
    title: qsTr("JTN - Just To Know")

    property var wg_current_quest_id;

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        FRM_Creator_list_quests {
            id: page1

            FRM_Quest_edit{
                id: page1_edit
                x: 0
                y: 0
                z: 2
                anchors.fill: parent
                visible: false
            }

            FRM_Edit_field{
                id: page1_fieldedit
                x: 0
                y: 0
                z: 3
                anchors.fill: parent
                visible: false
            }
        }

        Page {
            Label {
                text: qsTr("Page sondé")
                anchors.centerIn: parent
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            text: qsTr("Création")
        }
        TabButton {
            text: qsTr("Répondre")
        }
    }

    function init_database() {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")

        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS QUESTS(QUESTS_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, QUESTS_NAME TEXT, QUEST_DATE TEXT)');
                tx.executeSql('CREATE TABLE IF NOT EXISTS ANSWERS(ANSWERS_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ANSWERS_QUESTS_ID INT, ANSWERS_QUESTION_ID INT, ANSWERS_WHOIS TEXT)');
                tx.executeSql('CREATE TABLE IF NOT EXISTS QUESTIONS(QUESTIONS_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, QUESTS_ID INT, QUESTIONS_ORDER INT, QUESTIONS_TYPE INT, QUESTIONS_TITLE TEXT, QUESTIONS_ELEMENTS TEXT, QUESTIONS_ANSWERS TEXT)');
            }
        )
    }

    Component.onCompleted: init_database()
}
