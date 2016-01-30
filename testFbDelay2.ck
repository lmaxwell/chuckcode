
Impulse i => ResonZ rez  => FbDelay fbd[2];
fbd[0]=>Master.chan[0];
fbd[1]=>Master.chan[1];

100=>rez.Q;
200=>rez.gain;



Master.T=>dur T;

T/4=>dur time;
T - (now%T) => now;

fbd[0].setTime(time*3.0/4.0);
fbd[0].setFeedBack(0.6);
fbd[0].setMix(0.5);

fbd[1].setTime(time*1.0/4.0);
fbd[1].setFeedBack(0.6);
fbd[1].setMix(0.5);



[60,64,65,67,70,72] @=> int notes[];
notes.cap() - 1 => int numNotes;

while(true)
{
	notes[Math.random2(0,numNotes)]=>Std.mtof=>rez.freq;
	//Math.random2(40,52)=>Std.mtof => s.freq;
	20.0=>i.next;
	time=>now;
}
