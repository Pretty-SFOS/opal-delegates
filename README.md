<!--
SPDX-FileCopyrightText: 2023 Peter G. (nephros)
SPDX-License-Identifier: GFDL-1.3-or-later
-->

# Delegate Components for Sailfish apps

A handy collection of ListItems to be used as a delegate in views, so you can
concentrate on handling the data, not formatting the presentation.

## Screenshots

TBD.

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

    Copyright (C) 2023 Peter G. (nephros)
    Program: opal-delegates

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
