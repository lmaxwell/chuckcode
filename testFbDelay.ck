BeeThree bt => FbDelay fbd => Master.chan[2];


bt.noteOff(1.0);



Master.T=>dur T;

T/4=>dur time;
T - (now%T) => now;

fbd.setTime(time*3.0/4.0);
fbd.setFeedBack(0.6);
fbd.setMix(0.5);

[60,64,65,67,70,72] @=> int notes[];
notes.cap() - 1 => int numNotes;

while(true)
{
	bt.noteOn(1.0);
	time/2=>now;

	bt.noteOff(1.0);
	time/2=>now;
}
