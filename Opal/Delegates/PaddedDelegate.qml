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
    make sure to put all custom content into a container like \c Column.
    Do not set its vertical center anchor! Instead, assign the container to the
    \l centeredContainer property.

    This makes sure that the container is vertically centered without causing
    any binding loops on the item's height.

    \section2 Example

    \note Usually, it is recommended to use the provided implementations for new
    delegates.

    \qml
    import QtQuick 2.6
    import Sailfish.Silica 1.0
    import Opal.Delegates 1.0

    PaddedDelegate {
        id: root

        property int temperature
        property string text

        minContentHeight: Theme.itemSizeSmall
        centeredContainer: contentContainer
        interactive: false

        leftItem: DelegateIconItem {
            source: "image://theme/icon-m-favorite"
        }

        rightItem: DelegateInfoItem {
            title: qsTr("Temperature")
            text: temperature
            description: qsTr("°C")
            fixedWidth: S.Theme.itemSizeLarge
        }

        Column {
            // Note: all contents are placed inside a column to avoid
            // a binding loop on the delegate's height property.
            // Directly setting the label as the centeredContainer does
            // not work.
            id: contentContainer
            width: parent.width

            OptionalLabel {
                id: _line1
                width: parent.width
                text: root.text
                font.pixelSize: Theme.fontSizeMedium

                palette {
                    primaryColor: Theme.primaryColor
                    highlightColor: Theme.highlightColor
                }
            }
        }
    }
    \endqml

    \sa OneLineDelegate, TwoLineDelegate, ThreeLineDelegate, DelegateColumn
*/
ListItem {
    id: root

    /*!
      This property defines whether delegates will be emphasized with alternating colors.

      If \c true, delegates will use alternating background colors
      to make rows visually more distinct.

      It is usually preferably to not use this feature. Instead, try to
      make your delegates look clear on their own.

      \default false
    */
    property bool showOddEven: false

    /*!
      Background color for odd elements.

      This value is only used if \l showOddEven is set to \c true.

      \default \c "transparent"
    */
    property color oddColor: "transparent"

    /*!
      Background color for even elements.

      This value is only used if \l showOddEven is set to \c true.

      \default Theme.highlightBackgroundColor
    */
    property color evenColor: Theme.highlightBackgroundColor

    property bool _isOddRow: (index %2 != 0)

    /*!
      This property defines whether the delegate is interactive.

      Setting this to \c false will switch to non-interactive
      styling.

      \note context menu and click signals are still
      handled. To avoid confusion, do not set the \c onClicked
      or \c menu properties for non-interactive delegates.

      \default true
    */
    property bool interactive: true

    /*!
      This property defines an optional custom content item.

      Assign any visual item here to add extra content to the
      left side of the delegate.

      \note it takes up no space if left undefined.

      \sa rightItem, DelegateIconItem, DelegateInfoItem
    */
    property Component leftItem: null

    /*!
      This property gives access to the central content item.

      All children of \l PaddedDelegate will be parented to
      this item. You can use this property to manually parent
      content to it.

      It is usually not necessary to change any properties
      of this item.
    */
    readonly property alias centerItem: contentItem

    /*!
      This property defines an optional custom content item.

      Assign any visual item here to add extra content to the
      right side of the delegate.

      \note it takes up no space if left undefined.

      \sa leftItem, DelegateIconItem, DelegateInfoItem
    */
    property Component rightItem: null

    /*!
      This property can be used to load side items asynchronously.

      Settings this to \c true will load side items in a separate
      thread. This is useful if your custom content items are
      very complex and take a long time to load.

      However, this can mess up the size of your delegates. When
      using this feature, take care to engineer your delegates
      to not change their size.

      In other words: make sure that the side items are not taller
      than the height defined in \l minContentHeight, and make sure
      to set the \c fixedWidth property of your side items.

      \default false

      \sa leftItem, rightItem, DelegateIconItem, DelegateInfoItem
    */
    property bool loadSideItemsAsync: false

    /*!
      This property gives access to the central content item.

      All children of \l PaddedDelegate will be parented to
      this item. You can use this property to manually parent
      content to it.

      It is usually not necessary to change any properties
      of this item.
    */
    default property alias contents: contentItem.data

    /*!
      This property enables centering of the delegate's contents.

      When building a custom delegate that should have vertically centered content,
      make sure to put all custom content into a container like \c Column.
      Do not set its vertical center anchor! Instead, assign the container to the
      \l centeredContainer property.

      This makes sure that the container is vertically centered without causing
      any binding loops on the item's height.
    */
    property var centeredContainer

    /*!
      This property defines the minimum height of the delegate.

      The delegate may grow and shrink to fit its content but it
      will never shrink below this height.

      \default Theme.itemSizeMedium
    */
    property int minContentHeight: Theme.itemSizeMedium

    /*!
      This property defines the space between side items and content.

      If a left or right side item is defined, then this will
      be the spacing between the side items and the content.

      This value is ignored if no side items are defined.

      \sa leftItem, rightItem
    */
    property int spacing: Theme.paddingMedium

    /*!
      This group defines the outer padding around the delegate.

      See \l PaddingData for details.

      \sa PaddingData, PaddedDelegate
    */
    readonly property PaddingData padding: PaddingData {
        readonly property int __defaultLeftRight: Theme.horizontalPageMargin
        readonly property int __defaultTopBottom: Theme.paddingSmall

        leftRight: all == 0 && left == 0 && right == 0 ? __defaultLeftRight : 0
        topBottom: all == 0 && top == 0 && bottom == 0 ? __defaultTopBottom : 0
    }

    /*!
      This function toggles text wrapping in text labels.

      Provide a \l OptionalLabel as argument to toggle its
      text wrapping mode.

      You can also manually set the \l {OptionalLabel.wrapped}
      property.

      \sa OptionalLabel
    */
    function toggleWrappedText(label) {
        label.wrapped = !label.wrapped
    }

    opacity: enabled ? 1.0 : Theme.opacityLow

    Binding on highlighted {
        when: !interactive
        value: true
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
