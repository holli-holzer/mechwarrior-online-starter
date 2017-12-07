; mwo-auto-launch
; Version 0.2
;
; by Markus "Tailgunner" Holzer
;
; This script launches the Mechwarrior Online Client
; and eliminates the tedious need to enter your password every time
; to play.
;
; To make it work you will need to edit this script.
;
; This script must be run as administrator because the program it has to control "remotely"
; needs administrator priviliges itself.
;
; See you on the battlefield Mechwarrior


; This is the password the script uses to login to the MWO-Servers
; change after the =

MWOPassword = seifenoper

; This is the directory where the MWOClient.exe is located
; Change the value after the = if your its location is different on your machine

MWODirectory = C:\MWO\MechWarrior Online\Bin64

; The time the script waits before it presses Esc the first time
MWOStartupTime = 13000

; The time the script waits before it presses Esc again
MWOScreenTime = 2500

; Number of time the script presses Esc before attempting to enter the password
MWOScreenLoops = 3

; Screen coordinates of the "Play" button
MWOPlayButtonXCoord = 780
MWOPlayButtonYCoord = 550
	
; Check for administrator priviliges

;if not A_IsAdmin
;{
;	MsgBox, 48, MWO Auto Launch - Error, This script must be run as administrator.
;	ExitApp, -1
;}

; Start The MWO Client
StartMWO()
{
	global MWODirectory

	; Indicate Error when the Client is not found
	ifExist, %MWODirectory%\MWOClient.exe
	{
		Run, MWOClient.exe, %MWODirectory%

		; Wait for the Client to launch
		WinWait, MechWarrior Online,, 20
		WinActivate, MechWarrior Online
		if ErrorLevel
			return 0
			
		return 1
	}
	
	return 0
}

; Function to skip the start screens and enter the password
StartPlaying()
{
	global MWOPassword 
	global MWOScreenLoops
	global MWOStartupTime
	global MWOScreenTime
	global MWOPlayButtonXCoord
	global MWOPlayButtonYCoord
	
	Sleep, %MWOStartupTime%

	; Press Space a few times to skip the loading screen
	Loop %MWOScreenLoops% {
		WinActivate, MechWarrior Online
		Sleep, %MWOScreenTime%
		SendInput {Esc}
	}
	
	; Type the password
	Sleep, %MWOScreenTime%
	WinActivate, MechWarrior Online
	SendInput %MWOPassword%
	Sleep 500
	; Click login
	Click  %MWOPlayButtonXCoord%, %MWOPlayButtonYCoord%
}

ProcessExist(Name)
{
	Process, Exist, %Name%
	return Errorlevel
}

MWORunning()
{
	if ProcessExist("MWOClient.exe")
	{
		return 1
	}
	else
	{
		return 0
	}
}

MWOHasCrashed()
{
	IfWinExist, Unexpected Error
	{
		return 1
	}
	else
	{
		return 0
	}
}

RestartMWO()
{
	Run taskkill /f /im dxdiag.exe
	Run taskkill /f /im MWOClient.exe
	
	while MWORunning() 
	{
		; wait
	}
	
	StartMWO()
}

WatchMWO()
{
	while MWORunning() 
	{
		Sleep, 2000
		if MWOHasCrashed()
		{
			RestartMWO()
		}
	}
}

if ( StartMWO() )
{
	StartPlaying()
    WatchMWO()
}
else
{
	MsgBox, 48, MWO Auto Launch - Error, Could not start or find the client. Make sure the MWO directory is set correctly.
	ExitApp, -2
}

; Exit indicating success
Exit, 0