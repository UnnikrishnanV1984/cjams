INSERT INTO cjams.routing (eventcode, fromsecurityusersid, tosecurityusersid, teamid, 
fromroleid, toroleid, objectid,routingstatustypeid, activeflag, 
insertedby, insertedon, updatedby, updatedon, isreviewrequest, 
remarks, servicerequestnumber, objecttypekey) 
VALUES('INDR', 'a1c7b418-7b96-4cc8-9a5f-fbbc22d48f01', 'b567fa07-daef-4762-b877-079ccd874a11', '4c5c51e4-6983-4d7a-b5bf-b1b327cb7c05', 
'CWCW', 'CWSP', '4364e5b0-bc62-4627-9b90-1d628d153ff2', 15, 0, 
'a1c7b418-7b96-4cc8-9a5f-fbbc22d48f01', now(), 'a1c7b418-7b96-4cc8-9a5f-fbbc22d48f01', now(), true, 
null, 
'CW2947216', 'servicerequest' );		
			


update cjams.submissioncollection
set datakey = 'AssessorName2'
where submissioncollectionid = '60ecb51c-be9c-41e5-8e6a-3f09d0341466';



update cjams.submissioncollection
set datakey = 'SupervisorName'
where submissioncollectionid = '8072b00f-2835-4be1-bfcb-c47e6547a860';

