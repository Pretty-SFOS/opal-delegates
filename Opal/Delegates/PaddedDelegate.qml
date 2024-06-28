/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-FileCopyrightText: 2024 Mirian Margiani
SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

/*! \qmltype PaddedDelegate
    \inqmlmodule Opal.Delegates
    \inherits Sailfish.Silica.ListItem

    \brief Base type providing a \c ListItem intended to be used in views.

    Basic anatomy:

    \pre
    +----------------------------------------------------------+
    |                        top padding                       |
    |         +--------------------------------------+         |
    | left    | left  |        content       | right | right   |
    | padding | item  |         item         | item  | padding |
    |         +--------------------------------------+         |
    |                      bottom padding                      |
    +----------------------------------------------------------+
    \endpre
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

    // ------------------------------------------------------------------------

    /*! An Item such as an Icon displayed on the left side of the Delegate
    */
    property Component leftItem: null
    readonly property alias centerItem: contentItem
    property Component rightItem: null
    property bool loadSideItemsAsync: false

    default property alias contents: contentItem.data

    property int minContentHeight: Theme.itemSizeMedium
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

    contentHeight:

    contentHeight: Math.max(
          _topPadding
        + _bottomPadding
        + Math.max(leftItemLoader.height,
                   rightItemLoader.height,
                   contentItem.childrenRect.height)
        , minContentHeight
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
        sourceComponent: leftItem
        asynchronous: loadSideItemsAsync
        anchors {
            left: leftPaddingItem.right
            verticalCenter: parent.verticalCenter
        }
    }

    Loader {
        id: rightItemLoader
        sourceComponent: rightItem
        asynchronous: loadSideItemsAsync
        anchors {
            right: rightPaddingItem.left
            verticalCenter: topItemLoader.verticalCenter
        }
    }

    SilicaItem {
        id: contentItem
        anchors {
            left: leftItemLoader.right
            leftMargin: spacing
            right: rightItemLoader.left
            rightMargin: spacing
            top: topPaddingItem.bottom
            bottom: bottomPaddingItem.top
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
