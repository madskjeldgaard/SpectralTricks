module Sound.Tidal.SpectralTricks where

import Sound.Tidal.Context
import Sound.Tidal.Scales
import Sound.Tidal.Chords

-- Magnitude freezer: any integer above 0 freezes the input
freeze :: Pattern Int -> ParamPattern
freeze = make' VI freeze_p 
freeze_p = I "freeze" Nothing

-- Convenient function to use freeze with the every function
freezeEvery i = every i (#freeze "1")

comb :: Pattern Double -> ParamPattern
comb = make' VF comb_p 
comb_p = F "comb" Nothing

smear :: Pattern Double -> ParamPattern
smear = make' VF smear_p 
smear_p = F "smear" Nothing

scram :: Pattern Double -> ParamPattern
scram = make' VF scram_p 
scram_p = F "scram" Nothing

binshift :: Pattern Double -> ParamPattern
binshift = make' VF binshift_p 
binshift_p = F "binshift" Nothing

-- A weird combination of previous effects
abyss :: Pattern Double -> ParamPattern
abyss x = binshift x # scram x # smear x # comb x

ciel :: Pattern Double -> ParamPattern
ciel x = smear(1-x) # binshift (x) # scram (1-x) # comb (x)

-- High pass sort of spectral filter: 0.0-1.0
hbrick :: Pattern Double -> ParamPattern
hbrick = make' VF hbrick_p 
hbrick_p = F "hbrick" Nothing

-- Low pass sort of spectral filter: 0.0-1.0
lbrick :: Pattern Double -> ParamPattern
lbrick = make' VF lbrick_p 
lbrick_p = F "lbrick" Nothing

-- Band pass sort of spectral filter: 0.0-1.0
bbrick :: Pattern Double -> ParamPattern
bbrick x = lbrick (x/4) # hbrick (x/4)


