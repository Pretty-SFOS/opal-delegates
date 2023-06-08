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
        ListElement { name: "Nut"; price: "0.99"; desc: ""; note: "not a fruit."}
    }
    S.SilicaFlickable { id: flickable
        anchors.fill: parent
        contentHeight: column.height
        Column{ id: column
            width: parent.width
            S.PageHeader{ title: "Opal Delegates"}
            S.SectionHeader{ text: "ThreeLineDelegate"}
            S.ColumnView { id: view
                itemHeight: S.Theme.itemSizeLarge
                model: mymodel
                delegate: D.ThreeLineDelegate {
                    title: name
                    text: note
                    context: desc
                    extratext: price
                    leftItem: S.Icon{ source: "image://theme/icon-m-favorite" }
                    showOddEven: true
                }
            }
            S.SectionHeader{ text: "TwoLineDelegate"}
            S.ColumnView { id: view2
                itemHeight: S.Theme.itemSizeLarge
                model: mymodel
                delegate: D.TwoLineDelegate {
                    title: name
                    text: note
                    extratext: price
                    leftItem: S.Icon{ source: "image://theme/icon-m-favorite" }
                    showOddEven: true
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
}
