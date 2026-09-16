/*
   Issue Description: CDM-32001
   Category/ Module  : 
   Root cause: user want  to be screened I221010303301
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 


update
	intakedastaging
set
	updatedby = 'CDM-32001',
	updatedon = now(),
	jsondata = jsonb_set(jsondata, '{DAType}', jsonb_set(jsondata->'DAType', '{DATypeDetail}', jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
where
	intakenumber = 'I221010303301'
	and activeflag = 1;


	update routing set  activeflag=1,routingstatustypeid=8 where routingid='c47a188f-df88-4699-a3d4-a8c04cca1a8e';
