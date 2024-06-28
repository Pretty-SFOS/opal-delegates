//@ This file is part of opal-delegates.
//@ https://github.com/Pretty-SFOS/opal-delegates
//@ SPDX-FileCopyrightText: 2023 Peter G. (nephros)
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0
import Sailfish.Silica 1.0

/*! \qmltype ThreeLineDelegate
    \inqmlmodule Opal.Delegates
    \inherits ListDelegateBase

    \brief Provides a \c ListItem intended to be used in views.

    It allows quick display of three lines of text data, and an icon or other indicator.

    Layout:

    \pre
    |---------------------------------------------------|
    | left | title: normal, highlight, fade | hint
    | item | text: small, secondary, wrap
    |      | context: small, secondary, fade
    |---------------------------------------------------|
    \endpre
    \qml
        Column {
            width: parent.width

            Repeater {
                model: mymodel
                delegate: ThreeLineDelegate {
                    title: nickName
                    text: messageText
                    context: chatGroup
                    hint: onlineStatus
                    leftItem: Icon{ source: "image://theme/icon-m-chat" }
                }
            }
        }
    \endqml
*/
PaddedDelegate {
    id: root

    /*! \qmlproperty string title

       \brief The first line of text.

       Formatted as highlighted color, normal font size.
       The text will fade if too long.
    */

    /*! \qmlproperty string text

       \brief The second line of text.

       Formatted as secondary color, small font size.
       The text will wrap if too long

       Note: the item size is designed to show two lines here. If the text is
       longer, height will expand, but that may look ugly in your list.
    */

    /*! \qmlproperty string context

       \brief The third line of text.

       Formatted as secondary color, small font size.
       The text will fade if too long
    */

    /*! \qmlproperty string hint

       \brief An optional smaller text to the right of the first line (such as
       "online" for a user)
    */

    minContentHeight: Theme.itemSizeLarge
    centeredContainer: contentColumn

    property string title
    property string text
    property string description

    readonly property alias titleLabel: _line0
    readonly property alias textLabel: _line1
    readonly property alias descriptionLabel: _line2

    Column {
        id: contentColumn
        width: parent.width

        // Important: setting this here creates a binding loop
        // on the delegate's height property. Instead, use the
        // state mechanism provided by PaddedDelegate to automatically
        // center or un-center the item based on its size.
        // anchors.verticalCenter: parent.verticalCenter

        OptionalLabel {
            id: _line0
            width: parent.width
            text: root.title
            font.pixelSize: Theme.fontSizeSmall

            palette {
                primaryColor: Theme.secondaryHighlightColor
                highlightColor: Theme.highlightColor
            }
        }

        OptionalLabel {
            id: _line1
            width: parent.width
            text: root.text
            font.pixelSize: Theme.fontSizeMedium

            palette {
                primaryColor: Theme.primaryColor
                highlightColor: Theme.highlightColor
            }
        }

        OptionalLabel {
            id: _line2
            width: parent.width
            text: root.description
            font.pixelSize: Theme.fontSizeSmall

            palette {
                primaryColor: Theme.secondaryColor
                highlightColor: Theme.secondaryHighlightColor
            }
        }
    }
}
