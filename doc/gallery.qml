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

    ListModel { id: chatmodel
        ListElement { nick: "SamGee"; status: "online";   when: "yesterday"; post: "@mrunderhill: are there any taters left?" }
        ListElement { nick: "Sauron"; status: "busy";     when: "3rd age"; post: "You cannot hide. I see you. There is no life in the void. Only death." }
        ListElement { nick: "Aragorn"; status: "away";    when: "mid-day"; post: "Not idly do the leaves of Lorien fall..." }
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
    Component {id: rmenu
        S.ContextMenu {
            S.MenuItem { text: qsTr("Reply") }
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
                    menu: cmenu
                }
            }
            S.Label {
                width: parent.width
                wrapMode: Text.Wrap
                color: S.Theme.highlightColor
                text: qsTr("A conversation view using customized colors.")
            }
            S.ColumnView {
                itemHeight: S.Theme.itemSizeLarge
                model: chatmodel
                delegate: D.ThreeLineDelegate {
                    title: nick
                    text: post
                    context: when
                    extratext: status
                    leftItem: S.Icon{
                        width: S.Theme.iconSizeMedium
                        height: S.Theme.iconSizeMedium
                        source: (nick === "Sauron")
                            ? "image://theme/icon-splus-show-password?" + "darkorange"
                            : "image://theme/icon-m-chat" }
                    menu: rmenu
                    colors: [
                        S.Theme.primaryColor,
                        "darkorange",
                        S.Theme.highlightDimmerColor
                    ]
                }
            }
            S.SectionHeader{ text: "CompactDelegate"}
            S.Label {
                width: parent.width
                wrapMode: Text.Wrap
                color: S.Theme.highlightColor
                text: qsTr("A compact conversation view.")
            }
            S.ColumnView {
                itemHeight: S.Theme.itemSizeSmall
                model: chatmodel
                delegate: D.CompactDelegate {
                    title: nick
                    text: post
                    context: status
                    leftItem: S.Icon{
                        width: S.Theme.iconSizeSmall
                        height: S.Theme.iconSizeSmall
                        source: (nick === "Sauron")
                            ? "image://theme/icon-splus-show-password?" + "darkorange"
                            : "image://theme/icon-m-chat" }
                    menu: rmenu
                }
            }
        }
    }
}
