%Shivam Patel

%This code has been organized with the first things executed at the bottom...
%...and the last things executed at the top. This allows for the code to be...
%...compiled correctly. In addition the parameters are at the top along with...
%...screen designs since they are used throughout the program.

%This is the list of procedures/process in order:
%text - proecedure containing paramaters to easily draw text of any font/size
%picture - procedure containing paramaters to draw pictures
%animte - procedure with paramaters to add animation of any sort (sprites,gif)
%music - process with parameters to fork sound effects
%title - procedure compiling the title of the program; centered
%intro - procedure compiling the first screen of program
%mainMenu - procedure compiling main menu screen
%howToPlay - procedure compiling how to play screen with rules
%exitScreen - procedure compiling exit screen
%drawGame - procedure with parameters which draws 40x40 grid at any location
%mainGameScreen - procedure compiling screen where computer/player battles
%planningScreen - procedure compiling screen where player places their ships
%goodBye - procedure which processes exiting of program
%howToPlayProcess - procedure which processes the slide display of each rule
%userInput - prcedure processing the players move/what ship was hit/destroyed
%computerMove - procedure processing firing at players ship/ship hit/destroyed
%mainGame - procedure handling whos turn it is/who won/post game options
%shipPlacementCheck - procedure checks which ships have been placed and where
%gamePlanning - procedure processing placement of player/computer ships
%mainProcess - menu screen processing to go to how to play, exit or game
%display - processing of displaying introduction to continue onto menu screen

%My code is designed to be readable while still efficient. By having:
%Variables named exactly to their pourpose they make the code less confusing.
%The user input is always taken first then the processes are executed.
% Each ship also has its own grid for easier coding if more ship specific...<
%...actions are needed such as more animations,promts,etc.
%All similar procedures are grouped nearby eachother.
%Local variables are always decleared first.
%Error traping of mouse always occurs at the top (ensuring button is unclicked)
%Spaceings seperate groups of similar code

%Current Bugs: On extremly rare occurances all the human ships will not be...
%identified as destroyed when they actually are destroyed.


%Setting screen size and other prefrences
var windowID : int := Window.Open ("graphics:max;max,nobuttonbar,nocursor")

%---------------------------DECLARING VARIABLES--------------------------------
forward procedure mainProcess %Used to pre compile mainProcess
forward procedure display %Used to pre compile display

%For how to play question function
var ShowToPlayStringsNumber : int := 2

%Variable used to check if ships have been placed
var carrierPlaced, battleshipPlaced, cruiserPlaced,
    submarinePlaced, destroyerPlaced : boolean := false
%Variables used for ship orientation changes; either vertical or horizontal
var carrierFile, battleshipFile, cruiserFile, submarineFile,
    destroyerFile : string
%Variables used in coordination with mouse to place ships on grid.
var xCarrierMouse, yCarrierMouse, xBattleshipMouse, yBattleshipMouse,
    xCruiserMouse, yCruiserMouse, xSubmarineMouse, ySubmarineMouse,
    xDestroyerMouse, yDestroyerMouse : int

%Variable used for specifing individual ship grid coordinates.
%Allows for checking which ship was hit.
var xCarrierGrid, yCarrierGrid, xBattleshipGrid, yBattleshipGrid, xCruiserGrid,
    yCruiserGrid, xSubmarineGrid, ySubmarineGrid,
    xDestroyerGrid, yDestroyerGrid : int
%Computer version of above variables
var xCarrierComputerGrid, yCarrierComputerGrid, xBattleshipComputerGrid,
    yBattleshipComputerGrid, xCruiserComputerGrid, yCruiserComputerGrid,
    xSubmarineComputerGrid, ySubmarineComputerGrid,
    xDestroyerComputerGrid, yDestroyerComputerGrid : int

%Works in coordination with individual ship grids (above)
%Checks for if full ship has been hit
var carrierSunk : array 1 .. 15, 1 .. 15 of int
var battleshipSunk : array 1 .. 15, 1 .. 15 of int
var cruiserSunk : array 1 .. 15, 1 .. 15 of int
var submarineSunk : array 1 .. 15, 1 .. 15 of int
var destroyerSunk : array 1 .. 15, 1 .. 15 of int
%Computer version of above variables
var carrierComputerSunk : array 1 .. 15, 1 .. 15 of int
var battleshipComputerSunk : array 1 .. 15, 1 .. 15 of int
var cruiserComputerSunk : array 1 .. 15, 1 .. 15 of int
var submarineComputerSunk : array 1 .. 15, 1 .. 15 of int
var destroyerComputerSunk : array 1 .. 15, 1 .. 15 of int

%Boolean logic to check if ship has been destroyed; once all
%ship are destroyed game ends
var carrierDestroyed, battleshipDestroyed, cruiserDestroyed,
    submarineDestroyed,
    destroyerDestroyed : boolean := false
%Computer version of above variables
var carrierComputerDestroyed, battleshipComputerDestroyed,
    cruiserComputerDestroyed, submarineComputerDestroyed,
    destroyerComputerDestroyed : boolean := false


%Universal grid used to palce ships, see if any ship has been hit
var grid : array 1 .. 10, 1 .. 10 of int
%Computer version of above variables
var computerGrid : array 1 .. 10, 1 .. 10 of int

%STRINGS USED THROUGHOUT PROGRAM
var SmainStrings : array 1 .. 12 of string
SmainStrings (1) := "BATTLESHIP"
SmainStrings (2) := "Continue"
SmainStrings (3) := "Programmer: Shivam Patel -- Last Edit : 31/05/15"
SmainStrings (4) := "Play Game"
SmainStrings (5) := "Exit"
SmainStrings (6) := "Next Rule"
SmainStrings (7) := "Previous Rule"
SmainStrings (8) := "(ESC)Return"
SmainStrings (9) := "Welcome to my battleship game!"
SmainStrings (10) := "Its rules are based of the original game."
SmainStrings (11) :=
    ("The only difference is in this battleship you verse the computer!")
SmainStrings (12) :=
    ("To navigate click the buttons which highlight when the mouse is over it!")

%STRINGS USED DURING GAME
var SgameStrings : array 1 .. 22 of string
SgameStrings (1) := "Plan For Warefare"
SgameStrings (2) := "START BATTLLING!"
SgameStrings (3) := "Click and drag the ship to the desired square."
SgameStrings (4) := "-Right click the ship, when selecting, to rotate it!"
SgameStrings (5) := "-Press 'c' to restart ship placement."
SgameStrings (6) := "SHIPS CANNOT OVERLAP!"
SgameStrings (7) := "You LOST! Computer WON!"
SgameStrings (8) := "You WON! Computer LOST!"
SgameStrings (9) := "Main Menu"
SgameStrings (10) := "Your Turn! Click a coordinate to FIRE!"
SgameStrings (11) := "Computer's Turn. Please Wait"
SgameStrings (12) := "Computer's shots recorded on this grid!"
SgameStrings (13) := "Click anywhere on this grid to fire at computer!"
SgameStrings (14) := "Red = Hit...White = Miss"
SgameStrings (15) := "Your Ships "
SgameStrings (16) := "Computer's Ships "
SgameStrings (17) := "Destryoed:"
SgameStrings (18) := "Carrier"
SgameStrings (19) := "Battleship"
SgameStrings (20) := "Crusier"
SgameStrings (21) := "Submarine"
SgameStrings (22) := "Destroyer"

%STRINGS USED WHEN EXITING
var SexitStrings : array 1 .. 5 of string
SexitStrings (1) := "Are you sure you would like to exit?"
SexitStrings (2) := "Yes, Exit!"
SexitStrings (3) := "No, Go Back!"
SexitStrings (4) := "Are you sure you want to exit? Gameplay will reset!"
SexitStrings (5) := "Press 'y' to exit. Press any other key to return."

%STRINGS USED WHEN THERE IS AN ERROR
var SerrorStrings : array 1 .. 2 of string
SerrorStrings (1) :=
    "ERROR! IMAGE NOT LOADED CORRECTLY! -- PLACE IMAGES IN THE SAME FOLDER AS PROGRAM!"
SerrorStrings (2) := "The program will end in the following seconds: "

%STRINGS USED FOR HOW TO PLAY SCREEN
var ShowToPlayStrings : array 1 .. 8, 1 .. 6 of string
ShowToPlayStrings (1, 1) := "How To Play"

ShowToPlayStrings (2, 1) := "Battleship is a game in which players place their"
ShowToPlayStrings (2, 2) := " battleships on a 10x10 grid which is identified "
ShowToPlayStrings (2, 3) := "by a letter and number. The opponent must then "
ShowToPlayStrings (2, 4) := "pick a point in which they would like to fire. "
ShowToPlayStrings (2, 5) := "The goal is to sink all their opponents' ships;"
ShowToPlayStrings (2, 6) := " first one to do so wins."

ShowToPlayStrings (3, 1) := "1. The player first must choose where they would"
ShowToPlayStrings (3, 2) := " like to place their ships (cannot be outside of"
ShowToPlayStrings (3, 3) := " grid, or overlap another ship and must be "
ShowToPlayStrings (3, 4) := "vertical or horizontal)."
ShowToPlayStrings (3, 5) := " "
ShowToPlayStrings (3, 6) := " "

ShowToPlayStrings (4, 1) := "2. There are 5 ships: carrier (5 holes);"
ShowToPlayStrings (4, 2) := " battleships (4 holes); cruiser (3 holes); "
ShowToPlayStrings (4, 3) := "submarine (3 holes), and destroyer (2 holes). The"
ShowToPlayStrings (4, 4) := " holes identify how many grid spaces the boat "
ShowToPlayStrings (4, 5) := "will take up and also the amount of hits it will "
ShowToPlayStrings (4, 6) := "take to destroy."

ShowToPlayStrings (5, 1) := "3. Once your ships are placed, pick a target hole"
ShowToPlayStrings (5, 2) := " on the grid to the right. This is where your "
ShowToPlayStrings (5, 3) := "shots will be recorded. If the shot is a hit the "
ShowToPlayStrings (5, 4) := "square will turn red and if not it will turn "
ShowToPlayStrings (5, 5) := "white. Once the first move occurs you may no "
ShowToPlayStrings (5, 6) := "longer move ships."

ShowToPlayStrings (6, 1) := "4. The computer will then take its shot and if it"
ShowToPlayStrings (6, 2) := " is a hit the ship that was hit will turn red in "
ShowToPlayStrings (6, 3) := "that one area or if it is a miss the square which"
ShowToPlayStrings (6, 4) := " they picked will turn white to show places they "
ShowToPlayStrings (6, 5) := "have chosen."
ShowToPlayStrings (6, 6) := " "

ShowToPlayStrings (7, 1) := "5. If a ship is sunk it will be indentified "
ShowToPlayStrings (7, 2) := "during the last shot taken to sink it."
ShowToPlayStrings (7, 3) := " "
ShowToPlayStrings (7, 4) := " "
ShowToPlayStrings (7, 5) := " "
ShowToPlayStrings (7, 6) := " "

