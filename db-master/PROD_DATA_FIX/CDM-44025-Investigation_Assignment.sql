
/*
   Issue Description: CDM-44025
   Category/ Module  : cases have been closed but still showing as open
   Root cause: user wants to closed however they are still showing on workers workload as open. 
   Pull request# for code fix: 4681
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update caseassignment set enddate = '2024-11-15', updatedon = now(), updatedby = 'CDM-44025'
where caseassignmentid in ('cccf7ad2-f0b4-43aa-9793-53ab4eeb4942','1b6157e5-fc94-41b8-b065-bc40fd53b33c') and activeflag =1;

