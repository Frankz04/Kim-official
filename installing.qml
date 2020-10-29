import QtQuick 2.12
import QtQuick.Layouts 1.2
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.11
import QtQuick.Templates 2.5
import QtQuick.Extras 1.4
import QtQuick.Dialogs.qml 1.0
import QtPositioning 5.4
import Qt.labs.folderlistmodel 2.12
import Qt.labs.settings 1.1
import Qt.labs.platform 1.1
ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1000
    height: 500
    color: "#f0f0f0"
    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width
    Component.onDestruction: {
        trayicon.hide()
    }

    Component.onCompleted: {
        person.progress.connect(update)
    }
    function update(val){
        progress.text = val
    }
    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: 237
        height: 500
        color: "#e0ecef"
        z: 1
        border.width: 0

        Text {
            id: element2
            x: 46
            y: 238
            color: "#515151"
            text: qsTr("1. Vorbereitung")
            font.pixelSize: 20
        }

        Text {
            id: element3
            x: 55
            y: 297
            color: "#515151"
            opacity: 0.6
            text: qsTr("2. Installation")
            font.pixelSize: 20

        }

    }

    SystemTrayIcon {
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
    RotationAnimation {
        target: image
        running: true
        id: rotate1
        duration: 1600
        from: 0
        to: 360
        onFinished: rotate2.start()
    }
    RotationAnimation {
        target: image
        running: false
        id: rotate2
        duration: 1200
        from: 0
        to: 360
        onFinished: rotate1.start()
    }

    Timer {
        interval: 4000
        repeat: true
        id: timer
        running: true
        onTriggered: {
            if (element1.place == element1.txts.length) {
                element1.place = 0
            }
            element1.text = element1.txts[element1.place]
            element1.place = element1.place + 1
        }
    }


    Image {
        id: image1
        z: 200
        x: 57
        y: 73
        width: 120
        height: 120
        asynchronous: true
        source: "http://trio-app.de/app/kim/mask.ico"

        fillMode: Image.PreserveAspectFit
    }

    Item {
        id: element5
        x: 230
        y: 0
        width: 770

        height: 500
        visible: false

        Text {
            id: element1
            property int place: 0

            property var txts: ["Dateien werden heruntergeladen...","Dies dauert nur ein paar Sekunden.","Dateien werden entpackt...","Dies dauert nur ein paar Sekunden.","Auslesen...","Dies dauert nur ein paar Sekunden.","Vorbereiten...","Dies dauert nur ein paar Sekunden."]

            x: 173
            y: 346
            color: "#7f7f7f"
            text: qsTr("Dies dauert nur ein paar Sekunden.")

            font.italic: true
            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter

            anchors.horizontalCenterOffset: -7
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 22
        }

        Text {
            id: element
            x: 246
            y: 115
            color: "#065071"
            text: qsTr("Kim wird installiert...")
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenterOffset: -3

            font.family: "Verdana"
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 25

        }

        Image {
            id: image
            x: 316
            y: 190
            width: 135
            height: 135
            asynchronous: true
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: -5
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "http://trio-app.de/app/new/loading.png"
            fillMode: Image.PreserveAspectFit
        }


        Text {
            id: progress
            x: 370
            y: 243
            color: "#1060a7"
            text: qsTr("0%")
            font.bold: true
            anchors.verticalCenter: image.verticalCenter
            anchors.horizontalCenter: image.horizontalCenter
            font.pixelSize: 17
        }    }

    Item {
        id: element6
        x: 230
        y: 0
        width: 770
        height: 500
        visible: true

        Text {
            id: element7

            x: 29
            y: 77
            color: "#0c5778"
            text: qsTr("Willkommen\nbei dem Setup von Kim!")

            font.wordSpacing: 0
            font.letterSpacing: 1.4
            font.bold: true
            font.pixelSize: 51
        }

        Text {
            id: element8
            x: 29
            y: 260
            width: 395
            height: 75
            color: "#646464"
            text: "Sie werden nun durch das Setup geleitet,
dies dauert nur ein paar Sekunden. 
Klicken Sie auf Weiter!"
            font.pixelSize: 21
        }

        Rectangle {
            id: rectangle1
            x: 554
            y: 425
            width: 109

            height: 32
            color: "#219df4"
            radius: 15
            border.color: "#64c8f4"
            border.width: 3

            Text {
                id: element9
                x: 61
                y: 11
                color: "#ffffff"
                text: qsTr("Weiter")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 17
            }

            MouseArea {
                id: mouseArea
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    element6.visible = false

                    item7.visible = true
                }
            }
        }
    }

    Item {
        id: item7
        x: 233
        y: 2
        width: 770
        visible: false
        height: 500

        Rectangle {
            id: rectangle2

            x: 554
            y: 425
            width: 109
            height: 32
            color: "#219df4"
            radius: 15
            border.width: 3
            Text {
                id: element13
                x: 61
                y: 11

                color: "#ffffff"
                text: qsTr("Weiter")
                font.pixelSize: 17
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }

            MouseArea {
                id: mouseArea1
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    item7.visible = false
                    item8.visible = true
                }
            }
            border.color: "#64c8f4"

        }

        Text {
            id: element10
            x: 127
            y: 192
            color: "#515151"

            text: qsTr("Soll auf dem Desktop eine Verknüpfung für Kim angelegt werden?")
            visible: true
            font.pixelSize: 17

            Rectangle {
                id: rectangle5
                x: 96
                y: 57
                width: 30
                height: 30
                color: "#ffffff"
                radius: 5

                border.width: 1
                MouseArea {
                    id: mouseArea3
                    cursorShape: Qt.PointingHandCursor
                    anchors.fill: parent

                    onClicked: {
                        rectangle6.visible = !rectangle6.visible
                        rectangle6.activated = !rectangle6.activated
                    }
                }

                Rectangle {
                    id: rectangle6
                    property var activated: true
                    x: 5
                    y: 5

                    visible: true
                    width: 20
                    height: 20
                    color: "#4eb8f5"

                    radius: 5
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
                border.color: "#9b9b9b"
            }

            Text {

                id: element14
                x: 135
                y: 62
                color: "#515151"
                text: qsTr("Ja, Verknüpfung für Kim anlegen")
                font.pixelSize: 15
            }
        }
        Text {
            id: element18
            x: 253
            y: 291
            color: "#888888"
            text: qsTr("Blaues Rechteck = aktiviert")
            font.pixelSize: 15
            font.family: "Verdana"
        }
    }

    Item {
        id: item8
        x: 232
        y: 2
        visible: false
        width: 770
        height: 500
        Rectangle {
            id: rectangle7
            x: 554
            y: 425
            width: 129
            height: 32
            color: "#219df4"
            radius: 15
            border.color: "#64c8f4"
            Text {
                id: element15
                x: 61
                y: 11
                color: "#ffffff"
                text: qsTr("Ich stimme zu")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 17
            }

            MouseArea {
                id: mouseArea4
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    item8.visible = false
                    element5.visible = true
                    element2.opacity = 0.6
                    element3.opacity = 1

                    person.startinstall(String(rectangle6.activated))
                }
            }

            border.width: 3
        }

        Text {
            id: element16
            x: 24
            y: 48
            color: "#424242"
            text: qsTr("Um Kim installieren zu können, müssen Sie den Lizenzvereinbarungen zustimmen,
lesen Sie sie deswegen sorgfältig durch:")
            font.pixelSize: 18
        }

        Rectangle {
            id: rectangle8

            x: 24
            y: 113
            width: 659
            height: 296
            color: "#ffffff"
            border.color: "#a4a4a4"
            border.width: 1

            ScrollView {
                id: scrollView
                anchors.fill: parent
                clip: true

                TextArea {
                    id: textArea
                    x: 0

                    y: 0
                    text: qsTr("
                                                        Schäden
Da Ihnen Kim ohne Gegenleistung überlassen wurde, besteht ein Schenkungsvertrag zwischen dem Kim-Herausgeber und Ihnen. Dadurch ist der Kim-Herausgeber nur bei Schäden, die durch die Kim-Anwendung entstehen, haftbar, wenn sie durch grobe Fahrlässigkeit oder Vorsatz seitens des Herausgebers zustandekommen.


 GNU General Public License
Deutsche Übersetzung der Version 3, 29. Juni 2007

Copyright © 2007 Free Software Foundation, Inc. (http://fsf.org/) 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA

Es ist jedermann gestattet, diese Lizenzurkunde zu vervielfältigen und unveränderte Kopien zu verbreiten; Änderungen sind jedoch nicht erlaubt.

Diese Übersetzung ist kein rechtskräftiger Ersatz für die englischsprachige Originalversion, deswegen ist die englische ORIGINALVERSION weiter unten! Diese deutsche Version dient nur zum besseren Verständnis.

Vorwort
Die GNU General Public License – die Allgemeine Öffentliche GNU-Lizenz – ist eine freie Copyleft-Lizenz für Software und andere Arten von Werken.

Die meisten Lizenzen für Software und andere nutzbaren Werke sind daraufhin entworfen worden, Ihnen die Freiheit zu nehmen, die Werke mit anderen zu teilen und zu verändern. Im Gegensatz dazu soll Ihnen die GNU General Public License die Freiheit garantieren, alle Versionen eines Programms zu teilen und zu verändern. Sie soll sicherstellen, daß die Software für alle ihre Benutzer frei bleibt. Wir, die Free Software Foundation, nutzen die GNU General Public License für den größten Teil unserer Software; sie gilt außerdem für jedes andere Werk, dessen Autoren es auf diese Weise freigegeben haben. Auch Sie können diese Lizenz auf Ihre Programme anwenden.

Wenn wir von freier Software sprechen, so beziehen wir uns auf Freiheit, nicht auf den Preis. Unsere Allgemeinen Öffentlichen Lizenzen sind darauf angelegt, sicherzustellen, daß Sie die Freiheit haben, Kopien freier Software zu verbreiten (und dafür etwas zu berechnen, wenn Sie möchten), die Möglichkeit, daß Sie die Software als Quelltext erhalten oder den Quelltext auf Wunsch bekommen, daß Sie die Software ändern oder Teile davon in neuen freien Programmen verwenden dürfen und daß Sie wissen, daß Sie dies alles tun dürfen.

Um Ihre Rechte zu schützen, müssen wir andere daran hindern, Ihnen diese Rechte zu verweigern oder Sie aufzufordern, auf diese Rechte zu verzichten. Aus diesem Grunde tragen
Sie eine Verantwortung, wenn Sie Kopien der Software verbreiten oder die Software verändern: die Verantwortung, die Freiheit anderer zu respektieren.

Wenn Sie beispielsweise die Kopien eines solchen Programms verbreiten – kostenlos oder gegen Bezahlung – müssen Sie an die Empfänger dieselben Freiheiten weitergeben, die Sie selbst erhalten haben. Sie müssen sicherstellen, daß auch die Empfänger die Software im Quelltext erhalten bzw. den Quelltext erhalten können. Und Sie müssen ihnen diese Bedingungen zeigen, damit sie ihre Rechte kennen.

Software-Entwickler, die die GNU GPL nutzen, schützen Ihre Rechte in zwei Schritten: (1) Sie machen ihr Urheberrecht (Copyright) auf die Software geltend, und (2) sie bieten Ihnen diese Lizenz an, die Ihnen das Recht gibt, die Software zu vervielfältigen, zu verbreiten und/oder zu verändern.

Um die Entwickler und Autoren zu schützen, stellt die GPL darüberhinaus klar, daß für diese freie Software keinerlei Garantie besteht. Um sowohl der Anwender als auch der Autoren Willen erfordert die GPL, daß modifizierte Versionen der Software als solche gekennzeichnet werden, damit Probleme mit der modifizierten Software nicht fälschlicherweise mit den Autoren der Originalversion in Verbindung gebracht werden.

Manche Geräte sind daraufhin entworfen worden, ihren Anwendern zu verweigern, modifizierte Versionen der darauf laufenden Software zu installieren oder laufen zu lassen, wohingegen der Hersteller diese Möglichkeit hat. Dies ist grundsätzlich unvereinbar mit dem Ziel, die Freiheit der Anwender zu schützen, die Software zu modifizieren. Derartige gezielte mißbräuchliche Verhaltensmuster finden auf dem Gebiet persönlicher Gebrauchsgegenstände statt – also genau dort, wo sie
am wenigsten akzeptabel sind. Aus diesem Grunde wurde diese Version der GPL daraufhin entworfen, diese Praxis für diese Produkte zu verbieten. Sollten derartige Probleme substantiell auf anderen Gebieten auftauchen, sind wir bereit, diese Regelung auf diese Gebiete auszudehnen, soweit dies notwendig ist, um die Freiheit der Benutzer zu schützen.

Schließlich und endlich ist jedes Computerprogramm
permanent durch Software-Patente bedroht. Staaten sollten es nicht zulassen, daß Patente die Entwicklung und Anwendung von Software für allgemein einsetzbare Computer einschränken, aber in Staaten, wo dies geschieht, wollen wir die spezielle Gefahr vermeiden, daß Patente dazu verwendet werden, ein freies Programm im Endeffekt proprietär zu machen. Um dies zu verhindern, stellt die GPL sicher, daß Patente nicht verwendet werden können, um das Programm nicht-frei zu machen.

Es folgen die präzisen Bedingungen für das Kopieren, Verbreiten und Modifizieren.

LIZENZBEDINGUNGEN
0. Definitionen
„Diese Lizenz“ bezieht sich auf die Version 3 der GNU General Public
License.

Mit „Urheberrecht“ sind auch urheberrechtähnliche Rechte gemeint, die auf andere Arten von Werken Anwendung finden, beispielsweise auf Fotomasken in der Halbleitertechnologie.

„Das Programm“ bezeichnet jedes urheberrechtlich schützbare Werk, das unter diese Lizenz gestellt wurde. Jeder Lizenznehmer wird als „Sie“ angeredet. „Lizenznehmer“ und „Empfänger“ können natürliche oder rechtliche Personen sein.

Ein Werk zu „modifizieren“ bedeutet, aus einem Werk zu kopieren oder es ganz oder teilweise auf eine Weise umzuarbeiten, die eine urheberrechtliche Erlaubnis erfordert und kein Eins-zu-eins-Kopieren darstellt. Das daraus hervorgehende Werk wird als „modifizierte Version“ des früheren Werks oder als auf dem früheren Werk „basierendes“ Werk bezeichnet.

Ein „betroffenes Werk“ bezeichnet entweder das unmodifizierte Programm oder ein auf dem Programm basierendes Werk.
Ein Werk zu „propagieren“ bezeichnet jedwede Handlung mit dem Werk, für die man, wenn unerlaubt begangen, wegen Verletzung anwendbaren Urheberrechts direkt oder indirekt zur Verantwortung gezogen würde, ausgenommen das Ausführen auf einem Computer oder das Modifizieren einer privaten Kopie. Unter das Propagieren eines Werks fallen Kopieren, Weitergeben (mit oder ohne Modifikationen), öffentliches Zugänglichmachen und in manchen Staaten noch weitere Tätigkeiten.

Ein Werk zu „übertragen“ bezeichnet jede Art von Propagation, die es Dritten ermöglicht, das Werk zu kopieren oder Kopien zu erhalten. Reine Interaktion mit einem Benutzer über ein Computer-Netzwerk ohne Übergabe einer Kopie ist keine Übertragung.
Eine interaktive Benutzerschnittstelle zeigt „angemessene rechtliche Hinweise“ in dem Umfang, daß sie eine zweckdienliches und deutlich sichtbare Funktion bereitstellt, die (1) einen angemessenen Copyright-Vermerk zeigt und (2) dem Benutzer mitteilt, daß keine Garantie für das Werk besteht (ausgenommen in dem Umfang, in dem Garantie gewährt wird), daß Lizenznehmer das Werk gemäß dieser Lizenz
übertragen dürfen und wie man ein Exemplar dieser Lizenz zu Gesicht bekommen kann. Wenn die Benutzerschnittstelle eine Liste von Benutzerkommandos oder Optionen anzeigt, zum Beispiel ein Menü, dann erfüllt ein deutlich sichtbarer Punkt in dieser Liste dieses Kriterium.

1. Quelltext
Der „Quelltext“ eines Werkes bezeichnet diejenige Form des Werkes, die für Bearbeitungen vorzugsweise verwendet wird. „Objekt-Code“ bezeichnet jede Nicht-Quelltext-Form eines Werks.

Eine „Standardschnittstelle“ bezeichnet eine Schnittstelle, die
entweder ein offizieller Standard eines anerkannten Standardisierungsgremiums ist oder – im Falle von Schnittstellen, die für eine spezielle Programmiersprache spezifiziert wurden – eine Schnittstelle, die unter Entwicklern, die in dieser Programmiersprache arbeiten,
weithin gebräuchlich ist.

Die „Systembibliotheken“ eines ausführbaren Werks enthalten alles, ausgenommen das Werk als Ganzes, was (a) normalerweise zum Lieferumfang einer Hauptkomponente gehört, aber selbst nicht die Hauptkomponente ist, und (b) ausschließlich dazu dient, das Werk zusammen mit der Hauptkomponente benutzen zu können oder eine Standardschnittstelle zu implementieren, für die eine Implementation als Quelltext öffentlich erhältlich ist. Eine „Hauptkomponente“ bezeichnet in diesem Zusammenhang eine größere wesentliche Komponente (Betriebssystemkern, Fenstersystem usw.) des spezifischen Betriebssystems (soweit vorhanden), auf dem das ausführbare Werk läuft, oder des Compilers, der zur Erzeugung des Objekt-Codes eingesetzt wurde, oder des für die Ausführung verwendeten Objekt-Code-Interpreters.

Der „korrespondierende Quelltext“ eines Werks in Form von Objekt-Code bezeichnet den vollständigen Quelltext, der benötigt wird, um das Werk zu erzeugen, es zu installieren, um (im Falle eines ausführbaren Werks) den Objekt-Code auszuführen und um das Werk zu modifizieren, einschließlich der Skripte zur Steuerung dieser Aktivitäten. Er schließt jedoch nicht die Systembibliotheken,
allgemein einsetzbare Werkzeuge oder allgemein erhältliche freie Computerprogramme mit ein, die in unmodifizierter Form verwendet werden, um die o.a. Tätigkeiten durchzuführen, die aber nicht Teil des Werks sind. Zum Beispiel enthält der korrespondierende Quelltext die zum Programmquelltext gehörenden Schnittstellendefinitionsdateien sowie die Quelltexte von dynamisch eingebundenen Bibliotheken und
Unterprogrammen, auf die das Werk konstruktionsbedingt angewiesen ist, beispielsweise durch komplexe Datenkommunikation oder Ablaufsteuerung zwischen diesen Unterprogrammen und anderen Teilen des Werks.

Der korrespondierende Quelltext braucht nichts zu enthalten, das der Anwender aus anderen Teilen des korrespondierenden Quelltextes automatisch regenerieren kann.

Der korrespondierende Quelltext eines Werks in Quelltextform ist das Werk selbst.

2. Grundlegende Genehmigungen
Alle unter dieser Lizenz gewährten Rechte werden gewährt auf Grundlage des Urheberrechts an dem Programm, und sie sind unwiderruflich, solange die festgelegten Bedingungen erfüllt sind. Diese Lizenz erklärt ausdrücklich Ihr uneingeschränktes Recht zur Ausführung des unmodifizierten Programms. Die beim Ausführen eines betroffenen Werks erzeugten Ausgabedaten fallen unter diese Lizenz nur dann, wenn sie, in Anbetracht ihres Inhalts, ein betroffenes Werk darstellen. Diese Lizenz erkennt Ihr im Urheberrecht vorgesehenes Recht auf angemessene Benutzung – oder seine Entsprechung – an.

Sie dürfen betroffene Werke, die Sie nicht übertragen, uneingeschränkt erzeugen, ausführen und propagieren, solange Ihre Lizenz ansonsten in Kraft bleibt. Sie dürfen betroffene Werke an Dritte übertragen für den einzigen Zweck, Modifikationen exklusiv für Sie durchzuführen oder Einrichtungen für Sie bereitzustellen, um diese Werke auszuführen, vorausgesetzt, Sie erfüllen alle Bedingungen dieser Lizenz für das Übertragen von Material, dessen Urheberrecht nicht bei Ihnen liegt. Diejenigen, die auf diese Weise betroffene Werke für Sie anfertigen oder ausführen, müssen dies ausschließlich in Ihrem Namen tun, unter Ihrer Anleitung und Kontrolle und unter Bedingungen, die ihnen verbieten, außerhalb ihrer Beziehung zu Ihnen weitere Kopien Ihres urheberrechtlich geschützten Materials anzufertigen.

Übertragung ist in jedem Fall ausschließlich unter den unten aufgeführten Bedingungen gestattet. Unterlizensierung ist nicht gestattet, ist aber wegen §10 unnötig.

3. Schutz von Anwenderrechten vor Umgehungsverbotgesetzen
Kein betroffenes Werk darf als Teil eines wirksamen technischen Mechanismus' unter jedwedem anwendbarem Recht betrachtet werden, das die Auflagen von Artikel 11 des am 20. Dezember 1996 verabschiedeten WIPO-Urheberrechtsvertrags oder unter vergleichbaren Gesetzen erfüllt, die die Umgehung derartiger Mechanismen verbietet oder einschränkt.

Wenn Sie ein betroffenes Werk übertragen, verzichten Sie auf jedes Recht, die Umgehung technischer Mechanismen zu verbieten, insoweit diese Umgehung durch die Ausübung der von dieser Lizenz gewährten Rechte in bezug auf das betroffene Werk herbeigeführt wird, und Sie weisen jede Absicht von sich, die Benutzung oder Modifikation des Werks zu beschränken, um Ihre Rechtsansprüche oder Rechtsansprüche Dritter zum Verbot der Umgehung technischer Mechanismen gegen die Anwender des Werks durchzusetzen.

4. Unveränderte Kopien
Sie dürfen auf beliebigen Medien unveränderte Kopien des Quelltextes des Programms, wie sie ihn erhalten, übertragen, sofern Sie auf deutliche und angemessene Weise auf jeder Kopie einen angemessenen Urheberrechts-Vermerk veröffentlichen, alle Hinweise intakt lassen, daß diese Lizenz und sämtliche gemäß §7 hinzugefügten Einschränkungen auf den Quelltext anwendbar sind, alle Hinweise auf das Nichtvorhandensein einer Garantie intakt lassen und allen Empfängern gemeinsam mit dem Programm ein Exemplar dieser Lizenz zukommen lassen.

Sie dürfen für jede übertragene Kopie ein Entgelt – oder auch kein Entgelt – verlangen, und Sie dürfen Kundendienst- oder Garantieleistungen gegen Entgelt anbieten.

5. Übertragung modifizierter Quelltextversionen
Sie dürfen ein auf
dem Programm basierendes Werk oder die nötigen Modifikationen, um es aus dem Programm zu generieren, kopieren und übertragen in Form von Quelltext unter den Bestimmungen von §4, vorausgesetzt, daß Sie zusätzlich alle im folgenden genannten Bedingungen erfüllen:

a)
        Das veränderte Werk muß auffällige Vermerke tragen, die besagen, daß Sie es modifiziert haben, und die ein darauf bezogenes Datum angeben.
b)        Das veränderte Werk muß auffällige Vermerke tragen, die besagen, daß es unter dieser Lizenz einschließlich der gemäß §7 hinzugefügten Bedingungen herausgegeben wird. Diese Anforderung wandelt die Anforderung aus §4 ab, „alle Hinweise intakt zu
lassen“.
c)    Sie müssen das Gesamtwerk als Ganzes gemäß dieser Lizenz an jeden lizensieren, der in den Besitz einer Kopie gelangt.
Diese Lizenz wird daher – ggf. einschließlich zusätzlicher Bedingungen gemäß §7 – für das Werk als Ganzes und alle seine Teile gelten, unabhängig davon, wie diese zusammengepackt werden. Diese Lizenz erteilt keine Erlaubnis, das Werk in irgendeiner anderen Weise zu lizensieren, setzt aber eine derartige Erlaubnis nicht außer Kraft, wenn Sie sie diese gesondert erhalten haben.
d)      Wenn das Werk
über interaktive Benutzerschnittstellen verfügt, müssen diese jeweils angemessene rechtliche Hinweise anzeigen. Wenn allerdings das Programm interaktive Benutzerschnittstellen hat, die keine angemessenen rechtlichen Hinweise anzeigen, braucht Ihr Werk nicht dafür zu sorgen, daß sie dies tun.
Die Zusammenstellung eines betroffenen Werks mit anderen gesonderten und unabhängigen Werken, die nicht ihrer Natur nach Erweiterungen des betroffenen Werks sind und die nicht mit ihm in einer Weise kombiniert sind, um ein größeres Programm zu bilden, in oder auf einem Speicher- oder Verbreitungsmedium wird als „Aggregat“ bezeichnet, wenn die Zusammenstellung und das sich für sie ergebende Urheberrecht nicht dazu verwendet werden, den Zugriff oder die Rechte der Benutzer der Zusammenstellung weiter einzuschränken, als dies die einzelnen Werke erlauben. Die Aufnahme des betroffenen Werks in ein Aggregat sorgt nicht dafür, daß diese Lizenz auf die anderen Teile des Aggregats wirke.

6. Übertragung in Nicht-Quelltext-Form
Sie dürfen ein betroffenes Werk in Form von Objekt-Code unter den Bedingungen der Paragraphen 4 und 5 kopieren und übertragen – vorausgesetzt, daß Sie außerdem den maschinenlesbaren korrespondierenden Quelltext unter den Bedingungen dieser Lizenz übertragen auf eine der folgenden Weisen:

a)      Sie übertragen den Objekt-Code in einem physikalischen Produkt (einschließlich ein physikalisches Speichermedium) gemeinsam mit dem korrespondierenden Quelltext, der sich unveränderlich auf einem haltbaren physikalischen Medium befindet, das üblicherweise für den Austausch von Software verwendet wird.
b)        Sie übertragen den Objekt-Code in einem physikalischen Produkt (einschließlich ein physikalisches Speichermedium) gemeinsam mit einem schriftlichen Angebot, das mindestens drei Jahre lang gültig sein muß und so lange, wie Sie Ersatzteile und Kundendienst für dieses Produktmodell anbieten, jedem, der im Besitz des Objekt-Codes ist, entweder (1) eine Kopie des korrespondierenden Quelltextes der gesamten Software, die in dem Produkt enthalten und von dieser Lizenz betroffen ist, zur Verfügung zu stellen – auf einem haltbaren physikalischen Medium, das üblicherweise für den Austausch von Software verwendet wird, und zu nicht höheren Kosten als denen, die begründbar durch den physikalischen Vorgang der Übertragung des Quelltextes anfallen, oder (2) kostenlosen Zugriff, um den korrespondierenden Quelltext von einem Netzwerk-Server zu kopieren.
c)       Sie übertragen Kopien des Objekt-Codes gemeinsam mit einer Kopie des schriftlichen Angebots, den korrespondierenden Quelltext zur Verfügung zu stellen. Diese Alternative ist nur für gelegentliche, nicht-kommerzielle Übertragung zulässig und nur, wenn Sie den Objekt-Code als mit einem entsprechenden Angebot gemäß
Absatz 6b erhalten haben.
d)
Sie übertragen den Objekt-Code dadurch, daß Sie Zugriff auf eine dafür vorgesehene Stelle gewähren, und bieten gleichwertigen Zugriff auf den korrespondierenden Quelltext auf gleichem Weg auf dieselbe Stelle und ohne zusätzliche Kosten.
Sie müssen nicht von den Empfängern verlangen, den korrespondierenden Quelltext gemeinsam mit dem Objekt-Code zu kopieren. Wenn es sich bei der für das Kopieren vorgesehenen Stelle um einen Netzwerk-Server handelt, darf sich der korrespondierende Quelltext auf einem anderen Server befinden (von Ihnen oder von einem Dritten betrieben), der gleichwertige Kopiermöglichkeiten unterstützt – vorausgesetzt Sie legen dem Objekt-Code klare Anleitungen bei, die besagen, wo der korrespondierende Quelltext zu finden ist. Unabhängig davon, welcher Netzwerk-Server den korrespondierenden Quelltext beherbergt, bleiben Sie verpflichtet, sicherzustellen, daß dieser lange genug bereitgestellt wird, um diesen Bedingungen zu genügen.

