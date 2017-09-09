(

/*********************************************************

                CUSTOM EFFECTS

*********************************************************/

var numChannels =  ~dirt.numChannels;


/**************************** 
        SPECTRAL DELAY  
*****************************/

~dirt.addModule('spectral-delay', { |dirtEvent|
	dirtEvent.sendSynth('spectral-delay' ++ ~dirt.numChannels,
		// OPTIONAL
		// passing this array of parameters could be left out,
		// but it makes it clear what happens
		[
			xsdelay: ~xsdelay,
			tsdelay: ~tsdelay,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~tsdelay.notNil or: { ~xsdelay.notNil } }); // play synth only if at least one of the two was given

SynthDef("spectral-delay" ++ numChannels, { |out, tsdelay, xsdelay = 1, sustain|

	var signal, delayTime, delays, freqs, filtered;
	var size = 16;
	var maxDelayTime = 0.2;

	signal = In.ar(out, numChannels);
	delayTime = tsdelay * maxDelayTime;
	filtered = (1..size).sum { |i|
		var filterFreq = i.linexp(1, size, 40, 17000);
		var sig = BPF.ar(signal, filterFreq, 0.005);
		// the delay pattern is determined from xsdelay by bitwise-and:
		DelayN.ar(sig, maxDelayTime, i & xsdelay * (1/size) * delayTime )
	};
	signal = signal * 0.2 + (filtered * 4); // this controls wet/dry
	ReplaceOut.ar(out, signal)

}).add;

/**************************** 
        SPECTRAL FREEZ 
*****************************/

~dirt.addModule('spectral-freeze', { |dirtEvent|
	dirtEvent.sendSynth('spectral-freeze' ++ ~dirt.numChannels,
		[
			freeze: ~freeze,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~freeze.notNil } ); // play synth only if at least one of the two was given

SynthDef("spectral-freeze" ++ numChannels, { |out, freeze , sustain|

	var signal, chain, in;

	signal = In.ar(out, numChannels);

    chain = Array.fill(signal.size, {|i| FFT(LocalBuf(2048), signal[i])});	

    signal = IFFT(PV_MagFreeze(chain, freeze)); 
    
	ReplaceOut.ar(out, signal)

}).add;


/**************************** 
        SPECTRAL COMB 
*****************************/

~dirt.addModule('spectral-comb', { |dirtEvent|
	dirtEvent.sendSynth('spectral-comb' ++ ~dirt.numChannels,
		[
			comb: ~comb,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~comb.notNil}); // play synth only if at least one of the two was given

SynthDef("spectral-comb" ++ numChannels, { |out, comb, sustain|

	var signal, chain, in, clean, teeth=256;

	signal = In.ar(out, numChannels);

    chain = Array.fill(signal.size, {|i| FFT(LocalBuf(2048), signal[i])});	

    signal = IFFT(PV_RectComb(chain, numTeeth: teeth*comb, width:1-comb)); 
    
	ReplaceOut.ar(out, signal)

}).add;

/**************************** 
        SPECTRAL SMEAR 
*****************************/

~dirt.addModule('spectral-smear', { |dirtEvent|
	dirtEvent.sendSynth('spectral-smear' ++ ~dirt.numChannels,
		[
			smear: ~smear,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~smear.notNil}); // play synth only if at least one of the two was given

SynthDef("spectral-smear" ++ numChannels, { |out, smear, sustain|

	var signal, chain, in;

	signal = In.ar(out, numChannels);

    chain = Array.fill(signal.size, {|i| FFT(LocalBuf(2048), signal[i])});	

    signal = IFFT(PV_MagSmear(chain, bins: smear*100)); 

	ReplaceOut.ar(out, signal)

}).add;

/**************************** 
        SPECTRAL SCRAMBLE 
*****************************/

~dirt.addModule('spectral-scram', { |dirtEvent|
	dirtEvent.sendSynth('spectral-scram' ++ ~dirt.numChannels,
		[
			scram: ~scram,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~scram.notNil}); // play synth only if at least one of the two was given

SynthDef("spectral-scram" ++ numChannels, { |out, scram, sustain|

	var signal, chain, in, clean, teeth=256;

	signal = In.ar(out, numChannels);

    clean = signal;

    chain = Array.fill(signal.size, {|i| FFT(LocalBuf(2048), signal[i])});	
    
    signal = IFFT(PV_BinScramble(chain, wipe: scram, width: scram)); 
    
	ReplaceOut.ar(out, signal)

}).add;

/**************************** 
        SPECTRAL BINSHIFT 
*****************************/

~dirt.addModule('spectral-binshift', { |dirtEvent|
	dirtEvent.sendSynth('spectral-binshift' ++ ~dirt.numChannels,
		[
			binshift: ~binshift,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~binshift.notNil}); // play synth only if at least one of the two was given

SynthDef("spectral-binshift" ++ numChannels, { |out, binshift, sustain|

	var signal, chain, in, clean, teeth=256;

	signal = In.ar(out, numChannels);

    clean = signal;

    chain = Array.fill(signal.size, {|i| FFT(LocalBuf(2048), signal[i])});	
    
    signal = IFFT(PV_BinShift(chain, stretch:binshift.range(0.01,4),
    shift:binshift.range(0,10), interp:0)); 
 
	ReplaceOut.ar(out, signal)

}).add;

/**************************** 
SPECTRAL HIGH PASS FILTER 
*****************************/

~dirt.addModule('spectral-hbrick', { |dirtEvent|
	dirtEvent.sendSynth('spectral-hbrick' ++ ~dirt.numChannels,
		[
			hbrick: ~hbrick,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~hbrick.notNil}); // play synth only if at least one of the two was given

SynthDef("spectral-hbrick" ++ numChannels, { |out, hbrick, sustain|

	var signal, chain, in, clean, teeth=256;

	signal = In.ar(out, numChannels);

    clean = signal;

    chain = Array.fill(signal.size, {|i| FFT(LocalBuf(2048), signal[i])});	
    
    signal = IFFT(PV_BrickWall(chain, wipe:hbrick)); 
 
	ReplaceOut.ar(out, signal)

}).add;

/**************************** 
    SPECTRAL LOW PASS FILTER 
*****************************/

~dirt.addModule('spectral-lbrick', { |dirtEvent|
	dirtEvent.sendSynth('spectral-lbrick' ++ ~dirt.numChannels,
		[
			lbrick: ~lbrick,
			sustain: ~sustain,
			out: ~out
		]
	)
}, { ~lbrick.notNil}); // play synth only if at least one of the two was given

SynthDef("spectral-lbrick" ++ numChannels, { |out, lbrick, sustain|

	var signal, chain, in, clean, teeth=256;

	signal = In.ar(out, numChannels);

    clean = signal;

    chain = Array.fill(signal.size, {|i| FFT(LocalBuf(2048), signal[i])});	
    
    signal = IFFT(PV_BrickWall(chain, wipe:lbrick.range(0,-1))); 
 
	ReplaceOut.ar(out, signal)

}).add;


)
