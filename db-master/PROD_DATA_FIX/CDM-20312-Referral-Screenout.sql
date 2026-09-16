/*
   Issue Description: CDM-20312
   Category/ Module  : Referral needs to be screen out
   Root cause: user wants to remove referral and case number  
   Pull request# for code fix: 4797,4807
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
UPDATE intakesnapshot 
SET 
updatedby = 'CDM-20312', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I221010238147' AND activeflag=1;



update servicecase set activeflag =0, updatedby = 'CDM-20312', updatedon = now() where servicecasenumber = 221030014027 and activeflag =1;

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-20312', updatedon = now()
	
	where intakenumber = 'I221010238147'
	and activeflag = 1;

    update intakedastatus
	
	set status = 8, updatedby = 'CDM-20312', updatedon = now()
	
	where intakenumber = 'I221010238147'
	and activeflag = 1;