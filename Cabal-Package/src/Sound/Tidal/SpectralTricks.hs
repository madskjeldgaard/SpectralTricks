module Sound.Tidal.SpectralTricks where

import Sound.Tidal.Context
import Sound.Tidal.Scales
import Sound.Tidal.Chords

-- Magnitude freezer: any integer above 0 freezes the input
freeze :: Pattern Int -> ControlPattern
freeze = pI "freeze"

-- Convenient function to use freeze with the every function
freezeEvery i = every i (#freeze "1")

comb :: Pattern Double -> ControlPattern
comb = pF "comb"

smear :: Pattern Double -> ControlPattern
smear = pF "smear"

scram :: Pattern Double -> ControlPattern
scram = pF "scram"

binshift :: Pattern Double -> ControlPattern
binshift = pF "binshift"

-- A weird combination of previous effects
abyss :: Pattern Double -> ControlPattern
abyss x = binshift x # scram x # smear x # comb x

ciel :: Pattern Double -> ControlPattern
ciel x = smear(1-x) # binshift (x) # scram (1-x) # comb (x)

-- High pass sort of spectral filter: 0.0-1.0
hbrick :: Pattern Double -> ControlPattern
hbrick = pF "hbrick"

-- Low pass sort of spectral filter: 0.0-1.0
lbrick :: Pattern Double -> ControlPattern
lbrick = pF "lbrick"

-- Band pass sort of spectral filter: 0.0-1.0
bbrick :: Pattern Double -> ControlPattern
bbrick x = lbrick (x/4) # hbrick (x/4)


