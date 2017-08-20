function createSentenceMovie_ExpandingBar(wordChArray, numberToPlot, colours, word_spacing, bg_colour, barInterval, barBGColour, barFillColour, movie_filename, fps, nFrames, nFrPause)
% createSentenceMovie_ExpandingBar(wordChArray, colours, word_spacing, bg_colour, ...
%    barWidth, barInterval, barColour, movie_filename, fps, nFrames)
%       wordChArray         Character array consisting of word strings.
%       colours             Character array consisting of colour strings.
%       word_spacing        Integer to specify the length of spacing
%                           between words in the sentence.
%       bg_colour           Colour specification for background of image, 
%                           in the format 'r' or [0 0 0].
%       barInterval         Float specifying the interval that the bar 
%                           should move from frame to frame.
%       barBGColour       	Colour specification for bar background, in the
%                           format 'r' or [0 0 0].
%       barFillColour      	Colour specification for bar fill, in the 
%                           format 'r' or [0 0 0].
%       movie_filename      Output filepath and filename to save movie.
%       fps                 Integer to specify number of frames per second.
%       nFrames             Number of frames for the bar to move through 
%                           the sentence.
%       nFrPause            Integer specifying number of frames to pause the 
%                           bar at the start of the movie. 
%
% This function creates a movie containing a written versions
% of a sentence. Sentences are constructed from the words input 
% to the function (wordChArray).
%
% Emma Holmes
% Created on 13/02/2015
% Last modified 19/08/2017


% Specify parameters for figure displaying text
font        = 'Calibri';
fig_height  = 1;
fig_width   = 2;
scale_fact  = 2.5; % (determines the overall size of the figure)
text_size   = 16 * scale_fact;
fig_pos 	= [0, 0, 560*scale_fact, 420*scale_fact];
numColour   = [.7 .7 .7]; % (determines colour of number in corner of movie)
barYpos     = fig_height * 17/32;

% Run intial plot to check the physical length of sentence so it 
% can be plotted centrally on the figure in the next stage.
hFig = figure;
hold on;
set(hFig, 'Position', fig_pos);
leftpos = 0;
[txt_end,~] = plotSentence(wordChArray, leftpos, word_spacing, text_size, ...
    font, colours, fig_height);
lr_space = (fig_width - txt_end) / 2;
close(hFig);

% Create figure to be saved
hFig = figure; clf;
hold on;
set(hFig, 'Position', fig_pos);
xlim([0 fig_width])
ylim([0 fig_height]);
% Plot sentence on the figure
leftpos = lr_space * 0.5;
plotSentence(wordChArray, leftpos, word_spacing, text_size, font, ...
    colours, fig_height);
% Plot number in top left corner
hNum = text(fig_width/60, 1-fig_height/60, int2str(numberToPlot));
set(hNum, 'FontName', font, 'FontSize', text_size/2, 'Color', numColour);
% Format figure
set(hFig, 'Color', bg_colour);
set(gca, 'Visible', 'off');

% Create movie from figure
barHeight = 0.25;
movieMaker_ExpandingBar(hFig, fig_pos, barHeight, barInterval, ...
    barYpos, barBGColour, barFillColour, fps, nFrames, nFrPause, ...
    movie_filename);

end


% -------------
% SUB-FUNCTIONS
% -------------

function [txt_end, all_word_startpos] = plotSentence(wordChArray, leftpos, word_spacing, text_size, font, colours, fig_height)

all_word_startpos = leftpos; % store start positions of each word

% Plot each word from the sentence
for i = 1:numel(wordChArray)
    hTxt    = text(leftpos, fig_height/2, char(wordChArray(i)));
    set(hTxt, 'FontName', font, 'FontSize', text_size, ...
        'FontWeight', 'bold', 'Color', char(colours(i)));
    txtRect = get(hTxt, 'Extent');
    leftpos = txtRect(1) + word_spacing;
    all_word_startpos = [all_word_startpos, leftpos]; %#ok<AGROW>
end
all_word_startpos = all_word_startpos(1 : length(all_word_startpos)-1);

% Calculate position on plot where text ends
txt_end = txtRect(1) + txtRect(3);

end