e)      Sie übertragen den Objekt-Code unter Verwendung von Peer-To-Peer-Übertragung – vorausgesetzt, Sie informieren andere Teilnehmer darüber, wo der Objekt-Code und der korrespondierende Quelltext des Werks unter den Bedingungen von Absatz 6d öffentlich und kostenfrei angeboten werden.
Ein abtrennbarer Anteil des Objekt-Codes, dessen Quelltext von dem korrespondierenden Quelltext als Systembibliothek ausgeschlossen ist, braucht bei der Übertragung des Werks als Objekt-Code nicht miteinbezogen zu werden.

Ein „Benutzerprodukt“ ist entweder (1) ein „Endbenutzerprodukt“, womit ein materieller persönlicher Besitz gemeint ist, der normalerweise für den persönlichen oder familiären Gebrauch oder im Haushalt eingesetzt wird, oder (2) alles, was für den Einbau in eine Wohnung hin entworfen oder dafür verkauft wird. Bei der Entscheidung, ob ein Produkt ein Endbenutzerprodukt ist, sollen Zweifelsfälle als erfaßt gelten. Wenn ein spezieller Anwender ein spezielles Produkt erhält, bezeichnet „normalerweise
einsetzen“ eine typische oder weitverbreitete Anwendung dieser Produktklasse, unabhängig vom Status des speziellen Anwenders oder der
Art und Weise, wie der spezielle Anwender des spezielle Produkt tatsächlich einsetzt oder wie von ihm erwartet wird, daß er es einsetzt. Ein Produkt gilt als Endbenutzerprodukt unabhängig davon, ob es substantiellen kommerziellen, industriellen oder nicht-endbenutzerspezifischen Nutzen hat, es sei denn, dieser Nutzen stellt das einzige signifikante Anwendungsgebiet des Produkts dar.

