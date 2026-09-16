/*
   Issue Description: CDM-21305
   Category/ Module  :  Reopen service case
   Root cause: user asked to reopen the service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase 
set statustypekey ='Open', 
    dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-21305',
    updatedon = now() 
where servicecaseid = '6be7d3c0-b496-4fce-976e-0607b453139a';

update servicecasedisposition 
set activeflag = 0, 
    updatedby = 'CDM-21305',
    updatedon = now() 
where servicecasedispositionid = '1eae6715-99f4-4e60-a9f6-309e7d94296a';

update personprogramarea
set enddate = null, updatedby = 'CDM-21305', updatedon = now()
where personprogramid in ('7bb69893-8a95-423b-a538-ea24ab672dcd', '8c398075-618e-41aa-b530-36bce923d4b0', '8ce589d2-fdec-4ccf-8437-16fecb007c42');


update caseassignment 
set enddate = null,  updatedby = 'CDM-21305', updatedon = now()
where caseassignmentid in ('fcfee495-a817-4727-b2d0-94d8c1c34e08', 'aaa845cf-0372-4be1-9e0d-a48d72498842');
