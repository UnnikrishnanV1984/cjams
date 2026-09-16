/*
   Issue Description: CDM-22662
   Category/ Module  : supervisor decision making pending 
   Root cause: user wants to make referral decision as pending so that supervisor can approve again
   Pull request# for code fix: 5605
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-22662', 
updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
WHERE intakenumber = 'I221010274726' AND activeflag=1;
                    
update routing 
set routingstatustypeid  = 1, eventcode = 'INTR', updatedon = now(), updatedby = 'CDM-22662'
where objectid = 'I221010274726';

update intakedastatus 
set status = 1, updatedon = now(), updatedby = 'CDM-22662'
where intakenumber = 'I221010274726' and activeflag=1;

update intakedastaging
set status = 'pending', ispreintake = FALSE, updatedon = now(), updatedby = 'CDM-22662'
where intakenumber = 'I221010274726' and activeflag = 1;

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-22662', updatedon = now() 
where intakenumber = 'I221010274726';