ShowToPlayStrings (8, 1) := "6. The calling of shots will continue until all "
ShowToPlayStrings (8, 2) := "the ships of either the computers or yours "
ShowToPlayStrings (8, 3) := "are sunken. The winner is the one who sinks "
ShowToPlayStrings (8, 4) := "all the opponents' ships first."
ShowToPlayStrings (8, 5) := " "
ShowToPlayStrings (8, 6) := " "


%---------------------------------ALL PARAMETERS-------------------------------
%Used to place font special text
procedure text (textString : string, textType : string, xDivNumber : real,
	yDivNumber : real, colourType : int)
    var font := Font.New (textType)
    var alignWidth := Font.Width (textString, font) %Calculates with of text
    if xDivNumber = 0 then %Using "0" sets the text to align in the middle
	Font.Draw (textString, maxx div 2 - alignWidth div 2, maxy div
	    yDivNumber, font, colourType)
    else %Anything else is not centred and is defines with specific coordinates
	Font.Draw (textString, maxx div xDivNumber, maxy div yDivNumber, font,
	    colourType)
    end if
    Font.Free (font)
end text

%Used to place pictures
procedure picture (fileName : string, xPlace : int, yPlace : int, xSize : int,
	ySize : int)
    var picture := Pic.FileNew (fileName)
    if picture = 0 then %ERROR TRAP IF PICTURE NOT FOUND
	for decreasing seconds : 10 .. 0 %CLOSES IN 10 SECONDS IF PICTURE = 0
	    var secondsString := intstr (seconds)
	    cls
	    text (SerrorStrings (1), "Impact:15", 0, 2, brightred)
	    text (SerrorStrings (2), "Impact:15", 0, 2.1, brightred)
	    text (secondsString, "Impact:15", 1.62, 2.1, brightred)
	    delay (1000)
	end for
	Window.Close (windowID)
    elsif xSize = 0 and ySize = 0 then %For not resizing a picture.
	Pic.Draw (picture, xPlace, yPlace, picMerge)
    else
	%Fits to any screen size
	var newSizePicture := Pic.Scale (picture, xSize, ySize)
	Pic.Draw (newSizePicture, xPlace, yPlace, picCopy)
    end if
    Pic.Free (picture)
end picture

%Parameter to produce animations such as sprites and gifs
process animate (fileName : string, xOne, y, xTwo, byNumber, speed : int)
    %Obtaining info from gif needed for animation
    var numFrames : int := Pic.Frames (fileName)
    var pics : array 1 .. numFrames of int
    var delayTime : int
    % Load the picture
    Pic.FileNewFrames (fileName, pics, delayTime)

    %If  movement does not require movement of gif
    if xOne not= xTwo then
	var sprite : int := Sprite.New (pics (1)) %Creating Sprite
	Sprite.Show (sprite)
	for xMove : xOne .. xTwo by byNumber
	    Sprite.Animate (sprite, pics ((xMove div 10) mod numFrames + 1),
		xMove, y, false)
	    delay (speed)
	    View.Update
	end for
	Sprite.Free (sprite)
    else
	Pic.DrawFrames (pics, xOne, y, picMerge, numFrames, speed, false)
    end if
    %Destroys image after its been used
end animate

%For sound effects
process music (fileName : string)
    Music.PlayFileReturn (fileName)
end music

%-------------------------------END ALL PARAMETERS-----------------------------



%-------START ALL SCREEN RENDERINGS--------------
%Centred title, name, and last edit
procedure title
    text (SmainStrings (1), "Impact:50", 0, 1.2, brightred)
    text (SmainStrings (3), "Impact:15", 0, 1.25, brightgreen)
end title

%Introduction screen displated once at the beggining of program
procedure intro
    picture ("IntroBackground.JPG", 0, 0, maxx, maxy)
    title
    text (SmainStrings (2), "Impact:25", 0, 2, brightgreen)
    text (SmainStrings (5), "Impact:25", 0, 2.3, brightgreen)

    text (SmainStrings (9), "Impact:16", 0, 1.5, yellow)
    text (SmainStrings (10), "Impact:16", 0, 1.6, yellow)
    text (SmainStrings (11), "Impact:16", 0, 1.7, yellow)
    text (SmainStrings (12), "Impact:16", 0, 1.8, yellow)
end intro

%Main menu screen
procedure mainMenu
    View.Set ("offscreenonly")
    picture ("MainBackground.JPG", 0, 0, maxx, maxy)
    text (SmainStrings (1), "Impact:50", 0, 1.2, brightred)
    text (SmainStrings (4), "Impact:30", 0, 2, brightgreen)
    text (SmainStrings (5), "Impact:30", 0, 2.55, brightgreen)
    text (ShowToPlayStrings (1, 1), "Impact:30", 0, 3.5, brightgreen)
    text (SmainStrings (8), "Impact:18", 100, 100, yellow)
    View.Update
    View.Set ("nooffscreenonly")
end mainMenu

%Screen for how to play
procedure howToPlay
    picture ("HowToPlayBackground.JPG", 0, 0, maxx, maxy)
    text (ShowToPlayStrings (1, 1), "Impact:50", 0, 1.2, brightred)
    text (SmainStrings (6), "Impact:20", 1.25, 7.5, brightgreen)
    text (SmainStrings (7), "Impact:20", 7, 7.5, brightgreen)
    text (SmainStrings (8), "Impact:18", 100, 100, yellow)
    text (ShowToPlayStrings (ShowToPlayStringsNumber, 1), "Impact:25", 0, 1.6,
	black)
    text (ShowToPlayStrings (ShowToPlayStringsNumber, 2), "Impact:25", 0, 1.75,
	black)
    text (ShowToPlayStrings (ShowToPlayStringsNumber, 3), "Impact:25", 0, 1.9,
	black)
    text (ShowToPlayStrings (ShowToPlayStringsNumber, 4), "Impact:25", 0, 2.1,
	black)
    text (ShowToPlayStrings (ShowToPlayStringsNumber, 5), "Impact:25", 0, 2.3,
	black)
    text (ShowToPlayStrings (ShowToPlayStringsNumber, 6), "Impact:25", 0, 2.5,
	black)
end howToPlay

%Exit Screen
procedure exitScreen
    picture ("ExitBackground.JPG", 0, 0, maxx, maxy)
    title
    text (SexitStrings (1), "Impact:30", 0, 3.8, black)
    text (SexitStrings (2), "Impact:25", 1.75, 5, brightred)
    text (SexitStrings (3), "Impact:25", 2.8, 5, brightgreen)
end exitScreen

%Procedure that draw grid and has parameters to adjust where it is placed
procedure drawGame (xGridPlacement : real, yGridPlacement : real)
    var xGridStart := maxx div xGridPlacement %Adds to the 40 width of grid box
    var yGridStart := maxy div yGridPlacement %Adds to the 40 heigh of grid box

    %Two for loops create each individual box making a full grid
    for y : 1 .. 10
	for x : 1 .. 10
	    %Starts at grid placement; then adds 40 each time
	    var xLower := (40 * (x - 1)) + xGridStart
	    var yLower := (40 * (y - 1)) + yGridStart
	    var xHigher := (40 * x) + xGridStart
	    var yHigher := (40 * y) + yGridStart
	    drawbox (xLower, yLower, xHigher, yHigher, brightgreen)
	end for
    end for
end drawGame

%Screen for the main part of game after ship placement is done
procedure mainGameScreen
    picture ("MainGameBackground.JPG", 0, 0, maxx, maxy)
    picture ("Radar.JPG", (maxx div 50), (maxy div 1.25), 0, 0)
    picture ("Radar.JPG", (maxx div 1.2), (maxy div 1.25), 0, 0)

    text (SmainStrings (1), "Impact:40", 0, 1.1, brightred)
    text (SgameStrings (12), "Calibre:14", 30, 1.45, black)
    text (SgameStrings (13), "Calibre:14", 1.7, 1.45, black)
    text (SmainStrings (8), "Impact:18", 100, 100, yellow)
    text (SgameStrings (14), "Calibre:16", 0, 1.15, white)


    text (SgameStrings (15), "Calibre:12", 2.4, 1.2, yellow)
    text (SgameStrings (16), "Calibre:12", 1.95, 1.2, yellow)
    text (SgameStrings (17), "Calibre:12", 2.4, 1.25, yellow)
    text (SgameStrings (17), "Calibre:12", 1.95, 1.25, yellow)

    drawGame (30, 12)
    drawGame (1.75, 12)
    drawline (maxx div 2, maxy div 1.2, maxx div 2, maxy div 1.5, black)

    %Ships are placed where the user placed them on grid, by saving coordinates
    picture (carrierFile, xCarrierMouse, yCarrierMouse, 0, 0)
    picture (battleshipFile, xBattleshipMouse, yBattleshipMouse, 0, 0)
    picture (cruiserFile, xCruiserMouse, yCruiserMouse, 0, 0)
    picture (submarineFile, xSubmarineMouse, ySubmarineMouse, 0, 0)
    picture (destroyerFile, xDestroyerMouse, yDestroyerMouse, 0, 0)
end mainGameScreen

%Planning screen before main game commences
procedure planningScreen (carrier, battleship, cruiser, submarine,
	destroyer : int)

    picture ("MainGameBackground.JPG", 0, 0, maxx, maxy)

    text (SgameStrings (1), "Impact:40", 0, 1.1, brightred)
    text (SgameStrings (3), "Impact:18", 2.1, 1.5, black)
    text (SgameStrings (4), "Impact:18", 2.1, 1.6, black)
    text (SgameStrings (5), "Impact:18", 2.1, 1.7, black)
    text (SmainStrings (8), "Impact:18", 100, 100, yellow)

    drawGame (30, 12)

    %Paramets on procedure allow the option to choose which ships renders
    %Allows for removing ship rendering after ship has been placed by user
    if carrier = 1 then
	picture ("Carrier.GIF", maxx div 1.8, maxy div 4, 0, 0)
    else
    end if
    if battleship = 1 then
	picture ("Battleship.GIF", maxx div 1.5, maxy div 3, 0, 0)
    else
    end if
    if cruiser = 1 then
	picture ("Cruiser.GIF", maxx div 1.25, maxy div 3, 0, 0)
    else
    end if
    if submarine = 1 then
	picture ("Submarine.GIF", maxx div 1.5, maxy div 10, 0, 0)
    else
    end if
    if destroyer = 1 then
	picture ("Destroyer.GIF", maxx div 1.25, maxy div 6, 0, 0)
    else
    end if
end planningScreen



