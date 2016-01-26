
*Calculate the home and yard index (HY01)*****************************************************************;
  data ssn0007.hy (keep= subjid HY01 i12 i13 i14 i15 i16 i17 i18) ;
  set jhsv1.paca ;
    array old (*)  PACA13 PACA14 PACA15 PACA16 PACA17 PACA18 ; 
    array new (*)  i13 i14 i15 i16 i17 i18 ; 

  *Recode ; 
    if PACA12 = 'A' then i12 = 1 ;/*less than 1 hour per week*/
      else if PACA12 = 'B' then i12 = 3 ; /*at least 1 but less than 20*/
      else if PACA12 = 'C' then i12 = 5 ; /*more than 20)*/
      else i12 = . ;
      
    do i=1 to dim(old);
     if old(i) = 'A' then new(i)=1 ;/*less than 1 hour per week*/
      else if old(i) = 'B' then new(i)=2 ;  
      else if old(i) = 'C' then new(i)=3 ;  
      else if old(i) = 'D' then new(i)=4 ;   
      else if old(i) = 'E' then new(i)=5 ; 
      else new(i) = . ; 
    end;

    *Home/yard index missing if one of the above scores is missing;
      HY01 =((i12+i13+i14+i15+i16+i17+i18 )/7) ;

    label  i12    = "Weekly caregiving time"  
         i13    = "Weekly meal prep/cleanup time"
         i14    = "Frequency of major cleaning"  
         i15    = "Frequency routine cleaning"
         i16    = "Frequency gardening/yard work"  
         i17    = "Frequency heavy outdoor work"
         i18    = "Frequency major home repair activities" 
         HY01  = "Home/yard Index" ;
  run;

