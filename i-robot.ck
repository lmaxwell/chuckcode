
BeeThree bt; 
adc=> FbDelay fbd => Master.chan[2];


bt.noteOff(1.0);

fbd.setTime(15::ms);
fbd.setFeedBack(0.95);
fbd.setMix(0.95);

Master.T=>dur T;

T/4=>dur time;
T - (now%T) => now;



[60,64,65,67,70,72] @=> int notes[];
notes.cap() - 1 => int numNotes;

while(true)
{
	bt.noteOn(1.0);
	time/2=>now;

	bt.noteOff(1.0);
	time/2=>now;
}