%------------------------------EXIT PROCESS---------------------------------
procedure goodBye
    View.Set ("offscreenonly") %Stops flickering
    var xMouse, yMouse, button : int

    %ERROR TRAP ENSURES BUTTON IS UNCLICKED
    loop
	Mouse.Where (xMouse, yMouse, button)
	if button = 0 then
	    exit
	else
	end if
    end loop

    exitScreen
    View.Update
    loop
	Mouse.Where (xMouse, yMouse, button)         %Calculates where mouse is

	%Checks for correct x and y values
	if (xMouse >= (maxx div 1.75)) and (xMouse <= (maxx div 1.55))
	    %If correct text turns black
		and (yMouse >= (maxy div 5)) and
		(yMouse <= (maxy div 4.45)) then
	    text (SexitStrings (2), "Impact:25", 1.75, 5, black)
	    View.Update
	    if button = 1 then         %If clicked to close; window closes.
		Window.Close (windowID)
		quit
	    else
	    end if

	    %Checks for correct x and y values
	elsif (xMouse >= (maxx div 2.8)) and (xMouse <= (maxx div 2.2))
		and (yMouse >= (maxy div 5)) and
		(yMouse <= (maxy div 4.45)) then
	    text (SexitStrings (3), "Impact:25", 2.8, 5, black)
	    View.Update
	    if button = 1 then         %Clicking return; goes back to main menu
		display
		return
	    else
	    end if
	else         %If not over button then they remain green
	    text (SexitStrings (2), "Impact:25", 1.75, 5, brightred)
	    text (SexitStrings (3), "Impact:25", 2.8, 5, brightgreen)
	    View.Update
	end if
    end loop
end goodBye
%----------------------------END EXIT PROCESS-------------------------------



%--------------------------------HOW TO PLAY PROCESS------------------------
procedure howToPlayProcess
    setscreen ("offscreenonly")  %Stops Flickering
    var userKeyInput : string (1)
    var xMouse, yMouse, button : int

    loop
	Mouse.Where (xMouse, yMouse, button)
	if button = 0 then         %Error trap; ensures button is unclicked.
	    howToPlay
	    View.Update
	    loop
		Mouse.Where (xMouse, yMouse, button)

		%--NEXT RULE--
		%Checks for correct x and y values
		if (xMouse >= (maxx div 1.25)) and (xMouse <= (maxx div 1.15))
			and (yMouse >= (maxy div 7.5)) and
			(yMouse <= (maxy div 6.5)) then
		    text (SmainStrings (6), "Impact:20", 1.25, 7.5, red)
		    View.Update
		    if button = 1 then
			ShowToPlayStringsNumber :=
			    ShowToPlayStringsNumber + 1

			if ShowToPlayStringsNumber = 9 then
			    ShowToPlayStringsNumber :=
				ShowToPlayStringsNumber - 1
			else
			end if
			exit
		    else
		    end if

		    %--PREVIOUS RULE--
		    %Checks for correct x and y values
		elsif (xMouse >= (maxx div 7)) and (xMouse <= (maxx div 4)) and
			(yMouse >= (maxy div 7.5)) and
			(yMouse <= (maxy div 6.5)) then
		    text (SmainStrings (7), "Impact:20", 7, 7.5, red)
		    View.Update
		    if button = 1 then
			ShowToPlayStringsNumber :=
			    ShowToPlayStringsNumber - 1
			if ShowToPlayStringsNumber = 1 then
			    ShowToPlayStringsNumber :=
				ShowToPlayStringsNumber + 1
			else
			end if
			exit
		    else
		    end if

		elsif hasch then %Checks for keypress to go back
		    getch (userKeyInput)
		    if userKeyInput = KEY_ESC then
			mainProcess
		    else
		    end if

		else  %Anything else; mean button remains green
		    text (SmainStrings (6), "Impact:20", 1.25, 7.5, brightgreen)
		    text (SmainStrings (7), "Impact:20", 7, 7.5, brightgreen)
		    View.Update
		end if
	    end loop

	else
	end if
    end loop
end howToPlayProcess
%-------------------------------END HOW TO PLAY PROCESSES----------------------



%--------------------------------START GAME PROCESSES--------------------------
%----------PLAYER MOVE PROCESS----------
procedure userInput
    var xComputerGridStart := maxx div 1.75
    var yComputerGridStart := maxy div 12
    var userKeyInput : string (1)
    var xComputerGrid, yComputerGrid : int
    var xMouse, yMouse, button : int


    %ERROR TRAP ENSURES BUTTON IS UNCLICKED
    loop
	Mouse.Where (xMouse, yMouse, button)
	if button = 0 then
	    exit
	else
	end if
    end loop

    loop
	Mouse.Where (xMouse, yMouse, button)
	%Checks for mouse inside of grid
	if (xMouse > xComputerGridStart) and (xMouse < 400 + xComputerGridStart)
		and (yMouse > yComputerGridStart) and
		(yMouse < 400 + yComputerGridStart) then
	    if button = 1 then
		%Rounds to nearest 40th
		var xRound := (floor ((xMouse - xComputerGridStart) / 40)) * 40
		%Rounds to nearest 40th
		var yRound := (floor ((yMouse - yComputerGridStart) / 40)) * 40

		%Calculates row number
		xComputerGrid := round ((xRound / 40) + 1)
		%Calculates Column number
		yComputerGrid := round ((yRound / 40) + 1)

		%ERROR TRAP; ensures square more than 10 is not selected
		if xComputerGrid > 10 then
		    xComputerGrid := 10
		end if

		%Calculating bottom left and top right points of grid square
		var xLower := (40 * (xComputerGrid - 1)) + xComputerGridStart
		var yLower := 40 * (yComputerGrid - 1) + yComputerGridStart
		var xHigher := (40 * xComputerGrid) + xComputerGridStart
		var yHigher := (40 * yComputerGrid) + yComputerGridStart

		if computerGrid (xComputerGrid, yComputerGrid) = 1 then
		    %Sets grid square to show it has been shot at (2)
		    computerGrid (xComputerGrid, yComputerGrid) := 2
		    %Fill box red to show ship was there
		    drawfillbox (xLower, yLower, xHigher, yHigher, brightred)
		    drawbox (xLower, yLower, xHigher, yHigher, black)
		    %Fires missle when ship is hit
		    fork animate ("Missle.GIF", xBattleshipMouse,
			yBattleshipMouse, xLower, 10, 2)
		    View.Update

		    %--CHECKING FOR WHICH SHIP WAS HIT AND IF IT IS DESTROYED--
		    if carrierComputerSunk (xComputerGrid,
			    yComputerGrid) = 1 then
			%Setting grid to false showing that carrier has been hit
			carrierComputerSunk (xComputerGrid, yComputerGrid) := 2
			%---Checking if ship is destroyed---
			if (carrierComputerSunk (xCarrierComputerGrid + 1,
				yCarrierComputerGrid) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid + 2,
				yCarrierComputerGrid) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid + 3,
				yCarrierComputerGrid) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid + 4,
				yCarrierComputerGrid) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid,
				yCarrierComputerGrid) = 2) or

				((carrierComputerSunk (xCarrierComputerGrid,
				yCarrierComputerGrid + 1) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid,
				yCarrierComputerGrid + 2) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid,
				yCarrierComputerGrid + 3) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid,
				yCarrierComputerGrid + 4) = 2) and
				(carrierComputerSunk (xCarrierComputerGrid,
				yCarrierComputerGrid) = 2)) then
			    carrierComputerDestroyed := true
			    fork animate ("Explosion.GIF", xLower, yLower,
				xLower, 0, 35)
			    fork music ("MissileLaunch.WAV")
			    text (SgameStrings (18), "Calibre:12", 2.4, 1.3,
				brightred)
			else
			end if

		    elsif battleshipComputerSunk (xComputerGrid,
			    yComputerGrid) = 1 then
			%Setting grid to false showing that battleship has been hit
			battleshipComputerSunk (xComputerGrid, yComputerGrid) := 2
			%---Checking if ship is destroyed---
			if (battleshipComputerSunk (xBattleshipComputerGrid + 1,
				yBattleshipComputerGrid) = 2) and
				(battleshipComputerSunk (xBattleshipComputerGrid + 2,
				yBattleshipComputerGrid) = 2) and
				(battleshipComputerSunk (xBattleshipComputerGrid + 3,
				yBattleshipComputerGrid) = 2) and
				(battleshipComputerSunk (xBattleshipComputerGrid,
				yBattleshipComputerGrid) = 2) or

				((battleshipComputerSunk (xBattleshipComputerGrid,
				yBattleshipComputerGrid + 1) = 2) and
				(battleshipComputerSunk (xBattleshipComputerGrid,
				yBattleshipComputerGrid + 2) = 2) and
				(battleshipComputerSunk (xBattleshipComputerGrid,
				yBattleshipComputerGrid + 3) = 2) and
				(battleshipComputerSunk (xBattleshipComputerGrid,
				yBattleshipComputerGrid) = 2)) then
			    battleshipComputerDestroyed := true
			    fork animate ("Explosion.GIF", xLower, yLower,
				xLower, 0, 35)
			    fork music ("MissileLaunch.WAV")
			    text (SgameStrings (19), "Calibre:12", 2.4, 1.35,
				brightred)
			else
			end if

		    elsif cruiserComputerSunk (xComputerGrid,
			    yComputerGrid) = 1 then
			%Setting grid to false showing that cruiser has been hit
			cruiserComputerSunk (xComputerGrid, yComputerGrid) := 2
			%---Checking if ship is destroyed---
			if (cruiserComputerSunk (xCruiserComputerGrid + 1,
				yCruiserComputerGrid) = 2) and
				(cruiserComputerSunk (xCruiserComputerGrid + 2,
				yCruiserComputerGrid) = 2) and
				(cruiserComputerSunk (xCruiserComputerGrid,
				yCruiserComputerGrid) = 2) or

				((cruiserComputerSunk (xCruiserComputerGrid,
				yCruiserComputerGrid + 1) = 2) and
				(cruiserComputerSunk (xCruiserComputerGrid,
				yCruiserComputerGrid + 2) = 2) and
				(cruiserComputerSunk (xCruiserComputerGrid,
				yCruiserComputerGrid) = 2)) then
			    cruiserComputerDestroyed := true
			    fork animate ("Explosion.GIF", xLower, yLower,
				xLower, 0, 35)
			    fork music ("MissileLaunch.WAV")
			    text (SgameStrings (20), "Calibre:12", 2.4, 1.4,
				brightred)
			else
			end if

		    elsif submarineComputerSunk (xComputerGrid,
			    yComputerGrid) = 1 then
			%Setting grid to false showing that submarine has been hit
			submarineComputerSunk (xComputerGrid, yComputerGrid) := 2
			%---Checking if ship is destroyed---
			if (submarineComputerSunk (xSubmarineComputerGrid + 1,
				ySubmarineComputerGrid) = 2) and
				(submarineComputerSunk (xSubmarineComputerGrid + 2,
				ySubmarineComputerGrid) = 2) and
				(submarineComputerSunk (xSubmarineComputerGrid,
				ySubmarineComputerGrid) = 2) or

				((submarineComputerSunk (xSubmarineComputerGrid,
				ySubmarineComputerGrid + 1) = 2) and
				(submarineComputerSunk (xSubmarineComputerGrid,
				ySubmarineComputerGrid + 2) = 2) and
				(submarineComputerSunk (xSubmarineComputerGrid,
				ySubmarineComputerGrid) = 2)) then
			    submarineComputerDestroyed := true
			    fork animate ("Explosion.GIF", xLower, yLower,
				xLower, 0, 35)
			    fork music ("MissileLaunch.WAV")
			    text (SgameStrings (21), "Calibre:12", 2.4, 1.45,
				brightred)
			else
			end if

		    elsif destroyerComputerSunk (xComputerGrid,
			    yComputerGrid) = 1 then
			%Setting grid to false showing that destroyer has been hit
			destroyerComputerSunk (xComputerGrid, yComputerGrid) := 2
			%---Checking if ship is destroyed---
			if (destroyerComputerSunk (xDestroyerComputerGrid + 1,
				yDestroyerComputerGrid) = 2) and
				(destroyerComputerSunk (xDestroyerComputerGrid,
				yDestroyerComputerGrid) = 2) or

				((destroyerComputerSunk (xDestroyerComputerGrid,
				yDestroyerComputerGrid + 1) = 2) and
				(destroyerComputerSunk (xDestroyerComputerGrid,
				yDestroyerComputerGrid) = 2)) then
			    destroyerComputerDestroyed := true
			    fork animate ("Explosion.GIF", xLower, yLower,
				xLower, 0, 35)
			    fork music ("MissileLaunch.WAV")
			    text (SgameStrings (22), "Calibre:12", 2.4, 1.5,
				brightred)
			else
			end if
		    else
		    end if
		    return %Ends procedure to let computer make a move

		    %If area was already shot at; player gets another move
		elsif computerGrid (xComputerGrid, yComputerGrid) = 2 then

		else %If it is a miss
		    %Sets grid square to show it has been shot at (2)
		    computerGrid (xComputerGrid, yComputerGrid) := 2
		    drawfillbox (xLower, yLower, xHigher, yHigher, white)
		    drawbox (xLower, yLower, xHigher, yHigher, black)
		    View.Update
		    return
		end if
	    else
	    end if

	elsif hasch then %If user wants to quit
	    getch (userKeyInput)
	    if userKeyInput = KEY_ESC then
		var windowX := (maxx div 2)
		var windowY := (maxy div 2)
		var windowConfirmation := Window.Open
		    ("graphics:410;50,nobuttonbar,nocursor")
		Window.SetPosition (windowConfirmation, windowX - 205,
		    windowY - 25)
		colourback (yellow)
		drawfillbox (0, 0, 410, 60, yellow)
		put SexitStrings (4)
		put SexitStrings (5)
		getch (userKeyInput)
		if userKeyInput = "y" or userKeyInput = "Y" then
		    Window.Close (windowConfirmation)
		    mainProcess
		else
		    Window.Close (windowConfirmation)

		end if
	    else
	    end if

	else
	end if
    end loop
