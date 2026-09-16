
 /*
  Issue Description: CJAMS-66141 Person name change
   Category/ Module  :  Person Profile
   Root cause: E&E data update
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/


update person
set firstname='Jordana',lastname='Marie', updatedby='CJAMS-66141', updatedon=now()  
where personid = '50efb316-5b4b-482e-bd91-06f7ab5b89cd' and activeflag = 1;