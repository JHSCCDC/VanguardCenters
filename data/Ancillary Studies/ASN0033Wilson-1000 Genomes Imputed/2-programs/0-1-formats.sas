proc format library = asn0033;

  value rs28362286fm 
    2     = "AA: Minor-Minor"  
    1     = "AC: Heterogeneous"  
    0     = "CC: Major-Major"
    .     = " "  
    other = "Imputed";

  value rs2814778fm 
    2     = "AA: Minor-Minor"  
    1     = "AG: Heterogeneous"  
    0     = "GG: Major-Major"  
		.     = " "  
    other = "Imputed";

  value rs7626962fm 
    2     = "AA: Minor-Minor" 
    1     = "AC: Heterogeneous"  
    0     = "CC: Major-Major"  
		.     = " "  
    other = "Imputed";

  value  rs33930165fm 
    2     = "AA: Minor-Minor"
    1     = "AC: Heterogeneous" 
	  0     = "CC: Major-Major"
	  .     = " "  
    other = "Imputed";
 
  run ;