Mit „Installationsinformationen“ für ein Benutzerprodukt sind jedwede Methoden, Prozeduren, Berechtigungsschlüssel oder andere informationen gemeint, die notwendig sind, um modifizierte Versionen eines betroffenen Werks, die aus einer modifizierten Version seines korrespondierenden Quelltextes hervorgegangen sind, auf dem Produkt zu installieren und auszuführen. Die Informationen müssen ausreichen, um sicherzustellen, daß das Weiterfunktionieren des modifizierten Objekt-Codes in keinem Fall verhindert oder gestört wird aus dem einzigen Grunde, weil Modifikationen vorgenommen worden sind.

Wenn Sie Objekt-Code gemäß diesem Paragraphen innerhalb oder zusammen mit oder speziell für den Gebrauch innerhalb eines Benutzerprodukts übertragen und die Übertragung als Teil einer Transaktion stattfindet, in der das Recht auf den Besitz und die Benutzung des Benutzerprodukts dauerhaft auf den Empfänger übergeht (unabhängig davon, wie diese Transaktion charakterisiert ist), müssen dem gemäß diesem Paragraphen mitübertragenen korrespondierenden Quelltext die Installationsinformationen beiliegen. Diese Anforderung gilt jedoch nicht, wenn weder Sie noch irgendeine Drittpartei die Möglichkeit behält, modifizierten
Objekt-Code auf dem Benutzerprodukt zu installieren (zum Beispiel, wenn das Werk in einem ROM installiert wurde).

Die Anforderung,
Installationsinformationen bereitzustellen, schließt keine Anforderung mit ein, weiterhin Kundendienst, Garantie oder Updates für ein
Werk bereitzustellen, das vom Empfänger modifiziert oder installiert worden ist, oder für das Benutzerprodukt, in dem das Werk modifiziert oder installiert worden ist. Der Zugriff auf ein Computer-Netzwerk darf verweigert werden, wenn die Modifikation selbst die Funktion des Netzwerks grundlegend nachteilig beeinflußt oder wenn sie die Regeln und Protokolle für die Kommunikation über das Netzwerk verletzt.

Der korrespondierende Quelltext und die Installationsinformationen, die in Übereinstimmung mit diesem Paragraphen übertragen werden, müssen in einem öffentlich dokumentierten Format vorliegen (für das eine Implementation in Form von Quelltext öffentlich zugänglich ist), und sie dürfen keine speziellen Passwörter oder Schlüssel für das Auspacken, Lesen oder Kopieren erfordern.

7. Zusätzliche Bedingungen
„Zusätzliche Genehmigungen“ sind Bedingungen, die die Bedingungen dieser Lizenz ergänzen, indem sie Ausnahmen von einer oder mehreren Auflagen zulassen. Zusätzliche Genehmigungen zur Anwendung auf das gesamte Programm sollen so betrachtet werden, als wären sie in dieser Lizenz enthalten, soweit dies unter anwendbarem Recht zulässig ist. Wenn zusätzliche Genehmigungen nur für einen Teil des Programms gelten, darf dieser Teil separat unter diesen Genehmigungen verwendet werden; das gesamte Programm jedoch unterliegt weiterhin dieser Lizenz ohne Beachtung der zusätzlichen Genehmigungen.

Wenn Sie eine Kopie eines betroffenen Werks übertragen, dürfen Sie, wenn Sie es wünschen, jegliche zusätzliche Genehmigungen von dieser Kopie oder jedem Teil der Kopie entfernen. (Zusätzliche Genehmigungen dürfen so verfaßt sein, daß sie in bestimmten Fällen, wenn Sie das Werk modifizieren, entfernt werden müssen.) Sie dürfen Material, das Sie einem betroffenen Werk hinzufügen und für das Sie das Urheberrecht besitzen oder in entsprechender Form gewähren
dürfen, mit zusätzlichen Genehmigungen ausstatten.

Ungeachtet jeglicher anderer Regelungen dieser Lizenz dürfen Sie für Material, das Sie einem betroffenen Werk hinzufügen (sofern Sie durch die Urheberrechtsinhaber dieses Materials autorisiert sind), die Bedingungen dieser Lizenz um folgendes ergänzen:

