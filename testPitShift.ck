adc => PitShift p => dac;


0.5=>p.mix;
while(true)
{
	Math.random2f(0,10)=>p.shift;
	2000::ms=>now;
}
