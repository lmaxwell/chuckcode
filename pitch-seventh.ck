//--
// name: pitch-seventh.ck
// desc: rough pitch tracking + dominant 7th
//
// author: Rebecca Fiebrink + Ge Wang
// date: 2007
//--
// number of the device to open (see: chuck --probe)
0 => int device;
// get command line
if( me.args() ) me.arg(0) => Std.atoi => device;

// the midi event
MidiIn min;
// the message for retrieving data
MidiMsg msg;

// open the device
if( !min.open( device ) ) me.exit();

// print out device that was opened
<<< "MIDI device:", min.num(), " -> ", min.name() >>>;

0=>int inter;
// analysis
adc => PoleZero dcblock => FFT fft => blackhole;
// synthesis
SinOsc s => JCRev r => dac;

// set reverb mix
.05 => r.mix;
// set to block DC
.99 => dcblock.blockZero;
// set FFT params
1024 => fft.size;
// window
Windowing.hamming( fft.size() ) => fft.window;

// interpolate
float target_freq, curr_freq, target_gain, curr_gain;
spork ~ ramp_stuff();
spork ~midi();
// go for it
while( true )
{
    // take fft
    fft.upchuck() @=> UAnaBlob blob;
    
    // find peak
    0 => float max; float where;
    for( int i; i < blob.fvals().cap(); i++ )
    {
        // compare
        if( blob.fvals()[i] > max )
        {
            // save
            blob.fvals()[i] => max;
            i => where;
        }
    }
    
    // set freq
    (where / fft.size() * (second / samp)) * Math.pow(1.059,inter) => target_freq;
    // set gain
    (max / .25) => target_gain;
    
    // hop
    (fft.size()/2)::samp => now;
}


// interpolation
fun void ramp_stuff()
{
    // mysterious 'slew'
    0.025 => float slew;
    
    // infinite time loop
    while( true )
    {
        (target_freq - curr_freq) * 5 * slew + curr_freq => curr_freq => s.freq;
        (target_gain - curr_gain) * slew + curr_gain => curr_gain => s.gain;
        0.0025::second => now;
    }
}



fun void midi(){
// infinite time-loop
while( true )
{
    // wait on the event 'min'
    min => now;

    // get the message(s)
    while( min.recv(msg) )
    {
		<<<msg.data1,msg.data2,msg.data3>>>;
        // print out midi message
        if(msg.data1==176)
		{
			if(msg.data2==0)
			{
				msg.data2 => int ich;
				msg.data3/12.7 $ int=> inter;
			}
			if(msg.data2==1)
			{
				msg.data3/127.0 => dac.gain;
			}


		}
    }
}
}
