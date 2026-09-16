/*
   Issue Description: CDM-27984
   Category/ Module  : remove service case 
   Root cause: user wants to delete service case
   Pull request# for code fix: 7659
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update servicecase set activeflag =0, updatedby = 'CDM-27984', updatedon = now() 
where servicecaseid = 'a6bfd40f-2ae4-4085-a77f-3849b4b5857c';

update caseassignment set activeflag = 0, updatedby = 'CDM-27984', updatedon = now() 
where objectid = 'a6bfd40f-2ae4-4085-a77f-3849b4b5857c' and activeflag = 1 ;

update servicecasedisposition set activeflag = 0, updatedby = 'CDM-27984', updatedon = now() 
where servicecaseid = 'a6bfd40f-2ae4-4085-a77f-3849b4b5857c';