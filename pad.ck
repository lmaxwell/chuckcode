SawOsc s1 => ADSR e =>Gain g=> FbDelay d[2];
d[0]=> Master.chan[6];
d[1]=> Master.chan[7];
SawOsc s2=>e;
SawOsc s3=>e;


0.1=>g.gain;
//0.1=>r[0].mix;
//0.12=>r[1].mix;

d[0].setTime(0.2::second);
d[0].setFeedBack(0.5);
d[0].setMix(0.5);

d[1].setTime(0.1::second);
d[1].setFeedBack(0.5);
d[1].setMix(0.5);

e.set(10::ms,10::ms,0.8,100::ms);
//e.set(0.0001,0.005,0.55,0.01);
while(true)
{
	Math.random2(40,50)=> int p;
	p=>Std.mtof=>s1.freq;
	p+4=>Std.mtof=>s2.freq;
	p+7=>Std.mtof=>s3.freq;
	e.keyOn();
	0.01::second=>now;
	e.keyOff();
	0.5::second=>now;
}