end userInput

%-------COMPUTER MOVE PROCESS------------
procedure computerMove
    var xGridStart := maxx div 30
    var yGridStart := maxy div 12
    var xGrid, yGrid : int

    delay (500) %Computer "thinking"

    randint (xGrid, 1, 10) %Random row form 1 to 10
    randint (yGrid, 1, 10) %Random column form 1 to 10

    loop %Checks if grid has already been shot at; if so picks another point
	if grid (xGrid, yGrid) = 2 then
	    randint (xGrid, 1, 10)
	    randint (yGrid, 1, 10)
	else
	    exit
	end if
    end loop

    %Calculating bottom left and top right points of grid square
    var xLower := (40 * (xGrid - 1)) + xGridStart
    var yLower := 40 * (yGrid - 1) + yGridStart
    var xHigher := (40 * xGrid) + xGridStart
    var yHigher := 40 * yGrid + yGridStart

    if grid (xGrid, yGrid) = 1 then %If ship is located at shot square
	grid (xGrid, yGrid) := 2   %2 means shot at
	drawfillbox (xLower, yLower, xHigher, yHigher, brightred)
	drawbox (xLower, yLower, xHigher, yHigher, black)
	View.Update

	%--CHECKING FOR WHICH SHIP WAS HIT AND IF IT IS DESTROYED--
	if (carrierSunk (xGrid, yGrid) = 1) then
	    %Setting grid to false showing that players carrier has been hit
	    carrierSunk (xGrid, yGrid) := 2
	    %---Checking if ship is destroyed---
	    if (carrierSunk (xCarrierGrid + 1, yCarrierGrid) = 2) and
		    (carrierSunk (xCarrierGrid + 2, yCarrierGrid) = 2) and
		    (carrierSunk (xCarrierGrid + 3, yCarrierGrid) = 2) and
		    (carrierSunk (xCarrierGrid + 4, yCarrierGrid) = 2) and
		    (carrierSunk (xCarrierGrid, yCarrierGrid) = 2) or
		    ((carrierSunk (xCarrierGrid, yCarrierGrid + 1) = 2) and
		    (carrierSunk (xCarrierGrid, yCarrierGrid + 2) = 2) and
		    (carrierSunk (xCarrierGrid, yCarrierGrid + 3) = 2) and
		    (carrierSunk (xCarrierGrid, yCarrierGrid + 4) = 2) and
		    (carrierSunk (xCarrierGrid, yCarrierGrid) = 2)) then
		carrierDestroyed := true
		text (SgameStrings (18), "Calibre:12", 1.95, 1.3, brightred)
	    else
	    end if

	elsif (battleshipSunk (xGrid, yGrid) = 1) then
	    %Setting grid to false showing that players battleship has been hit
	    battleshipSunk (xGrid, yGrid) := 2
	    %---Checking if ship is destroyed---
	    if (battleshipSunk (xBattleshipGrid + 1, yBattleshipGrid) = 2) and
		    (battleshipSunk (xBattleshipGrid + 2, yBattleshipGrid) = 2)
		    and (battleshipSunk (xBattleshipGrid + 3,
		    yBattleshipGrid) = 2) and
		    (battleshipSunk (xBattleshipGrid, yBattleshipGrid) = 2) or
		    ((battleshipSunk (xBattleshipGrid,
		    yBattleshipGrid + 1) = 2) and
		    (battleshipSunk (xBattleshipGrid, yBattleshipGrid + 2) = 2)
		    and (battleshipSunk (xBattleshipGrid,
		    yBattleshipGrid + 3) = 2) and
		    (battleshipSunk (xBattleshipGrid, yBattleshipGrid) = 2)) then
		battleshipDestroyed := true
		text (SgameStrings (19), "Calibre:12", 1.95, 1.35, brightred)
	    else
	    end if

	elsif (cruiserSunk (xGrid, yGrid) = 1) then
	    %Setting grid to false showing that players cruiser has been hit
	    cruiserSunk (xGrid, yGrid) := 2
	    %---Checking if ship is destroyed---
	    if (cruiserSunk (xCruiserGrid + 1, yCruiserGrid) = 2) and
		    (cruiserSunk (xCruiserGrid + 2, yCruiserGrid) = 2) and
		    (cruiserSunk (xCruiserGrid, yCruiserGrid) = 2) or
		    ((cruiserSunk (xCruiserGrid, yCruiserGrid + 1) = 2) and
		    (cruiserSunk (xCruiserGrid, yCruiserGrid + 2) = 2) and
		    (cruiserSunk (xCruiserGrid, yCruiserGrid) = 2)) then
		cruiserDestroyed := true
		text (SgameStrings (20), "Calibre:12", 1.95, 1.4, brightred)
	    else
	    end if


	elsif (submarineSunk (xGrid, yGrid) = 1) then
	    %Setting grid to false showing that players submarine has been hit
	    submarineSunk (xGrid, yGrid) := 2
	    %---Checking if ship is destroyed---
	    if (submarineSunk (xSubmarineGrid + 1, ySubmarineGrid) = 2) and
		    (submarineSunk (xSubmarineGrid + 2, ySubmarineGrid) = 2) and
		    (submarineSunk (xSubmarineGrid, ySubmarineGrid) = 2) or
		    ((submarineSunk (xSubmarineGrid, ySubmarineGrid + 1) = 2) and
		    (submarineSunk (xSubmarineGrid, ySubmarineGrid + 2) = 2) and
		    (submarineSunk (xSubmarineGrid, ySubmarineGrid) = 2)) then
		submarineDestroyed := true
		text (SgameStrings (21), "Calibre:12", 1.95, 1.45, brightred)
	    else
	    end if

	elsif (destroyerSunk (xGrid, yGrid) = 1) then
	    %Setting grid to false showing that players destroyer has been hit
	    destroyerSunk (xGrid, yGrid) := 2
	    %---Checking if ship is destroyed---
	    if (destroyerSunk (xDestroyerGrid + 1, yDestroyerGrid) = 2) and
		    (destroyerSunk (xDestroyerGrid, yDestroyerGrid) = 2) or
		    ((destroyerSunk (xDestroyerGrid, yDestroyerGrid + 1) = 2) and
		    (destroyerSunk (xDestroyerGrid, yDestroyerGrid) = 2)) then
		destroyerDestroyed := true
		text (SgameStrings (22), "Calibre:12", 1.95, 1.5, brightred)
	    else
	    end if
	else
	end if

    else %If there is no ship where computer shot at
	grid (xGrid, yGrid) := 2 %Sets square to shot at
	drawfillbox (xLower, yLower, xHigher, yHigher, white)
	drawbox (xLower, yLower, xHigher, yHigher, black)
	View.Update
    end if
end computerMove


