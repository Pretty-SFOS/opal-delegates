/*
SPDX-FileCopyrightText: 2024 Mirian Margiani
SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Column {
    id: root
    width: Math.max(Theme.itemSizeMedium, childrenRect.width)
    height: Math.max(Theme.itemSizeMedium, childrenRect.height
    spacing: Theme.paddingSmall

    property string title
    property string text
    property string description

    readonly property alias titleLabel: _line0
    readonly property alias textLabel: _line1
    readonly property alias descriptionLabel: _line2

    Label {
        id: _line0
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeExtraSmall
        text: root.title

        palette.primaryColor: Theme.secondaryColor
        palette.highlightColor: Theme.secondaryHighlightColor
    }

    Label {
        id: _line1
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeLarge
        text: root.text

        palette.primaryColor: Theme.primaryColor
        palette.highlightColor: Theme.highlightColor
    }

    Label {
        id: _line2
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: Theme.fontSizeExtraSmall
        text: root.description

        palette.primaryColor: Theme.secondaryColor
        palette.highlightColor: Theme.secondaryHighlightColor
    }
}
