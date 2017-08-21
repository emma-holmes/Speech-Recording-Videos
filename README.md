# Speech-Recording-Videos
Code to create videos for recording sentence stimuli with standardised timings

## Description of videos
There are two different types of videos that can be created here. One in which a vertical bar moves through the sentence, optionally changing colour at the beginning of each word. Another in which a horizontal bar appears across the length of the sentence and fills with colour over time. Examples of both video types are provided in the directory.

## Prerequisites
The scripts were created and tested using MATLAB 2014b. No additional toolboxes are required.

## Useage
To create videos for a list of sentences (that are specified in an Excel document), run either [AllSentenceMovies_MovingBar.m](AllSentenceMovies_MovingBar.m) or [AllSentenceMovies_ExpandingBar.m](AllSentenceMovies_ExpandingBar.m). The output directory (where the videos will be saved) and Excel file are both inputs to the script. The parameters in the first section of the script can be changed as desired, including the estimated time (in seconds) that the bar should take to move through the sentence.

The scripts call [createSentenceMovie_MovingBar.m](createSentenceMovie_ExpandingBar.m) and [createSentenceMovie_MovingBar.m](createSentenceMovie_ExpandingBar.m), respectively, which can be used to create a single video file.

The file [movieMaker_MovingBar.m](movieMaker_MovingBar.m) or [movieMaker_ExpandingBar.m](movieMaker_ExpandingBar) will also need to be in the MATLAB path.
