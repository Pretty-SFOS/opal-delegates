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
            statusType: "online"
        }
        ListElement {
            nick: qsTr("Sauron")
            status: qsTr("busy")
            when: qsTr("3rd age")
            post: qsTr("You cannot hide. I see you. There is no life in the void. Only death.")
            statusType: "busy"
        }
        ListElement {
            nick: qsTr("Aragorn")
            status: qsTr("away")
            when: qsTr("mid-day")
            post: qsTr("Not idly do the leaves of Lorien fall...")
            statusType: "away"
        }
    }

    Component {
        id: fruitMenu

        S.ContextMenu {
            S.MenuItem {
                text: qsTr("Add to Shopping Basket")
                onClicked: pageStack.push("EmptyDummyPage.qml")
            }
        }
    }

    Component {
        id: chatMenu

        S.ContextMenu {
            S.MenuItem {
                text: qsTr("Reply")
                onClicked: pageStack.push("EmptyDummyPage.qml")
            }
        }
    }

    S.SilicaFlickable {
        id: flick
        anchors.fill: parent
        contentHeight: column.height + S.Theme.horizontalPageMargin

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
                      qsTr("Optionally, rows can be alternatingly highlighted.")
            }

            S.TextSwitch {
                id: emphasizeRowsFirst
                text: qsTr("Emphasize rows")
                checked: false
            }

            Column {
                // Note: if your delegates are guaranteed to be the same
                // sized when rendered, you can alternatively use Silica's
                // ColumnView here. ColumnView has better performance for
                // long lists, but it cuts your view off at the bottom if
                // your delegates have different sizes.
                width: parent.width

                Repeater {
                    model: fruitModel
                    delegate: D.TwoLineDelegate {
                        title: name
                        text: note
                        hint: price
                        leftItem: S.Icon {
                            source: "image://theme/icon-m-favorite"
                        }
                        showOddEven: emphasizeRowsFirst.checked
                        menu: fruitMenu
                    }
                }
            }

            S.SectionHeader {
                text: "ThreeLineDelegate"
            }

            S.Label {
                x: S.Theme.horizontalPageMargin
                width: parent.width - 2*x
                wrapMode: Text.Wrap
                color: S.Theme.secondaryHighlightColor
                font.pixelSize: S.Theme.fontSizeSmall
                text: qsTr("The “ThreeLineDelegate” component has an extra third " +
                           "content line for least important information.") + " " +
                      qsTr("Optionally, rows can be alternatingly highlighted.")
            }

            S.TextSwitch {
                id: emphasizeRowsSecond
                text: qsTr("Emphasize rows")
                checked: false
            }

            Column {
                width: parent.width

                Repeater {
                    model: fruitModel
                    delegate: D.ThreeLineDelegate {
                        title: name
                        text: note
                        context: desc
                        hint: price
                        leftItem: S.Icon {
                            source: "image://theme/icon-m-favorite"
                        }
                        showOddEven: emphasizeRowsSecond.checked
                        menu: fruitMenu
                    }
                }
            }

            S.SectionHeader {
                text: "CompactDelegate"
            }

            S.Label {
                x: S.Theme.horizontalPageMargin
                width: parent.width - 2*x
                wrapMode: Text.Wrap
                color: S.Theme.secondaryHighlightColor
                font.pixelSize: S.Theme.fontSizeSmall
                text: qsTr("The “CompactDelegate” has a primary and secondary " +
                           "content line. Lines are not wrapped. It can also " +
                           "optionally show an icon on the left.")
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

            S.SectionHeader {
                text: qsTr("Customization")
            }

            S.Label {
                x: S.Theme.horizontalPageMargin
                width: parent.width - 2*x
                wrapMode: Text.Wrap
                color: S.Theme.secondaryHighlightColor
                font.pixelSize: S.Theme.fontSizeSmall
                text: qsTr("Colors and other properties can be " +
                           "freely customized for each line.")
            }

            Column {
                width: parent.width

                Repeater {
                    model: chatModel
                    delegate: D.ThreeLineDelegate {
                        title: nick
                        text: post
                        context: when
                        hint: status
                        menu: chatMenu
                        showOddEven: true

                        hintLabel.color: {
                            if (statusType == "online") "green"
                            else if (statusType == "busy") "orange"
                            else if (statusType == "away") "red"
                            else S.Theme.secondaryColor
                        }

                        titleLabel.color: Qt.tint(hintLabel.color, S.Theme.rgba(S.Theme.highlightColor, 0.8))
                        textLabel.color: S.Theme.primaryColor
                        contextLabel {
                            color: S.Theme.secondaryColor
                            horizontalAlignment: Text.AlignRight
                            font.pixelSize: S.Theme.fontSizeExtraSmall
                        }
                    }
                }
            }
        }
    }
}
