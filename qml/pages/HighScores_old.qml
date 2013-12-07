import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    ListModel {
        id: datamodel
        ListElement { txt: "Pan Bulwa"; score: 402 }
        ListElement { txt: "Dewastator"; score: 356  }
        ListElement { txt: "Math Master"; score: 149  }
    }

    SilicaListView {
        id: listView
        model: datamodel
        anchors.fill: parent
        header: PageHeader {
            title: "Highscores"
        }
        delegate: BackgroundItem {
            id: delegate

            Label {
                x: Theme.paddingLarge
                text: txt
            }
            Label {
                anchors.right: parent.right
                anchors.margins: Theme.paddingLarge
                text: score
            }
        }
    }
}
