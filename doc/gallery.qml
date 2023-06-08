/*
 * This file is part of harbour-opal.
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Peter G. (nephros)
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

    Component {id: cmenu
        S.ContextMenu {
            S.MenuItem {
                text: qsTr("Add to Shopping Basket")
                onClicked: S.Remorse.itemAction(
                    parent.parent.parent,
                    qsTr("Added"),
                    function(){},
                    2000
                )
            }
        }
    }
    S.SilicaFlickable { id: flickable
        anchors.fill: parent
        contentHeight: column.height
        Column{ id: column
            width: parent.width - S.Theme.horizontalPageMargin
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: S.Theme.paddingLarge
            S.PageHeader{ title: "Opal Delegates"}
            S.SectionHeader{ text: "TwoLineDelegate"}
            S.Label {
                width: parent.width
                wrapMode: Text.Wrap
                color: S.Theme.highlightColor
                text: qsTr("A list of things, information in two lines, odd/even elements marked.")
            }
            S.ColumnView {
                itemHeight: S.Theme.itemSizeLarge
                model: mymodel
                delegate: D.TwoLineDelegate {
                    title: name
                    text: note
                    extratext: price
                    leftItem: S.Icon{ source: "image://theme/icon-m-favorite" }
                    showOddEven: true
                    menu: cmenu
                }
            }
            S.SectionHeader{ text: "ThreeLineDelegate"}
            S.Label {
                width: parent.width
                wrapMode: Text.Wrap
                color: S.Theme.highlightColor
                text: qsTr("A list of things, information in three lines, no marking of odd/even elements.")
            }
            S.ColumnView {
                itemHeight: S.Theme.itemSizeLarge
                model: mymodel
                delegate: D.ThreeLineDelegate {
                    title: name
                    text: note
                    context: desc
                    extratext: price
                    leftItem: S.Icon{ source: "image://theme/icon-m-favorite" }
                    //showOddEven: true
                    menu: cmenu
                }
            }
            S.Label {
                width: parent.width
                wrapMode: Text.Wrap
                color: S.Theme.highlightColor
                text: qsTr("Same as above, customized colors.")
            }
            S.ColumnView {
                itemHeight: S.Theme.itemSizeLarge
                model: mymodel
                delegate: D.ThreeLineDelegate {
                    title: name
                    text: note
                    context: desc
                    extratext: price
                    leftItem: S.Icon{ source: "image://theme/icon-m-favorite" }
                    colors: [ S.Theme.primaryColor, "darkorange", S.Theme.highlightDimmerColor ]
                    //showOddEven: true
                    menu: cmenu
                }
            }
        }
    }
}
