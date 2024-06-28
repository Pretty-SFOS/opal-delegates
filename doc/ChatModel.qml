//@ This file is part of opal-delegates.
//@ https://github.com/Pretty-SFOS/opal-delegates
//@ SPDX-FileCopyrightText: 2023 Peter G. (nephros)
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0
import Sailfish.Silica 1.0 as S
import Opal.Delegates 1.0 as D

ListModel {
    id: chatModel

    ListElement {
        nick: qsTr("SamGee")
        status: qsTr("online")
        when: qsTr("yesterday")
        post: qsTr("@mrunderhill: are there any taters left?")
        statusType: "online"
    }
    ListElement {
        nick: qsTr("Sauron")
        status: qsTr("busy")
        when: qsTr("3rd age")
        post: qsTr("You cannot hide. I see you. There is no life in the void. Only death.")
        statusType: "busy"
    }
    ListElement {
        nick: qsTr("Aragorn")
        status: qsTr("away")
        when: qsTr("mid-day")
        post: qsTr("Not idly do the leaves of Lorien fall...")
        statusType: "away"
    }
}
