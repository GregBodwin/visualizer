require 'spcore' # signal processing library
require 'ruby-audio' # audio read/write library

# currently only handles .wav files

FPS = 44100 #approximate frames per second in .wav files
WINDOW_SIZE = 0.01 # seconds to look at at once
INFILE = "cb.wav"
OUTFILE = "outfile.wav"

# read data into array; this array holds many floats corresponding to sound intensity in subsequent frames.
info = RubyAudio::SoundInfo.new :channels => 2, :samplerate => 48000, :format => RubyAudio::FORMAT_WAV
audio = RubyAudio::Sound.new INFILE, 'r', info

RubyAudio::Sound.open(INFILE) do |snd|
  buf = snd.read(:float, 100)
  # fourier that shit, get principal pitches
  DFT.forward(buf)
end
buf = RubyAudio::Buffer.float(FPS*WINDOW_SIZE, 2)
#audio.read(buf, FPS*WINDOW_SIZE)

# write it all to a new file
#RubyAudio::Sound.open(OUTFILE, 'w', audio.info.clone).write(buf)
