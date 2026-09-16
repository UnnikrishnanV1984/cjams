/*
  Issue Description:  CDM-41264
   Category/ Module  :  Child Removal
   Root cause: User request to Data fix to end date the program assignment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update cjams.personprogramarea 
set enddate = '2022-02-09 00:00:00',
	updatedby = 'CDM-41264',
	updatedon = now()
where entityid = '221020172574' 
	and activeflag = 1 ;
