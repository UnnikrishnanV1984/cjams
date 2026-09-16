/*
   Issue Description: CDM-19873
   Category/ Module  : Intake Removal/Placement
   Root cause: user wants remove intake and connect to the right case
   Pull request# for code fix: 4704,4713
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
UPDATE intakesnapshot 
	SET 
	updatedby = 'CDM-19873', 
	updatedon = now(), 
	jsondata = jsonb_set(jsondata, '{DAType}', 
				jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
				jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
				jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '""'))))
	WHERE intakenumber = 'I221010232629' AND activeflag=1;

	update routing set routingstatustypeid = 1,updatedby = 'CDM-19873', updatedon = now() where objectid = 'I221010232629' and activeflag = 1;

	-- 2
	update intakedastatus set status = 1, updatedby = 'CDM-19873' , updatedon = now() where intakenumber = 'I221010232629';

	-- true
	update cjams.intakedastaging set status = 'pending', ispreintake =false, updatedby ='CDM-19873', updatedon =now()  where intakenumber ='I221010232629' and activeflag = 1;
	
