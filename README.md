# Speech-Recording-Videos
Code to create videos for recording sentence stimuli with standardised timings

## About the videos
There are two different types of videos that can be created here. One in which a vertical bar moves through the sentence, optionally changing colour at the beginning of each word ("moving bar"). Another in which a horizontal bar appears across the length of the sentence and fills with colour over time ("expanding bar"). Examples of the [moving bar](ExampleOutput_MovingBar.mp4) and [expanding bar](ExampleOutput_ExpandingBar.mp4) videos are provided.

## Getting Started
### Prerequisites
The scripts were created and tested using MATLAB 2014b. No additional toolboxes are required.

### Moving bar videos
To create moving bar videos for a list of sentences (that are specified in an Excel document), run [AllSentenceMovies_MovingBar.m](AllSentenceMovies_MovingBar.m). The output directory (where the videos will be saved) and Excel file are both inputs to the script. The parameters in the first section of the script can be changed as desired, including the estimated time (in seconds) that the bar should take to move through the sentence.

The script calls [createSentenceMovie_MovingBar.m](createSentenceMovie_ExpandingBar.m), which can be used alone to create a video file of an individual sentence.

The file [movieMaker_MovingBar.m](movieMaker_MovingBar.m) will also need to be in the MATLAB path. The function of this script is to add a bar to an image.

### Expanding bar videos
To create expanding videos for a list of sentences (that are specified in an Excel document), run [AllSentenceMovies_ExpandingBar.m](AllSentenceMovies_ExpandingBar.m). The output directory (where the videos will be saved) and Excel file are both inputs to the script. The parameters in the first section of the script can be changed as desired, including the estimated time (in seconds) that the bar should take to move through the sentence.

The script calls [createSentenceMovie_MovingBar.m](createSentenceMovie_ExpandingBar.m), which can be used alone to create a video file of an individual sentence.

The file [movieMaker_ExpandingBar.m](movieMaker_ExpandingBar) will also need to be in the MATLAB path. The function of this script is to add a bar to an image.

## License
This project is licensed under the MIT License; see the [LICENSE](LICENSE) file for details.

This project can be cited using the following DOI: [![DOI](https://zenodo.org/badge/100834657.svg)](https://zenodo.org/badge/latestdoi/100834657)
