/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {

    property int arg1: 0
    property int arg2: 0
    property int expectedResult: 0
    property int resultProposal: 0
    property string operation: "+"

    function changeEquation() {
        arg1 = Math.random() * 100;
        arg2 = Math.random() * 100;

        operation = "+"
        expectedResult = arg1 + arg2

        equation.text = arg1 + " " + operation + " " + arg2 + " = "
        result.text = "?"

        resultProposal = 0
    }
    function assertEquation() {
        //equation.text = expectedResult // for debug only
        //result.text = resultProposal // for debug only

        if(resultProposal == expectedResult)
            changeEquation()
    }
    function resetResultProposal() {
        resultProposal = 0
        result.text = "?"
    }
    function appendResultProposal(number) {
        //changeEquation();

        if(0 == resultProposal)
            result.text = number
        else
            result.text += number

        //resultProposal *= 10
        resultProposal += number
    }

    Component.onCompleted: {
        changeEquation();
    }

    id: page
    property int seconds: 90
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "MathMaster"
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: equation
                    text: "5 + 5 = "
                    font.pixelSize: Theme.fontSizeLarge
                }
                Label {
                    id: result
                    text: "?"
                    font.pixelSize: Theme.fontSizeLarge
                }
            }

            Keypad{
                id: keypad
                vanityDialNumbers :
                    ["0","1","2","3","4","5","6","7","8","9","OK","C"]
                vanityDialNumbersVisible: false
                symbolsVisible: false
                onPressed: {
                    appendResultProposal(number)
                }
            }
        }
    }

    Label
    {
        x: Theme.paddingLarge
        anchors.margins: Theme.paddingLarge
        color: Theme.primaryColor
        anchors.bottom: buttonC.top
        font.pixelSize: Theme.fontSizeMedium
        id: time_left_label
        text: "Paused"
    }

    Button {
        text: "Pause"
        anchors.right : parent.right
        anchors.bottom: buttonC.top
        onClicked: {
            left_time_timer.running ? left_time_timer.stop() : left_time_timer.start()
            left_time_timer.running ? text = "Pause" : text = "Play"
        }
    }

    Button{
        id: buttonC
        anchors.bottom : page.bottom
        anchors.left : parent.left
        text: "C"

        onClicked: {
            resetResultProposal();
        }
    }

    Button{
        id: buttonOK
        anchors.bottom : page.bottom
        anchors.right : parent.right
        text: "OK"

        onClicked: {
            assertEquation();
        }
    }

    Timer
    {
        id: left_time_timer
        interval: 1000; running: true; repeat: true;
        onTriggered:
        {
            time_left_label.text = "Time left: " + seconds
            if (seconds == 0)
            {
                left_time_timer.stop()
            }
            else
            {
                seconds--;
            }
        }
    }
}


