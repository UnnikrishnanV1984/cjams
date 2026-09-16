/*
   Issue Description: CDM-44077
   Category/ Module  :  Case assingnement
   Root cause: user requeseted to updated case assingment end date.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update caseassignment set enddate ='2025-01-27 00:00:00', updatedon = now(), updatedby ='CDM-44077'
where caseassignmentid='0a374e25-d25c-4898-9a69-7d1ce1cc367d' and objectid ='1c993c80-61bd-4a50-aefe-12e6ba32402a' and activeflag =1;