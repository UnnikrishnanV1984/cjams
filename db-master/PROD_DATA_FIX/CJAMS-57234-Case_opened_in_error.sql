/*
   Issue Description: CJAMS-57234
   Category/ Module  : Service Case Removal
   Root cause: User requested to remove service case opened in error 
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


INSERT INTO cjams.servicecasedisposition
(servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('ec478f1f-88b6-4975-a1bd-ed8d095ee96b'::uuid, now(), 'Closed', 'Closed', 'Case opened in error', now(), 1, 'CJAMS-57234', now(), 'CJAMS-57234', now());


INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', 'c76a19b4-adf3-413e-8f0c-9c1e07ee64bc',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='ec478f1f-88b6-4975-a1bd-ed8d095ee96b'
		and updatedby ='CJAMS-57234' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CJAMS-57234', now(), 'CJAMS-57234', now(), true);

update servicecase
set statustypekey = 'Closed',dispositioncode = 'Closed',updatedby = 'CJAMS-57234', updatedon = now()
where servicecaseid = 'ec478f1f-88b6-4975-a1bd-ed8d095ee96b' and activeflag = 1;