
/*
   Issue Description: CDM-19606
   Category/ Module  : Case closure Records
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- ASSGN
UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2022-01-11 12:00:00', updatedby = 'CDM-19606',updatedon = now() WHERE servicecaseid = '9a999164-2ecb-48c1-8eff-f7984f770bf4';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('d5f54b23-8554-4d64-8827-b340f82ade1b', '9a999164-2ecb-48c1-8eff-f7984f770bf4', '2022-01-11 12:00:00', 'Closed', 'Closed','Case Closed', 
	   '2022-01-11 12:00:00', 1, 'acfcbf74-6677-4175-8ed9-295b8196374b',now(),'CDM-19606',now()) ON CONFLICT DO NOTHING;

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR','959c3774-bfb3-4f52-9770-8b0487d4daf8','acfcbf74-6677-4175-8ed9-295b8196374b', 'd5f54b23-8554-4d64-8827-b340f82ade1b', 16, 1, 'CDM-19606',now(),'CDM-19606', now()) ON CONFLICT DO NOTHING;

update caseassignment 
set enddate = '2022-01-11 12:00:00',
updatedon = now(),
updatedby = 'CDM-19606'
where caseassignmentid = '2bd2246e-8e41-46f3-b3e6-a1cb4af8c879';
