/*
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

/*! \qmltype ListDelegateBase
    \inqmlmodule Opal.Delegates
    \inherits Sailfish.Silica.ListItem

    \brief Base type providing a \c ListItem intended to be used in views.
*/

ListItem { id: root

    /*! \qmlproperty var colors

       \brief An array of \c color values, overriding the defaults for the text colors.

     */
    property var colors: []


    /*! \qmlproperty bool showOddEven

       \brief If \c true delegates will use alternating background colors

       \default false
     */
    property bool showOddEven: false

    /*! \qmlproperty color oddColor

       \brief Background color for odd elements.

       \default \c "transparent"
     */
     /*! \qmlproperty color evenColor

       \brief Background color for even elements.

       \default \c Theme.highlightBackgroundColor
     */
    property color oddColor: "transparent"
    property color evenColor: Theme.highlightBackgroundColor

    property bool isOdd: (index %2 != 0)
    Rectangle { id: oddevenrect
        anchors.fill: parent
        visible: showOddEven
        radius: Theme.paddingSmall
        opacity: Theme.opacityFaint
        color: isOdd ? oddColor : evenColor
        border.color: "transparent"
        border.width: radius/2
    }
    /*! \qmlproperty Component leftItem

        \brief An Item such as an Icon displayed on the left side of the Delegate

    */
    property Component leftItem: null
}
