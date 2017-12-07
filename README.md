# mechwarrior-online-starter

This script launches the Mechwarrior Online Client and eliminates the tedious need to click through the
loading screens and having to enter your password every time.

The script also detects game crashes and automatically restarts the game if one should happen.

mechwarrior-online-starter requires [Autohotkey](https://autohotkey.com/) to run.

## Setup

To make the script work you will need to edit it and change some values to fit your system.

    MWOPassword = Y0urPassword
    
Change "Y0urPassword" to whatever your password is.

    MWOStartupTime = 13000

The time (in milliseconds) the script waits before it presses Esc the first time

    MWOScreenTime = 2000
    
 The time (in milliseconds) the script waits before it presses Esc again

    MWODirectory = C:\Program Files\MechWarrior Online\Bin32

Game executable directory, you only need to change this if you picked an alternative location while installing the game.

    MWOScreenLoops = 3
    
Number of time the script presses Esc before attempting to enter the password, you should not need to change this.

    MWOPlayButtonXCoord = 780
    MWOPlayButtonYCoord = 550

Screen coordinates of the "Play" button, you should not need to change this.

    MWOPlayButtonXCoord = 780
    MWOPlayButtonYCoord = 480

Screen coordinates of the "Password" textbox, you should not need to change this.
