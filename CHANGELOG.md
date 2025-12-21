<!--
SPDX-FileCopyrightText: 2024 Mirian Margiani
SPDX-License-Identifier: GFDL-1.3-or-later
-->

# Changelog

## 3.5.2 (2025-12-21)

- Updated packaging to be easier to integrate into new projects
- Minor documentation fixes

## 3.5.1 (2025-08-08)

- Fixed drag handle padding when using right side items
- Fixed a warning when building the documentation

## 3.5.0 (2025-06-17)

- Added support for custom drag handle implementations (see `enableDefaultGrabHandle`)
- Cleaned up styling for emphasized rows
  - Removed rounded corners from default emphasis background
  - Toned down the default color of even rows
  - Added property `emphasisBackground` to allow full customization of the
    background of even/odd rows
- Clarified documentation and fixed a few typos

## 3.4.1 (2025-06-11)

- Fixed `TwoLineDelegate` labels overflowing to the right when using left side items.
  This reverts the "fix" introduced to `TwoLineDelegate`'s width calculation in v3.4.0.

## 3.4.0 (2025-03-11)

- Added `pressAndHold` signal to `DelegateIconButton`
- Added `bodyColumn` property to `PaddedDelegate` for accessing delegate's body
- Removed unused `metrics` property from `OptionalLabel` to slightly increase performance
- Fixed width calculation of `TwoLineDelegate`
- Fixed type of internal properties for performance
- Updated documentation for clarity

## 3.3.0 (2024-10-30)

- Added `leftItemLoader` and `rightItemLoader` properties to access the actual side items
- Fixed an issue where a label would get stuck with a height of 0 after clearing contents and setting new contents.
- Fixed DelegateIconButton highlighting if it is used in a container
- Moved the drag handle to the left of the right side item to use all available space more efficiently

## 3.2.0 (2024-10-10)

- Removed unused translations (there are no translated strings in this module)
- Added properties to set the vertical alignment of side items: `rightItemAlignment`, `leftItemAlignment`, `dragHandleAlignment`
- Added a new `DelegateIconButton` side item to easily add buttons to delegates
- Added first-class support for dragging delegates using the [Opal.DragDrop](https://github.com/Pretty-SFOS/opal-dragdrop) module
- Added propagating a `_delegate` property to custom side items so they can
  easily access the delegate itself
- Fixed various visual glitches that were caused by access to the delegate's content item
- Fixed `hidden` state by setting `contentHeight` to zero when hidden
- Fixed automatically enabling wrapped mode for labels if they contain linebreaks
- Fixed binding loops on a delegate's content height which could lead to performance hits
- Fixed changing `padding.left` and `padding.right` padding values without also changing `padding.leftRight`
- Fixed various warnings that were irrelevant but confusing
- Fixed default height of delegates so they don't include vertical padding twice
- Updated the example page

## 3.1.0 (2024-09-07)

- Added a new `alignment` property to `DelegateInfoItem`. It is now possible to
  change the text alignment of info items. They are still horizontally centered
  by default.
- Fixed documentation of default property values

## 3.0.0 (2024-06-29)

- Completely refactored API, style, and internal workings
- Changed main branch name from `master` to `main`
- Added full documentation
- Updated example gallery
- First public release

Note: API changes are not listed here because the previous versions have not
been included in Opal releases. However, porting should be easy by copying
examples from the [`doc/gallery.qml`](doc/gallery.qml) file and by following
the documentation.

## 2.0.0 (2024-06-18)

- Relicensed under GPL-3.0-or-later

## 1.0.0 (2023-06-17)

- Initial version under Apache-2.0
