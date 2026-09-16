/*
   Issue Description: CDM-36487
   Category/ Module  : Permanancy Planning 
   Root cause: Annual Review approval is not recorded
   Pull request# for code fix: 
   Reason why no related code fix: In Teammember table, katie.hitch@maryland.gov's role not primary role. It should be changed from FTDMFW to CWCW . FIxed as part of CDM-36488
   Need to do data fix: Data fix provided for approved annual review to show on screen
*/
	
-- Datafix for GRACE REESE (1044566)
update routing 
	set fromroleid = 'CWCW',
		updatedon = now(),
		updatedby = 'CDM-36487'
	where routingid = 'dc4aa9b8-7ae3-4744-b8f7-3acec8d664c5';


update routing 
	set fromroleid = 'CWSP',
		fromsecurityusersid = '7ca5718d-cc3f-4884-934c-6769a4d00eed',
		activeflag = 1,
		routingstatustypeid = 16,
		updatedon = now(),
		updatedby = 'CDM-36487'
	where routingid = '8c936492-3032-4abe-b0fd-3770cf050b30';