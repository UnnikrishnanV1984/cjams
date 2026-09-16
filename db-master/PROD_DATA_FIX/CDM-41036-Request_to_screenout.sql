/*
   Issue Description: CDM-41036
   Category/ Module  : Screenout referral
   Root cause: user wants to screenout
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
SET updatedby = 'CDM-41036', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012885327' AND activeflag=1;

update routing 
set updatedby = '64a77a00-ecd8-4a67-adad-2b75e35b601f',updatedon = now(), activeflag =0, routingstatustypeid = 8, supervisordecision ='screenout'
WHERE objectid = 'I241012885327' and activeflag =1;


update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-41036', updatedon = now() 
where intakenumber = 'I241012885327' and activeflag =1;