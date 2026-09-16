/*
   Issue Description: CDM-20332
   Category/ Module  : Intake Decision and Service case 
   Root cause: user wants to remove service case and referral status changes 
   Pull request# for code fix: 4808
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


UPDATE intakesnapshot 
SET 
updatedby = 'CDM-20332', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I202100137034' AND activeflag=1;

update servicecase set activeflag =0, updatedby = 'CDM-20332', updatedon = now() where servicecasenumber = 202107406587 and activeflag =1;

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-20332', updatedon = now()
	
	where intakenumber = 'I202100137034'
	and activeflag = 1;

    update intakedastatus
	
	set status = 8, updatedby = 'CDM-20332', updatedon = now()
	
	where intakenumber = 'I202100137034'
	and activeflag = 1;	