a)    Gewährleistungsausschluß oder Haftungsbegrenzung abweichend von §§15 und 16 dieser Lizenz oder
b)    die Anforderung, spezifizierte sinnvolle rechtliche Hinweise oder Autorenschaftshinweise in diesem Material oder in den angemessenen rechtlichen Hinweisen, die von den sie enthaltenen Werken angezeigt werden, zu erhalten, oder
c)        das Verbot, die Herkunft des Materials falsch darzustellen oder die Anforderung, daß modifizierte Versionen des Materials auf angemessens Weise als
vom Original verschieden markiert werden, oder
d)      Begrenzung der Verwendung der Namen von Lizenzgebern oder Autoren des Materials für Werbezwecke oder
e)      das Zurückweisen der Einräumung von Rechten gemäß dem Markenrecht zur Benutzung gewisser Produktnamen, Produkt- oder Service-Marken oder
f)  die Erfordernis der Freistellung des Lizenznehmers und der Autoren des Materials durch jeden,
der die Software (oder modifizierte Versionen davon) überträgt, mit vertraglichen Prämissen der Verantwortung gegenüber dem Empfänger
für jede Verantwortung, die diese vertraglichen Prämissen diesen Lizenzgebern und Autoren direkt auferlegen.
Alle anderen hinzugefügten einschränkenden Bedingungen werden als „zusätzliche Einschränkungen“ im Sinne von §10 betrachtet. Wenn das Programm, wie Sie es erhalten haben, oder ein Teil davon dieser Lizenz untersteht zuzüglich einer weiteren Bedingung, die eine zusätzliche Einschränkung darstellt, dürfen Sie diese Bedingung entfernen. Wenn ein Lizenzdokument eine zusätzliche Einschränkung enthält, aber die Relizensierung unter dieser Lizenz erlaubt, dürfen Sie dem betroffenen Werk Material hinzufügen, das den Bedingungen jenes Lizenzdokuments unterliegt,
unter der Voraussetzung, daß die zusätzlichen Einschränkungen bei einer derartigen Relizensierung oder Übertragung verfallen.

Wenn
Sie einem betroffenen Werk in Übereinstimmung mit diesem Paragraphen Bedingungen hinzufügen, müssen Sie in den betroffenen Quelltextdateien eine Aufstellung der zusätzlichen Bedingungen plazieren, die auf diese Quelltextdatei Anwendung finden, oder einen Hinweis darauf, wo die Zusätzlichen Bedingungen zu finden sind.

Zusätzliche Bedingungen, seien es Genehmigungen oder Einschränkungen, dürfen in
Form einer separaten schriftlichen Lizenz oder in Form von Ausnahmen festgelegt werden; die o.a. Anforderungen gelten in jedem Fall.

8. Kündigung
Sie dürfen das Programm nicht verbreiten oder modifizieren, sofern es nicht durch diese Lizenz ausdrücklich gestattet
ist. Jeder anderweitige Versuch der Verbreitung oder Modifizierung ist nichtig und beendet automatisch Ihre Rechte unter dieser Lizenz (einschließlich aller Patentlizenzen gemäß §11 Abs. 3).

Wenn Sie jedoch alle Verletzungen dieser Lizenz beenden, wird Ihre Lizenz
durch einen speziellen Urheberrechtsinhaber wiederhergestellt, und zwar (a) vorübergehend, solange nicht bzw. bis der Rechteinhaber Ihre Lizenz ausdrücklich und endgültig kündigt, und (b) dauerhaft, sofern es der Rechteinhaber versäumt, Sie auf sinnvolle Weise auf die Lizenzverletzung innerhalb von 60 Tagen ab deren Beendigung hinzuweisen.

Darüberhinaus wird Ihre Lizenz durch einen speziellen Urheberrechtsinhaber permanent wiederhergestellt, wenn Sie der Rechteinhaber auf sinnvolle Weise auf die Verletzung hinweist, wenn außerdem dies das erste Mal ist, daß Sie auf die Verletzung dieser Lizenz (für jedes Werk) des Rechteinhabers hingewiesen werden, und wenn Sie die Verletzung innerhalb von 30 Tagen ab dem Eingang des Hinweises einstellen.

Die Beendigung Ihrer Rechte unter dieser Lizenz beendet nicht die Lizenzen Dritter, die von Ihnen Kopien oder Rechte unter dieser Lizenz erhalten haben. Wenn Ihre Rechte beendet und nicht dauerhaft wiederhergestellt worden sind, sind Sie nicht berechtigt, neue Lizenzen für dasselbe Material gemäß §10 zu erhalten.

9. Annahme der Lizenz keine Voraussetzung für den Besitz von Kopien
Um eine Kopie des Programms auszuführen, ist es nicht erforderlich, daß Sie diese Lizenz annehmen. Die nebenbei stattfindende Verbreitung eines betroffenen Werks, die sich ausschließlich als Konsequenz der Teilnahme an einer Peer-To-Peer-Datenübertragung ergibt, um eine Kopie entgegennehmen zu können, erfordert ebenfalls keine Annahme dieser Lizenz. Jedoch gibt Ihnen nichts außer dieser Lizenz die Erlaubnis, das Programm oder jedes betroffene Werk zu verbreiten
oder zu verändern. Diese Handlungen verstoßen gegen das Urheberrecht, wenn Sie diese Lizenz nicht anerkennen. Indem Sie daher ein betroffenes Werk verändern oder propagieren, erklären Sie Ihr Einverständnis mit dieser Lizenz, die Ihnen diese Tätigkeiten erlaubt.

10. Automatische Lizensierung nachgeordneter Anwender
Jedesmal, wenn Sie ein betroffenes Werk übertragen, erhält der Empfänger automatisch vom ursprünglichen Lizenzgeber die Lizenz, das Werk auszuführen, zu verändern und zu propagieren – in Übereinstimmung mit dieser Lizenz. Sie sind nicht dafür verantwortlich, die Einhaltung dieser Lizenz durch Dritte durchzusetzen.

Eine „Organisations-Transaktion“ ist entweder eine Transaktion, bei der die Kontrolle über eine Organisation oder das im wesentlichen gesamte Kapital einer solchen, übertragen wird, oder sie ist die Aufteilung einer Organisation in mehrere oder die Fusion mehrerer Organisationen zu einer. Wenn die Propagation eines betroffenen Werks durch eine Organisations-Transaktion erfolgt, erhält jeder an der Transaktion Beteiligte, der eine Kopie des Werks erhält, zugleich jedwede Lizenz an dem Werk, die der Interessenvorgänger des Beteiligten hatte, sowie das Recht auf
den Besitz des korrespondierenden Quelltextes des Werks vom Interessenvorgänger, wenn dieser ihn hat oder mit vertretbarem Aufwand beschaffen kann.

Sie dürfen keine zusätzlichen Einschränkungen bzgl. der Ausübung der unter dieser Lizenz gewährten oder zugesicherten Rechte vornehmen. Beispielsweise dürfen Sie keine Lizenzgebühr oder sonstige Gebühr für die Ausübung der unter dieser Lizenz gewährten Rechte verlangen, und Sie dürfen keine Rechtsstreitigkeit beginnen (eingeschlossen Kreuz- oder Gegenansprüche in einem Gerichtsverfahren), in der Sie unterstellen, daß irgendein Patentanspruch durch Erzeugung, Anwendung, Verkauf, Verkaufsangebot oder Import des Programms oder irgendeines Teils davon verletzt wurde.

11. Patente
Ein „Kontributor“ ist ein Urheberrechtsinhaber, der die Benutzung des Programms oder eines auf dem Programm basierenden Werks unter dieser Lizenz erlaubt. Das auf diese Weise lizensierte Werk bezeichnen wir als die „Kontributor-Version“ des Kontributors.

Die „wesentlichen Patentansprüche“ eines Kontributors sind all diejenigen Patentansprüche, die der Kontributor besitzt oder kontrolliert, ob bereits erworben oder erst in Zukunft zu erwerben, die durch irgendeine Weise des gemäß dieser Lizenz erlaubten Erzeugens, Ausführens oder Verkaufens seiner Kontributor-Version verletzt würden. Dies schließt keine Patentansprüche ein, die erst als Konsequenz weiterer Modifizierung seiner Kontributor-Version entstünden. Für den Zweck dieser Definition schließt 'Kontrolle' das Recht mit ein, Unterlizenzen für ein Patent zu erteilen auf eine Weise, die mit den Erfordernissen dieser Lizenz vereinbar ist.

Jeder Kontributor gewährt Ihnen eine nicht-exklusive, weltweite und gebührenfreie Patentlizenz gemäß den wesentlichen Patentansprüchen des Kontributors, den Inhalt seiner Kontributor-Version zu erzeugen, zu verkaufen, zum Verkauf anzubieten, zu importieren und außerdem auszuführen, zu modifizieren und zu propagieren.

In den folgenden drei Absätzen ist eine „Patentlizenz“ jedwede ausdrückliche Vereinbarung oder Verpflichtung, wie auch immer benannt, ein Patent nicht geltend zu machen (beispielsweise eine ausdrückliche Erlaubnis, ein Patent zu nutzen oder eine Zusicherung, bei Patentverletzung nicht zu klagen). Jemandem eine solche Patentlizenz zu „erteilen“ bedeutet, eine solche Vereinbarung oder Verpflichtung zu beschließen, ein Patent nicht gegen ihn durchzusetzen.

Wenn Sie ein betroffenes Werk übertragen, das wissentlich auf eine Patentlizenz angewiesen ist, und wenn der korrespondierende Quelltext nicht für jeden zum Kopieren zur Verfügung gestellt wird – kostenlos, unter den Bedingungen dieser Lizenz und über
einen öffentlich zugänglichen Netzwerk-Server oder andere leicht zugängliche Mittel –, dann müssen Sie entweder (1) dafür sorgen, daß
der korrespondierende Quelltext auf diese Weise verfügbar gemacht wird oder (2) dafür sorgen, daß Ihnen selbst die Vorteile der Patentlizenz für dieses spezielle Werk entzogen werden oder (3) in einer mit den Erfordernissen dieser Lizenz vereinbaren Weise bewirken, daß die Patentlizenz auf nachgeordnete Empfänger ausgedehnt wird. „Wissentlich angewiesen sein“ bedeutet, daß Sie tatsächliches Wissen darüber haben, daß – außer wegen der Patentlizenz – Ihre Übertragung des betroffenen Werks in einen Staat oder die Benutzung des betroffenen Werks durch Ihren Empfänger in einem Staat, eins oder mehrere identifizierbare Patente in diesem Staat verletzen würden, deren Gültigkeit Ihnen glaubhaft erscheint.

Wenn Sie, als Folge von oder in Verbindung mit einer einzelnen Transaktion oder Vereinbarung,
ein betroffenes Werk übertragen oder durch Vermittlung einer Übertragung propagieren, und Sie gewähren einigen Empfängern eine Patentlizenz, die ihnen das Benutzen, Propagieren, Modifizieren und Übertragen einer speziellen Kopie des betroffenen Werks gestatten, dann wird die von Ihnen gewährte Patentlizenz automatisch auf alle Empfänger des betroffenen Werks und darauf basierender Werke ausgedehnt.

Eine Patentlizenz ist „diskriminierend“, wenn sie in ihrem Gültigkeitsbereich die speziell unter dieser Lizenz gewährten Rechte nicht einschließt, wenn sie die Ausübung dieser Rechte verbietet oder wenn sie die Nichtausübung einer oder mehrerer dieser Rechte zur Bedingung hat. Sie dürfen ein betroffenes Werk nicht übertragen, wenn Sie Partner in einem Vertrag mit einer Drittpartei sind, die auf dem Gebiet der Verbreitung von Software geschäftlich tätig ist, gemäß dem Sie dieser Drittpartei Zahlungen leisten, die auf dem Maß Ihrer Aktivität des Übertragens des Werks basieren, und gemäß dem die Drittpartei eine diskriminierende Patentlizenz all denjenigen gewährt, die das Werk von Ihnen erhielten, (a) in Verbindung mit von Ihnen übertragenen Kopien des betroffenen Werks (oder Kopien dieser Kopien) oder (b) hauptsächlich für und in Verbindung mit spezifischen Produkten oder Zusammenstellungen, die das betroffene Werk enthalten, es sei denn, Sie sind in diesen Vertrag vor dem 28. März 2007 eingetreten oder die Patentlizenz wurde vor diesem Datum erteilt.

