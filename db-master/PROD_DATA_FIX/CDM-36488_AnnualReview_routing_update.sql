/*
   Issue Description: CDM-36488
   Category/ Module  : Permanancy Planning 
   Root cause: Annual Review approval is not recorded
   Pull request# for code fix: 
   Reason why no related code fix: In Teammember table, katie.hitch@maryland.gov's role not primary role. It should be changed from FTDMFW to CWCW 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix: Also data fix provided for approved annual review to show on screen
*/


update teammember 
	set roletypekey = 'CWCW', -- Existing role FTDMFW
		updatedon = now(),
		updatedby = 'CDM-36488'
	where teammemberid = 'c0a16807-f980-40f1-b35d-106318742b65';
	
	
-- Datafix for JEREMIAH GALE (2521985)	
update routing 
	set fromroleid = 'CWCW',
		updatedon = now(),
		updatedby = 'CDM-36488'
	where routingid = 'e7ab042b-7fbf-43ba-a8ea-24d7e0b4cd02';


update routing 
	set fromroleid = 'CWSP',
		fromsecurityusersid = '7ca5718d-cc3f-4884-934c-6769a4d00eed',
		activeflag = 1,
		routingstatustypeid = 16,
		updatedon = now(),
		updatedby = 'CDM-36488'
	where routingid = '012aeae3-cb67-4c23-9834-e292528f564c';
	
-- Datafix for JOSEPH GALE (2521982)	
update routing 
	set fromroleid = 'CWCW',
		updatedon = now(),
		updatedby = 'CDM-36488'
	where routingid = '62a696fe-9072-4f8f-acd4-d000b714d616';


update routing 
	set fromroleid = 'CWSP',
		fromsecurityusersid = '7ca5718d-cc3f-4884-934c-6769a4d00eed',
		activeflag = 1,
		routingstatustypeid = 16,
		updatedon = now(),
		updatedby = 'CDM-36488'
	where routingid = '44c4dd49-a449-4458-b8fa-0e2173abce71';