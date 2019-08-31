# Music-Identification
Simple music identification algorithm implemented with MATLAB

## Usage
There are 4 main scripts:
- create_db : creates the database using the audio files present in the 'database' directory.
Example : create_db(22050, 2048, 20, 15) creates a database with parameters : sample_rate=22050, window_size=2048, peak_radius=20, fanout_size=15
- record_samples : records audio samples
Songs will be played with your computer's speaker and recorded with your computer's microphone. Samples are saved in the 'samples' directory.
- tests :  tests the accuracy 'samples' of the algorithm
tests(n) will test samples for 1,2,...,n seconds
- main: for manual testing

*Note 1 :* Depending on the number of files and their size, create_db and record_samples can take a while to execute.

*Note 2 :* If your filenames contains "non standard english" characters (like accentued characters, or chinese/korean/arabic/thai/other characters) it is recommended that you run this command before any other command:
slCharacterEncoding('UTF-8')

## Example
Put music files in the 'database' directory then launch in MATLAB command window:
create_db; record_samples(15); tests(15);
