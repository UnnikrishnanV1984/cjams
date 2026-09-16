/*
  Issue Description:  CDM-39679
   Category/ Module  :  Application
   Root cause: user requested to add Enrollement end date.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


update personeducation set enrollmentdate='2023-08-26 00:00:00',updatedby='CDM-39679',updatedon=now()
where personeducationid='da9bebcc-5c95-4715-ae0a-adb11058bcfd' and personid='c956ef72-1e6c-4362-86f7-3ea3b8ccf887';