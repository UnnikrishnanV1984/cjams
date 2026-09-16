/* 
    Issue Description: CDM-38210
   Category/ Module  : Child Removal Review
   Root cause: A duplicate Child Removal Review was submitted for this case on 4/5/24, the duplicate can not be removed. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/


update cjams.intakeservreqchildremoval set activeflag =0, updatedby ='CDM-38210', updatedon = now ()
where intakeservreqchildremovalid ='207b64ae-03f5-49ee-835c-74bc92e8a79d';

update cjams.intakeservreqchildremoval_history set activeflag =0, updatedby ='CDM-38210', updatedon = now ()
where intakeservreqchildremovalid ='207b64ae-03f5-49ee-835c-74bc92e8a79d';

UPDATE cjams.routing
SET  activeflag = 0 , updatedon = now(), updatedby = 'CDM-38210'
WHERE objectid='207b64ae-03f5-49ee-835c-74bc92e8a79d';