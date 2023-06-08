/*
 * This file is part of harbour-opal.
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: 2020-2023 Mirian Margiani
 */

import QtQuick 2.0
import Sailfish.Silica 1.0 as S
import Opal.Delegates 1.0 as D

Page {
    id: page

    ListModel { id: mymodel
        ListElement { name: "apple"; price: "2.95"; desc: "a juicy fruit!; note: "A is for Apple" }
    }
    S.SilicaColumnView {
            anchors.fill: parent
            model: mymodel
            delegate: D.ThreeLineDelegate {
                    line1.text: name
                    line2.text: desc
                    line3.text: note
                    extratext: price
            }
    }
    S.PullDownMenu {
        parent: page.flickable
        S.MenuItem {
            text: qsTr("Open another page")
            onClicked: pageStack.push(Qt.resolvedUrl("EmptyDummyPage.qml"))
        }
    }
}
