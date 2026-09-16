/*
   Issue Description: CDM-19807
   Category/ Module  : cases have been closed but still showing as open
   Root cause: user wants to closed however they are still showing on workers workload as open. 
   Pull request# for code fix: 4681
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update caseassignment set enddate = '2021-12-30 09:37:00', updatedby = 'CDM-19807', updatedon = now() where caseassignmentid = 'e638adb0-1b92-42fa-89c1-757fcd6269cd';
update caseassignment set enddate = '2022-01-03 16:01:00', updatedby = 'CDM-19807', updatedon = now() where caseassignmentid = '7927ad49-d242-4042-b6ba-630acce98856';
update caseassignment set enddate = '2021-12-30 09:33:00', updatedby = 'CDM-19807', updatedon = now() where caseassignmentid = 'ba45536e-a08d-48f1-8847-02e8c6cf3933';
