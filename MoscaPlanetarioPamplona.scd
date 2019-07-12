(
s.quit;
~supercoll = OSSIA_Device('SC');
~supercoll.exposeOSC;
s = Server.local;
s.quit;
o = s.options;
//o.sampleRate = 48000;
//o.device = "MADIface Pro (79250472)";
o.numInputBusChannels = 32;
o.numOutputBusChannels = 15;
o.numAudioBusChannels = 2048;
o.numWireBufs = 512;
s.waitForBoot {

	//~decoder = PlanetarioDePamplona2; ~order = 2; ~out = 1; ~sub = 0; // ADTB Dome
	~decoder = "internal"; ~order = 2; ~out = 1; ~sub = 0; // INTERNAL Dome
    ~setup = [ [ -60, 18, 10 ],
		[ 60, 18, 10 ],
		[ 0, 18, 10 ],
		[ -120, 18, 10 ],
        [ 120, 18, 10 ],
		[ 180, 18, 10 ],
		[ 0, 90, 10 ],
		[ -60, 51, 10 ],
        [ 60, 51, 10 ],
		[ 0, 51, 10 ],
		[ 180, 51, 10 ],
		[ -120, 51, 10 ],
        [ 120, 51, 10 ] ];

	s.sync;
	//MIDIIn.connect();  // must connect to MIDI for MMC synch
	s.sync;
	~testMosca = Mosca(
		//projDir: "/home/iain/projects/ambisonics/moscaproject",
		nsources: 11,
		width: 850,
		dur: 60,
		speaker_array:~setup,
		maxorder:~order,
		outbus:~out,
		suboutbus:~sub,
		decoder: ~decoder,
		parentOssiaNode:~supercoll;
	);

};
)

