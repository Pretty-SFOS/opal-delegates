/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

/*!
    Layout:

    |------------------------------------------|
    | left | line1, normal, highlight, fade
    | item | line2, small, secondary, fade
    |      | line3, small, secondary, wrap
    |------------------------------------------|
*/

ListItem { id: root

    property QtObject line1: QtObject{ property string text: ""; property color color: Theme.highlightColor; property int size: Theme.fontSizeMedium }
    property QtObject line2: QtObject{ property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeSmall }
    property QtObject line3: QtObject{ property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeSmall }
    property QtObject extratext: QtObject{ property string text: ""; property color color: Theme.primaryColor; property int size: Theme.fontSizeTiny }

    property Item leftItem: Item { visible: false; height: 0; width: 0 }

    Item { id: leftItemItem
        width:  leftItem.width
        height: leftItem.height
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        visible: (height > 0)
    }
    Column { id: content
        anchors.left: leftItemItem.right
        anchors.right: parent.right
        anchors.verticalCenter: (leftItemItem.height > 0) ? leftItemItem.verticalCenter : parent.verticalCenter
        // Top Row, the main text, and an optional smaller text to the right (such as "online" for a user)
        Row {
            // Main line, a title or similar. Fades.
            Label {
                width: parent.width - extraLabel.width
                anchors.verticalCenter: parent.verticalCenter
                text: root.line1.text;
                color:          !!root.line1.color ? root.line1.color : Theme.highlightColor;
                font.pixelSize: !!root.line1.size  ? root.line1.size  : Theme.fontSizeNormal;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
            // Main line, a small status-like text. Fades.
            Label {
                anchors.verticalCenter: parent.verticalCenter
                text: root.extratext.text;
                color:          !!root.extratext.color ? root.extratext.color : Theme.primaryColor;
                font.pixelSize: !!root.extratext.size  ? root.extratext.size  : Theme.fontSizeNormal;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
        }
        // second line, a description or similar. Fades.
        Label {
            width: parent.width
            text: root.line2.text;
            color:          !!root.line2.color ? root.line2.color : Theme.secondaryColor;
            font.pixelSize: !!root.line2.size  ? root.line2.size  : Theme.fontSizeSmall;
            wrapMode:       Text.NoWrap
            truncationMode: TruncationMode.Fade

        }
        // third line, a  some additional context. This text is wrapped.
        Label {
            width: parent.width
            text: root.line3.text;
            color:          !!root.line3.color ? root.line3.color : Theme.secondaryColor;
            font.pixelSize: !!root.line3.size  ? root.line3.size  : Theme.fontSizeSmall;
            wrapMode:       Text.Wrap
        }
    }
}
