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

ListItem {
    id: root

    /*! This property defines whether delegates will be emphasized with alternating colors.

        If \c true, delegates will use alternating background colors
        to make rows visually more distinct.

        \default false
    */
    property bool showOddEven: false

    /*! Background color for odd elements.

        \default \c "transparent"
    */
    property color oddColor: "transparent"

    /*! Background color for even elements.

        \default \c Theme.highlightBackgroundColor
    */
    property color evenColor: Theme.highlightBackgroundColor

    property bool _isOddRow: (index %2 != 0)

    /*! An Item such as an Icon displayed on the left side of the Delegate
    */
    property Component leftItem: null
    property Component rightItem: null
    property Component topItem: null
    property Component bottomItem: null
    readonly property alias bodyItem: contentItem

    property Component topLeftItem: null
    property Component topRightItem: null
    property Component bottomLeftItem: null
    property Component bottomRightItem: null


    // ------------------------------------------------------------------------

    default property alias contents: contentItem.data

    property int spacing: Theme.paddingSmall

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
        contentItem.childrenRect.height + _topPadding + _bottomPadding +
            Math.max(topItemLoader.height, topLeftItemLoader.height, topRightItemLoader.height),
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

    Loader {
        id: leftItemLoader
        anchors {
            left: leftPaddingItem.right
            verticalCenter: parent.verticalCenter
        }
        sourceComponent: leftItem
        width: height
    }

    Loader {
        id: topItemLoader
        sourceComponent: topItem
        anchors {
            left: topLeftItemLoader.right
            leftMargin: spacing
            top: topPaddingItem.bottom
            right: topRightItemLoader.left
            rightMargin: spacing
        }
    }

    Loader {
        id: topLeftItemLoader
        sourceComponent: topLeftItem
        anchors {
            left: leftItemLoader.right
            leftMargin: spacing
            verticalCenter: topItemLoader.verticalCenter
        }
    }

    Loader {
        id: topRightItemLoader
        sourceComponent: topRightItem
        anchors {
            right: rightItemLoader.left
            rightMargin: spacing
            verticalCenter: topItemLoader.verticalCenter
        }
    }

    Loader {
        id: rightItemLoader
        sourceComponent: rightItem
        anchors {
            right: rightPaddingItem.left
            rightMargin: spacing
            verticalCenter: topItemLoader.verticalCenter
        }
    }

    Item {
        id: contentItem
        anchors {
            left: leftItemLoader.right
            leftMargin: spacing
            right: rightPaddingItem.left
            rightMargin: spacing
            top: topPaddingItem.bottom
            topMargin: spacing
            bottom: bottomPaddingItem.top
            bottomMargin: spacing
        }
    }

    Rectangle {
        id: emphasisBackground
        anchors.fill: parent

        visible: showOddEven
        radius: Theme.paddingSmall
        opacity: Theme.opacityFaint
        color: _isOddRow ? oddColor : evenColor

        border {
            color: "transparent"
            width: radius / 2
        }
    }
}
