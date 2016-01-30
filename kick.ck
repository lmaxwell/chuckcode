SndBuf kick => Master.chan[2];

"audio/kick_01.wav" => kick.read;

kick.samples()=>kick.pos;

Master.T=>dur T;
T-(now%T)=>now;

[1,0,0,0,0,0,1,1,0,0,1,1,0,0,0,0] @=> int seq[];

while(true)
{
	for(0=> int i;i<16;i++)
	{
		if(seq[i]==1)
			0=>kick.pos;
		T/16=>now;
	}		


}
