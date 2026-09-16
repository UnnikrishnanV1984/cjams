/*
-- CDM-22894- 

-- Issue Description: 
 Unable to set the activeflag
  
-- Customer Email ID: stacie.parker@maryland.gov

-- Root cause: Data fix to set the active flag
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- ASSGN        
UPDATE servicecase SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2022-06-13 12:00:00', updatedby = 'CDM-22894',updatedon = now() WHERE servicecaseid = '7e6ac34d-48c2-4d9c-9cc2-c62bf3422dd1';

INSERT INTO servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('763b8af1-60fa-407c-a126-3ca4c9531178' ,'7e6ac34d-48c2-4d9c-9cc2-c62bf3422dd1', '2022-06-13 11:07:21.120', 'Closed', 'Closed','Case Closed', '2022-05-16 11:07:21.120', 1, '527e483b-5108-4906-b2bb-6fdbc317f03e', now(),'CDM-22894',now()) ON CONFLICT DO NOTHING;

insert into routing (eventcode, fromsecurityusersid, tosecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon,updatedby, updatedon)
values ('SCDR','527e483b-5108-4906-b2bb-6fdbc317f03e','527e483b-5108-4906-b2bb-6fdbc317f03e', '763b8af1-60fa-407c-a126-3ca4c9531178', 16, 1, 'CDM-22894',now(),'CDM-22894', now()) ON CONFLICT DO NOTHING;