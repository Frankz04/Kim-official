import QtQuick 2.12
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.12
import QtQuick.Window 2.14
import QtQuick.Shapes 1.11
import QtQuick.Templates 2.5
import QtQuick.Extras 1.4
import QtQuick.Dialogs.qml 1.0
import QtPositioning 5.4
import Qt.labs.folderlistmodel 2.12
import Qt.labs.settings 1.1
import Qt.labs.platform 1.1
import QtGraphicalEffects 1.14


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1050
    height: 750
    color: "#f0f0f0"
    minimumHeight: 500
    property var boxes: []
    property var boxes2: []
    minimumWidth: 1000 
    Component.onCompleted: {
        person.update.connect(reload) //Wenn Python das Bild abgespeichert hat, wird es durch reload in qml neu geladen
        person.sendBox.connect(draw)
        person.sendBox2.connect(draw2)
        //Mithilfe der Gesichtskoordinaten werden in draw / draw2 Rechtecke erstellt

    }

    function draw(str) {
        var data =JSON.parse(str); //Die Koordinaten mussten in Strings übergeben werden, weil reine Listen nicht zwischen PySide2 und QML gesendet werden
        for (var i=0; i < boxes.length; i++) {
            boxes[i].destroy() //Früher erstellte Rechtecke werden gelöscht
        }
        boxes = []
        for (var i = 0;i < data.length;i++) {

            var specs = "import QtQuick 2.12; Rectangle { color: 'transparent';border.color: '#ff0000'; border.width: 3.5;radius: 4; width:" + String(img.width*data[i][2]) +  "; height:" + String(img.height*data[i][3]) + "; x: " + String(img.width*data[i][0]) + "; y: " + String(img.height*data[i][1]) +
                    "; Rectangle { y: parent.height; height: 30; width: parent.width; color: 'transparent'} Text {text:'NO MASK'; anchors.horizontalCenter: parent.horizontalCenter; color: '#ff0000'; font.pixelSize: 25; y: parent.height}}"
            boxes.push(Qt.createQmlObject(specs,img))
            //Für jede Koordinatenliste wird ein Rechteck an der Position im Bild erstellt und in einer Liste abgespeichert, damit das Rechteck bei der nächsten Aktualisierung wieder zerstört werden kann
        }


    }
    function draw2(str) {

        var data =JSON.parse(str);
        for (var i=0; i < boxes2.length; i++) {
            boxes2[i].destroy()
        }
        boxes2 = []
        for (var i = 0;i < data.length;i++) {
            var specs = "import QtQuick 2.12; Rectangle { color: 'transparent';border.color: '#00ff00'; border.width: 3.5;radius: 4; width:" + String(img.width*data[i][2]) +  "; height:" + String(img.height*data[i][3]) + "; x: " + String(img.width*data[i][0]) + "; y: " + String(img.height*data[i][1]) +
                    "; Rectangle { y: parent.height; height: 30; width: parent.width; color: 'transparent'} Text {text:'MASKED'; anchors.horizontalCenter: parent.horizontalCenter; color: '#00ff00'; font.pixelSize:25; y: parent.height}}"
            boxes2.push(Qt.createQmlObject(specs,img))
        }


    }

    PropertyAnimation { //Beim Start wird diese Animation ausgeführt und startet eine weitere, damit das Bild und der Text am Anfang erscheint
        id: startan
        target: image
        property: "opacity"
        from: 0
        to: 1
        duration: 1000
        onFinished: {
            startanim2.start()
        }

        running: true
    }
    Timer {
        interval: 3000
        running: false
        id: timer
        onTriggered: {
            rectangle7.visible = false
        }
    }

    ParallelAnimation {
        id: startanim2
        running: false
        onFinished: {
            timer.start()
        }

        PropertyAnimation {
            target: image
            property: "anchors.verticalCenterOffset"
            easing.type: Easing.OutQuart
            to: -55
            duration: 700
            onFinished: {
                image.anchors.verticalCenterOffset = -55
            }

        }
        PropertyAnimation {
            target: element10
            property: "opacity"
            from: 0
            to: 1
            duration: 550

        }
        PropertyAnimation {
            target: element7
            property: "opacity"
            from: 0
            to: 1
            duration: 550

        }

    }

    function reload() {
        try {
            img.source = ""
            img.source = "frame.jpg?t=" + Date.now() //Qml lädt das von Python wieder abgespeicherte Bild neu, ca. 15 mal pro Sekunde
        }
        catch(e) {

        }
    }
    Component.onDestruction: {
        trayicon.hide()
    }

    SystemTrayIcon { //Es wird unter Windows ein TrayIcon für die Anwendung angezeigt
        id: trayicon
        visible: true
        icon.source: "mask.ico"
        onActivated: {
            applicationWindow.show()
            applicationWindow.raise()
            applicationWindow.requestActivate()
        }
        menu: Menu {
            MenuItem {
                text: qsTr("Öffnen")
                onTriggered: {
                    applicationWindow.show()
                    applicationWindow.raise()
                    applicationWindow.requestActivate()
                }
            }
            MenuItem {
                text: qsTr("Schließen")
                onTriggered: Qt.quit()
            }
        }
    }

    Item {
        id: element
        width: applicationWindow.width
        height: applicationWindow.height
        Image { //Das neugeladene Bild
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: 640/480* element.height
            height: element.height
            source: "frame.jpg"
            id: img


        }

        Rectangle { //Weißer Hintergrund mit dem Icon und Bild am Anfang
            id: rectangle7
            color: "#ffffff"
            visible: true
            anchors.fill: parent

            Image {
                id: image
                x: 682
                opacity: 0
                y: 325
                width: 220
                height: 220
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "Mask.ico"
                fillMode: Image.PreserveAspectFit
            }

            Text {
                id: element10
                x: 709
                y: 452
                opacity: 0
                color: "#3d597e"
                text: qsTr("KIM")
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 60
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.pixelSize: 60
                font.family: "Tahoma"
            }
            Text {
                id: element7
                x: 709
                y: 452
                opacity: 0
                color: "#cfcfcf"
                text: qsTr("(Künstliche Intelligenz\nfür Maskenerkennung)")
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 140
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.pixelSize: 25
                font.family: "Tahoma"
            }

        }


    }


}