procedure mainGame
    View.Set ("offscreenonly")
    var userKeyInput : string (1)
    var computerWin, playerWin : boolean := false
    var xMouse, yMouse, button : int


    loop
	Mouse.Where (xMouse, yMouse, button)
	%ERROR TRAP; ensures button is unclicked before proceeding.
	if button = 0 then
	    exit
	else
	end if
    end loop
    mainGameScreen
    View.Update

    loop
	%Only continues game is no won has won yet
	if computerWin = false and playerWin = false then

	    userInput

	    computerMove
	else
	end if
	%Checks to see if all ships of either CPU or user are destroyed
	if (carrierDestroyed = true) and (battleshipDestroyed = true)
		and (cruiserDestroyed = true) and (submarineDestroyed = true)
		and (destroyerDestroyed = true) then

	    text (SgameStrings (7), "Impact:25", 0, 1.5, brightred)
	    View.Update
	    exit
	elsif (carrierComputerDestroyed = true) and
		(battleshipComputerDestroyed = true) and
		(cruiserComputerDestroyed = true) and
		(submarineComputerDestroyed = true) and
		(destroyerComputerDestroyed = true) then
	    text (SgameStrings (8), "Impact:25", 0, 1.5, brightgreen)
	    View.Update
	    exit
	else
	end if
    end loop

    %IF GAME IS OVER EXITS OUT OF LOOP AND GIVES FURTHER OPTIONS
    %----RESETS ALL GAME SETTINGS TO FALSE----
    carrierDestroyed := false
    battleshipDestroyed := false
    cruiserDestroyed := false
    submarineDestroyed := false
    destroyerDestroyed := false

    %Computer version of above variables
    carrierComputerDestroyed := false
    battleshipComputerDestroyed := false
    cruiserComputerDestroyed := false
    submarineComputerDestroyed := false
    destroyerComputerDestroyed := false

    setscreen ("nooffscreenonly")
    text (SgameStrings (9), "Impact:20", 0, 1.6, 41)
    text (SmainStrings (5), "Impact:20", 0, 1.7, 41)

    var font := Font.New ("Impact:20")

    var buttonXNameOne := Font.Width (SgameStrings (9), font)
    var buttonXNameTwo := Font.Width (SmainStrings (5), font)

    var xButtonBeginOne := (maxx div 2 - buttonXNameOne div 2)
    var xButtonBeginTwo := (maxx div 2 - buttonXNameTwo div 2)

    var xButtonEndOne := (maxx div 2 + buttonXNameOne div 2)
    var xButtonEndTwo := (maxx div 2 + buttonXNameTwo div 2)

    loop
	Mouse.Where (xMouse, yMouse, button)
	%Checks for correct x and y values
	if (xMouse >= xButtonBeginOne) and (xMouse <= xButtonEndOne)
		and (yMouse >= (maxy div 1.6)) and
		(yMouse <= (maxy div 1.55)) then
	    text (SgameStrings (9), "Impact:20", 0, 1.6, black)
	    if button = 1 then
		mainProcess         %To go back to main screen
		return
	    else
	    end if

	    %Checks for correct x and y values
	elsif (xMouse >= xButtonBeginTwo) and (xMouse <= xButtonEndTwo)
		and (yMouse >= (maxy div 1.7)) and
		(yMouse <= (maxy div 1.65)) then
	    text (SmainStrings (5), "Impact:20", 0, 1.7, black)
	    if button = 1 then
		goodBye         %To exit
		return
	    else
	    end if

	else
	    text (SgameStrings (9), "Impact:20", 0, 1.6, 41)
	    text (SmainStrings (5), "Impact:20", 0, 1.7, 41)
	end if
    end loop
end mainGame


procedure shipPlacementCheck (carrier, battleship, cruiser,
	submarine, destroyer : int)
    if carrier = 1 then
	%Carrier placement check
	if carrierPlaced = true then
	    picture (carrierFile, xCarrierMouse, yCarrierMouse, 0, 0)
	else
	    carrierFile := "Carrier.GIF"
	    picture (carrierFile, maxx div 1.8, maxy div 4, 0, 0)
	end if
    end if

    if battleship = 1 then
	%Battleship placement check
	if battleshipPlaced = true then
	    picture (battleshipFile, xBattleshipMouse, yBattleshipMouse, 0, 0)
	else
	    battleshipFile := "Battleship.GIF"
	    picture (battleshipFile, maxx div 1.5, maxy div 3, 0, 0)
	end if
    end if

    if cruiser = 1 then
	%Crusier placement check
	if cruiserPlaced = true then
	    picture (cruiserFile, xCruiserMouse, yCruiserMouse, 0, 0)
	else
	    cruiserFile := "Cruiser.GIF"
	    picture (cruiserFile, maxx div 1.25, maxy div 3, 0, 0)
	end if
    end if

    if submarine = 1 then
	%Submarine placement check
	if submarinePlaced = true then
	    picture (submarineFile, xSubmarineMouse, ySubmarineMouse, 0, 0)
	else
	    submarineFile := "Submarine.GIF"
	    picture (submarineFile, maxx div 1.5, maxy div 10, 0, 0)
	end if
    end if

    if destroyer = 1 then
	%Destroyer placement check
	if destroyerPlaced = true then
	    picture (destroyerFile, xDestroyerMouse, yDestroyerMouse, 0, 0)
	else
	    destroyerFile := "Destroyer.GIF"
	    picture (destroyerFile, maxx div 1.25, maxy div 6, 0, 0)
	end if
    end if
end shipPlacementCheck


