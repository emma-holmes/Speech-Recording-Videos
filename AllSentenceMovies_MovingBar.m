function AllSentenceMovies_MovingBar(outDir, xlsFilename)
%% AllSentenceMovies_MovingBar(outDir, xlsFilename)
%       outDir      String specifying directory where movie files will be
%                   stored.
%       xlsFilename String specifying path to Excel file containing
%                   sentences for movies. First column should contain
%                   sentence number. Second column onwards should contain 
%                   sentence words to be drawn.
% 
% This script iterates through sentences that are stored in an Excel file. 
% For each sentence, a movie is created in which a bar moves through the 
% written sentence. One use of this script is to create visual stimuli that 
% can be used for speech recordings--to standardise timings across talkers.
% The filenames are the sentence numbers.
%
% Example useage:
%   Create_Sentence_Movies('C:\Users\Emma\video_outputs', ...
%       'C:\Users\Emma\Example_Sentence_List')
%
% Emma Holmes
% Created on 13/02/2015
% Last updated 19/08/2017


%% Specify movie paramters

% Load excel file containing all sentences and extract sentence numbers and
% sentences
[num, words]    = xlsread(xlsFilename);
numberToPlot    = num;
allWords        = words;
nWords          = size(allWords, 2);

% Specify colours to be used for each word in the sentence.
colours         = cell(1, nWords);
colours(1:2:end)= {'w'}; % white
colours(2:2:end)= {'g'}; % green

% Specify colour of background for movie.
bg_colour       = 'k';

% Specify the size of spacing between words
word_spacing    = 0.4;

% Specifity properties of the bar
barWidth        = 0.025;
barColour       = 'r'; % (of the form 'r' or [.7 .7 .7])
barChangeCol    = 'y'; % (of the form 'r' or [.7 .7 .7]) 

% Specify desired time taken to read entire sentence (in seconds)
sentenceTime    = 2.4; 

% Specify frames per second for the movie 
% (note: Ensure this value is compatible with monitor settings. 60 is a 
% common monitor refresh rate)
fps = 60;

% Specify number of frames to pause at the beginning of the movie,
% before the bar starts moving
nFrPause        = 90;


%% Create moving bar movie for each sentence
% Calls script: visualSentenceStim.m

% First, calculate the interval that the bar should move from
% frame to frame
numSentFrames   = sentenceTime*fps;
barInterval     = (word_spacing*5) / numSentFrames;

% Next, loop through all sentences to create movies
for a = 1 : length(numberToPlot);
    wordArray   = allWords(a);
    sentence    = strjoin(wordArray);
    movieFilename = sprintf('%s\\%s', outDir, strjoin(wordArray, '_'));
    
    fprintf('\nSentence: "%s"\n', sentence);
    createSentenceMovie_MovingBar(wordArray, numberToPlot(a), colours, ...
        word_spacing, bg_colour, barWidth, barInterval, barColour, ...
        barChangeCol, movieFilename, fps, ceil(numSentFrames*1.2), nFrPause);
    close all;
end

fprintf('\n\nScript finished.\n\n');
