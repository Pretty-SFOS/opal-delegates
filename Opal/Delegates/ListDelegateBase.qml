/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

/*! \qmltype ListDelegateBase
    \inqmlmodule Opal.Delegates
    \inherits Sailfish.Silica.ListItem

    \brief Base type providing a \c ListItem intended to be used in views.
*/

ListItem { id: root

//    /*! \qmlproperty var colors

//       \brief An array of \c color values, overriding the defaults for the text colors.

//     */
//    property var colors: []


    /*! \qmlproperty bool showOddEven

       \brief If \c true delegates will use alternating background colors

       \default false
     */
    property bool showOddEven: false

    /*! \qmlproperty color oddColor

       \brief Background color for odd elements.

       \default \c "transparent"
     */
     /*! \qmlproperty color evenColor

       \brief Background color for even elements.

       \default \c Theme.highlightBackgroundColor
     */
    property color oddColor: "transparent"
    property color evenColor: Theme.highlightBackgroundColor

    property bool isOdd: (index %2 != 0)
    Rectangle {
        id: oddevenrect
        anchors.fill: parent

        visible: showOddEven
        radius: Theme.paddingSmall
        opacity: Theme.opacityFaint
        color: isOdd ? oddColor : evenColor

        border {
            color: "transparent"
            width: radius/2
        }
    }
    /*! \qmlproperty Component leftItem

        \brief An Item such as an Icon displayed on the left side of the Delegate

    */
    property Component leftItem: null

    default property alias contents: contentItem.data

    property int padding: 0
    property int lrPadding: Theme.horizontalPageMargin
    property int tbPadding: Theme.paddingSmall
    property int topPadding: 0
    property int bottomPadding: 0
    property int leftPadding: 0
    property int rightPadding: 0

    readonly property int _topPadding: topPadding > 0 ? topPadding : tbPadding
    readonly property int _bottomPadding: bottomPadding > 0 ? bottomPadding : tbPadding
    readonly property int _leftPadding: leftPadding > 0 ? leftPadding : lrPadding
    readonly property int _rightPadding: rightPadding > 0 ? rightPadding : lrPadding
    readonly property int _tbPadding: tbPadding > 0 ? tbPadding : padding
    readonly property int _lrPadding: lrPadding > 0 ? lrPadding : padding

    contentHeight: Math.max(
        contentItem.childrenRect.height + _topPadding + _bottomPadding,
        Theme.itemSizeMedium
    )

    Item {
        id: topPaddingItem
        anchors.top: parent.top
        width: parent.width
        height: _topPadding
    }

    Item {
        id: bottomPaddingItem
        anchors.bottom: parent.bottom
        width: parent.width
        height: _bottomPadding
    }

    Item {
        id: leftPaddingItem
        anchors.left: parent.left
        width: _leftPadding
        height: parent.height
    }

    Item {
        id: rightPaddingItem
        anchors.right: parent.right
        width: _rightPadding
        height: parent.height
    }

    Item {
        id: contentItem
        anchors {
            left: leftPaddingItem.right
            right: rightPaddingItem.left
            top: topPaddingItem.bottom
            bottom: bottomPaddingItem.top
        }
    }
}
