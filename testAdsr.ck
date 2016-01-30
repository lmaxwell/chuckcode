1=> int NUM;
ADSR adsr;
FbDelay fd;
//Phasor s[NUM] => adsr => FbDelay fd=> dac;
Blit s => adsr => fd =>  dac;
//SawOsc s  => adsr => dac;

fd.setTime(400::ms);
fd.setFeedBack(0.5);
fd.setMix(0.5);
adsr.set(100::ms,1000::ms,0,1000::ms);

16=>s.harmonics;

while(true)
{
	Math.random2(70,90) => Std.mtof => s.freq;
	adsr.keyOn();
	1.5::second=>now;
	adsr.keyOff();
	1::second=>now;

}
