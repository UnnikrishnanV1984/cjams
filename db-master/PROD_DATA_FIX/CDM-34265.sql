 /*
   Issue Description: CDM-34265
   Category/ Module  : personprogram area
   Root cause: As requested by user
   Fix Privided: Did data fix to remove the end date 
*/


update cjams.personprogramarea 
set enddate = null, 
     endreasonkey =null, 
	updatedby = 'CDM-34265',
	updatedon = now()
where personprogramid = '2b264ed1-6fe4-483b-a61b-512d96aea951'
	and activeflag = 1 ;


update cjams.personprogramarea 
set enddate = null, 
     endreasonkey =null,
	updatedby = 'CDM-34265',
	updatedon = now()
where personprogramid = '6ee16b87-80ee-49a2-8aed-c37224018c05'
	and activeflag = 1 ;
