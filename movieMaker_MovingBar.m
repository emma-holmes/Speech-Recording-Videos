function movieMaker_MovingBar(hFig, fig_pos, barHeight, barWidth, barInterval, barColour, barChangeCol, fps, nFrames, nFrPause, colorChangePos, movieFilename)
% movieMaker_MovingBar(hFig, fig_pos, barHeight, barWidth, barInterval, 
%   barColour, fps, nFrames, nFrPause, colorChangePos, movieFilename)
%       hFig            Figure handle for image to superimpose bar onto.
%       fig_pos         4-element vector specifying position of figure, as
%                       would be output from get(gcf,'Position').
%       barHeight       Integer specifying bar height.
%       barWidth        Integer specifying bar width.
%       barColour       Colour of bar. Colour specification, in the format 
%                       'r' or [0 0 0].
%       barChangeCol    Colour bar should change to during video. Colour 
%                       specification, in the format 'r' or [0 0 0].
%       fps             Integer specifying number of frames per second 
%                       in the output movie.
%       nFrames         Integer specifying desired number of frames for the
%                       bar to move through the figure.
%       nFrPause        Integer specifying number of frames to pause the 
%                       bar at the start of the movie. 
%       colorChangePos  Vector to indicate any positions across the image
%                       (x-axis) for which the colour of the bar should be
%                       different.
%       movieFilename   String containing output filepath and filename for
%                       saving movie.
%
% This function adds a moving bar to a pre-existing figure (hFig).
% The bar will move across the image horizontally (left -> right).
% Movie is saved in MPEG-4 format.
%
% Emma Holmes
% Created on 13/02/2015
% Last modified 19/08/2017


fprintf('\nCreating movie...');
timerVal    = tic;

% Get properties of the input image
hFig; %#ok<VUNUS>
ylimit      = get(gca,'YLim');
fig_height  = ylimit(2) - ylimit(1);

% Set up variable to store frames of movie
nFrames     = nFrames + nFrPause;
all_frames(nFrames) = struct('cdata',[],'colormap',[]);

% Specify difference in position between the bar colorChangePos to 
% apply the change in bar colour
barColPos   = 0.02;

% Create frames with bar image overlaid on figure
reverseStr = '';
for i = 1 : nFrames
    msg         = sprintf('\nCreating frame %d of %d', i, nFrames);
    fprintf([reverseStr msg]);
    reverseStr  = repmat(sprintf('\b'),1,length(msg));
    
    % Create new figure from input figure handle, which allows figure
    % editing
    barIm = figure;
    set(barIm, 'Position', fig_pos);
    copyobj(get(hFig,'children'), barIm);    
    set(barIm, 'Color', 'k');
    set(barIm, 'Visible', 'off');
    hold on;    
    
    % Pause the bar at the start of the image for a specified number of 
    % frames at the beginning of the movie.
    if i > nFrPause
        startPos = barInterval * (i-nFrPause);
    else
        startPos = barInterval;
    end
    endPos      = startPos + barWidth;
    x_co        = [startPos endPos];
    x_co        = [x_co fliplr(x_co)]; %#ok<AGROW>
    y_co        = [(fig_height-barHeight)/2 fig_height-(fig_height-barHeight)/2];
    y_co        = reshape([y_co;y_co], 1, 4);

    % Identify whether positions are specified where the bar should
    % be a different colour, and plot the bar with the desired colour.
    if any(abs(startPos - colorChangePos) < barColPos)
        hBar = fill(x_co, y_co, barChangeCol);
    else
        hBar = fill(x_co, y_co, barColour);
    end
    set(hBar, 'EdgeColor', 'none');

    all_frames(i) = getframe(barIm);
end

% Write movie to file
movieFilename = sprintf('%s', movieFilename);
fprintf('\nWriting movie to file...\n(%s)', movieFilename);
vidObj = VideoWriter(movieFilename, 'MPEG-4');
vidObj.FrameRate = fps;
open(vidObj)
writeVideo(vidObj, all_frames)
close(vidObj);
timeElapsed = toc(timerVal);
fprintf('...movie created! (time taken = %.2f mins)\n\n', timeElapsed/60);

end