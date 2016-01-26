
*Calculate the active living index (acl01)************************************************************************;
	 data pa.acl (keep=subjid acl01 i1 i2 i3 tlv01);
		set jhsv1.paca (drop=PAGREPEAT PACA32);
			array old (4) PACA1 PACA3 PACA4 PACA6 ;
			array new (4) i1 i2 i3 tlv01 ;

		*Recode PACA variables;
			do i=1 to dim(old);
			 if old(i) = 'A' then new(i)=1 ;		 /*less than 1 hour per week*/
				else if old(i) = 'B' then new(i)=2 ; /*at least 1 hour a week but less than 7 hours a week*/
				else if old(i) = 'C' then new(i)=3 ; /*at least 1 hour per day but less than 2 hours a day*/
				else if old(i) = 'D' then new(i)=4 ; /*at least 2 hours a day but less than 4 hours a day*/
				else if old(i) = 'E' then new(i)=5 ; /*4 or more hours a day*/
			end;

		*Active living index missing if one of the above scores is missing;
			ACL01 = ((i1 + i2 + i3 + (6 - tlv01))/4) ;

		label  i1    = "Time spent walking/biking for work/errands"  
			   i2    = "Frequency of walking during leisure time"
			   i3    = "Frequency of biking during leisure time"
			   tlv01 = "Frequency of TV watching" 
			   ACL01 = "Active Living Index" ;
	run;

