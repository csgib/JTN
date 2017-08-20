import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.LocalStorage 2.0
import QtMultimedia 5.8
import QtGraphicalEffects 1.0
import "../WIDGETS/"

Item {

    Rectangle{
        id: background_welcome_new_user
        x: 0
        y: 0
        anchors.fill: parent
        color: "#BBFFFFFF"


        TabBar {
            id: tabBar1
            x: 0
            y: parent.height - 40
            width: parent.width
            z: 3
            TabButton {
                text: "Données"
            }

            TabButton {
                text: "Photo"
            }
        }

        SwipeView {
            id: swipeView
            x: 0
            y: 0
            interactive: false
            width: parent.width
            height: parent.height - tabBar1.height
            currentIndex: tabBar1.currentIndex

            Item {
                z: 2

                Rectangle{
                    x: 0
                    y: 0
                    width: parent.width
                    height: parent.height / 3
                    color: '#f6f6f2'
                    Image {
                        id: avatar_profil
                        anchors.fill: parent
                        source: "../PIXMAPS/avatar.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                WID_Textfield{
                    id: chp_first_name
                    placeholderText: qsTr("Entrez votre nom ...")
                    x: 10
                    y: applicationwindow.height - 210
                    width: applicationwindow.width - 20
                }

                WID_Textfield{
                    id: chp_last_name
                    placeholderText: qsTr("Entrez votre prénom ...")
                    x: 10
                    y: applicationwindow.height - 170
                    width: applicationwindow.width - 20
                }


                WID_Button{
                    x: 10
                    y: applicationwindow.height - 100
                    width: applicationwindow.width - 20
                    visible: true
                    z: 11
                    button_title: qsTr("Valider")

                    onClicked: {
                        fn_manage_user()
                    }
                }

            }

            Item {
                z: 2
                Camera {
                    id: camera
                    position: Camera.FrontFace

                    imageCapture {
                        //resolution: Qt.size(320, 240)
                        onImageCaptured: {
                            photoPreview.source = preview
                            console.log(montoto)

                        }

                        onCaptureFailed: {
                            console.log("ERREUR CAPTURE IMAGE")
                        }
                    }
                }

                VideoOutput {
                    source: camera
                    x: 0
                    y: 0
                    width: parent.width
                    height: parent.height
                    autoOrientation: true
                    fillMode: Image.PreserveAspectCrop
                }

                Image {
                    id: photoPreview
                    x: 400
                    y: 0
                    width: 400
                    height: 300
                    visible: false
                }

                Button{
                    text: "Capture"
                    x: 100
                    y: 350
                    width: 100
                    height: 32
                    onClicked: {
                        //camera.imageCapture.capture()
                        camera.imageCapture.captureToLocation(montoto & "/toto.jpg")
                        console.log(camera.imageCapture.capturedImagePath)
                    }
                }

                Button{
                    text: "Avant / Arr"
                    x: 100
                    y: 385
                    width: 100
                    height: 32
                    onClicked: {
                        if ( camera.position == Camera.FrontFace )
                        {
                            camera.position = Camera.BackFace
                        }
                        else
                        {
                            camera.position = Camera.FrontFace
                        }
                    }
                }

            }
        }
    }

    // *************************************
    // *** COMMONS ELEMENTS ON EACH PAGE ***
    // *************************************

    FastBlur {
        id: blur_me_welcome_new_user
        source: background_welcome_new_user
        anchors.fill: parent
        radius: 48
        visible: false
    }

    Behavior on x {
        NumberAnimation {
            easing.amplitude: 0.5
            duration: 800
            easing.type: Easing.OutBounce
        }
    }

    Behavior on y {
        NumberAnimation {
            easing.amplitude: 0.5
            duration: 800
            easing.type: Easing.OutBounce
        }
    }

    // *****************************************
    // *** FUNCTIONS TO CREATE / MODIFY USER ***
    // *****************************************

    function fn_manage_user()
    {
        if ( chp_first_name.text == "" || chp_last_name == "" )
        {
            message_box.wg_current_frame = blur_me_welcome_new_user
            message_box.wg_message_text = qsTr("Vous devez renseigner un nom et un prénom pour pouvoir utiliser l'application")
            blur_me_welcome_new_user.visible = true
            message_box.visible = true

        }
        else
        {
            var db = LocalStorage.openDatabaseSync("JTNDB", "1.0", "JTN Database")

            db.transaction(
                function(tx) {
                    tx.executeSql('INSERT INTO USERS VALUES(?, ?)', [ chp_first_name.text, chp_last_name.text ])
                }
            )

            wg_full_name = chp_first_name.text + " " + chp_last_name.text
            welcome_new_user.y = applicationwindow.height
            choose_profil.x = 0
        }
    }
}


