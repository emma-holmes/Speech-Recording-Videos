function movieMaker_ExpandingBar(hFig, fig_pos, barHeight, barInterval, barYpos, barBGColour, barFillColour, fps, nFrames, nFrPause, movieFilename)
% movieMaker_ExpandingBar(hFig, fig_pos, barHeight, barInterval, barYpos, ...
%   barBGColour, barFillColour, fps, nFrames, nFrPause, movie_filename)
%       hFig            Figure handle for image to superimpose bar onto.
%       fig_pos         4-element vector specifying position of figure, in
%                       the format output from get(gcf,'Position').
%       barHeight       Integer specifying bar height.
%       barYpos         Integer specifying position on the y-axis to
%                       place the lower edge of the bar.
%       barBGColour     Colour specification for unfilled portion of bar, 
%                       in the format 'r' or [0 0 0].
%       barFillColour   Colour specification for filled portion of bar, 
%                       in the format 'r' or [0 0 0].
%       fps             Integer specifying number of frames per second 
%                       in the output movie.
%       nFrames         Integer specifying number of frames for the bar 
%                       to move through the figure.
%       nFrPause        Integer specifying number of frames to pause the 
%                       bar at the start of the movie. 
%       movieFilename   String containing output filepath and filename for
%                       saving movie.
%
% This function adds a filled bar to a pre-existing figure (hFig).
% The bar will start empty and fill horizontally (left -> right).
% Movie is saved in MPEG-4 format
%
% Emma Holmes
% Created on 08/04/2015
% Last modified 19/08/2017


fprintf('\nCreating movie...');
timerVal    = tic;

% Get properties of the input image
hFig; %#ok<VUNUS>
xlimit      = get(gca,'XLim');
fig_width   = xlimit(2) - xlimit(1);

% Set up pause frames at the start of movie
nFrames     = nFrames + nFrPause;
all_frames(nFrames) = struct('cdata',[],'colormap',[]);

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
    
    % First, plot unfilled bar
    startPos	= fig_width * barInterval;
    endPos      = fig_width - (fig_width * barInterval);
    y_co        = [barYpos barYpos+barHeight];
    y_co        = reshape([y_co;y_co], 1, 4);
    x_co        = [startPos endPos];
    x_co        = [x_co fliplr(x_co)]; %#ok<AGROW>
    fill(x_co, y_co, barBGColour);
    
    % Pause the bar at the start of the image for a specified number of 
    % frames at the beginning of the movie.
    if i > nFrPause
        fillPos = barInterval * (i-nFrPause);
    else
        fillPos = barInterval;
    end
    
    % Plot filled portion of bar
    x_co        = [startPos fillPos];
    x_co        = [x_co fliplr(x_co)]; %#ok<AGROW>
    hBar        = fill(x_co, y_co, barFillColour);
    set(hBar, 'EdgeColor', 'none');

    all_frames(i) = getframe(barIm);
end

% Write movie to file
fprintf('\nWriting movie to file...\n(%s)', movieFilename);
vidObj = VideoWriter(movieFilename, 'MPEG-4');
vidObj.FrameRate = fps;
open(vidObj)
writeVideo(vidObj, all_frames)
close(vidObj);
timeElapsed = toc(timerVal);
fprintf('...movie created! (time taken = %.2f mins)\n\n', timeElapsed/60);

end