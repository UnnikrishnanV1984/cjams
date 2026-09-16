/*
   Issue Description: CDM-39155
   Category/ Module  : Child removal
   Root cause: The rejected child removal created in-error and need to be removed so the GAP Closing Checklist can be saved and completed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE intakeservreqchildremoval 
SET activeflag =0,
    updatedby ='CDM-39155',
    updatedon = now()
WHERE intakeservreqchildremovalid = '9cb76930-0f37-4d54-8914-ea3a05ecf494' and activeflag =1;

UPDATE tb_client_eligibility 
SET 
     delete_sw = 'Y'
    , update_user_id = 'CDM-39155'
    , update_ts = now()
WHERE removal_id ='313109' and delete_sw = 'N';

update routing
SET activeflag =0,
    updatedby ='CDM-39155',
    updatedon = now()
 where routingid ='f0b0da8f-7ed3-4d1e-96b1-5fd8ee7d7122'; 