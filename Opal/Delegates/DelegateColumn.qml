//@ This file is part of opal-delegates.
//@ https://github.com/Pretty-SFOS/opal-delegates
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0
import Sailfish.Silica 1.0

// Note: if your delegates are guaranteed to be the same
// sized when rendered, you can alternatively use Silica's
// ColumnView instead. ColumnView has better performance for
// long lists, but it cuts your view off at the bottom if
// your delegates have different sizes.

Column {
    id: root
    width: parent.width

    property alias model: repeater.model
    property alias delegate: repeater.delegate

    Repeater {
        id: repeater
    }
}
