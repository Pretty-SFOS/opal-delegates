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

    property alias text1: line1.text
    property alias text2: line2.text
    property alias text3: line3.text
    property alias extratext: extra.text

    QtObject{ id: line1; property string text: ""; property color color: Theme.highlightColor; property int size: Theme.fontSizeMedium }
    QtObject{ id: line2; property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeSmall }
    QtObject{ id: line3; property string text: ""; property color color: Theme.secondaryColor; property int size: Theme.fontSizeSmall }
    QtObject{ id: extra; property string text: ""; property color color: Theme.primaryColor; property int size: Theme.fontSizeTiny }

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
            width: parent.width
            spacing: Theme.paddingMedium
            // Main line, a title or similar. Fades.
            Label { id: label1
                //width: parent.width - extraLabel.width
                width: (implicitWidth > parent.width*2/3) ? parent.width*2/3 : implicitWidth
                //anchors.verticalCenter: parent.verticalCenter
                text: line1.text;
                color:          !!line1.color ? line1.color : Theme.highlightColor;
                font.pixelSize: !!line1.size  ? line1.size  : Theme.fontSizeNormal;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
            // Main line, a small status-like text. Fades.
            Label { id: extraLabel
                anchors.bottom: label1.bottom
                text: extra.text;
                color:          !!extra.color ? extra.color : Theme.primaryColor;
                font.pixelSize: !!extra.size  ? extra.size  : Theme.fontSizeNormal;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
        }
        // second line, a description or similar. Fades.
        Label {
            width: parent.width
            text: line2.text;
            color:          !!line2.color ? line2.color : Theme.secondaryColor;
            font.pixelSize: !!line2.size  ? line2.size  : Theme.fontSizeSmall;
            wrapMode:       Text.NoWrap
            truncationMode: TruncationMode.Fade

        }
        // third line, a  some additional context. This text is wrapped.
        Label {
            width: parent.width
            text: line3.text;
            color:          !!line3.color ? line3.color : Theme.secondaryColor;
            font.pixelSize: !!line3.size  ? line3.size  : Theme.fontSizeSmall;
            wrapMode:       Text.Wrap
        }
    }
}