Nichts in dieser Lizenz soll in einer Weise ausgelegt werden, die irgendeine implizite Lizenz oder sonstige Abwehr gegen Rechtsverletzung ausschließt oder begrenzt, die Ihnen ansonsten gemäß anwendbarem Patentrecht zustünde.

12. Keine Preisgabe der Freiheit Dritter
Sollten Ihnen (durch Gerichtsbeschluß, Vergleich oder anderweitig) Bedingungen auferlegt werden, die den Bedingungen dieser Lizenz
widersprechen, so befreien Sie diese Umstände nicht von den Bestimmungen dieser Lizenz. Wenn es Ihnen nicht möglich ist, ein betroffenes Werk unter gleichzeitiger Beachtung der Bedingungen in dieser Lizenz und Ihrer anderweitigen Verpflichtungen zu übertragen, dann dürfen Sie als Folge das Programm überhaupt nicht übertragen. Wenn Sie zum Beispiel Bedingungen akzeptieren, die Sie dazu verpflichten,
von denen, denen Sie das Programm übertragen haben, eine Gebühr für die weitere Übertragung einzufordern, dann besteht der einzige Weg, sowohl jene Bedingungen als auch diese Lizenz zu befolgen darin, ganz auf die Übertragung des Programms zu verzichten.

13. Nutzung zusammen mit der GNU Affero General Public License
Ungeachtet anderer Regelungen dieser Lizenz, ist es Ihnen gestattet, ein betroffenes Werk mit einem Werk zu einem einzelnen, kombinierten Werk zu verbinden (linken) oder zu kombinieren, das unter Version 3 der GNU
Affero General Public License steht, und das Ergebnis zu übertragen. Die Bedingungen dieser Lizenz bleiben weiterhin auf denjenigen Teil anwendbar, der das betroffene Werk darstellt, aber die speziellen Anforderungen der GNU Affero General Public License, §13, die sich auf Interaktion über ein Computer-Netzwerk beziehen, werden auf die Kombination als solche anwendbar.

14. Überarbeitungen dieser
Lizenz
Die Free Software Foundation kann von Zeit zu Zeit überarbeitete und/oder neue Versionen der General Public License veröffentlichen. Solche neuen Versionen werden vom Grundprinzip her der gegenwärtigen entsprechen, können aber im Detail abweichen, um neuen Problemen und Anforderungen gerecht zu werden.

Jede Version dieser Lizenz hat eine eindeutige Versionsnummer. Wenn in einem Programm angegeben wird, daß es dieser Lizenz in einer bestimmten Versionsnummer „oder jeder späteren Version“ (“or any later version”) unterliegt, so haben Sie die Wahl, entweder den Bestimmungen der genannten Version zu folgen oder denen jeder beliebigen späteren Version, die von der Free Software Foundation veröffentlicht wurde. Wenn das Programm keine Versionsnummer angibt, können Sie eine beliebige Version wählen, die je von der Free Software Foundation veröffentlicht wurde.

15. Gewährleistungsausschluß
Es besteht keinerlei Gewährleistung für das Programm, soweit dies gesetzlich zulässig ist. Sofern nicht anderweitig schriftlich bestätigt, stellen die Urheberrechtsinhaber und/oder Dritte das Programm so zur Verfügung, „wie es ist“, ohne irgendeine Gewährleistung, weder ausdrücklich noch implizit, einschließlich – aber nicht begrenzt auf – die implizite Gewährleistung der Marktreife oder der Verwendbarkeit für einen bestimmten Zweck. Das volle Risiko bezüglich Qualität und Leistungsfähigkeit des Programms liegt bei Ihnen. Sollte sich das Programm als fehlerhaft herausstellen, liegen die Kosten für notwendigen Service, Reparatur oder Korrektur bei Ihnen.

16. Haftungsbegrenzung
In keinem Fall, außer wenn durch geltendes Recht gefordert oder schriftlich zugesichert, ist irgendein Urheberrechtsinhaber oder irgendein Dritter, der das Programm wie oben erlaubt modifiziert oder übertragen hat, Ihnen gegenüber für irgendwelche Schäden haftbar, einschließlich jeglicher allgemeiner oder spezieller Schäden, Schäden durch Seiteneffekte (Nebenwirkungen) oder Folgeschäden, die aus der Benutzung des Programms oder der Unbenutzbarkeit des Programms folgen (einschließlich – aber nicht beschränkt auf – Datenverluste, fehlerhafte Verarbeitung von Daten, Verluste, die von Ihnen oder anderen getragen werden müssen, oder dem Unvermögen des Programms, mit irgendeinem anderen Programm zusammenzuarbeiten), selbst wenn ein Urheberrechtsinhaber oder Dritter über die Möglichkeit solcher Schäden unterrichtet worden war.

17. Interpretation von §§ 15 und 16
Sollten der o.a. Gewährleistungsausschluß und die o.a. Haftungsbegrenzung aufgrund ihrer Bedingungen gemäß lokalem Recht unwirksam sein, sollen Bewertungsgerichte dasjenige lokale Recht anwenden, das einer absoluten Aufhebung jeglicher zivilen Haftung in Zusammenhang mit dem Programm am nächsten kommt, es sei denn, dem Programm lag eine entgeltliche Garantieerklärung oder Haftungsübernahme bei.



GNU Lesser General Public License
Deutsche Übersetzung der Version 3, 29. Juni 2007

Copyright © 2007 Free Software Foundation, Inc. (http://fsf.org/) 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA

Es ist jedermann gestattet, diese Lizenzurkunde zu vervielfältigen und unveränderte Kopien zu verbreiten; Änderungen sind jedoch nicht erlaubt.

Diese Übersetzung ist kein rechtskräftiger Ersatz für die englischsprachige Originalversion, deswegen ist die
ORIGINALVARIANTE weiter unten einzusehen! Die deutsche Version dient nur zum besseren Verständnis.

Diese Version der GNU Lesser General Public License umfaßt die Bedingungen von Version 3 der GNU General Public License, ergänzt um die unten aufgelisteten zusätzlichen Genehmigungen.

0. Zusätzliche Definitionen.
Nachstehend bezeichnet „diese Lizenz“ die GNU Lesser General Public License, Version 3, und „GNU GPL“ die GNU General Public License, Version 3.

„Die Bibliothek“ steht für ein betroffenes Werk unter dieser Lizenz,
bei dem es nicht um eine Anwendung oder um ein kombiniertes Werk im Sinne der untenstehenden Definitionen handelt.

Eine „Anwendung“ ist irgendein Werk, das eine von der Bibliothek bereitgestellte Schnittstelle nutzt, ansonsten aber nicht auf der Bibliothek basiert. Die Definition einer abgeleiteten Klasse einer von der Bibliothek bereitgestellten Klasse wird als eine Weise betrachtet, eine von der Bibliothek bereitgestellte Schnittstelle zu nutzen.

Ein „kombiniertes Werk“ ist ein Werk, das durch das Kombinieren oder Linken einer Anwendung mit der Bibliothek erzeugt wurde. Die spezifische Version der Bibliothek, mit der zusammen das kombinierte Werk erzeugt wurde, wird auch „gelinkte Version“ genannt.

Der „Minimalquelltext“ eines kombinierten Werks bezeichnet den korrespondierenden Quelltext des kombinierten Werks, ausgenommen den Quelltext von Teilen des kombinierten Werks, die, einzeln betrachtet, auf der Anwendung basieren und nicht auf der gelinkten Version.

Der „korrespondierende Anwendungs-Code“ eines kombinierten Werks bezeichnet den Objekt-Code und/oder Quelltext der Anwendung einschließlich aller Daten und Hilfsprogramme, die benötigt werden, um das kombinierte Werk anhand der Anwendung zu reproduzieren, mit Ausnahme der Systembibliotheken des kombinierten Werks.

1. Ausnahmen von §3 der GNU GPL
Sie dürfen ein betroffenes Werk gemäß §§3 und 4 dieser Lizenz übertragen, ohne an §3 der GNU GPL gebunden zu sein.

2. Übertragung modifizierter Versionen
Wenn Sie ein Exemplar der Bibliothek modifizieren und sich eine Routine (“facility”) innerhalb dieser Modifikationen auf eine Funktion oder auf Daten bezieht, die von einer Anwendung bereitgestellt werden, die die Bibliothek nutzt (auf eine andere Weise als in Gestalt eines Arguments, das beim Aufruf der Routine übergeben wird), dann dürfen Sie eine Kopie der modifizierten Version folgendermaßen übertragen:

a)  gemäß dieser Lizenz, sofern Sie sich in gutem Glauben darum bemühen, sicherzustellen, daß die
Routine weiterhin funktioniert, wenn die Anwendung die Funktion oder Daten nicht bereitstellt und denjenigen Teil ihres Zweckes, der sinnvoll bleibt, weiterhin ausführt, oder
b)    gemäß der GNU GPL, wobei keine der zusätzlichen Genehmigungen dieser Lizenz bei dieser Kopie greifen.
3. Objekt-Code, der Material aus Bibliotheks-Header-Dateien enthält
Die Objekt-Code-Form einer Anwendung darf Material aus einer Header-Datei enthalten, die Teil der Bibliothek ist. Sie dürfen derartigen Objekt-Code gemäß Bedingungen Ihrer Wahl übertragen, vorausgesetzt – sofern das enthaltene Material nicht auf numerische Parameter, Datenstrukturanordnungen und -zugriffsfunktionen oder kleine Makros, Inline-Funktionen und Templates (zehn oder weniger Zeilen lang) beschränkt ist –, Sie führen die beiden folgenden Handlungen aus:

a)  Versehen Sie jedes Exemplar des Objekt-Codes mit einem prominenten Hinweis, daß die Bibliothek darin verwendet wird und daß die Bibliothek und ihre Benutzung durch diese Lizenz abgedeckt werden.
b)        Legen Sie dem Objekt-Code ein Exemplar der GNU GPL und dieses Lizenzdokuments bei.
4. Kombinierte Werke
Sie dürfen ein betroffenes Werk unter Bedingungen Ihrer Wahl übertragen, die insgesamt die Modifikation der in dem kombinierten Werk enthaltenen Teile der Bibliothek und das Zurückbilden (“reverse engineering”), um derartige Modifikationen von Fehlern zu bereinigen, nicht wirksam einschränken, wenn Sie außerdem alle folgenden Handlungen ausführen:

