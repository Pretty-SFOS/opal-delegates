//@ This file is part of opal-delegates.
//@ https://github.com/Pretty-SFOS/opal-delegates
//@ SPDX-FileCopyrightText: 2023 Peter G. (nephros)
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0
import Sailfish.Silica 1.0
import "private"

/*!
    \qmltype PaddedDelegate
    \inqmlmodule Opal.Delegates
    \inherits Sailfish.Silica.ListItem

    \brief Base type providing a \c ListItem intended to be used in views.

    This base type can be used for building custom list items that
    follow Silica styling with a simple API.

    The ready-made delegates \l OneLineDelegate, \l TwoLineDelegate, and
    \l ThreeLineDelegate are sufficient for most use-cases. Complex
    customizations are possible with these types, without having to
    develop a custom delegate.

    \section2 Anatomy

    The basic anatomy of a padded delegate is like this:

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

    All contents that are added as direct children of the \l PaddedDelegate
    component are inserted into the content item in the center of the
    delegate.

    Custom contents can be added to the left and the right of the item.

    The default padding adds the standard page margin to both sides and
    standard spacing between delegates. These values usually don't have to be
    changed unless you know what you are doing.


    \section2 Centering custom content

    When building a custom delegate that should have vertically centered content,
    make sure to put all custom content into a container. Do not set set
    its vertical center anchor! Instead, assing the container to the
    \l centeredContainer property.

    This makes sure that the container is vertically centered without causing
    any binding loops on the item's height.

    \sa OneLineDelegate, TwoLineDelegate, ThreeLineDelegate, DelegateColumn
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

    property bool interactive: true

    /*! An Item such as an Icon displayed on the left side of the Delegate
    */
    property Component leftItem: null
    readonly property alias centerItem: contentItem
    property Component rightItem: null
    property bool loadSideItemsAsync: false

    default property alias contents: contentItem.data
    property var centeredContainer

    property int minContentHeight: Theme.itemSizeMedium
    property int spacing: Theme.paddingMedium

    readonly property PaddingData padding: PaddingData {
        readonly property int __defaultLeftRight: Theme.horizontalPageMargin
        readonly property int __defaultTopBottom: Theme.paddingSmall

        leftRight: all == 0 && left == 0 && right == 0 ? __defaultLeftRight : 0
        topBottom: all == 0 && top == 0 && bottom == 0 ? __defaultTopBottom : 0
    }

    function toggleWrappedText(label) {
        label.wrapped = !label.wrapped
    }

    opacity: enabled ? 1.0 : Theme.opacityLow

    Binding on highlighted {
        when: !interactive
        value: false
    }

    Binding on _backgroundColor {
        when: !interactive
        value: "transparent"
    }

    contentHeight: Math.max(
          padding.effectiveTop
        + padding.effectiveBottom
        + Math.max(leftItemLoader.height,
                   rightItemLoader.height,
                   contentItem.childrenRect.height)
        , minContentHeight
    )

    Item {
        id: topPaddingItem
        anchors.top: parent.top
        width: parent.width
        height: padding.effectiveTop
    }

    Item {
        id: bottomPaddingItem
        anchors.bottom: parent.bottom
        width: parent.width
        height: padding.effectiveBottom
    }

    Item {
        id: leftPaddingItem
        anchors.left: parent.left
        width: padding.effectiveLeft
        height: parent.contentHeight
    }

    Item {
        id: rightPaddingItem
        anchors.right: parent.right
        width: padding.effectiveRight
        height: parent.contentHeight
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
            verticalCenter: parent.verticalCenter
        }
    }

    SilicaItem {
        id: contentItem

        anchors {
            left: leftItemLoader.right
            leftMargin: leftItemLoader.width > 0 ? spacing : 0
            right: rightItemLoader.left
            rightMargin: rightItemLoader.width > 0 ? spacing : 0
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

    states: [
        State {
            name: "tall"
            when: !!centeredContainer &&
                  (   centeredContainer.height > minContentHeight
                   || centeredContainer.implicitHeight > minContentHeight
                   || centeredContainer.childrenRect.height > minContentHeight)

            AnchorChanges {
                target: centeredContainer
                anchors {
                    verticalCenter: undefined
                    top: centeredContainer.parent.top
                }
            }
        },
        State {
            name: "short"
            when: !!centeredContainer &&
                  (   centeredContainer.height <= minContentHeight
                   || centeredContainer.implicitHeight <= minContentHeight
                   || centeredContainer.childrenRect.height <= minContentHeight)

            AnchorChanges {
                target: centeredContainer
                anchors {
                    top: undefined
                    verticalCenter: centeredContainer.parent.verticalCenter
                }
            }
        }
    ]
}
