//@ This file is part of opal-delegates.
//@ https://github.com/Pretty-SFOS/opal-delegates
//@ SPDX-FileCopyrightText: 2024 Mirian Margiani
//@ SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.0

/*!
    \qmltype PaddingData
    \inqmlmodule Opal.Delegates
    \inherits QtObject

    \brief Item for defining delegate padding.

    This group defines the padding for \l PaddedDelegate
    delgates.

    \section2 Anatomy

    \pre
    +----------------------------------------------------------+
    |                        top padding                       |
    |         +--------------------------------------+         |
    | left    |               delegate               | right   |
    | padding |               contents               | padding |
    |         +--------------------------------------+         |
    |                      bottom padding                      |
    +----------------------------------------------------------+
    \endpre

    \section2 Priorities

    Note that more specific values have higher priority than less
    specific values. In other words: by defining \l all and \l top
    you can set left, right, and bottom to the value of \l all, while
    top get the value of \l top.

    The same goes for \l leftRight and \l rightLeft, which have higher
    priority than \l all but lower priority than the four sides.

    \sa PaddedDelegate, OneLineDelegate, TwoLineDelegate, ThreeLineDelegate,
        DelegateIconItem, DelegateInfoItem, DelegateColumn
*/
QtObject {
    /*!
      This property sets values for all four sides.

      Priority: lowest

      \default 0
    */
    property int all

    /*!
      This property sets values for left and right.

      Priority: medium

      \default Theme.horizontalPageMargin
    */
    property int leftRight  // default value is assigned in PaddedDelegate

    /*!
      This property sets values for top and bottom.

      Priority: medium

      \default Theme.paddingSmall
    */
    property int topBottom

    /*!
      This property sets the top padding.

      Priority: highest

      \default 0
    */
    property int top

    /*!
      This property sets the bottom padding.

      Priority: highest

      \default 0
    */
    property int bottom

    /*!
      This property sets the left padding.

      Priority: highest

      \default 0
    */
    property int left

    /*!
      This property sets the right padding.

      Priority: highest

      \default 0
    */
    property int right

    /*!
      This property shows the effective top padding.

      This takes the values of \l all and \l topBottom in account.
    */
    readonly property int effectiveTop: top > 0 ? top : _topBottom

    /*!
      This property shows the effective bottom padding.

      This takes the values of \l all and \l topBottom in account.
    */
    readonly property int effectiveBottom: bottom > 0 ? bottom : _topBottom

    /*!
      This property shows the effective left padding.

      This takes the values of \l all and \l leftRight in account.
    */
    readonly property int effectiveLeft: left > 0 ? left : _leftRight

    /*!
      This property shows the effective left padding.

      This takes the values of \l all and \l leftRight in account.
    */
    readonly property int effectiveRight: right > 0 ? right : _leftRight

    // internal
    readonly property int _topBottom: topBottom > 0 ? topBottom : all

    // internal
    readonly property int _leftRight: leftRight > 0 ? leftRight : all
}
