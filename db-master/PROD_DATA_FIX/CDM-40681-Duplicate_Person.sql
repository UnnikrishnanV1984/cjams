
/*
   Issue Description: CDM-40681
   Category/ Module  : Removing duplicate persons from servicecase
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update actor
set activeflag = 0, updatedby = 'CDM-40681', updatedon = now()
where personid = '1b3e19c0-cdbf-4155-8ed9-f810fd961184' and actorid = '83eecfa4-eaad-4aee-b475-cbb4d116565a'
and activeflag = 1;


update intakeservicerequestactor    
set activeflag = 0, updatedby = 'CDM-40681', updatedon = now()
where personid = '1b3e19c0-cdbf-4155-8ed9-f810fd961184'
and intakeservicerequestactorid = '9faeac8f-0e28-490f-9960-98dd0951a7f4' and activeflag = 1;


update actorrelationship set activeflag = 0, updatedby = 'CDM-40681', updatedon = now() 
where intakeservicerequestactorid in (  
    select intakeservicerequestactorid 
    from intakeservicerequestactor
    where personid = '1b3e19c0-cdbf-4155-8ed9-f810fd961184' 
    and intakeservicerequestactorid = '9faeac8f-0e28-490f-9960-98dd0951a7f4')   
and activeflag = 1; 


update personrole
set activeflag = 0,
    updatedby = 'CDM-40681',
    updatedon = now()
where personroleid = 'b49ee856-01b5-4e7c-9db1-d7ec5c55d310' and activeflag = 1;

update personroletype
set activeflag = 0,
    updatedby = 'CDM-40681',
    updatedon = now()
where personroletypeid in ('1b8b8c44-13cd-42e4-979a-370960bd47dd', '350a6eb3-f9b5-4a1b-bc9a-5b3f3c2faf02','bfea4f4b-2592-4de6-9159-887fe34e760a') and activeflag = 1;

update personprogramarea
set activeflag = 0,
    updatedby = 'CDM-40681',
    updatedon = now()
where personprogramid in ('e6e72aba-6771-4925-921d-0b0ab1460dcd') and activeflag = 1;