%--------PLACING SHIPS AND GENERATING COMPUTER SHIPS-------------
procedure gamePlanning
    var xGridStart := maxx div 30
    var yGridStart := maxy div 12
    var xComputerGrid, yComputerGrid : int
    var xMouse, yMouse, button : int
    carrierPlaced := false
    battleshipPlaced := false
    cruiserPlaced := false
    submarinePlaced := false
    destroyerPlaced := false

    %Initializing variables to false
    for x : 1 .. 10
	for y : 1 .. 10
	    grid (x, y) := 0
	end for
    end for

    %Initializing variables to false
    for x : 1 .. 15
	for y : 1 .. 15
	    carrierSunk (x, y) := 0
	    battleshipSunk (x, y) := 0
	    cruiserSunk (x, y) := 0
	    submarineSunk (x, y) := 0
	    destroyerSunk (x, y) := 0

	    carrierComputerSunk (x, y) := 0
	    battleshipComputerSunk (x, y) := 0
	    cruiserComputerSunk (x, y) := 0
	    submarineComputerSunk (x, y) := 0
	    destroyerComputerSunk (x, y) := 0
	end for
    end for

    %ERROR TRAP ENSURES BUTTON IS UNCLICKED
    loop
	Mouse.Where (xMouse, yMouse, button)
	if button = 0 then
	    exit
	else
	end if
    end loop

    var userKeyInput : string (1)
    View.Set ("offscreenonly")
    Mouse.ButtonChoose ("multibutton")

    planningScreen (1, 1, 1, 1, 1)
    View.Update

    loop
	Mouse.Where (xMouse, yMouse, button)

	%---------------------- FOR CARRIER PLACEMENT -----------------
	if (xMouse > (maxx div 1.8)) and (xMouse < (maxx div 1.7)) and
		(yMouse > (maxy div 4)) and (yMouse < (maxy div 2.2)) then
	    %Only proceeds if carrier has not been placed
	    if carrierPlaced = false then

		%Depending on click ship rotates
		if button = 1 or button = 100 then
		    if button = 1 then
			carrierFile := "Carrier.GIF"
		    else
			carrierFile := "CarrierRotated.Gif"
		    end if
		    loop
			Mouse.Where (xMouse, yMouse, button)
			%Moves carrier according to mouse
			picture (carrierFile, xMouse, yMouse, 0, 0)
			View.Update
			cls
			planningScreen (0, 0, 0, 0, 0)
			shipPlacementCheck (0, 1, 1, 1, 1)
			View.Update
			if button = 0 then %Once button is unclicked ship drops
			    %Anything outside grid, does not count.
			    if (xMouse > (450 + xGridStart)) or
				    (xMouse < xGridStart) or (yMouse > (450 +
				    yGridStart)) or (yMouse < yGridStart) then
				planningScreen (1, 0, 0, 0, 0)
				shipPlacementCheck (0, 1, 1, 1, 1)

				View.Update
				exit
			    else
				%Rounds to nearest 40th
				var xRound := (floor ((xMouse - xGridStart)
				    / 40)) * 40
				%Rounds to nearest 40th
				var yRound := (floor ((yMouse - yGridStart)
				    / 40)) * 40
				%Calculates row number
				var xGrid := round ((xRound / 40) + 1)
				%Calculates Column number
				var yGrid := round ((yRound / 40) + 1)

				%ERROR TRAP ENSURES SQUARE >10 IS NOT SELECTED
				if xGrid > 10 then
				    xGrid := 10
				else
				end if

				%ERROR TRAP; If part of carrier is
				%placed outside sets it to lower area
				if carrierFile = "Carrier.GIF" then
				    if yGrid > 6 then
					yGrid := 6
				    elsif xGrid > 10 then
					xGrid := 10
				    elsif xGrid > 10 and yGrid > 6 then
					xGrid := 10
					yGrid := 6
				    end if

				    %ERROR TRAP; ensures ships do not overlap
				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid, yGrid + 1)) = 1 or
					    (grid (xGrid, yGrid + 2)) = 1 or
					    (grid (xGrid, yGrid + 3)) = 1 or
					    (grid (xGrid, yGrid + 4)) = 1 then

					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					carrierFile := "Carrier.GIF"
					picture (carrierFile, maxx div 1.8,
					    maxy div 4, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %For identifying specific ships
				    xCarrierGrid := xGrid
				    yCarrierGrid := yGrid

				    for counter : 0 .. 4
					%Setting grid to "1" meaning ship is there
					grid (xGrid, yGrid + counter) := 1
					carrierSunk (xCarrierGrid, yCarrierGrid
					    + counter) := 1
				    end for

				else %Same as above; difference is ship is horizontal
				    if yGrid > 10 then
					yGrid := 10
				    elsif xGrid > 6 then
					xGrid := 6
				    elsif xGrid > 6 and yGrid > 10 then
					xGrid := 6
					yGrid := 10
				    end if

				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid + 1, yGrid)) = 1 or
					    (grid (xGrid + 2, yGrid)) = 1 or
					    (grid (xGrid + 3, yGrid)) = 1 or
					    (grid (xGrid + 4, yGrid)) = 1 then

					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					carrierFile := "Carrier.GIF"
					picture (carrierFile, maxx div 1.8,
					    maxy div 4, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %For identifying specific ships
				    xCarrierGrid := xGrid
				    yCarrierGrid := yGrid

				    for counter : 0 .. 4
					%Adds to x value not y (unlike above)
					grid (xGrid + counter, yGrid) := 1
					carrierSunk (xCarrierGrid + counter,
					    yCarrierGrid) := 1
				    end for
				end if

				xCarrierMouse := (40 * (xGrid - 1)) + xGridStart
				yCarrierMouse := (40 * (yGrid - 1)) + yGridStart
				%Saving postion user placed ship
				picture (carrierFile, xCarrierMouse,
				    yCarrierMouse, 0, 0)
				View.Update
				carrierPlaced := true
				exit
			    end if
			else
			end if
		    end loop
		else
		end if
	    else
	    end if

	    %------------------- FOR BATTLESHIP PLACEMENT ---------------
	elsif (xMouse > (maxx div 1.5)) and (xMouse < (maxx div 1.45)) and
		(yMouse > (maxy div 3)) and (yMouse < (maxy div 2.08)) then
	    %Only proceeds if battleship has not been placed
	    if battleshipPlaced = false then
		%Depending on click ship rotates
		if button = 1 or button = 100 then
		    if button = 1 then
			battleshipFile := "Battleship.GIF"
		    else
			battleshipFile := "BattleshipRotated.GIF"
		    end if
		    loop
			Mouse.Where (xMouse, yMouse, button)
			picture (battleshipFile, xMouse, yMouse, 0, 0)
			View.Update
			cls
			planningScreen (0, 0, 0, 0, 0)
			shipPlacementCheck (1, 0, 1, 1, 1)

			View.Update
			%Once button is unclicked ship drops off
			if button = 0 then
			    %Anything outside grid, does not count.
			    if (xMouse > (450 + xGridStart)) or (xMouse <
				    xGridStart) or (yMouse > (450 +
				    yGridStart)) or (yMouse < yGridStart) then
				planningScreen (0, 1, 0, 0, 0)
				shipPlacementCheck (1, 0, 1, 1, 1)

				View.Update
				exit
			    else
				%Rounds to nearest 40th
				var xRound := (floor ((xMouse - xGridStart)
				    / 40)) * 40
				%Rounds to nearest 40th
				var yRound := (floor ((yMouse - yGridStart)
				    / 40)) * 40
				%Calculates row number
				var xGrid := round ((xRound / 40) + 1)
				%Calculates Column number
				var yGrid := round ((yRound / 40) + 1)

				%ERROR TRAP ENSURES SQUARE >10 IS NOT SELECTED
				if xGrid > 10 then
				    xGrid := 10
				    xBattleshipGrid := 10
				else
				end if

				%ERROR TRAP; If part of battleship is
				%placed outside sets it to lower area
				if battleshipFile = "Battleship.GIF" then
				    if yGrid > 7 then
					yGrid := 7
				    elsif xGrid > 10 then
					xGrid := 10
				    elsif xGrid > 10 and yGrid > 7 then
					xGrid := 10
					yGrid := 7
				    end if

				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid, yGrid + 1)) = 1 or
					    (grid (xGrid, yGrid + 2)) = 1 or
					    (grid (xGrid, yGrid + 3)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					battleshipFile := "Battleship.GIF"
					picture (battleshipFile, maxx div 1.5,
					    maxy div 3, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %For identifying specific ships
				    xBattleshipGrid := xGrid
				    yBattleshipGrid := yGrid

				    for counter : 0 .. 3
					%Setting grid to "1" meaning ship is there
					grid (xGrid, yGrid + counter) := 1
					battleshipSunk (xBattleshipGrid,
					    yBattleshipGrid + counter) := 1
				    end for

				else  %If ship is horizontal
				    if yGrid > 10 then
					yGrid := 10
				    elsif xGrid > 7 then
					xGrid := 7
				    elsif xGrid > 7 and yGrid > 10 then
					xGrid := 7
					yGrid := 10
				    end if

				    %ERROR TRAP; ensures ships do not overlap
				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid + 1, yGrid)) = 1
					    or (grid (xGrid + 2, yGrid)) = 1 or
					    (grid (xGrid + 3, yGrid)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					battleshipFile := "Battleship.GIF"
					picture (battleshipFile, maxx div 1.5,
					    maxy div 3, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %For identifying specific ships
				    xBattleshipGrid := xGrid
				    yBattleshipGrid := yGrid

				    for counter : 0 .. 3
					%Adds to x value not y (unlike above)
					grid (xGrid + counter, yGrid) := 1
					battleshipSunk (xBattleshipGrid +
					    counter, yBattleshipGrid) := 1
				    end for

				end if

				xBattleshipMouse := (40 * (xGrid - 1))
				    + xGridStart
				yBattleshipMouse := (40 * (yGrid - 1))
				    + yGridStart
				%Saving postion user placed ship
				picture (battleshipFile, xBattleshipMouse,
				    yBattleshipMouse, 0, 0)
				View.Update
				battleshipPlaced := true
				exit
			    end if
			else
			end if
		    end loop
		else
		end if
	    else
	    end if

	    %------------------- FOR CRUISER PLACEMENT ---------------
	elsif (xMouse > (maxx div 1.25)) and (xMouse < (maxx div 1.21)) and
		(yMouse > (maxy div 3)) and (yMouse < (maxy div 2.2)) then
	    %Only proceeds if cruiser has not been placed
	    if cruiserPlaced = false then
		%Depending on click ship rotates
		if button = 1 or button = 100 then
		    if button = 1 then
			cruiserFile := "Cruiser.GIF"
		    else
			cruiserFile := "CruiserRotated.GIF"
		    end if
		    loop
			Mouse.Where (xMouse, yMouse, button)
			picture (cruiserFile, xMouse, yMouse, 0, 0)
			View.Update
			cls
			planningScreen (0, 0, 0, 0, 0)
			shipPlacementCheck (1, 1, 0, 1, 1)
			View.Update

			%Once button is unclicked ship drops off
			if button = 0 then
			    %Anything outside grid, does not count.
			    if (xMouse > (450 + xGridStart)) or
				    (xMouse < xGridStart) or
				    (yMouse > (450 + yGridStart))
				    or (yMouse < yGridStart) then
				planningScreen (0, 0, 1, 0, 0)
				shipPlacementCheck (1, 1, 0, 1, 1)
				View.Update
				exit

			    else
				%Rounds to nearest 40th
				var xRound := (floor ((xMouse - xGridStart)
				    / 40)) * 40
				%Rounds to nearest 40th
				var yRound := (floor ((yMouse - yGridStart)
				    / 40)) * 40
				%Calculates row number
				var xGrid := round ((xRound / 40) + 1)
				%Calculates Column number
				var yGrid := round ((yRound / 40) + 1)

				%ERROR TRAP ENSURES SQUARE >10 IS NOT SELECTED
				if xGrid > 10 then
				    xGrid := 10
				    xCruiserGrid := 10
				else
				end if


				if cruiserFile = "Cruiser.GIF" then

				    %ERROR TRAP; If part of cruiser is
				    %placed outside sets it to lower area
				    if yGrid > 8 then
					yGrid := 8
				    elsif xGrid > 10 then
					xGrid := 10
				    elsif xGrid > 10 and yGrid > 8 then
					xGrid := 10
					yGrid := 8
				    end if

				    %ERROR TRAP; ensures ships do not overlap
				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid, yGrid + 1)) = 1 or
					    (grid (xGrid, yGrid + 2)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					cruiserFile := "Cruiser.GIF"
					picture (cruiserFile, maxx div 1.25,
					    maxy div 3, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %For identifying specific ships
				    xCruiserGrid := xGrid
				    yCruiserGrid := yGrid

				    for counter : 0 .. 2
					%Adds to x value not y (unlike above)
					grid (xGrid, yGrid + counter) := 1
					cruiserSunk (xCruiserGrid, yCruiserGrid
					    + counter) := 1
				    end for

				else  %If ship is horizontal
				    if yGrid > 10 then
					yGrid := 10
				    elsif xGrid > 8 then
					xGrid := 8
				    elsif xGrid > 8 and yGrid > 10 then
					xGrid := 8
					yGrid := 10
				    end if

				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid + 1, yGrid)) = 1 or
					    (grid (xGrid + 2, yGrid)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					cruiserFile := "Cruiser.GIF"
					picture (cruiserFile, maxx div 1.25,
					    maxy div 3, 0, 0)
					View.Update
					exit
				    else
				    end if
				    %For identifying specific ships
				    xCruiserGrid := xGrid
				    yCruiserGrid := yGrid

				    for counter : 0 .. 2
					%Adds to x value not y (unlike above)
					grid (xGrid + counter, yGrid) := 1
					cruiserSunk (xCruiserGrid + counter,
					    yCruiserGrid) := 1
				    end for

				end if

				xCruiserMouse := (40 * (xGrid - 1)) +
				    xGridStart
				yCruiserMouse := (40 * (yGrid - 1)) +
				    yGridStart
				%Saving postion user placed ship
				picture (cruiserFile, xCruiserMouse,
				    yCruiserMouse, 0, 0)
				View.Update
				cruiserPlaced := true
				exit
			    end if
			else
			end if
		    end loop
		else
		end if
	    else
	    end if

	    %------------------- FOR SUBMARINE PLACEMENT ---------------
	elsif (xMouse > (maxx div 1.5)) and (xMouse < (maxx div 1.45)) and
		(yMouse > (maxy div 10)) and (yMouse < (maxy div 4)) then
	    %Only proceeds if submarin has not been placed
	    if submarinePlaced = false then
		if button = 1 or button = 100 then
		    %Depending on click ship rotates
		    if button = 1 then
			submarineFile := "Submarine.GIF"
		    else
			submarineFile := "SubmarineRotated.GIF"
		    end if
		    loop
			Mouse.Where (xMouse, yMouse, button)
			picture (submarineFile, xMouse, yMouse, 0, 0)
			View.Update
			cls
			planningScreen (0, 0, 0, 0, 0)
			shipPlacementCheck (1, 1, 1, 0, 1)
			View.Update

			%Once button is unclicked ship drops off
			if button = 0 then
			    %Anything outside grid, does not count.
			    if (xMouse > (450 + xGridStart)) or
				    (xMouse < xGridStart) or
				    (yMouse > (450 + yGridStart))
				    or (yMouse < yGridStart) then
				planningScreen (0, 0, 0, 1, 0)
				shipPlacementCheck (1, 1, 1, 0, 1)
				View.Update
				exit

			    else
				%Rounds to nearest 40th
				var xRound := (floor ((xMouse - xGridStart)
				    / 40)) * 40
				%Rounds to nearest 40th
				var yRound := (floor ((yMouse - yGridStart)
				    / 40)) * 40
				%Calculates row number
				var xGrid := round ((xRound / 40) + 1)
				%Calculates Column number
				var yGrid := round ((yRound / 40) + 1)

				%ERROR TRAP ENSURES SQUARE >10 IS NOT SELECTED
				if xGrid > 10 then
				    xGrid := 10
				    xSubmarineGrid := 10
				else
				end if

				%ERROR TRAP; If part of submarine is
				%placed outside sets it to lower area
				if submarineFile = "Submarine.GIF" then
				    if yGrid > 8 then
					yGrid := 8
				    elsif xGrid > 10 then
					xGrid := 10
				    elsif xGrid > 10 and yGrid > 8 then
					xGrid := 10
					yGrid := 8
				    end if

				    %ERROR TRAP; ensures ships do not overlap
				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid, yGrid + 1)) = 1 or
					    (grid (xGrid, yGrid + 2)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					submarineFile := "Submarine.GIF"
					picture (submarineFile, maxx div 1.5,
					    maxy div 10, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %For identifying specific ships
				    xSubmarineGrid := xGrid
				    ySubmarineGrid := yGrid

				    for counter : 0 .. 2
					%Setting grid to "1" meaning ship is there
					grid (xGrid, yGrid + counter) := 1
					submarineSunk (xSubmarineGrid,
					    ySubmarineGrid + counter) := 1
				    end for

				else  %If ship is horizontal
				    if yGrid > 10 then
					yGrid := 10
				    elsif xGrid > 8 then
					xGrid := 8
				    elsif xGrid > 8 and yGrid > 10 then
					xGrid := 8
					yGrid := 10
				    end if

				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid + 1, yGrid)) = 1 or
					    (grid (xGrid + 2, yGrid)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					submarineFile := "Submarine.GIF"
					picture (submarineFile, maxx div 1.5,
					    maxy div 10, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %For identifying specific ships
				    xSubmarineGrid := xGrid
				    ySubmarineGrid := yGrid

				    for counter : 0 .. 2
					%Setting grid to "1" meaning ship is there
					grid (xGrid + counter, yGrid) := 1
					submarineSunk (xSubmarineGrid +
					    counter, ySubmarineGrid) := 1
				    end for

				end if

				xSubmarineMouse := (40 * (xGrid - 1))
				    + xGridStart
				ySubmarineMouse := (40 * (yGrid - 1))
				    + yGridStart
				%Saving postion user placed ship
				picture (submarineFile, xSubmarineMouse,
				    ySubmarineMouse, 0, 0)
				View.Update
				submarinePlaced := true
				exit
			    end if
			else
			end if
		    end loop
		else
		end if
	    else
	    end if

	    %------------------- FOR DESTROYER PLACEMENT ---------------
	elsif (xMouse > (maxx div 1.25)) and (xMouse < (maxx div 1.22)) and
		(yMouse > (maxy div 6)) and (yMouse < (maxy div 4.4)) then
	    %Only proceeds if destroyer has not been placed
	    if destroyerPlaced = false then
		%Depending on click ship rotates
		if button = 1 or button = 100 then
		    if button = 1 then
			destroyerFile := "Destroyer.GIF"
		    else
			destroyerFile := "DestroyerRotated.GIF"
		    end if
		    loop
			Mouse.Where (xMouse, yMouse, button)
			picture (destroyerFile, xMouse, yMouse, 0, 0)
			View.Update
			cls
			planningScreen (0, 0, 0, 0, 0)
			shipPlacementCheck (1, 1, 1, 1, 0)
			View.Update

			%Once button is unclicked ship drops off
			if button = 0 then
			    %Anything outside grid, does not count.
			    if (xMouse > (450 + xGridStart)) or
				    (xMouse < xGridStart) or
				    (yMouse > (450 + yGridStart)) or
				    (yMouse < yGridStart) then
				planningScreen (0, 0, 0, 0, 1)
				shipPlacementCheck (1, 1, 1, 1, 0)

				View.Update
				exit
			    else
				%Rounds to nearest 40th
				var xRound := (floor ((xMouse - xGridStart)
				    / 40)) * 40
				%Rounds to nearest 40th
				var yRound := (floor ((yMouse - yGridStart)
				    / 40)) * 40
				%Calculates row number
				var xGrid := round ((xRound / 40) + 1)
				%Calculates Column number
				var yGrid := round ((yRound / 40) + 1)

				%ERROR TRAP ENSURES SQUARE >10 IS NOT SELECTED
				if xGrid > 10 then
				    xGrid := 10
				    xDestroyerGrid := 10
				else
				end if


				if destroyerFile = "Destroyer.GIF" then
				    if yGrid > 9 then
					yGrid := 9
				    elsif xGrid > 10 then
					xGrid := 10
				    elsif xGrid > 10 and yGrid > 9 then
					xGrid := 10
					yGrid := 9
				    end if

				    %ERROR TRAP; ensures ships do not overlap
				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid, yGrid + 1)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					destroyerFile := "Destroyer.GIF"
					picture (destroyerFile, maxx div 1.25,
					    maxy div 6, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %Setting grid to "1" meaning ship is there
				    grid (xGrid, yGrid) := 1
				    grid (xGrid, yGrid + 1) := 1

				    %For identifying specific ships
				    xDestroyerGrid := xGrid
				    yDestroyerGrid := yGrid

				    destroyerSunk (xDestroyerGrid,
					yDestroyerGrid) := 1
				    destroyerSunk (xDestroyerGrid,
					yDestroyerGrid + 1) := 1

				else  %If ship is horizontal
				    if yGrid > 10 then
					yGrid := 10
				    elsif xGrid > 9 then
					xGrid := 9
				    elsif xGrid > 9 and yGrid > 10 then
					xGrid := 9
					yGrid := 10
				    end if

				    if (grid (xGrid, yGrid)) = 1 or
					    (grid (xGrid + 1, yGrid)) = 1 then
					text (SgameStrings (6), "Impact:25", 0,
					    2, brightred)
					destroyerFile := "Destroyer.GIF"
					picture (destroyerFile, maxx div 1.25,
					    maxy div 6, 0, 0)
					View.Update
					exit
				    else
				    end if

				    %Adds to x value not y (unlike above)
				    grid (xGrid, yGrid) := 1
				    grid (xGrid + 1, yGrid) := 1

				    %For identifying specific ships
				    xDestroyerGrid := xGrid
				    yDestroyerGrid := yGrid

				    destroyerSunk (xDestroyerGrid,
					yDestroyerGrid) := 1
				    destroyerSunk (xDestroyerGrid + 1,
					yDestroyerGrid) := 1
				end if



				xDestroyerMouse := (40 * (xGrid - 1))
				    + xGridStart
				yDestroyerMouse := (40 * (yGrid - 1))
				    + yGridStart
				%Saving postion user placed ship
				picture (destroyerFile, xDestroyerMouse,
				    yDestroyerMouse, 0, 0)
				View.Update
				destroyerPlaced := true
				exit
			    end if
			else
			end if
		    end loop
		else
		end if
	    else
	    end if

	    %------TO EXIT GAME PLANNING OR RESTART------
	elsif hasch then
	    getch (userKeyInput)
	    if userKeyInput = KEY_ESC then
		mainProcess
	    elsif userKeyInput = "c" or userKeyInput = "C" then
		for x : 1 .. 10
		    for y : 1 .. 10
			grid (x, y) := 0  %Initializing grid array
		    end for
		end for
		%Setting all placements to false
		carrierPlaced := false
		battleshipPlaced := false
		cruiserPlaced := false
		submarinePlaced := false
		destroyerPlaced := false
		planningScreen (1, 1, 1, 1, 1)
		View.Update
		View.Set ("offscreenonly")
	    else
	    end if

	    %------------TO MOVE ONTO THE FINAL PART OF GAME-----------
	elsif carrierPlaced = true and battleshipPlaced = true
		and cruiserPlaced = true and submarinePlaced = true and
		destroyerPlaced = true then  %Continues if all ships placed
	    setscreen ("nooffscreenonly")
	    text (SgameStrings (2), "Impact:30", 0, 50, 0)

	    var font := Font.New ("Impact:30")
	    var buttonXName := Font.Width (SgameStrings (2), font)
	    var xButtonBegin := (maxx div 2 - buttonXName div 2)
	    var xButtonEnd := (maxx div 2 + buttonXName div 2)
	    %Checks for correct x and y values
	    if (xMouse > xButtonBegin) and (xMouse < xButtonEnd) and
		    (yMouse > (maxy div 75)) and (yMouse < (maxy div 16)) then
		text (SgameStrings (2), "Impact:30", 0, 50, black)
		if button = 1 then

		    %------------------------COMPUTER SHIPS--------------------
		    var orientation : int
		    for x : 1 .. 10
			for y : 1 .. 10
			    %Initializing grid array to ship not placed
			    computerGrid (x, y) := 0
			end for
		    end for

		    %----------------------------CARRIER-----------------------
		    randint (orientation, 0, 1)

		    if orientation = 0 then %Horizontal placement
			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 6)
			randint (yComputerGrid, 1, 10)

			%Ship specific coordinates
			xCarrierComputerGrid := xComputerGrid
			yCarrierComputerGrid := yComputerGrid

			for counter : 0 .. 4
			    computerGrid (xComputerGrid + counter,
				yComputerGrid) := 1
			    carrierComputerSunk (xCarrierComputerGrid +
				counter, yCarrierComputerGrid) := 1
			end for

		    else  %Vertical placement
			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 10)
			randint (yComputerGrid, 1, 6)

			%Ship specific coordinates
			xCarrierComputerGrid := xComputerGrid
			yCarrierComputerGrid := yComputerGrid

			for counter : 0 .. 4
			    computerGrid (xComputerGrid, yComputerGrid +
				counter) := 1
			    carrierComputerSunk (xCarrierComputerGrid,
				yCarrierComputerGrid + counter) := 1
			end for
		    end if

		    %-----------------------BATTLESHIP-----------------
		    randint (orientation, 0, 1)

		    if orientation = 0 then %Horizontal placement

			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 7)
			randint (yComputerGrid, 1, 10)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid + 1,
				    yComputerGrid)) = 1
				    or (computerGrid (xComputerGrid + 2,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid + 3,
				    yComputerGrid)) = 1 then
				randint (xComputerGrid, 1, 7)
				randint (yComputerGrid, 1, 10)
			    else
				exit
			    end if
			end loop

			%Ship specific coordinates
			xBattleshipComputerGrid := xComputerGrid
			yBattleshipComputerGrid := yComputerGrid

			for counter : 0 .. 3
			    computerGrid (xComputerGrid + counter,
				yComputerGrid) := 1
			    battleshipComputerSunk (xBattleshipComputerGrid
				+ counter, yBattleshipComputerGrid) := 1
			end for

		    else         %Vertical placement

			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 10)
			randint (yComputerGrid, 1, 7)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid,
				    yComputerGrid + 1)) = 1
				    or (computerGrid (xComputerGrid,
				    yComputerGrid + 2)) = 1 or
				    (computerGrid (xComputerGrid,
				    yComputerGrid + 3)) = 1 then
				randint (xComputerGrid, 1, 10)
				randint (yComputerGrid, 1, 7)
			    else
				exit
			    end if
			end loop

			%Ship specific coordinates
			xBattleshipComputerGrid := xComputerGrid
			yBattleshipComputerGrid := yComputerGrid

			for counter : 0 .. 3
			    computerGrid (xComputerGrid, yComputerGrid
				+ counter) := 1
			    battleshipComputerSunk (xBattleshipComputerGrid,
				yBattleshipComputerGrid + counter) := 1
			end for
		    end if

		    %------------------------------CRUISER---------------------
		    randint (orientation, 0, 1)

		    if orientation = 0 then         %Horizontal placement

			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 8)
			randint (yComputerGrid, 1, 10)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid + 1,
				    yComputerGrid)) = 1
				    or (computerGrid (xComputerGrid + 2,
				    yComputerGrid)) = 1 then
				randint (xComputerGrid, 1, 8)
				randint (yComputerGrid, 1, 10)
			    else
			    end if
			    exit when (computerGrid (xComputerGrid,
				yComputerGrid)) = 0 and
				(computerGrid (xComputerGrid + 1,
				yComputerGrid)) = 0
				and (computerGrid (xComputerGrid + 2,
				yComputerGrid)) = 0
			end loop

			%Ship specific coordinates
			xCruiserComputerGrid := xComputerGrid
			yCruiserComputerGrid := yComputerGrid

			for counter : 0 .. 2
			    computerGrid (xComputerGrid + counter,
				yComputerGrid) := 1
			    cruiserComputerSunk (xCruiserComputerGrid +
				counter, yCruiserComputerGrid) := 1
			end for

		    else         %Vertical placement

			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 10)
			randint (yComputerGrid, 1, 8)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid,
				    yComputerGrid + 1)) = 1
				    or (computerGrid (xComputerGrid,
				    yComputerGrid + 2)) = 1 then
				randint (xComputerGrid, 1, 10)
				randint (yComputerGrid, 1, 8)
			    else
			    end if
			    exit when (computerGrid (xComputerGrid,
				yComputerGrid)) = 0 and
				(computerGrid (xComputerGrid,
				yComputerGrid + 1)) = 0
				and (computerGrid (xComputerGrid,
				yComputerGrid + 2)) = 0
			end loop

			%Ship specific coordinates
			xCruiserComputerGrid := xComputerGrid
			yCruiserComputerGrid := yComputerGrid

			for counter : 0 .. 2
			    computerGrid (xComputerGrid, yComputerGrid
				+ counter) := 1
			    cruiserComputerSunk (xCruiserComputerGrid,
				yCruiserComputerGrid + counter) := 1
			end for

		    end if

		    %-----------------------------SUBMARINE----------------------
		    randint (orientation, 0, 1)
		    randint (xComputerGrid, 1, 8)
		    randint (yComputerGrid, 1, 10)

		    if orientation = 0 then  %Horizontal placement

			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 8)
			randint (yComputerGrid, 1, 10)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid + 1,
				    yComputerGrid)) = 1
				    or (computerGrid (xComputerGrid + 2,
				    yComputerGrid)) = 1 then
				randint (xComputerGrid, 1, 8)
				randint (yComputerGrid, 1, 10)
			    else
			    end if
			    exit when (computerGrid (xComputerGrid,
				yComputerGrid)) = 0 and
				(computerGrid (xComputerGrid + 1,
				yComputerGrid)) = 0
				and (computerGrid (xComputerGrid + 2,
				yComputerGrid)) = 0
			end loop
			%Ship specific coordinates
			xSubmarineComputerGrid := xComputerGrid
			ySubmarineComputerGrid := yComputerGrid

			for counter : 0 .. 2
			    computerGrid (xComputerGrid + counter,
				yComputerGrid) := 1
			    submarineComputerSunk (xSubmarineComputerGrid
				+ counter, ySubmarineComputerGrid) := 1
			end for

		    else         %Vertical placement

			%Dosent allow for extended ships out of grid
			randint (xComputerGrid, 1, 10)
			randint (yComputerGrid, 1, 8)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid,
				    yComputerGrid + 1)) = 1
				    or (computerGrid (xComputerGrid,
				    yComputerGrid + 2)) = 1 then
				randint (xComputerGrid, 1, 10)
				randint (yComputerGrid, 1, 8)
			    else
			    end if
			    exit when (computerGrid (xComputerGrid,
				yComputerGrid)) = 0 and
				(computerGrid (xComputerGrid,
				yComputerGrid + 1)) = 0
				and (computerGrid (xComputerGrid,
				yComputerGrid + 2)) = 0
			end loop
			%Ship specific coordinates
			xSubmarineComputerGrid := xComputerGrid
			ySubmarineComputerGrid := yComputerGrid

			for counter : 0 .. 2
			    computerGrid (xComputerGrid, yComputerGrid
				+ counter) := 1
			    submarineComputerSunk (xSubmarineComputerGrid,
				ySubmarineComputerGrid + counter) := 1
			end for

		    end if

		    %----------------------------DESTROYER---------------------
		    randint (orientation, 0, 1)
		    if orientation = 0 then         %Horizontal placement
			%Does no allow for placement outside grid
			randint (xComputerGrid, 1, 9)
			randint (yComputerGrid, 1, 10)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid + 1,
				    yComputerGrid)) = 1 then
				randint (xComputerGrid, 1, 9)
				randint (yComputerGrid, 1, 10)
			    else
			    end if
			    exit when (computerGrid (xComputerGrid,
				yComputerGrid)) = 0 and
				(computerGrid (xComputerGrid + 1,
				yComputerGrid)) = 0
			end loop

			computerGrid (xComputerGrid, yComputerGrid) := 1
			computerGrid (xComputerGrid + 1, yComputerGrid) := 1

			%Ship specific coordinates
			xDestroyerComputerGrid := xComputerGrid
			yDestroyerComputerGrid := yComputerGrid

			destroyerComputerSunk (xDestroyerComputerGrid,
			    yDestroyerComputerGrid) := 1
			destroyerComputerSunk (xDestroyerComputerGrid + 1,
			    yDestroyerComputerGrid) := 1


		    else         %Vertical placement
			%Does no allow for placement outside grid
			randint (xComputerGrid, 1, 10)
			randint (yComputerGrid, 1, 9)

			%Checks for is ship is already at the chose location
			loop
			    if (computerGrid (xComputerGrid,
				    yComputerGrid)) = 1 or
				    (computerGrid (xComputerGrid,
				    yComputerGrid + 1)) = 1 then
				randint (xComputerGrid, 1, 10)
				randint (yComputerGrid, 1, 9)
			    else
			    end if
			    exit when (computerGrid (xComputerGrid,
				yComputerGrid)) = 0 and
				(computerGrid (xComputerGrid,
				yComputerGrid + 1)) = 0
			end loop

			computerGrid (xComputerGrid, yComputerGrid) := 1
			computerGrid (xComputerGrid, yComputerGrid + 1) := 1

			%Ship specific coordinates
			xDestroyerComputerGrid := xComputerGrid
			yDestroyerComputerGrid := yComputerGrid

			destroyerComputerSunk (xDestroyerComputerGrid,
			    xDestroyerComputerGrid) := 1
			destroyerComputerSunk (xDestroyerComputerGrid,
			    yDestroyerComputerGrid + 1) := 1
		    end if
		    %-----------------------END COMPUTER SHIPS-----------------

		    mainGame
		else
		end if
	    else
		text (SgameStrings (2), "Impact:30", 0, 50, 0)
	    end if

	else
	end if
    end loop
