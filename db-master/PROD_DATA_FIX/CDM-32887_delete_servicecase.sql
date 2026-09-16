/*
   Issue Description: CDM-32887
   Category/ Module  :  delete service case
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   this is a defect raised from person merge 
*/


update servicecase set activeflag = 0, updatedby = 'CDM-32887', updatedon = now()
where servicecaseid = '1ada35a6-af68-49f7-8cb1-5d76f29665e5';

update servicecasedisposition set activeflag = 0, updatedon = now(), updatedby = 'CDM-32887' 
where servicecaseid = '1ada35a6-af68-49f7-8cb1-5d76f29665e5' and servicecasedispositionid = '6be73307-19f0-4a7a-9cbd-8ffb76aad5da';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-32887' 
where routingid ='7ab0c250-ec07-4c3d-981b-056f35869f7f' and objectid = '1ada35a6-af68-49f7-8cb1-5d76f29665e5';

update caseassignment set activeflag = 0, updatedon = now(), updatedby = 'CDM-32887' 
where caseassignmentid ='8e74e7ab-9d38-40db-abec-caa895e2f096' and objectid = '1ada35a6-af68-49f7-8cb1-5d76f29665e5';
