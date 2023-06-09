/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: Apache-2.0
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
    | left | title, normal, highlight, fade | extratext
    | item | text, small, secondary, wrap
    |      | context, small, secondary, fade
    |---------------------------------------------------|
    \endpre
    \qml
        Column {
            Repeater {
                model: mymodel
                delegate: ThreeLineDelegate {
                    title: nickName
                    text: messageText
                    context: chatGroup
                    extratext: onlineStatus
                    leftItem: Icon{ source: "image://theme/icon-m-chat" }
                }
            }
        }
    \endqml

*/


ListDelegateBase { id: root

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
    /*! \qmlproperty string extratext

       \brief An optional smaller text to the right of the first line (such as
       "online" for a user)

     */
    property alias title:   line1.text
    property alias text:    line2.text
    property alias context: line3.text
    property alias extratext: extra.text

    property bool amThreeLine: true

    Component.onCompleted: {
        var num = amThreeLine ? 3 : 2
        if ( !!colors && colors.length === num) {
            line1.color = colors[0];
            line2.color = colors[1];
            if (amThreeLine)
                line3.color = colors[2];
        }
    }

    // TODO: do these make sense at all?
    QtObject{ id: line1; property string text: ""; property color color: Theme.highlightColor; property int size: Theme.fontSizeMedium }
    QtObject{ id: line2; property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeSmall }
    QtObject{ id: line3; property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeTiny }
    QtObject{ id: extra; property string text: ""; property color color: Theme.primaryColor; property int size: Theme.fontSizeTiny }

    contentHeight: Math.max(
        content.height,
        amThreeLine ? Theme.itemSizeMedium : Theme.itemSizeSmall
    )

    Loader { id: leftItemLoader
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        active: leftItem !== null
        sourceComponent: leftItem
        width: height
    }

    Column { id: content
        anchors.left: leftItemLoader.right
        anchors.right: parent.right
        anchors.verticalCenter: (leftItemLoader.height > 0)
            ? leftItemLoader.verticalCenter
            : parent.verticalCenter
        Row {
            width: parent.width
            spacing: Theme.paddingMedium
            Label { id: label1
                width:  parent.width - extraLabel.width - parent.spacing
                text: line1.text;
                color:          !!line1.color ? line1.color : Theme.highlightColor;
                font.pixelSize: !!line1.size  ? line1.size  : Theme.fontSizeNormal;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
            Label { id: extraLabel
                anchors.bottom: label1.bottom
                anchors.rightMargin: parent.spacing
                anchors.verticalCenter: label1.verticalCenter
                text: extra.text;
                color:          !!extra.color ? extra.color : Theme.primaryColor;
                font.pixelSize: !!extra.size  ? extra.size  : Theme.fontSizeNormal;
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
        Label {
            visible: amThreeLine
            width: parent.width
            text: line3.text;
            color:          !!line3.color ? line3.color : Theme.secondaryColor;
            font.pixelSize: !!line3.size  ? line3.size  : Theme.fontSizeSmall;
            wrapMode:       Text.NoWrap
            truncationMode: TruncationMode.Fade
        }
    }
}
