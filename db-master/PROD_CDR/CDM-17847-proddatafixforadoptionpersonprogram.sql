
/*
   Issue Description: CDM-17847
   Category/ Module  :  Child person program area removal
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--2020-06-18 00:00:00
update personprogramarea set enddate = null, updatedby = 'CDM-17847', updatedon = now() where personprogramid = '82901a3b-64e5-4410-a379-7aa062c68af6';
