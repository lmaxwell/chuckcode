Noise n => Envelope e => LPF lp => dac;

e.duration(40::ms);
400=>lp.freq;
e.value(1);

while(true)
{
	e.keyOff();
	1000::ms=>now;
	e.keyOn();
	e.value(1);
	
}
