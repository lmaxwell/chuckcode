Noise n => Envelope e => LPF lp => FbDelay fd => Gain gain=> Pan2 pan;
pan.left=>Master.chan[4];
pan.right=>Master.chan[5];

Master.T => dur T;
T - (now%T) => now;
e.duration(40::ms);
800=>lp.freq;
e.value(1);

fd.setTime(T/16);
fd.setFeedBack(0.6);
fd.setMix(1.0);

0.3=>gain.gain;

while(true)
{
	Math.random2(600,1500)=>lp.freq;
	Math.random2f(-1.0,1.0)=>pan.pan;
	Math.random2(10,110)::ms => e.duration;
	//e.keyOn();
	e.keyOff();
	T/4=>now;
	//e.keyOn();
	e.value(1);
}
