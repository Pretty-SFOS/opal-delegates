/*
SPDX-FileCopyrightText: 2024 Mirian Margiani
SPDX-License-Identifier: Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

/*! \qmltype OneLineDelegate
    \inqmlmodule Opal.Delegates
    \inherits PaddedDelegate

    \brief A \c ListItem intended to be used in views.

    It allows quick display two lines of text data, and an icon or other indicator.

    \sa ThreeLineDelegate
*/
PaddedDelegate {
    id: root
    minContentHeight: Theme.itemSizeSmall

    property string text
    readonly property alias textLabel: _line1

    Label {
        id: _line1
        width: parent.width
        text: root.text
        font.pixelSize: Theme.fontSizeMedium
        wrapMode: Text.Wrap

        palette.primaryColor: Theme.primaryColor
        palette.highlightColor: Theme.highlightColor
    }
}