a)   Versehen Sie jedes Exemplar des kombinierten Werks mit einem prominenten Hinweis, daß die Bibliothek darin verwendet wird und daß die Bibliothek und ihre Benutzung durch diese Lizenz abgedeckt werden.
b)  Legen Sie dem kombinierten Werk ein Exemplar der GNU GPL und dieses Lizenzdokuments bei.
c)  Für ein kombiniertes Werk, das bei Ausführung Copyright-Hinweise anzeigt, fügen Sie den Copyright-Hinweis für die Bibliothek diesen Hinweisen hinzu sowie einen Verweis, der den Anwender zu den Exemplaren der GNU
GPL und dieses Lizenzdokuments führt.
d)       Führen Sie eine der folgenden Handlungen aus:
0.       Übertragen Sie den korrespondierenden Minimalquelltext gemäß den Bedingungen dieser Lizenz und den korrespondierenden Anwendungs-Code in einer Form und gemäß Bedingungen, die den Anwender erlauben, die Anwendung mit einer modifizierten Version der gelinkten Version neu zu kombinieren oder zu linken, um ein modifiziertes korrespondierendes Werk zu erzeugen, auf eine Weise, wie sie in §6 der GNU GPL spezifiziert ist, um korrespondierenden Quelltext zu übertragen.
1.   Verwenden Sie einen geeigneten Shared-Library-Mechanismus, um mit der Bibliothek zu linken. Ein geeigneter Mechanismus ist ein Mechanismus, der (a) zur Laufzeit ein Exemplar der Bibliothek verwendet, das sich bereits auf dem Computer des Anwenders befindet, und (b) mit einer modifizierten Version der Bibliothek, die mit der gelinkten Version schnittstellenkompatibel ist, korrekt arbeiten wird.
e)  Stellen Sie Installationsinformationen zur Verfügung – allerdings nur dann, wenn Sie dazu ansonsten gemäß §6 der GNU GPL verpflichtet wären, und nur in dem Maße, in dem derartige Informationen benötigt werden, um eine modifizierte Version des kombinierten Werks installieren und ausführen zu können, die durch erneutes Kombinieren oder Linken der Anwendung mit einer modifizierten Version der gelinkten Version erzeugt wurde. (Wenn Sie Option 4d0 verwenden, müssen die Installationsinformationen
dem korrespondierenden Minimalquelltext und Anwendungs-Code beiliegen. Wenn Sie Option 4d1 verwenden, müssen Sie die Installationsinformationen in einer Form zur Verfügung stellen, die in §6 der GNU GPL für das Übertragen des korrespondierenden Quelltextes spezifiziert wurde.)
5. Kombinierte Bibliotheken
Sie dürfen Routinen aus der Bibliothek, die ein auf der Bibliothek basierendes Werk darstellen, mit anderen Bibliotheks-Routinen, die keine Anwendungen sind und die nicht unter dieser Lizenz stehen, in einer einzelnen Bibliothek nebeneinanderstellen und eine derartige kombinierte Bibliothek unter Bedingungen Ihrer Wahl übertragen, wenn Sie die beiden folgenden Handlungen ausführen:

a)    Legen Sie der kombinierten Bibliothek ein Exemplar desselben auf der Bibliothek basierenden Werks bei, das von jedweden anderen Bibliotheks-Routinen entbündelt wurde und unter den Bedingungen dieser Lizenz übertragen wird.
b)    Versehen Sie die kombinierte Bibliothek mit einem prominenten Hinweis, daß Teile davon ein auf der Bibliothek basierendes Werk darstellen, und erklären Sie, wo die beiliegende entbündelte Form desselben Werks zu finden ist.
6. Überarbeitungen der GNU Lesser General Public
License
Die Free Software Foundation kann von Zeit zu Zeit überarbeitete und/oder neue Versionen der GNU Lesser General Public License veröffentlichen. Solche neuen Versionen werden vom Grundprinzip her der gegenwärtigen entsprechen, können aber im Detail abweichen,
um neuen Problemen und Anforderungen gerecht zu werden.

Jede Version hat eine eindeutige Versionsnummer. Wenn eine Bibliothek, wie
Sie sie erhalten haben, angibt, daß eine bestimmte Versionsnummer der GNU Lesser General Public License „oder irgendeine spätere Version“ (“or any later version”) darauf anwendbar ist, so haben Sie die Wahl, entweder den Bestimmungen der genannten Version zu folgen oder denen jeder beliebigen späteren Version, die von der Free Software Foundation veröffentlicht wurde. Wenn die Bibliothek, wie Sie sie erhalten haben, keine Versionsnummer angibt, können Sie irgendeine Version der GNU Lesser General Public License wählen, die je von
der Free Software Foundation veröffentlicht wurde.


Wenn die Bibliothek, wie Sie sie erhalten haben, bestimmt, daß ein Bevollmächtigter entscheiden kann, ob zukünftige Versionen der GNU Lesser General Public License anwendbar sein sollen, dann ist eine öffentliche Stellungnahme der Akzeptanz einer beliebigen Version für Sie eine permanente Erlaubnis, diese Version für die Bibliothek auszuwählen.

AB HIER DIE RECHTSKRÄFTIGE ORIGINALVERSIONEN:

GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.

                            Preamble

  The GNU General Public License is a free, copyleft license for
software and other kinds of works.

  The licenses for most software and other practical works are designed
to take away your freedom to share and change the works.  By contrast,
the GNU General Public License is intended to guarantee your freedom to
share and change all versions of a program--to make sure it remains free
software for all its users.  We, the Free Software Foundation, use the
GNU General Public License for most of our software; it applies also to
any other work released this way by its authors.  You can apply it to
your programs, too.

  When we speak of free software, we are referring to freedom, not
price.  Our General Public Licenses are designed to make sure that you
have the freedom to distribute copies of free software (and charge for
them if you wish), that you receive source code or can get it if you
want it, that you can change the software or use pieces
of it in new
free programs, and that you know you can do these things.

  To protect your rights, we need to prevent others from denying you
these rights or asking you to surrender the rights.  Therefore, you have
certain responsibilities if you distribute copies of the software, or if
you modify it: responsibilities to respect the freedom of others.

  For example, if you distribute copies
of such a program, whether
gratis or for a fee, you must pass on to the recipients the same
freedoms that you received.  You must make sure that they, too, receive
or can get the source code.  And you must show them these terms so they
know their rights.

  Developers that use the GNU GPL protect your rights with two steps:
(1) assert copyright on the software, and (2) offer you this License
giving you legal permission to copy, distribute and/or modify it.

  For the developers' and authors' protection, the GPL clearly explains
that there is no warranty for this free software.  For both users' and
authors' sake, the GPL requires that modified versions be marked as
changed, so that their problems will not be attributed erroneously to
authors of previous versions.

  Some devices are designed to deny users access to install or run
modified versions of the software inside them, although the manufacturer
can do so.  This is fundamentally incompatible with the aim of
protecting users' freedom to change the software.  The systematic
pattern of such abuse occurs in the area of products for individuals to
use, which is precisely where it is most unacceptable.  Therefore, we
have designed this version of the GPL to prohibit the practice for those
products.  If such problems arise substantially in other domains, we
stand ready to extend this provision to those domains in future versions
of the GPL, as needed to protect the freedom of users.

  Finally, every program is threatened constantly by software patents.
States should not allow patents to restrict development and use of
software on general-purpose computers, but in those that do, we wish to
avoid the special danger that patents applied
to a free program could
make it effectively proprietary.  To prevent this, the GPL assures that
patents cannot be used to render the program non-free.

  The precise terms and conditions for copying, distribution and
modification follow.


 TERMS AND CONDITIONS

  0. Definitions.

  'This License' refers to version 3 of the GNU General Public License.

  'Copyright' also means copyright-like laws that apply to other kinds of
works, such as semiconductor masks.

  'The Program' refers to any copyrightable work licensed under this
License.  Each licensee is addressed as 'you'.  'Licensees' and
'recipients' may be individuals
or organizations.

  To 'modify' a work means to copy from or adapt all or part of the work
in a fashion requiring copyright permission, other than the making of an
exact copy.  The resulting work is called a 'modified version' of the
earlier work or a work 'based on' the earlier work.

  A 'covered work' means either the unmodified Program or a work based
on the Program.

  To 'propagate' a work means to do anything with it that, without
permission, would make you directly or secondarily liable for
infringement under
applicable copyright law, except executing it on a
computer or modifying a private copy.  Propagation includes copying,
distribution (with or without modification), making available to the
public, and in some countries other activities as well.

  To 'convey' a work means any kind of propagation that enables other
parties to make or receive copies.  Mere interaction with a user through
a computer network, with no transfer of a copy, is not conveying.

  An interactive user interface displays 'Appropriate Legal Notices'
to the extent that it includes a convenient and prominently visible
feature that (1) displays an appropriate copyright notice, and (2)
tells the user that there is no warranty for the work (except to the
extent that warranties are provided), that licensees may convey the
work under this License, and how to view a copy of this License.  If
the interface presents a list of user commands or options, such as a
menu, a prominent item in the list meets this criterion.

  1. Source Code.

  The 'source code' for a work means the preferred form of the work
for making modifications to it.  'Object code' means any non-source
form of a work.

  A 'Standard Interface' means an interface that either is an official
standard defined by a recognized standards body, or, in the case of
interfaces specified for a particular programming language, one that
is widely used among developers working in that language.

  The 'System Libraries' of an executable work include anything, other
than the work as a whole, that (a) is included in the normal form of
packaging a Major Component, but which is not part of that Major
Component, and (b) serves only to enable use of the work with that
Major Component, or to implement a Standard Interface for which an
implementation is available to the public in source code form.  A
'Major Component', in this context, means a major essential component
(kernel, window system, and so on) of the specific operating system
(if any) on which the executable work runs, or a compiler used to
produce the work, or an object code interpreter used to run it.

  The 'Corresponding Source' for a work in object code form means all
the source code needed to generate, install, and (for an executable
work) run the object code and to modify the work, including scripts to
control those activities.  However, it does not include the work's
System Libraries, or general-purpose tools or generally available free
programs which are used unmodified in performing those activities but
which are not part of the work.  For example, Corresponding Source
includes interface definition files associated with source files for
the work, and the source code for shared libraries and dynamically
linked subprograms that the work is specifically designed to require,
such as by intimate data communication or control flow between those
subprograms and other parts of the work.

  The Corresponding Source need not include anything that users
can regenerate automatically from other parts of the Corresponding
Source.

  The Corresponding Source for a work in source code form is that
same work.

  2. Basic Permissions.

  All rights granted under this License are granted for the term of
copyright on the Program, and are irrevocable provided the stated
conditions are met.  This License explicitly affirms your unlimited
permission to run the unmodified Program.  The output from running
a
covered work is covered by this License only if the output, given its
content, constitutes a covered work.  This License acknowledges your
rights of fair use or other equivalent, as provided by copyright law.

  You may make, run and propagate covered works that you do not
convey, without conditions so long as your license otherwise remains
in force.  You may convey covered works to others
for the sole purpose
of having them make modifications exclusively for you, or provide you
with facilities for running those works,
provided that you comply with
the terms of this License in conveying all material for which you do
not control copyright.  Those thus making or running the covered works
for you must do so exclusively on your behalf, under your direction
and control, on terms that prohibit them from making any copies of
your copyrighted material outside their relationship with you.

  Conveying under any other circumstances is permitted solely under
the conditions stated below.  Sublicensing is not allowed; section 10
makes it unnecessary.

  3. Protecting Users' Legal Rights From Anti-Circumvention Law.

  No covered work shall be deemed part of an effective technological
measure under any applicable law fulfilling obligations under article
11 of the WIPO copyright treaty adopted on 20 December 1996, or
similar laws prohibiting or restricting circumvention of such
measures.

  When you convey a covered work, you waive any legal power to forbid
circumvention of technological measures to the extent such circumvention
is effected by exercising rights under this License with respect to
the covered work, and you disclaim any intention to limit operation or
modification of the work as a means of enforcing, against the work's
users, your or third parties' legal rights to forbid circumvention of
technological measures.

  4. Conveying Verbatim Copies.

  You may convey verbatim copies of the Program's source code as you
