/*
 * This file is part of harbour-opal.
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2020-2023 Mirian Margiani
 */

import QtQuick 2.0
import Sailfish.Silica 1.0 as S
//import Opal.Delegates 1.0 as D
import "../Opal/Delegates" as D

S.Page {
    id: page

    ListModel { id: mymodel
        ListElement { name: "Apple"; price: "2.95"; desc: "a juicy fruit!"; note: "A is for Apple" }
        ListElement { name: "Banana"; price: "1.05"; desc: "a yellow fruit!"; note: "Oh| Banana!" }
        ListElement { name: "A basket full of exotic fruits"; price: "15.99"; desc: "fruits!"; note: "Suitable as a generous gift\nBuy now!" }
    }
    S.SilicaFlickable { id: flickable
        anchors.fill: parent
        S.ColumnView { id: view
            anchors.fill: parent
            itemHeight: S.Theme.itemSizeLarge*2
            model: mymodel
            delegate: D.ThreeLineDelegate {
                text1: name
                text2: desc
                text3: note
                extratext: price
                leftItem: S.Icon{ source: "image://theme/icon-m-play" }
            }
        }
    }
    /*
    S.PullDownMenu {
        parent: page.flickable
        S.MenuItem {
            text: qsTr("Open another page")
            onClicked: pageStack.push(Qt.resolvedUrl("EmptyDummyPage.qml"))
        }
    }
    */
}
