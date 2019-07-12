(
s.quit;
~supercoll = OSSIA_Device('SC');
~supercoll.exposeOSC;
s = Server.local;
s.quit;
o = s.options;
o.sampleRate = 48000;
o.device = "JackRouter";
o.memSize = 64 * 8192;
o.numInputBusChannels = 23;
o.numOutputBusChannels = 2;
o.numAudioBusChannels = 2048;
o.numWireBufs = 512;
s.waitForBoot {
/*
	~decoder = FaustChateauBonnefont3; ~order = 3; ~out = 4; ~sub = [0, 1]; // ADTB Dome
	~setup = [ [ 0, 90, 1.601],[ -45, 50, 1.565 ], [ -135, 50, 1.565 ], [ 135, 50, 1.565 ],
		[ 45, 50, 1.565 ], [ -30, 20, 2.062 ], [ -90, 20, 2.062 ], [ -150, 20, 2.062 ],
		[ 150, 20, 2.062 ], [ 90, 20, 2.062 ], [ 30, 20, 2.062 ], [ -22.5, -3, 2.829 ],
		[ -67.5, -3, 2.829 ], [ -112.5, -3, 2.829 ], [ -157.5, -3, 2.829 ], [ 157.5, -3, 2.829 ],
		[ 112.5, -3, 2.829 ], [ 67.5, -3, 2.829 ], [ 22.5, -3, 2.829 ] ];
	*/

	~decoder = FoaDecoderKernel.newCIPIC(21, s, 48000); ~order = 1; ~out = 0; ~sub = nil; ~setup = nil;
	// Binaural
    s.sync;
    //MIDIIn.connect();  // must connect to MIDI for MMC synch
    s.sync;
    ~instaceOfMosca = Mosca(
        projDir: "/Users/christophe/Documents/Travaux/SPIN/spin52-master",
		nsources: 16,
        width: 850,
        dur: 60,
        decoder: ~decoder,
		speaker_array:~setup,
        maxorder:~order,
        outbus:~out,
        suboutbus:~sub,
        parentOssiaNode:~supercoll;
    );

	s.sync;
	~instaceOfMosca.loadNonAutomationData("/Users/christophe/Documents/Travaux/SPIN/spin52-master/auto");

};
)

a = ServerOptions;
a.devices;

