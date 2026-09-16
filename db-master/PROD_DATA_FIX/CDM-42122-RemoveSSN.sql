/*
  Issue Description:  CDM-42122
   Category/ Module: Persons
   Root cause: User request to remove SSN attached to multiple clients
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update
    person
set
    ssnno = null,
    updatedby = 'CDM-42122',
    updatedon = now()
where
    cjamspid = 1955982
    and activeflag = 1;

update
    personidentifier
set
    activeflag = 0,
    updatedby = 'CDM-42122',
    updatedon = now()
where
    personid = 'c1d3f860-e395-4f72-a6c7-eb540a8935b0'
    and personidentifiertypekey = 'SSN'
    and activeflag = 1;