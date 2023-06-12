/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

/*! \qmltype ThreeLineDelegate
    \inqmlmodule Opal.Delegates
    \inherits Sailfish.Silica.ListItem

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
            ColumnView {
                itemHeight: Theme.itemSizeLarge
                model: mymodel
                delegate: ThreeLineDelegate {
                    title: nickName
                    text: messageText
                    context: chatGroup
                    extratext: onlineStatus
                    leftItem: Icon{ source: "image://theme/icon-m-chat" }
                    menu: cmenu
                }
            }
    \endqml

    Properties are inherited from 
    \l {https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-listitem.html/}{Silica.ListItem}
    so you can use menus, actions, and all that.


*/


ListItem { id: root

    /*! \qmlproperty string title

       The first line of text.

       Formatted as highlighted color, normal font size.
       The text will fade if too long.
     */

    /*! \qmlproperty string text

       The second line of text.

       Formatted as secondary color, small font size.
       The text will wrap if too long

       Note: the item size is designed to show two lines here. If the text is
       longer, height will expand, but that may look ugly in your list.

     */

    /*! \qmlproperty string context

       The third line of text.

       Formatted as secondary color, small font size.
       The text will fade if too long

     */
    /*! \qmlproperty string extratext

       An optional smaller text to the right of the first line (such as
       "online" for a user)

     */
    property alias title:   line1.text
    property alias text:    line2.text
    property alias context: line3.text
    property alias extratext: extra.text

    /*! \qmlproperty Component leftItem

       An Item such as an Icon displayed on the left side of the Delegate

     */
    property Component leftItem: null

    /*! \qmlproperty bool showOddEven

       If \c true delegates will use alternating background colors

       \default false
     */
    property bool showOddEven: false

    /*! \qmlproperty color oddColor

       Background color for odd elements.

       \default \c "transparent"
     */
     /*! \qmlproperty color evenColor

       Background color for even elements.

       \default \c Theme.highlightBackgroundColor
     */
    property color oddColor: "transparent"
    property color evenColor: Theme.highlightBackgroundColor

    property bool isOdd: (index %2 != 0)
    Rectangle { id: oddevenrect
        anchors.fill: parent
        visible: showOddEven
        radius: Theme.paddingSmall
        opacity: Theme.opacityFaint
        color: isOdd ? oddColor : evenColor
        border.color: "transparent"
        border.width: radius/2
    }

    /*! \qmlproperty var colors

       An array of three \c color values, overriding the defaults for the text color.

     */
    property var colors: []

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

    contentHeight: Math.max(content.height, Theme.itemSizeMedium)

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
                width: (extra.text.length > 0) ? parent.width*3/4 : parent.width
                text: line1.text;
                color:          !!line1.color ? line1.color : Theme.highlightColor;
                font.pixelSize: !!line1.size  ? line1.size  : Theme.fontSizeNormal;
                wrapMode:       Text.NoWrap
                truncationMode: TruncationMode.Fade

            }
            Label { id: extraLabel
                anchors.bottom: label1.bottom
                anchors.verticalCenter: label1.verticalCenter
                width: (extra.text.length > 0) ? parent.width*1/4 : implicitWidth
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
