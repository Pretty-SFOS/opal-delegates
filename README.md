<!--
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: GFDL-1.3-or-later
-->

# Delegate Components for Sailfish apps

A handy collection of ListItems to be used as a delegate in views, so you can
concentrate on handling the data, not formatting the presentation.

## Screenshots

Screenshots can be found in the [doc](doc/) directory.

## Example code

```{qml}
import QtQuick 2.0
import Sailfish.Silica 1.0 as S
import Opal.Delegates 1.0 as D

ListView {
    model: myModel
    delegate: D.ThreeLineDelegate {
        line1.text: "Main text"
        line2.text: "Descriptive text"
        line3.text: "Additional text"
    }
}
```

Advanced features are just as easy to use and extensive documentation is
available through QtCreator.

## How to use

You do not need to clone this repository if you only intend to use the module in
another project. Simply download the
[latest release bundle](https://github.com/Pretty-SFOS/opal-delegates/releases/latest).

### Setup

Follow the main documentation for installing Opal modules
[here](https://github.com/Pretty-SFOS/opal/blob/main/README.md#using-opal).

### Configuration

See [`doc/gallery.qml`](doc/gallery.qml) for some examples.


### Documentation

Extensive documentation is included in the release bundle and can be added to
QtCreator via Extras → Settings → Help → Documentation → Add.

## License

    Copyright (C) 2023  Peter G. (nephros)
    Copyright (C) 2024  Mirian Margiani
    Program: opal-delegates

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