end gamePlanning
%------------------------------END GAME PROCESSES------------------------------



%-------------------------------MENU PROCESSING--------------------------------
%Main menu process
body procedure mainProcess
    var xMouse, yMouse, button : int
    var userInput : string (1)

    %ERROR TRAP ENSURES BUTTON IS UNCLICKED
    loop
	Mouse.Where (xMouse, yMouse, button)
	if button = 0 then
	    exit
	else
	end if
    end loop

    mainMenu

    %Calculating center of text
    var font := Font.New ("Impact:30")

    var buttonXNameOne := Font.Width (SmainStrings (4), font)
    var buttonXNameTwo := Font.Width (SmainStrings (5), font)
    var buttonXNameThree := Font.Width (ShowToPlayStrings (1, 1), font)

    var xButtonBeginOne := (maxx div 2 - buttonXNameOne div 2)
    var xButtonBeginTwo := (maxx div 2 - buttonXNameTwo div 2)
    var xButtonBeginThree := (maxx div 2 - buttonXNameThree div 2)

    var xButtonEndOne := (maxx div 2 + buttonXNameOne div 2)
    var xButtonEndTwo := (maxx div 2 + buttonXNameTwo div 2)
    var xButtonEndThree := (maxx div 2 + buttonXNameThree div 2)

    loop
	Mouse.Where (xMouse, yMouse, button)

	%Checks for correct x and y values
	if (xMouse >= xButtonBeginOne) and (xMouse <= xButtonEndOne)
		and (yMouse >= (maxy div 2)) and
		(yMouse <= (maxy div 1.85)) then
	    text (SmainStrings (4), "Impact:30", 0, 2, red)
	    if button = 1 then
		gamePlanning         %To start playing game
		return
	    else
	    end if

	    %Checks for correct x and y values
	elsif (xMouse >= xButtonBeginThree)
		and (xMouse <= xButtonEndThree) and
		(yMouse >= (maxy div 3.5)) and
		(yMouse <= (maxy div 3.15)) then
	    text (ShowToPlayStrings (1, 1), "Impact:30", 0, 3.5, red)
	    if button = 1 then
		howToPlayProcess    %To read instruction on how to play
		return
	    else
	    end if

	    %Checks for correct x and y values
	elsif (xMouse >= xButtonBeginTwo) and (xMouse <= xButtonEndTwo)
		and (yMouse >= (maxy div 2.55)) and
		(yMouse <= (maxy div 2.25)) then
	    text (SmainStrings (5), "Impact:30", 0, 2.55, red)
	    if button = 1 then
		goodBye         %To exit
		return
	    else
	    end if

	elsif hasch then
	    getch (userInput)
	    if userInput = KEY_ESC then
		display
	    else
	    end if
	else
	    text (SmainStrings (4), "Impact:30", 0, 2, brightgreen)
	    text (SmainStrings (5), "Impact:30", 0, 2.55, brightgreen)
	    text (ShowToPlayStrings (1, 1), "Impact:30", 0, 3.5,
		brightgreen)
	end if
    end loop
