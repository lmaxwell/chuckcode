ADSR adsr;
SndBuf buf => LiSa lisa  => Gain g => NRev rev[2]=>  dac;


3.0=>dac.gain;
 FbDelay fd[2] ;
fd[0].setTime(0.1::second);
fd[1].setTime(0.1::second);


fd[0].setMix(0.5);
fd[1].setMix(0.5);

fd[0].setFeedBack(0.7);
fd[1].setFeedBack(0.7);

0.5=>rev[0].mix=>rev[1].mix;
0.7=>g.gain;

adsr.set(100::ms,1000::ms,1.0,6000::ms);

buf.pos(-1);
buf.read("/home/lxian/code/myproject/ocwmit/21m-361/150427-184116.WAV");

//set lisa buffer size to sample size
buf.samples() * 1::samp => lisa.duration;

//transfer values from SndBuf to LiSa
for ( 0 => int i; i < buf.samples(); i++ ) {

	//args are sample value and sample index (dur must be integral in samples)
	lisa.valueAt(buf.valueAt(i), i::samp);
	
}

spork ~update();
1.0 => float newrate;
100::ms => dur newdur;
10::ms => dur newpos;
	    Math.random2f( 1.3, 2.5 ) => newrate;
		Math.random2f(10,40 ) * 1::ms => newdur;
		Math.random2f(0,(lisa.duration()-70::ms)/second)*1::second=> newpos;fun void update(){
	while(true)
	{
	    Math.random2f( 2.3, 4.5 ) => newrate;
		Math.random2f(10,40 ) * 1::ms => newdur;
		Math.random2f(0,(lisa.duration()-700::ms)/second)*1::second=> newpos;
		100000::ms => now;
	}
}

fun void adsrc()
{
		adsr.keyOn();
		1::second =>now;
		adsr.keyOff();
		1::second=>now;
}



 spork ~ getgrain( 2::ms, 2::ms );

while(true)
{
10::ms=>now;	
}


// sporkee
fun void getgrain( dur rampup, dur rampdown )
{
    lisa.getVoice() => int newvoice;
    <<<newvoice>>>;
		while(true)
		{
			<<<newvoice>>>;
        lisa.rate(newvoice, newrate);
        // lisa.playpos(newvoice, Math.random2f(0., 1000.) * 1::ms);
        lisa.playPos(newvoice, newpos);
        // <<< lisa.playpos(newvoice) >>>;
        lisa.rampUp( newvoice, rampup );
        (newdur - ( rampdown)) => now;
        lisa.rampDown( newvoice, rampdown );
        rampdown => now;
		}
}