receive it, in any medium, provided that you conspicuously and
appropriately publish on each copy an appropriate copyright notice;
keep intact all notices stating that this License and any
non-permissive terms added in accord with section 7 apply to the code;
keep intact all notices of the absence of any warranty; and give all
recipients a copy of this License along with the Program.

  You may charge any price or no price for each copy that you convey,
and you may offer support or warranty protection for a fee.

  5. Conveying Modified Source
Versions.

  You may convey a work based on the Program, or the modifications to
produce it from the Program, in the form of source code under the
terms of section 4, provided that you also meet all of these conditions:

    a) The work must carry prominent notices stating that you modified
    it, and giving a relevant date.

    b) The work must carry prominent notices stating that it is
    released under this License and any conditions added under section
    7.  This requirement modifies the requirement in section
4 to
    'keep intact all notices'.

    c) You must license the entire work, as a whole, under this
    License to anyone who comes into possession of a copy.  This
    License will therefore apply, along with any applicable section 7
    additional terms, to the whole of the work, and all its parts,
    regardless of how they are packaged.  This License gives no
    permission to license the work in any other way, but it does not
    invalidate such permission if you have separately received it.

    d) If the work has interactive user interfaces, each must display
    Appropriate Legal Notices; however, if the Program has interactive
    interfaces that do not display Appropriate Legal Notices, your
    work need not make them do so.

  A compilation of a covered work with other separate and independent
works, which are not by their nature extensions of the covered work,
and which are not combined with it such as to form a larger program,
in or on a volume of a storage or distribution medium, is called an
'aggregate' if the compilation and its resulting copyright are not
used to limit the access or legal rights of the compilation's users
beyond what the individual works permit.  Inclusion of a covered work
in an aggregate does not cause this License to apply to the other
parts of the aggregate.

  6. Conveying Non-Source Forms.

  You may convey a covered work in object code form under the terms
of sections 4 and 5, provided that you also convey the
machine-readable Corresponding Source under the terms of this License,
in one of these ways:


a) Convey the object code in, or embodied in, a physical product
    (including a physical distribution medium), accompanied by the
    Corresponding Source fixed on a durable physical medium
    customarily used for software interchange.

    b) Convey the object code in, or embodied in, a physical product
    (including a physical distribution medium), accompanied by a
    written offer, valid for at least three years and valid for as
    long as you offer spare parts or customer support for that product
    model, to give anyone who possesses the object code either (1) a
    copy of the Corresponding Source for all the software in the
    product that is covered by this License, on a durable physical
    medium customarily used for software interchange, for a price no
    more
than your reasonable cost of physically performing this
    conveying of source, or (2) access to copy the
    Corresponding Source
from a network server at no charge.

    c) Convey individual copies of the object code with a copy of the
    written offer to provide the Corresponding Source.  This
    alternative is allowed only occasionally and noncommercially, and
    only if you received
the object code with such an offer, in accord
    with subsection 6b.

    d) Convey the object code by offering access from a designated
    place (gratis or for a charge), and offer equivalent access to the
    Corresponding Source in the same way through the same place at no
    further charge.  You need not require recipients to copy the
    Corresponding Source along with the object code.  If the place to
    copy the object code is a network server, the Corresponding Source
    may be on a different server (operated by you or a third party)
    that supports equivalent copying facilities, provided you maintain
    clear directions next to the object code saying where to find the
    Corresponding Source.  Regardless of what server hosts the
    Corresponding Source, you remain obligated to ensure that it is
    available for as long as needed to satisfy these requirements.

    e) Convey the object code using peer-to-peer transmission, provided
    you inform other peers where the object code and Corresponding
    Source of the work are being offered to the general public at no
    charge under subsection 6d.

  A separable portion of the object code, whose source code is excluded
from the Corresponding Source as a System Library, need not be
included in conveying the object code work.


 A 'User Product' is either (1) a 'consumer product', which means any
tangible personal property which is normally used for personal, family,
or household purposes, or (2) anything designed or sold for incorporation
into a dwelling.  In determining whether a product is a consumer product,
doubtful cases shall be resolved in favor of coverage.  For a particular
product received by a particular user, 'normally used' refers to a
typical or common use of that class of product, regardless of the status
of the particular user or
of the way in which the particular user
actually uses, or expects or is expected to use, the product.  A product
is a consumer product regardless of whether the product has substantial
commercial, industrial or non-consumer uses, unless such uses represent
the only significant mode of use of the product.

  'Installation Information' for a User Product means any methods,
procedures, authorization keys, or other information required to install
and execute modified versions of a covered work in that User Product from
a modified version of its Corresponding Source.  The information must
suffice to ensure that the continued functioning of the modified object
code is in no case prevented or interfered with solely because
modification has been made.

  If you convey an object code work under this section in, or with, or
specifically for use in, a User Product, and the conveying occurs as
part of a transaction in which the right of possession and use of the
User Product is transferred to the recipient in perpetuity or for a
fixed term (regardless of how the transaction is characterized), the
Corresponding Source conveyed under this section must be accompanied
by the Installation Information.  But this requirement does not apply
if neither you nor any third party retains the ability to install
modified object code on the User Product (for example, the work has
been installed in ROM).

  The requirement to provide Installation Information does not include a
requirement to continue to provide support service, warranty, or updates
for a work that has been modified or installed by the recipient, or for
the User Product in which it has been modified or installed.  Access to a
network may be denied when the modification itself materially and
adversely affects the operation of the network or violates the rules and
protocols for
communication across the network.

  Corresponding Source conveyed, and Installation Information provided,
in accord with this section must be in a format that is publicly
documented (and with an implementation available to the public in
source code form), and must require no special password or key for
unpacking, reading or copying.

  7. Additional Terms.

  'Additional permissions' are
terms that supplement the terms of this
License by making exceptions from one or more of its conditions.
Additional permissions that are applicable to the entire Program shall
be treated as though they were included in this License, to the extent
that they are valid under applicable law.  If additional permissions
apply only to part of the Program, that part may be used separately
under those
permissions, but the entire Program remains governed by
this License without regard to the additional permissions.

  When you convey a copy of a covered work, you may at your option
remove any additional permissions from that copy, or from any part of
it.  (Additional permissions may be written to require their own
removal in certain cases when you modify the work.)  You may place
additional permissions on material, added by you to a covered work,
for which you have or can give appropriate copyright permission.

  Notwithstanding any other provision of this License, for material you
add to a covered work, you may (if authorized by the copyright holders of
that material) supplement the terms of this License with terms:

    a) Disclaiming warranty or limiting liability differently from the
    terms of sections 15 and 16 of this License; or

    b) Requiring preservation of specified reasonable legal notices or
    author attributions in that material or in the Appropriate Legal
    Notices displayed by works containing it; or

    c)
Prohibiting misrepresentation of the origin of that material, or
    requiring that modified versions of such material be marked in
    reasonable ways as different from the original version; or

    d) Limiting the use for publicity purposes of names of licensors or
    authors of the material; or

    e) Declining to grant rights under trademark law for use of some
    trade names, trademarks, or service marks; or

    f) Requiring indemnification of licensors and authors of that
    material by anyone who conveys the material (or modified versions of
    it) with contractual assumptions of liability to the recipient, for
    any liability that these contractual assumptions directly impose on
    those licensors and authors.

  All other non-permissive additional terms are considered 'further
restrictions' within the meaning of section 10.  If the Program as you
received it, or any part of it, contains a
notice stating that it is
governed by this License along with a term that is a further
restriction, you may remove that term.  If a
license document contains
a further restriction but permits relicensing or conveying under this
License, you may add to a covered work material governed by the terms
of that license document, provided that the further restriction does
not survive such relicensing
or conveying.

  If you add terms to a covered work in accord with this section, you
must place, in the relevant source files, a statement of the
additional terms that apply to those files, or a notice indicating
where to find the applicable terms.

  Additional terms, permissive or non-permissive, may be stated in the
form of a separately written license, or stated as exceptions;
the above requirements apply either way.

  8. Termination.

  You may not propagate or modify a covered work except as expressly
provided under this License.  Any attempt otherwise to propagate or
modify it is void, and will automatically terminate your rights under
this License (including any patent licenses granted under the third
paragraph of section 11).

  However, if you cease all violation
of this License, then your
license from a particular copyright holder is reinstated (a)
provisionally, unless and until the copyright holder explicitly and
finally terminates your license, and (b) permanently, if the copyright
holder fails to notify you of the violation by some reasonable means
prior to 60 days after the cessation.

  Moreover, your license from a particular copyright holder
is
reinstated permanently if the copyright holder notifies you of the
violation by some reasonable means, this is the first time you have
received notice of violation of this License (for any work) from that
copyright holder, and you cure the violation prior to 30 days after
your receipt of the notice.

  Termination of your rights under this section does not terminate the
licenses of parties who have received copies or rights from you under
this License.  If your rights have been terminated and not permanently
reinstated, you do not qualify to receive new licenses for the same
material under section 10.

  9. Acceptance Not Required for Having Copies.

  You are not required to accept this License in order to receive or
run a copy of the Program.  Ancillary propagation of a covered work
occurring solely as a consequence of using peer-to-peer transmission
to receive a copy likewise does not require acceptance.  However,
nothing other than this License grants you permission to propagate or
modify any covered work.  These actions infringe copyright if you do
not accept this License.  Therefore, by modifying or propagating a
covered work, you indicate your acceptance of this License to do so.

  10. Automatic Licensing of Downstream Recipients.

  Each time you convey a covered work, the recipient automatically
receives a license from the original licensors, to run, modify and
propagate that work, subject to this License.  You are not responsible
for enforcing compliance by third parties with this License.

  An 'entity transaction' is a transaction transferring control of an
organization, or substantially all assets of one, or subdividing an
organization, or merging organizations.
If propagation of a covered
work results from an entity transaction, each party to that
transaction who receives a copy of the work
also receives whatever
licenses to the work the party's predecessor in interest had or could
give under the previous paragraph, plus a right to possession of the
Corresponding Source of the work from the predecessor in interest, if
the predecessor has it or can get it with reasonable efforts.

  You may not impose any further restrictions on the exercise of the
rights granted or affirmed under this License.  For example, you may
not impose a license fee, royalty, or other charge for exercise of
rights granted under this License, and you may not initiate litigation
(including a cross-claim or counterclaim in a lawsuit) alleging that
any patent claim is infringed by making, using, selling, offering for
sale, or importing the Program or any portion of it.

  11. Patents.

  A 'contributor' is a copyright holder who authorizes use under this
License of the Program or a work on which the Program is based.  The
work thus licensed is called the contributor's 'contributor version'.

  A contributor's 'essential patent claims' are all patent claims
owned or controlled by the contributor, whether already acquired or
hereafter acquired, that would be infringed by some manner,
permitted
by this License, of making, using, or selling its contributor version,
but do not include claims that would be infringed only as a
consequence of further modification of the contributor version.  For
purposes of this definition, 'control' includes the right to grant
patent sublicenses in a manner consistent with the requirements of
this License.

  Each contributor grants you a non-exclusive, worldwide, royalty-free
patent license under the contributor's essential patent claims, to
make, use, sell, offer for sale, import and otherwise run, modify and
propagate the contents of its contributor version.

  In the following three paragraphs, a 'patent license' is any express
agreement or commitment, however denominated, not to enforce a patent
(such as an express permission to practice a patent or covenant not to
sue for patent infringement).  To 'grant' such a patent license to a
party means to make such an agreement or commitment not to enforce a
patent against the party.

  If you convey a covered work, knowingly relying on a patent license,
