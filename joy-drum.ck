// which joystick
0 => int device;
// get from command line
if( me.args() ) me.arg(0) => Std.atoi => device;

SndBuf kick => Master.chan[2];

"audio/kick_01.wav" => kick.read;


kick.samples()=>kick.pos;

SndBuf snare => Master.chan[3];

"audio/snare_01.wav" => snare.read;

snare.samples()=>snare.pos;


Master.T=>dur T;
T-(now%T)=>now;

int base;
float a0;
float a1;
float a2;
int count;
// hid objects
Hid hi;
HidMsg msg;
// try
if( !hi.openJoystick( device ) ) me.exit();
<<< "joystick '" + hi.name() + "' ready...", "" >>>;

// infinite time loop
while( true )
{
    // wait on event
    hi => now;
    // loop over messages
    while( hi.recv( msg ) )
    {
        if( msg.isAxisMotion() )
        {
            if( msg.which == 0 ) msg.axisPosition => a0;
            else if( msg.which == 1 ) msg.axisPosition => a1;
            else if( msg.which == 2 ) msg.axisPosition => a2;
            set( base, a0, a1, a2 );
        }

        else if( msg.isButtonDown() )
        {
            msg.which => base;
            count++;
            set( base, a0, a1, a2 );
        }

        else if( msg.isButtonUp() )
        {
            msg.which => base;
            count--;
        }
    }
}

// mapping function
fun void set( int base, float v0, float v1, float v2 )
{
   if (base==3)
	0=>kick.pos;
   if(base==4)
	0=>snare.pos;
}
