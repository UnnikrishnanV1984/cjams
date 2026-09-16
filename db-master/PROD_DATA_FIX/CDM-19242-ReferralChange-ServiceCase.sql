/*
   Issue Description: CDM-19242
   Category/ Module  : Referral change and Service case 
   Root cause: user wants to remove service case 
   Pull request# for code fix: 4802
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
	UPDATE intakesnapshot 
SET 
updatedby = 'CDM-19242', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}', 
			jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
			jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I211010173117' AND activeflag=1;



update servicecase set activeflag =0, updatedby = 'CDM-19242', updatedon = now() where servicecasenumber = 3236216 and activeflag =1;

update intakedastaging 
	
	set status = 'Closed', updatedby = 'CDM-19242', updatedon = now()
	
	where intakenumber = 'I211010173117'
	and activeflag = 1;

    update intakedastatus
	
	set status = 8, updatedby = 'CDM-19242', updatedon = now()
	
	where intakenumber = 'I211010173117'
	and activeflag = 1;