and the Corresponding Source of the work is not available for anyone
to copy, free of charge and under the terms of this License, through a
publicly available network server or other readily accessible means,
then you must either (1) cause the Corresponding Source to be so
available, or (2) arrange to deprive yourself of the benefit of the
patent license for this particular work, or (3) arrange, in a manner
consistent with the requirements of this License, to extend the patent
license to downstream recipients.  'Knowingly relying' means you have
actual knowledge that, but for the patent license, your conveying the
covered work in a country, or your recipient's use of the covered work
in a country, would infringe one or more identifiable patents in that
country that you have reason to believe are valid.

  If, pursuant to or in connection with a single transaction or
arrangement, you convey, or propagate by procuring conveyance of, a
covered work, and grant a patent license to some of the parties
receiving the covered work authorizing them to use, propagate, modify
or convey a specific copy of the covered work, then the patent license
you grant is automatically extended to all recipients of the covered
work and works based on it.

  A patent license is 'discriminatory' if it does not include within
the scope of its coverage, prohibits the exercise of, or is
conditioned on the non-exercise of one or more of the rights that are
specifically granted under this License.  You may not convey a covered
work if you are a party to an arrangement with
a third party that is
in the business of distributing software, under which you make payment
to the third party based on the extent
of your activity of conveying
the work, and under which the third party grants, to any of the
parties who would receive the covered
work from you, a discriminatory
patent license (a) in connection with copies of the covered work
conveyed by you (or copies made from those copies), or (b) primarily
for and in connection with specific products or compilations that
contain the covered work, unless you entered into that arrangement,
or that patent license was granted, prior to 28 March 2007.

  Nothing in this License shall be construed as excluding or limiting
any implied license or other defenses to infringement that may
otherwise be available to you under applicable patent law.

  12. No Surrender of Others' Freedom.

  If conditions are imposed on you (whether by court order, agreement or
otherwise) that contradict the conditions of this License, they do not
excuse you from the conditions of this License.  If you cannot convey a
covered work so as to satisfy simultaneously your obligations under this
License and any other pertinent obligations, then as a consequence you may
not convey it at all.  For example, if you agree to terms that obligate you
to collect a royalty for further conveying from those to whom you convey
the Program, the only way you could satisfy both those terms and this
License
would be to refrain entirely from conveying the Program.

  13. Use with the GNU Affero General Public License.

  Notwithstanding any other provision of this License, you have
permission to link or combine any covered work with a work licensed
under version 3 of the GNU Affero General Public License into a single
combined work, and to convey the resulting work.  The terms of this
License will continue to apply to the part which is the covered work,
but the special requirements of the GNU Affero General Public License,
section 13, concerning interaction through a network will apply to the
combination as such.

  14. Revised Versions of this License.

  The Free Software Foundation may publish revised and/or new versions of
the GNU General Public License from time to time.  Such new versions will
be similar in spirit to the present version, but may differ in detail to
address new problems or concerns.

  Each version is given a distinguishing version number.  If the
Program specifies that a certain numbered version of the GNU General
Public License 'or any later version' applies to it, you have the
option of following the terms and conditions either of that numbered
version or of any later version published by the Free Software
Foundation.  If the Program does not specify a version number of the
GNU General Public License, you may choose any version ever published
by the Free Software Foundation.

  If the Program specifies that a proxy can decide which future
versions of the GNU General Public License can be used, that proxy's
public statement of acceptance of a version permanently authorizes you
to choose that version for the Program.

  Later license versions may give you additional or different
permissions.  However, no additional obligations are imposed on any
author or copyright holder as a result of your choosing to follow a
later version.

  15. Disclaimer of Warranty.

  THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM 'AS
IS' WITHOUT WARRANTY
OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
ALL NECESSARY SERVICING, REPAIR OR CORRECTION.

  16. Limitation of Liability.

  IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS
THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY
GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
DATA OR DATA BEING RENDERED
INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD
PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),
EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
SUCH DAMAGES.

  17. Interpretation of Sections 15 and 16.

  If the disclaimer of warranty and limitation of liability provided
above cannot be given local legal effect according to their terms,
reviewing courts shall apply local law that most closely approximates
an absolute waiver of all civil liability in connection with the
Program, unless a warranty or assumption of liability accompanies a
copy of the Program in return for a fee.


END OF TERMS AND CONDITIONS

            How to Apply These Terms to Your New Programs

  If you develop a new program, and you want it to be of the greatest
possible use to the public, the best way to achieve this is to make it
free software which everyone can
redistribute and change under these terms.

  To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
state the exclusion of warranty; and each file should have at least
the 'copyright' line and a pointer to where the full notice is found.

    <one line to give the program's name and a brief idea of what it does.>
    Copyright (C) <year>  <name of author>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.

Also add information on how to contact you by electronic and paper mail.

  If the program does terminal interaction, make it output a short
notice like this when it starts in an interactive mode:

    <program>  Copyright (C) <year>  <name of author>
    This program comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
    This is free
software, and you are welcome to redistribute it
    under certain conditions; type `show c' for details.

The hypothetical commands `show w' and `show c' should show the appropriate
parts of the General Public License.  Of course, your program's commands
might be different; for a GUI interface, you would use an 'about box'.

  You should also get your employer (if you work as a programmer) or school,
if any, to sign a 'copyright disclaimer' for the program, if necessary.
For more information on this, and how to apply and follow the GNU GPL, see
<https://www.gnu.org/licenses/>.

  The GNU General Public License does not permit incorporating your program
into proprietary programs.  If your program is a subroutine library, you
may consider it more useful to permit linking proprietary applications with
the library.  If this is what you want to do, use the GNU Lesser General
Public License instead of this License.  But first, please read
<https://www.gnu.org/licenses/why-not-lgpl.html>.

  GNU LESSER GENERAL PUBLIC LICENSE

      Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.


  This version of the GNU Lesser General Public License incorporates
the terms and conditions of version 3 of the GNU General Public
License, supplemented by the additional permissions listed below.

  0. Additional Definitions.

  As used herein, 'this License' refers to version 3 of the GNU Lesser
General Public License, and the 'GNU GPL' refers to version 3 of the GNU
General Public License.

  'The Library' refers to a covered work governed by this License,
other than an Application or a Combined Work as defined below.

  An 'Application' is any work that makes use of an interface provided
by the Library, but which is not otherwise based on the Library.
Defining a subclass of a class defined by the Library is deemed a mode
of using an interface provided by the Library.

  A 'Combined Work' is a work produced by combining or linking an
Application with the Library.  The particular version of the Library
with which the Combined Work was made is also called the 'Linked
Version'.

  The 'Minimal Corresponding Source' for a Combined Work means the
Corresponding Source for the Combined Work, excluding any source code
for portions of the Combined Work that, considered in isolation, are
based on the Application, and not on the Linked Version.

  The 'Corresponding Application Code' for a Combined Work means the
object code and/or
source code for the Application, including any data
and utility programs needed for reproducing the Combined Work from the
Application, but excluding the System Libraries of the Combined Work.

  1. Exception to Section 3 of the GNU GPL.

  You may convey a covered work under sections 3 and 4 of this License
without being bound by section 3 of the GNU GPL.

  2. Conveying Modified Versions.

  If you modify a copy of the Library, and, in your modifications, a
facility refers to a function or data to be supplied by an Application
that uses the facility (other than as an argument passed when the
facility is invoked), then you may convey a copy of the modified
version:

   a) under this License, provided that you make a good faith effort to
   ensure that, in the event an Application does not supply the
   function or data, the facility still operates, and performs
   whatever part of its purpose remains meaningful, or

   b) under the GNU GPL, with none of the additional permissions of
   this License applicable to that copy.

  3. Object Code Incorporating Material from Library Header Files.

  The object code form of an Application may incorporate material from
a header file that is part of the Library.  You may convey such object
code under terms of your choice, provided that, if the incorporated
material is not limited to numerical parameters, data structure
layouts and accessors, or small macros, inline functions and templates
(ten or fewer lines in length), you do both of the following:

   a) Give prominent notice with each copy of the object
code that the
   Library is used in it and that the Library and its use are
   covered by this License.

   b) Accompany the object code with a copy of the GNU GPL and this license
   document.

  4. Combined Works.

  You may convey a Combined Work under terms of your choice that,
taken together, effectively do not restrict modification of the
portions of the Library contained in the Combined Work and reverse
engineering for debugging such modifications, if you also do each of
the following:

   a) Give prominent notice with each copy of the Combined Work that
   the Library is used in it and that the Library and its use are
   covered by this
License.

   b) Accompany the Combined Work with a copy of the GNU GPL and this license
   document.

   c) For a Combined Work that displays copyright notices during
   execution, include the copyright notice for the Library among
   these notices, as well as
a reference directing the user to the
   copies of the GNU GPL and this license document.

   d) Do one of the following:


 0) Convey the Minimal Corresponding Source under the terms of this
       License, and the Corresponding Application Code in a form
       suitable for, and under terms that permit, the user to
       recombine or relink the Application with a modified version of
       the Linked Version to produce a modified Combined Work, in the
       manner specified by section 6 of the GNU GPL for conveying
       Corresponding Source.

       1) Use a suitable shared library mechanism for linking with the
       Library.  A suitable mechanism is one that (a) uses at run time
       a copy of the Library already present on the user's computer
       system, and (b) will operate properly with a modified version
       of the Library that is interface-compatible with the Linked
       Version.

   e) Provide Installation Information, but only if you would otherwise
   be required to provide such information under section 6 of the
   GNU GPL, and only to the extent that such information is
   necessary to install and execute a modified version of the
   Combined Work produced by recombining or relinking the
   Application with a modified version of the Linked Version. (If
   you
use option 4d0, the Installation Information must accompany
   the Minimal Corresponding Source and Corresponding Application
   Code. If you use option 4d1, you must provide the Installation
   Information in the manner specified by section 6 of the GNU GPL
   for conveying Corresponding Source.)

  5. Combined Libraries.

  You may place library facilities that are a work based on the
Library side by side in a single library together with other library
facilities that are not Applications and are not covered by this
License, and convey such a combined library under terms of your
choice, if you do both of the following:

   a) Accompany the combined library with a copy of the same work based
   on the Library, uncombined with any other library facilities,
   conveyed under the terms of this License.

   b) Give prominent notice with the combined library that part of it
   is a work based on the Library, and explaining where to find the
   accompanying uncombined form of the same work.

  6. Revised Versions of the GNU Lesser General
Public License.

  The Free Software Foundation may publish revised and/or new versions
of the GNU Lesser General Public License from time to time. Such new
versions will be similar in spirit to the present version, but may
differ in detail to address new problems or concerns.

  Each version is given a distinguishing version number. If the
Library as you received it specifies that a certain numbered version
of the GNU Lesser General Public License 'or any later version'
applies to it, you have the option of following the terms and
conditions either of that published version or of any later version
published by the Free Software Foundation. If the Library as you
received it does not specify a version number of the GNU Lesser
General Public License, you may choose any version of the GNU Lesser
General Public License ever published by the Free Software Foundation.

  If the Library as you received it specifies that a proxy can decide
whether future versions of the GNU Lesser General Public License shall
apply, that proxy's public statement of acceptance of any version is
permanent authorization for you to choose that version for the
Library.
")
                    font.pixelSize: 16
                    readOnly: true
                    wrapMode: Text.WordWrap
                }
            }
        }

        Rectangle {

            id: rectangle9
            x: 428
            y: 425
            width: 109
            height: 32
            color: "#eeeeee"
            radius: 15
            border.color: "#7d7d7d"
            Text {
                id: element17
                x: 61
                y: 11
                color: "#404040"
                text: qsTr("Zurück")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 17

            }

            MouseArea {
                id: mouseArea5
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                onClicked: {
                    item8.visible = false
                    item7.visible = true
                }
            }

            border.width: 1
        }
    }


}
