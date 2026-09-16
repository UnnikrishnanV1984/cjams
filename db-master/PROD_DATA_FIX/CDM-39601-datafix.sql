/*
  Issue Description:  CDM-39601
   Category/ Module  :  permanency plan
   Root cause:Migrated case error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update permanencyplan 
set enddate = null,
	updatedby = 'CDM-39601',
	updatedon = now()
where permanencyplanid = '5d955bef-6ebf-4a28-891f-df1f45fa7642'
	and activeflag  = 1 ;