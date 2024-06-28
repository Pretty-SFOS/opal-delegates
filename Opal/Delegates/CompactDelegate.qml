/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

/*! \qmltype CompactDelegate
    \inqmlmodule Opal.Delegates
    \inherits ListDelegateBase

    \brief Provides a \c ListItem intended to be used in views.

    It allows compact display of two lines of text data, and an icon or other indicator.

    Layout:

    \pre
    |------------------------------------------------------|
    | left | title, highlight | text, small, primary, fade
    | item | context, small, secondary, fade
    |------------------------------------------------------|
    \endpre
    \qml
        Column {
            Repeater {
                model: mymodel
                delegate: CompactDelegate {
                    title: nickName
                    text: messageText
                    context: status
                    leftItem: Icon{ source: "image://theme/icon-m-chat" }
                }
            }
        }
    \endqml

*/

PaddedDelegate {
    id: root

    /*! \qmlproperty string title

       \brief The left part of the first line of text.

       Formatted as secondary highlighted color, small font size.
     */

    /*! \qmlproperty string text

       \brief The right part of the first line of text.

       Formatted as primary color, small font size.
       The text will fade if too long.

     */

    /*! \qmlproperty string context

       \brief The second line of text.

       Formatted as secondary color, tiny font size.
       The text will wrap if too long.
     */

    property alias title:   line1.text
    property alias text:    extra.text
    property alias context: line2.text

    Component.onCompleted: {
        var num = 2
        if ( !!colors && colors.length === num) {
            line1.color = colors[0];
            line2.color = colors[1];
        }
    }

    // TODO: do these make sense at all?
    QtObject{ id: line1; property string text: ""; property color color: Theme.secondaryHighlightColor; property int size: Theme.fontSizeSmall }
    QtObject{ id: line2; property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeTiny }
    QtObject{ id: extra; property string text: ""; property color color: Theme.primaryColor; property int size: Theme.fontSizeSmall }

    contentHeight: Math.max(
        content.height,
        Theme.itemSizeMedium /2
    )

    Loader { id: leftItemLoader
        anchors.left: parent.left
        active: leftItem !== null
        sourceComponent: leftItem
        width: height
    }

    Column { id: content
        anchors.left: leftItemLoader.right
        anchors.right: parent.right
        Row {
            width: parent.width
            spacing: Theme.paddingSmall
            Label { id: label1
                text: line1.text;
                color:          !!line1.color ? line1.color : Theme.secondaryHighlightColor;
                font.pixelSize: !!line1.size  ? line1.size  : Theme.fontSizeSmall;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade
            }
            Label { id: extraLabel
                width:  parent.width - label1.width - parent.spacing
                anchors.rightMargin: parent.spacing
                text: extra.text;
                color:          !!extra.color ? extra.color : Theme.primaryColor;
                font.pixelSize: !!extra.size  ? extra.size  : Theme.fontSizeSmall;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
        }
        Label {
            width: parent.width
            text: line2.text;
            color:          !!line2.color ? line2.color : Theme.secondaryColor;
            font.pixelSize: !!line2.size  ? line2.size  : Theme.fontSizeSmall;
            wrapMode:       Text.Wrap
        }
    }
}
