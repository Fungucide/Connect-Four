% Menu.t
% Dec 7,2016
% William F. and Max
% Menu of game

% Include relevant files
include "2Play.t"

% Open window
var winID : int
winID := Window.Open ("position:0;0,graphics:max;max")
View.Set ("offscreeenonly")

% Add music
process backMusic
    Music.PlayFile ("PureWhite.mp3")
end backMusic

% Show menu
procedure menu ()
    % Set background image
    background := Pic.FileNew ("Table.jpg")
    background := Pic.Scale (background, maxx, maxy)

    % Play background music
    fork backMusic

    % Take input from buttons
    loop
	View.Update
	% Redraw background
	Pic.Draw (background, 0, 0, picMerge)

	% Draw tittle
	Font.Draw ("Connect Four", maxx div 2 - 350, maxy div 2 + 200, tittle, black)

	% Add button boxes
	drawfillbox (maxx div 2 - 200, maxy div 2 - 60, maxx div 2 + 200, maxy div 2 - 160, brightwhite)
	drawfillbox (maxx div 2 - 200, maxy div 2 + 60, maxx div 2 + 200, maxy div 2 + 160, brightwhite)
	drawfillbox (maxx div 2 - 200, maxy div 2 + 50, maxx div 2 + 200, maxy div 2 - 50, brightwhite)

	% Add text to buttons
	Font.Draw ("2 Player Game", maxx div 2 - 150, maxy div 2 + 100, font, black)
	Font.Draw ("Exit", maxx div 2 - 50, maxy div 2 - 125, font, black)
	Font.Draw ("1 Player Game", maxx div 2 - 150, maxy div 2 - 20, font, black)

	% Push graphic updates
	View.Update

	% Wait for mouse click
	buttonwait ("down", mousex, mousey, notused1, notused2)
	if mousex > maxx div 2 - 200 and mousex < maxx div 2 + 200 and mousey > maxy div 2 + 60 and mousey < maxy div 2 + 160 then
	    game2 ()
	elsif mousex > maxx div 2 - 200 and mousex < maxx div 2 + 200 and mousey < maxy div 2 - 60 and mousey > maxy div 2 - 160 then
	    Window.Close (winID)
	    quit
	elsif mousex > maxx div 2 - 200 and mousey < maxy div 2 + 50 and mousex < maxx div 2 + 200 and mousey > maxy div 2 - 50 then
	    game1 ()
	end if
    end loop

end menu
