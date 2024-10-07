//@ This file is part of opal-delegates.
//@ https://github.com/Pretty-SFOS/opal-delegates
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0
import Sailfish.Silica 1.0

/*!
    \qmltype OneLineDelegate
    \inqmlmodule Opal.Delegates
    \inherits PaddedDelegate

    \brief Delegate for one string of text.

    This delegate can be used to show one primary text
    as well as custom left and right items.

    \section2 Anatomy

    The delegate is structured like this:

    \code
    +----------------------------------------------------------+
    |                        top padding                       |
    |         +--------------------------------------+         |
    | left    | left  |          text        | right | right   |
    | padding | item  |                      | item  | padding |
    |         +--------------------------------------+         |
    |                      bottom padding                      |
    +----------------------------------------------------------+
    \endcode

    \section2 Wrapped text

    The text is not wrapped by default. You can configure that
    by changing the \l {OptionalLabel::wrapped} property of
    the label. However, note that the height of the delegate
    will become dynamic if text is wrapped.

    You can programmatically switch between wrapped and
    non-wrapped views by passing the label to the
    \l {PaddedDelegate::toggleWrappedText} function:

    \qml
    toggleWrappedText(textLabel)
    \endqml

    \section2 Side content

    You can define custom content in the \l {PaddedDelegate::leftItem}
    and \l {PaddedDelegate::rightItem} properties. Common uses
    are to show an icon or some additional info. For this, you can
    use \l DelegateIconItem and \l DelegateInfoItem respectively.

    \section2 Example

    \qml
    import QtQuick 2.0
    import Sailfish.Silica 1.0
    import Opal.Delegates 1.0

    DelegateColumn {
        model: ListModel {
            ListElement { post: "Hello there" }
            ListElement { post: "Goodbye again" }
        }
        delegate: D.OneLineDelegate {
            text: post

            textLabel.wrapped: false
        }
    }
    \endqml

    \sa PaddedDelegate, TwoLineDelegate, ThreeLineDelegate, OptionalLabel,
        DelegateIconItem, DelegateInfoItem, DelegateColumn
*/
PaddedDelegate {
    id: root
    minContentHeight: Theme.itemSizeSmall
                      - padding.effectiveTop
                      - padding.effectiveBottom
    centeredContainer: contentContainer

    /*!
      This property holds the text of the delegate.

      The text is shown vertically centered and is not
      wrapped by default. You can change that by changing
      the \l {OptionalLabel::wrapped} property.
    */
    property string text

    /*!
      This property gives access to the text label.

      You can use this property to customize all properties
      of the \l OptionalLabel item that is used
      for this text.
    */
    readonly property alias textLabel: _line1

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
