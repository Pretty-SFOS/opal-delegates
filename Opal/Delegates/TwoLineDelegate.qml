/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.0

/*! \qmltype TwoLineDelegate
    \inqmlmodule Opal.Delegates
    \inherits ThreeLineDelegate

    \brief A \c ListItem intended to be used in views.

    It allows quick display two lines of text data, and an icon or other indicator.

    \sa ThreeLineDelegate
*/
ThreeLineDelegate {
    _amThreeLine: false
}
