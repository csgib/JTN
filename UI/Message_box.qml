import QtQuick 2.0
import QtQuick.Controls 2.0
import "../WIDGETS/"

Item {

    Rectangle{
        x: 0
        y: 0
        anchors.fill: parent
        color: "#AAFF0000"
    }

    Text{
        anchors.fill: parent
        font.pointSize: 24
        text: "Ben y a une erreur"
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
    }

    /*FastBlur {
        source: welcome_new_user
        anchors.fill: parent
        radius: 64
    }*/
}

