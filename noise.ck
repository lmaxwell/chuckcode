Noise n => LPF lp => ADSR adsr => Master.chan[5];


Master.T=>dur time;

time - (now % time)=>now;

Envelope adsr2 => blackhole;

adsr2.duration(Master.T);
adsr2.value(0);
adsr2.target(2310);

spork ~ sweep();
adsr.set(time,0::ms,1.0,0::ms);
while(true)
{
	adsr.keyOn();
	adsr2.keyOn();
	time*3.5/4.0=>now;
	adsr.keyOff();
	time*0.5/4.0=>now;
	//adsr2.keyOff();
	adsr2.value(0);
}

fun void sweep()
{

	while(true)
	{
		adsr2.value() => lp.freq;
		10::ms=>now;
	}
}
