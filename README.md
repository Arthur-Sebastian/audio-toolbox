# AudioToolbox
### Released into the public domain.
A collection of audio related tools written in bash.

## Dependencies
- pulseaudio
- ffmpeg

## Installation
- Download the 'audiotoolbox.sh' script from the repository.
- Add the following extract to your '.bashrc' file:

> source /path/to/audiotoolbox.sh

Notes: 
- replace the example path accordingly.
- '.bashrc' should be located under '/home/[username]/.bashrc'.

## Available tools
### flacrip
Used to rip audio files via raw soundcard output. Creates 16bit, 44.1kHz nicely clipped FLAC files,
with added relevant metadata.<br>
Clips leading and trailing silence out of the recording automatically.<br>
Usage:<br>
Start the tool:
> flacrip [artist] [title] [album]

Arguments:
- artist: Performing artist name
- title: Audio file title
- album: Musical album name

Note: If an argument is not set, it will be substituted by "Unknown".

General usage:<br>
- Select the appropriate recording audio source.
- Wait for a timestamp status information.
- Play your audio from a CD, or a streaming service.
- Press Q to stop ripping.

### audioclip
Used to clip silence out of audio files.<br>
Usage:
> audioclip [filepath]

Arguments:
- filepath: path to the audio file to be clipped

### mp3ify
Macro for converting various audio files into mp3s.<br>
Usage:
> mp3ify [filepath] [quality]

Arguments:
- filepath: path to the audio file to be converted
- quality (optional - default 0): VBR quality setting 0-9 (0 - highest)

Note: Argument [quality] has a default value of 0 which corresponds to
220-260 kbit/s VBR encoding.<br> 
See [this article](https://wiki.hydrogenaudio.org/index.php?title=LAME#Recommended_encoder_settings) for more information.

### flacer
A script converting various audio files into a standard 16bit/44.1kHz flac format.<br>
Usage:
> flacer [filepath]

Arguments:
- filepath: path to the audio file to be converted 


### flactag
Tool for metadata addition or edition for flac files, automatically naming the file as follows:
>[Artist] - [Title].flac<br>

Usage:
> flactag [image] [image]

Arguments:
- flac location: path to the audio file that will have its metadata changed
- image location: path of the image to be assigned to the flac, can be both jpg and png, in any acpect rato.
  
Note: Provided with both filepaths, the script will change both text and image metadata.
Given only the flac filepath, only text tags will be modified.



## Disclaimer
I do not condone the usage of any of those tools for illicit purposes. Please use the provided tools (especially flacrip) only for your own, personal use.
Content piracy and redistribution may be punishable by law, consult your local authorities for more information.
