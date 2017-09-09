# SpectralTricks
A haskell package adding spectral effects to Tidal

This package adds all of the common spectral effects from SuperCollider to Tidal as synth parameters. 
Unforunately some of these are a bit heavy on the cpu so sprinkle them gently throughout your code. 

Use:
1. Install the package on your system
2. In Tidal, evaluate the line `import Sound.Tidal.SpectralTricks`
3. Evaluate SpectralTricksSCSynths.scd in Supercollider

That's it!

Now you can destroy your sounds like this: `d1 $ every 2 (# freeze 1) $ weave 16 (smear saw # comb sine # binshift rand) [sound1, sound2, sound3] # hbrick (slow 64 $ saw)`

### The parameters are

`# freeze`
Magnitude freeze.

Accepts integers: 1 freezes the audio, 0 doesn't. 

`# smear`

Magnitude smearing. 

Accepts floats to determine the amount of smearing. 

`# comb`
A spectral comb filter

Number of teeth and width of the comb are all controlled using one floating point number

`# scram`
Bin scrambling

Accepts floats to control the width and placement of the scrambling in the spectrum

`# binshift`

Both the stretching and shifting of bins are controlled by supplying this parameter with floats. 

`# hbrick`

A spectral high pass filter

Accepts floats in values ranging from 0.0 to 1.0

`# lbrick`

A spectral low pass filter

Accepts floats in values ranging from 0.0 to 1.0
