import QtQuick 2.0
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0

Item {
    ToolBar {
        id: toolBar
        x: 0
        y: 0
        width: 640
        height: 40

        ToolButton {
            id: toolButton
            x: parent.width - 40
            y: 0
            width: 40
            height: parent.height
            text: "*"
        }

        Image {
            id: toolbar_avatar
            x: 0
            y: 0
            width: 40
            height: 40
            source: ""
            fillMode: Image.PreserveAspectCrop
            visible: false
        }

        OpacityMask {
            anchors.fill: toolbar_avatar
            source: toolbar_avatar
            maskSource: Rectangle {
                width: toolbar_avatar.width
                height: toolbar_avatar.height
                radius: 40
                visible: false
            }
        }

        Text {
            id: toolbar_username
            x: 49
            y: 13
            width: 311
            height: 14
            text: ""
            font.pixelSize: 12
        }
    }

    Choose_profil{
        id: choose_profil
        x: 0
        y: toolBar.height
        width: applicationwindow.width
        height: applicationwindow.height - toolBar.height
        z: 9
        visible: true
    }

    /*Survey_list{
        id: survey_list
        x: 0
        y: applicationwindow.height
        width: applicationwindow.width
        height: applicationwindow.height
        z: 8
        visible: true
    }

    Survey_edit{
        id: survey_edit
        x: 0
        y: applicationwindow.height
        width: applicationwindow.width
        height: applicationwindow.height
        z: 9
        visible: true
    }

    Edit_field{
        id: edit_field
        x: 0
        y: applicationwindow.height
        width: applicationwindow.width
        height: applicationwindow.height
        z: 9
        visible: true
    }*/

    function init_env() {
        var wl_avatar = "file:" + wg_img_path + "/JTN_Avatar.jpg"
        toolbar_avatar.source = wl_avatar
        toolbar_username.text = wg_full_name
    }
}
