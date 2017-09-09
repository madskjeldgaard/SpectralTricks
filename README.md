# SpectralTricks
A haskell package adding spectral effects to Tidal

Use:
1. Download this repo from github
2. Install the package on your system (using your terminal, cd into the `Cabal-Package` folder and type `cabal install`)
3. In Tidal, evaluate the line `import Sound.Tidal.SpectralTricks`
4. Evaluate SpectralTricksSCSynths.scd in Supercollider

That's it!

This package adds all of the common spectral effects from SuperCollider to Tidal as synth parameters. 
Unforunately some of these are a bit heavy on the cpu so sprinkle them gently throughout your code. If you want to keep an eye on cpu usage, you can evaluate `fork{loop{1.wait; "CPU usage: ".post; s.avgCPU.post; " %".postln}};` in supercollider – this will have sc post an update every second on how much cpu usage you're at.

Anyway, now you can destroy your sounds like this: `d1 $ every 2 (# freeze 1) $ weave 16 (smear saw # comb sine # binshift rand) [sound1, sound2, sound3] # hbrick (slow 64 $ saw)`


## The parameters:

#### Magnitude freeze.
`# freeze`

Accepts integers: 1 freezes the audio, 0 doesn't. 

#### Magnitude smearing. 
`# smear`

Accepts floats to determine the amount of smearing. 

#### A spectral comb filter
`# comb`

Number of teeth and width of the comb are all controlled using one floating point number

#### Bin scrambling
`# scram`

Accepts floats to control the width and placement of the scrambling in the spectrum

#### Bin shifting
`# binshift`

Both the stretching and shifting of bins are controlled by supplying this parameter with floats. 

#### Spectral high pass filter
`# hbrick`

Accepts floats in values ranging from 0.0 to 1.0

#### Spectral low pass filter
`# lbrick`

Accepts floats in values ranging from 0.0 to 1.0
