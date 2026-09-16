/*
   Issue Description: CDM-26350
   Category/ Module  : Continuing Issue with CJAMS-33617
   Root cause: Need to remove from to be assigned 
   Pull request# for code fix: 
   Explanantion: User wants to remove from assignservicecase ---> to be assigned
*/

update
    servicecase
set
    statustypekey = 'ASSGN',
    dispositioncode = NULL,
    updatedon = now(),
    updatedby = 'CDM-26350'
where
    servicecaseid = '5f8082ee-c288-41f1-adfb-51bc25ba3c11'
    and servicecasenumber = '221030014808';