/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: Apache-2.0
*/

import QtQuick 2.0

/*! \qmltype TwoLineDelegate
    \inqmlmodule Opal.Delegates
    \inherits ThreeLineItem

    \brief A \c ListItem intended to be used in views.

    It allows quickly display two lines of text data, and an icon or other indicator.

    Properties are inherited from 
    \l {https://sailfishos.org/develop/docs/silica/qml-sailfishsilica-sailfish-silica-listitem.html/}{Silica.ListItem}
    so you can use menus, actions, and all that.

    \sa ThreeLineItem

*/

ThreeLineDelegate {
    amThreeLine: false
}
