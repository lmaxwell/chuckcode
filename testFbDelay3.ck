adc => FbDelay fbd => dac;






Master.T=>dur T;

T/4=>dur time;
T - (now%T) => now;

fbd.setTime(time*3.0/4.0);
fbd.setFeedBack(0.6);
fbd.setMix(0.5);


while(true)
{
	time/2=>now;

	time/2=>now;
}
