// SPDX-FileCopyrightText: 2024 - 2027 UnionTech Software Technology Co., Ltd.
// SPDX-License-Identifier: GPL-3.0-or-later
import org.deepin.dcc 1.0

DccObject {
    name: "Manage Input Methods"
    parentName: "keyboard"
    displayName: qsTr("Input Methods")
    description: qsTr("Input method management, input method shortcuts, advanced settings")
    icon: "dcc_input_method"
    weight: 200 // 101~299 for InputMethod in Keyboard-plguin
}