end mainProcess

%The introduction before proceeding to main menu
body procedure display
    setscreen ("nooffscreenonly")
    var xMouse, yMouse, button : int
    var userInput : string (1)

    intro

    %Calculating center of text
    var font := Font.New ("Impact:25")
    var buttonXNameOne := Font.Width (SmainStrings (2), font)
    var buttonXNameTwo := Font.Width (SmainStrings (5), font)

    var xButtonBeginOne := (maxx div 2 - buttonXNameOne div 2)
    var xButtonBeginTwo := (maxx div 2 - buttonXNameTwo div 2)

    var xButtonEndOne := (maxx div 2 + buttonXNameOne div 2)
    var xButtonEndTwo := (maxx div 2 + buttonXNameTwo div 2)

    loop
	Mouse.Where (xMouse, yMouse, button)
	%Checks for correct x and y values
	if (xMouse >= xButtonBeginOne) and (xMouse <= xButtonEndOne) and
		(yMouse >= (maxy div 2)) and (yMouse <= (maxy div 1.85)) then
	    text (SmainStrings (2), "Impact:25", 0, 2, red)
	    if button = 1 then
		mainProcess
		return
	    else
	    end if

	    %Checks for correct x and y values
	elsif (xMouse >= xButtonBeginTwo) and (xMouse <= xButtonEndTwo)
		and (yMouse >= (maxy div 2.3)) and
		(yMouse <= (maxy div 2.15)) then
	    text (SmainStrings (5), "Impact:25", 0, 2.3, red)
	    if button = 1 then
		goodBye %To exit
		return
	    else
	    end if

	    %Error trap to ensure hasch is not picked up on next process
	elsif hasch then
	    getch (userInput)
	    if userInput = KEY_ESC then
	    else
	    end if

	else
	    text (SmainStrings (2), "Impact:25", 0, 2, brightgreen)
	    text (SmainStrings (5), "Impact:25", 0, 2.3, brightgreen)
	end if
    end loop
end display
%------------------------------END MENU PROCESSING-----------------------------

%Music outside procedure so it does not restart when user goes to first screen
Music.PlayFileLoop ("BackgroundMusic.MP3")
%Display starts the whole program which leads into other screens.
display
