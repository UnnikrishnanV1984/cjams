/*
   Issue Description: CDM-41259
   Category/ Module  : Application  
   Root cause: user requested to remove the program assignment and Removal history as its created by error
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


UPDATE cjams.personprogramarea
set activeflag = 0 where 
personprogramid ='bab87266-6250-44ce-bacb-4c15ef961b31' and activeflag = 1;

UPDATE intakeservreqchildremoval 
SET activeflag =0,
    updatedby ='CDM-41259',
    updatedon = now()
WHERE intakeservreqchildremovalid = '744d672f-7de5-4b45-87b3-4a3907751233' and activeflag =1;

UPDATE tb_client_eligibility 
SET 
     delete_sw = 'Y'
    , update_user_id = 'CDM-41259'
    , update_ts = now()
WHERE removal_id ='322429' and delete_sw = 'N';

update routing
SET activeflag =0,
    updatedby ='CDM-41259',
    updatedon = now()
 where routingid ='744d672f-7de5-4b45-87b3-4a3907751233'; 