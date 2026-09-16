/*
   Issue Description: CDM-16127
   Category/ Module  :  case approval
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/


update intakeservreqchildremoval 
	set exitdate = '2021-05-12 19:47:10', updatedby = 'CDM-16703', updatedon = now() 
	where intakeservreqchildremovalid = '43391361-e4cd-4951-9104-3a8a4b0ffa00';

	update personprogramarea
	set enddate = '2021-05-12 00:00:00', updatedby = 'CDM-16703', updatedon = now()
	where personprogramid = 'db406170-d915-491d-8a26-618f1f0b2f2c';