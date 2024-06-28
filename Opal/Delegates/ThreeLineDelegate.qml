/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-FileCopyrightText: 2024 Mirian Margiani
SPDX-License-Identifier: GPL-3.0-or-later
*/

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

    property string title
    property string text
    property string context
    property string hint

    readonly property alias titleLabel: _line1
    readonly property alias textLabel: _line2
    readonly property alias contextLabel: _line3
    readonly property alias hintLabel: _hint

    property bool _amThreeLine: true

//    Component.onCompleted: {
//        var num = amThreeLine ? 3 : 2
//        if ( !!colors && colors.length === num) {
//            line1.color = colors[0];
//            line2.color = colors[1];
//            if (amThreeLine)
//                line3.color = colors[2];
//        }
//    }

//    // TODO: do these make sense at all?
//    QtObject{ id: line1; property string text: ""; property color color: Theme.highlightColor; property int size: Theme.fontSizeMedium }
//    QtObject{ id: line2; property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeSmall }
//    QtObject{ id: line3; property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeTiny }
//    QtObject{ id: extra; property string text: ""; property color color: Theme.primaryColor; property int size: Theme.fontSizeTiny }

//    contentHeight: Math.max(
//        content.height,
//        amThreeLine ? Theme.itemSizeMedium : Theme.itemSizeSmall
//    )

    Loader {
        id: leftItemLoader
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
        active: leftItem !== null
        sourceComponent: leftItem
        width: height
    }

    Column {
        id: content
        anchors {
            left: leftItemLoader.right
            right: parent.right

            // TODO use states, code below is explicitly discouraged in docs
            verticalCenter: (leftItemLoader.height > 0)
                ? leftItemLoader.verticalCenter
                : parent.verticalCenter
        }

        Row {
            width: parent.width
            spacing: Theme.paddingMedium

            Label {
                id: _line1
                width:  parent.width - _hint.width - parent.spacing
                text: root.title
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.NoWrap
                truncationMode: TruncationMode.Fade

            }

            Label {
                id: _hint
                anchors {
                    bottom: _line1.bottom
                    rightMargin: parent.spacing
                    verticalCenter: _line1.verticalCenter
                }
                text: root.hint
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
        }

        Label {
            id: _line2
            width: parent.width
            text: root.text
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeMedium
            wrapMode: Text.Wrap

        }

        Label {
            id: _line3
            visible: _amThreeLine
            width: parent.width
            text: root.context
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeSmall
            wrapMode: Text.NoWrap
            truncationMode: TruncationMode.Fade
        }
    }
}
