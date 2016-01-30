SndBuf snare => Master.chan[3];

"audio/snare_01.wav" => snare.read;

snare.samples()=>snare.pos;

Master.T=>dur T;
T-(now%T)=>now;

[0,2,0,0,1,0,0,0,0,2,0,0,1,0,0,0] @=> int seq[];

while(true)
{
	for (0=>int i;i<16;i++)
	{
		Math.random2f(-1,2)=>snare.rate;
		if(seq[i]==1)
			0=>snare.pos;
		if(seq[i]==2 && Math.random2f(0,1)>0.5)
			0=>snare.pos;
		T/16=>now;		
	}
}
