/*
   Issue Description: CDM-31053
   Category/ Module  :Person Tab 
   Root cause: House of headhold missing , wrong person linked with case and intake
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor set activeflag = 0, updatedby ='CDM-31053',updatedon =now() where personid = '7aa4877d-7799-4238-aaf9-84815491c711' and intakeserviceid ='0f2ac823-af6b-4a0a-af0c-c5e5e2c4ddcf' ;

update intakeservicerequestactor set intakenumber = 'I231010561509',updatedby ='CDM-31053',updatedon =now()
where intakeserviceid ='0f2ac823-af6b-4a0a-af0c-c5e5e2c4ddcf' 
and intakeservicerequestactorid ='5da28104-3cac-4de2-b229-d3be4bd3ccf3';



update personprogramarea set entityid = '231020489745',updatedby ='CDM-31053',updatedon =now() where personprogramid ='bda6dec5-6378-456d-9244-ed6d4d8a24cf';
