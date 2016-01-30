KBHit kb;
while(true)
{
	kb=>now;
	while(kb.more())
	{
		kb.getchar()=>int c;
		if(c==61 && Master.out.gain()<1.0)
		{
			Master.out.gain() + 0.1=> Master.out.gain;
			<<<c,"Master Gain:",Master.out.gain()>>>;
		}
		if(c==45 && Master.out.gain()>0.00009)
		{
			Master.out.gain() - 0.1=> Master.out.gain;
			<<<c,"Master Gain:",Master.out.gain()>>>;
		}

	}
	
}

