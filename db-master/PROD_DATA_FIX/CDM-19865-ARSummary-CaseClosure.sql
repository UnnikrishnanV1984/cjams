/*
   Issue Description: CDM-19865
   Category/ Module  : A R Summary case closure status
   Root cause: user wants to display the case clousure status
   Pull request# for code fix: 4710
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update caseclosuresummary set closuretypekey = 'CONS', updatedby = 'CDM-19865', 
updatedon = now() where caseclosuresummaryid = '2ed3b613-9329-4eaf-8e73-acba57e61648';

