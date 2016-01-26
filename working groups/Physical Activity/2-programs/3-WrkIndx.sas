*Calculate the work index*****************************************************************;
data pa.work (keep=subjid PA8  WRK01A i5  i6  i7  i8 i9 i10 i11 OCI01 ) ;
	merge jhsv1.paca(in=a) 
	npa.OccpIntensity(in=b keep=subjid oci01 );

	by subjid;

	array old (*) PACA9  PACA10  PACA11A  PACA11B PACA11C PACA11D PACA11E ;
	array new (*) i5  i6  i7  i8 i9 i10 i11 ;

	*Recode ; 
		do i=1 to dim(old);
		 if old(i) = 'A' then new(i)=1 ;
			else if old(i) = 'B' then new(i)=2 ;  
			else if old(i) = 'C' then new(i)=3 ;  
			else if old(i) = 'D' then new(i)=4 ;   
			else if old(i) = 'E' then new(i)=5 ; 
			else new(i) = . ; 
		end;

	*convert PACA8 to numeric 1=Yes,0=No;
		PA8=. ;
		if PACA8 ne ' ' then do;
			if PACA8='N' then PA8=0;
			else if PACA8='Y' then PA8=1;
		end;

	*Work index missing if PACA8 = no OR  one of the above scores is missing;
		WRK01A = ((i5 + i6 + i8 + i9 + i10 + i11 + OCI01 +(6-i7))/8) ;

		
	  label PA8  = "Work for pay/volunteer in past year"
			WRK01A = "Work Index"
			i5   = "Physical difficulty of work compared to peers"
			i6   = "Physically tired after work"
			i7   = "Frequency sitting at work"
			i8   = "Frequency standing at work"
			i9   = "Frequency walking at work"
			i10  = "Frequency lifting heavy loads at work"
			i11  = "Frequency sweating at work from exertion"
			OCI01= "Occupation intensity";
run;
