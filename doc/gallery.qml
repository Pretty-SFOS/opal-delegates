/*
 * This file is part of harbour-opal.
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2023 Peter G. (nephros)
 * SPDX-FileCopyrightText: 2024 Mirian Margiani
 */
import QtQuick 2.0
import Sailfish.Silica 1.0 as S
import Opal.Delegates 1.0 as D

S.Page {
    id: root
    allowedOrientations: S.Orientation.All

    ListModel {
        id: fruitModel

        ListElement {
            name: qsTr("Apple")
            price: qsTr("2.95/kg")
            desc: qsTr("a juicy fruit!")
            note: qsTr("A is for Apple")
        }
        ListElement {
            name: qsTr("Banana")
            price: qsTr("1.05/pc")
            desc: qsTr("a yellow fruit!")
            note: qsTr("Oh| Banana!")
        }
        ListElement {
            name: qsTr("A basket full of exotic fruits")
            price: qsTr("15.99/pc")
            desc: qsTr("fruits!")
            note: qsTr("Suitable as a generous gift\nBuy now!")
        }
        ListElement {
            name: qsTr("Nut")
            price: qsTr("0.99/bag")
            desc: qsTr("")
            note: qsTr("not a fruit.")
        }
    }

    ListModel {
        id: chatModel

        ListElement {
            nick: qsTr("SamGee")
            status: qsTr("online")
            when: qsTr("yesterday")
            post: qsTr("@mrunderhill: are there any taters left?")
        }
        ListElement {
            nick: qsTr("Sauron")
            status: qsTr("busy")
            when: qsTr("3rd age")
            post: qsTr("You cannot hide. I see you. There is no life in the void. Only death.")
        }
        ListElement {
            nick: qsTr("Aragorn")
            status: qsTr("away")
            when: qsTr("mid-day")
            post: qsTr("Not idly do the leaves of Lorien fall...")
        }
    }

    Component {
        id: fruitMenu

        S.ContextMenu {
            S.MenuItem {
                text: qsTr("Add to Shopping Basket")
                onClicked: S.Remorse.itemAction(
                    parent.parent.parent, qsTr("Added"),
                    function () {}, 2000)
            }
        }
    }

    Component {
        id: chatMenu

        S.ContextMenu {
            S.MenuItem {
                text: qsTr("Reply")
            }
        }
    }

    S.SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: column.height

        S.VerticalScrollDecorator {
            flickable: flick
        }

        Column {
            id: column
            width: parent.width
            spacing: S.Theme.paddingLarge

            S.PageHeader {
                title: "Opal.Delegates"
            }

            S.SectionHeader {
                text: "TwoLineDelegate"
            }

            S.Label {
                x: S.Theme.horizontalPageMargin
                width: parent.width - 2*x
                wrapMode: Text.Wrap
                color: S.Theme.secondaryHighlightColor
                font.pixelSize: S.Theme.fontSizeSmall
                text: qsTr("The “TwoLineDelegate” component can be used to create " +
                           "a list of things with information in two lines.") + " " +
                      qsTr("Optionally, lines can be alternatingly highlighted.")
            }

            S.ColumnView {
                itemHeight: S.Theme.itemSizeLarge
                model: fruitModel
                delegate: D.TwoLineDelegate {
                    width: parent.width

                    title: name
                    text: note
                    extratext: price
                    leftItem: S.Icon {
                        source: "image://theme/icon-m-favorite"
                    }
                    showOddEven: true
                    menu: fruitMenu
                }
            }

            S.SectionHeader {
                text: "ThreeLineDelegate"
            }

            S.Label {
                width: parent.width
                wrapMode: Text.Wrap
                color: S.Theme.highlightColor
                text: qsTr("A list of things, information in three lines, no marking of odd/even elements.")
            }

            S.ColumnView {
                itemHeight: S.Theme.itemSizeLarge
                model: fruitModel
                delegate: D.ThreeLineDelegate {
                    title: name
                    text: note
                    context: desc
                    extratext: price
                    leftItem: S.Icon {
                        source: "image://theme/icon-m-favorite"
                    }
                    menu: fruitMenu
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
                model: chatModel
                delegate: D.ThreeLineDelegate {
                    title: nick
                    text: post
                    context: when
                    extratext: status
                    leftItem: S.Icon {
                        width: S.Theme.iconSizeMedium
                        height: S.Theme.iconSizeMedium
                        source: (nick === "Sauron") ? "image://theme/icon-splus-show-password?"
                                                      + "darkorange" : "image://theme/icon-m-chat"
                    }
                    menu: chatMenu
                    colors: [S.Theme.primaryColor, "darkorange", S.Theme.highlightDimmerColor]
                }
            }

            S.SectionHeader {
                text: "CompactDelegate"
            }

            S.Label {
                width: parent.width
                wrapMode: Text.Wrap
                color: S.Theme.highlightColor
                text: qsTr("A compact conversation view.")
            }

            S.ColumnView {
                itemHeight: S.Theme.itemSizeSmall
                model: chatModel
                delegate: D.CompactDelegate {
                    title: nick
                    text: post
                    context: status
                    leftItem: S.Icon {
                        width: S.Theme.iconSizeSmall
                        height: S.Theme.iconSizeSmall
                        source: (nick === "Sauron") ? "image://theme/icon-splus-show-password?"
                                                      + "darkorange" : "image://theme/icon-m-chat"
                    }
                    menu: chatMenu
                }
            }
        }
    }
}
