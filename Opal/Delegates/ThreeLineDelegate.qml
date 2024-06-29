//@ This file is part of opal-delegates.
//@ https://github.com/Pretty-SFOS/opal-delegates
//@ SPDX-FileCopyrightText: 2023 Peter G. (nephros)
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0
import Sailfish.Silica 1.0

/*!
    \qmltype ThreeLineDelegate
    \inqmlmodule Opal.Delegates
    \inherits PaddedDelegate

    \brief Delegate for three strings of text.

    This delegate can be used to show a title, a primary text,
    a description, as well as custom left and right items.

    All texts are optional and will take up no space if
    they are empty.

    \section2 Anatomy

    The delegate is structured like this:

    \pre
    +----------------------------------------------------------+
    |                        top padding                       |
    |         +--------------------------------------+         |
    | left    | left  |         title        | right | right   |
    |         |       |          text        |       |         |
    | padding | item  |       description    | item  | padding |
    |         +--------------------------------------+         |
    |                      bottom padding                      |
    +----------------------------------------------------------+
    \endpre

    \section2 Wrapped text

    The text is not wrapped by default. You can configure that
    by changing the \l {OptionalLabel.wrapped} property of
    the label. However, note that the height of the delegate
    will become dynamic if text is wrapped.

    You can programmatically switch between wrapped and
    non-wrapped views by passing the label to the
    \l {PaddedDelegate.toggleWrappedText} function:

    \qml
    toggleWrappedText(titleLabel)
    toggleWrappedText(textLabel)
    toggleWrappedText(descriptionLabel)
    \endqml

    \section2 Side content

    You can define custom content in the \l {PaddedDelegate.leftItem}
    and \l {PaddedDelegate.rightItem} properties. Common uses
    are to show an icon or some additional info. For this, you can
    use \l DelegateIconItem and \l DelegateInfoItem respectively.

    \section2 Example

    \qml
    import QtQuick 2.0
    import Sailfish.Silica 1.0
    import Opal.Delegates 1.0

    DelegateColumn {
        model: ListModel {
            ListElement {
                name: "Jane Doe"
                post: "Hello there"
                date: "yesterday"
            }
            ListElement {
                name: "John Doe"
                post: "Goodbye again"
                date: "just now"
            }
        }
        delegate: D.OneLineDelegate {
            title: name
            text: post
            description: date

            textLabel.wrapped: true
        }
    }
    \endqml

    \sa PaddedDelegate, OneLineDelegate, TwoLineDelegate, OptionalLabel,
        DelegateIconItem, DelegateInfoItem, DelegateColumn
*/
PaddedDelegate {
    id: root
    minContentHeight: Theme.itemSizeLarge
    centeredContainer: contentColumn

    /*!
      This property holds the title text of the delegate.

      The text is shown above the primary text and is not
      wrapped by default. You can change that by changing
      the \l {OptionalLabel.wrapped} property.

      All texts are optional and will take up no space if
      they are empty.
    */
    property string title

    /*!
      This property holds the primary text of the delegate.

      The text is shown vertically centered and is not
      wrapped by default. You can change that by changing
      the \l {OptionalLabel.wrapped} property.

      All texts are optional and will take up no space if
      they are empty.
    */
    property string text

    /*!
      This property holds the description text of the delegate.

      The text is shown below the primary text and is not
      wrapped by default. You can change that by changing
      the \l {OptionalLabel.wrapped} property.

      All texts are optional and will take up no space if
      they are empty.
    */
    property string description

    /*!
      This property gives access to the title label.

      You can use this property to customize all properties
      of the \l OptionalLabel item that is used
      for this text.
    */
    readonly property alias titleLabel: _line0

    /*!
      This property gives access to the text label.

      You can use this property to customize all properties
      of the \l OptionalLabel item that is used
      for this text.
    */
    readonly property alias textLabel: _line1

    /*!
      This property gives access to the description label.

      You can use this property to customize all properties
      of the \l OptionalLabel item that is used
      for this text.
    */
    readonly property alias descriptionLabel: _line2

    Column {
        id: contentColumn
        width: parent.width

        // Important: setting this here creates a binding loop
        // on the delegate's height property. Instead, use the
        // state mechanism provided by PaddedDelegate to automatically
        // center or un-center the item based on its size.
        // >>> anchors.verticalCenter: parent.verticalCenter

        OptionalLabel {
            id: _line0
            width: parent.width
            text: root.title
            font.pixelSize: Theme.fontSizeSmall

            palette {
                primaryColor: Theme.secondaryHighlightColor
                highlightColor: Theme.highlightColor
            }
        }

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

        OptionalLabel {
            id: _line2
            width: parent.width
            text: root.description
            font.pixelSize: Theme.fontSizeSmall

            palette {
                primaryColor: Theme.secondaryColor
                highlightColor: Theme.secondaryHighlightColor
            }
        }
    }
}
