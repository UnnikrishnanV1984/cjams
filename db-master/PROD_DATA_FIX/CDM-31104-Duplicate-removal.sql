/*
   Issue Description: CDM-31104
   Category/ Module  : child removal 
   Root cause: user requested 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-31104', updatedon = now ()
where intakeservreqchildremovalid ='68d92d09-efd2-46a2-b2f5-ad128c71d9d7';

update cjams.intakeservreqchildremoval_history set activeflag =0, updatedby ='CDM-31104', updatedon = now ()
where intakeservreqchildremovalid ='68d92d09-efd2-46a2-b2f5-ad128c71d9d7';

UPDATE cjams.routing
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-31104'
WHERE objectid='68d92d09-efd2-46a2-b2f5-ad128c71d9d7';