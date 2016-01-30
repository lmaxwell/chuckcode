
SndBuf click => Master.chan[4];

"audio/hihat_02.wav" => click.read;

0.4=>click.gain;
click.samples()=>click.pos;

Master.T=>dur T;
T-(now%T)=>now;


Euclid seq;
seq.compute(16,9);

while(true)
{
	for (0=>int i;i<16;i++)
	{
		if(seq.bitmap[i]==1)
			0=>click.pos;
		T/16=>now;		
	}
}
