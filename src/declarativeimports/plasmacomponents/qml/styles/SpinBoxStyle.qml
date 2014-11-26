/*
 *   Copyright 2014 by Marco Martin <mart@kde.org>
 *   Copyright 2014 by David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Library General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.0
import QtQuick.Controls.Styles 1.1 as QtQuickControlStyle
import QtQuick.Layouts 1.1

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.extras 2.0 as PlasmaExtras
import org.kde.plasma.components 2.0 as PlasmaComponents

import "../private" as Private

QtQuickControlStyle.SpinBoxStyle {
    id: styleRoot

    horizontalAlignment: Qt.AlignRight

    textColor: theme.viewTextColor
    selectionColor: theme.viewFocusColor
    selectedTextColor: theme.viewBackgroundColor


    renderType: Text.NativeRendering

    PlasmaCore.Svg {
        id: arrowSvg
        imagePath: "widgets/arrows"
        colorGroup: PlasmaCore.Theme.ButtonColorGroup
    }

   /* property Component incrementControl: Item {
        implicitWidth: padding.right
        Image {
            source: "images/arrow-up.png"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: 1
            opacity: control.enabled ? (styleData.upPressed ? 1 : 0.6) : 0.5
        }
    }*/


    incrementControl: PlasmaCore.SvgItem {
        anchors {
            fill: parent
            margins : 1
            leftMargin: -1
            rightMargin: 3
        }
        svg: arrowSvg
        elementId: "up-arrow"
        opacity: control.enabled ? (styleData.upPressed ? 1 : 0.6) : 0.5
    }

    decrementControl: PlasmaCore.SvgItem {
        anchors {
            fill: parent
            margins : 1
            leftMargin: -1
            rightMargin: 3
        }
        svg: arrowSvg
        elementId: "down-arrow"
        opacity: control.enabled ? (styleData.downPressed ? 1 : 0.6) : 0.5
    }


    background: Item {
        implicitHeight: theme.mSize(theme.defaultFont).height * 1.6
        implicitWidth: theme.mSize(theme.defaultFont).width * 12

        Private.TextFieldFocus {
            id: hover
            state: control.activeFocus ? "focus" : (control.hovered ? "hover" : "hidden")
            anchors.fill: base
        }
        PlasmaCore.FrameSvgItem {
            id: base
            anchors.fill: parent
            imagePath: "widgets/lineedit"
            prefix: "base"
        }
        Component.onCompleted: {
            root.padding.left = base.margins.left
            root.padding.top = base.margins.top
            root.padding.right = base.margins.right + (control.clearButtonShown ? Math.max(control.parent.height*0.8, units.iconSizes.small)+units.smallSpacing : 0)
            root.padding.bottom = base.margins.bottom
        }
    }
}
