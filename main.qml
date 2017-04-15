import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.LocalStorage 2.0
import "UI/"

ApplicationWindow {

    id: applicationwindow
    visible: true
    width: 480
    height: 640
    title: qsTr("JTN - Just To Know")

    property string wg_full_name


    Welcome_new_user{
        id: welcome_new_user
        anchors.fill: parent
        x: 0
        y: 0
        visible: false
    }

    Choose_profil{
        id: choose_profil
        anchors.fill: parent
        x: 0
        y: 0
        visible: false
    }

    function init_database() {
        var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")
        var wl_record_users;
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS USERS(USERS_FIRST_NAME TEXT, USERS_LAST_NAME TEXT)')
                tx.executeSql('CREATE TABLE IF NOT EXISTS QUESTS(QUESTS_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, QUESTS_NAME TEXT, QUEST_DATE TEXT)')
                tx.executeSql('CREATE TABLE IF NOT EXISTS ANSWERS(ANSWERS_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, ANSWERS_QUESTS_ID INT, ANSWERS_QUESTION_ID INT, ANSWERS_WHOIS TEXT)')
                tx.executeSql('CREATE TABLE IF NOT EXISTS QUESTIONS(QUESTIONS_ID INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, QUESTS_ID INT, QUESTIONS_ORDER INT, QUESTIONS_TYPE INT, QUESTIONS_TITLE TEXT, QUESTIONS_ELEMENTS TEXT, QUESTIONS_ANSWERS TEXT)')
                wl_record_users = tx.executeSql('SELECT * FROM USERS')
            }
        )

        if ( wl_record_users.rows.length == 0 )
        {
            welcome_new_user.visible = true
        }
        else
        {
            wg_full_name = wl_record_users.rows.item(0).USERS_FIRST_NAME + " " + wl_record_users.rows.item(0).USERS_LAST_NAME
            choose_profil.visible = true
        }

    }

    Component.onCompleted: init_database()
}
