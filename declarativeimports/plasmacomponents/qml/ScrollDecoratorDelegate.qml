/*
*   Copyright (C) 2011 by Daker Fernandes Pinheiro <dakerfp@gmail.com>
*   Copyright (C) 2011 Marco Martin <mart@kde.org>
*
*   This program is free software; you can redistribute it and/or modify
*   it under the terms of the GNU Library General Public License as
*   published by the Free Software Foundation; either version 2, or
*   (at your option) any later version.
*
*   This program is distributed in the hope that it will be useful,
*   but WITHOUT ANY WARRANTY; without even the implied warranty of
*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*   GNU General Public License for more details
*
*   You should have received a copy of the GNU Library General Public
*   License along with this program; if not, write to the
*   Free Software Foundation, Inc.,
*   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

import QtQuick 1.1
import org.kde.plasma.core 0.1 as PlasmaCore


PlasmaCore.FrameSvgItem {
    id: background
    anchors.fill: parent
    imagePath:"widgets/scrollbar"
    prefix: _isVertical ? "background-vertical" : "background-horizontal"

    opacity: 0
    Behavior on opacity {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutQuad
        }
    }

    property Item handle: handle

    property Item contents: contents
    Item {
        id: contents
        anchors.fill: parent

        PlasmaCore.FrameSvgItem {
            id: handle
            imagePath:"widgets/scrollbar"
            prefix: "slider"

            property int length: _isVertical? flickableItem.visibleArea.heightRatio * parent.height :  flickableItem.visibleArea.widthRatio * parent.width

            width: _isVertical ? parent.width : length
            height: _isVertical ? length : parent.height
        }
    }

    property MouseArea mouseArea: null

    Connections {
        target: flickableItem
        onMovingChanged: {
            if (flickableItem.moving) {
                background.opacity = 1
            } else {
                opacityTimer.restart()
            }
        }
    }
    Timer {
        id: opacityTimer
        interval: 500
        repeat: false
        running: false
        onTriggered: {
            background.opacity = 0
        }
    }
}

