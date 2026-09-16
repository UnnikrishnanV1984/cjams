/*
   Issue Description: CJAMS-58866
   Category/ Module  : Placement
   Root cause: Requested to do the data fix to add the suspension with start date - 03/13/2025
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '0591be70-0a1c-428a-b251-76142d14d550', '2025-03-13 00:00:00.000', 'COHP', '2025-03-13 00:00:00.000', NULL,  '', '3045', now(), NULL, now(),'a264241b-0e9c-4a9f-99a3-cf2b52ccfd98' , now(), 'CJAMS-58866', 0, '2025-03-13 00:00:00.000',NULL , NULL, NULL, 'e6c73eec-711b-45e5-89dd-b79c75d0d9e9', NULL, NULL);

INSERT INTO cjams.adoptioncasesuspension
(adoptionsuspensionid, adoptioncaseid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '0591be70-0a1c-428a-b251-76142d14d550', '2025-03-13 00:00:00.000', 'COHP', '2025-03-13 00:00:00.000', NULL,  '', '3047', now(), NULL, now(),'a264241b-0e9c-4a9f-99a3-cf2b52ccfd98' , now(), 'CJAMS-58866', 1, '2025-03-13 00:00:00.000', NULL, NULL, NULL, 'e6c73eec-711b-45e5-89dd-b79c75d0d9e9', NULL, NULL);

INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), (select adoptionsuspensionid from adoptioncasesuspension a  where adoptioncaseid  = '0591be70-0a1c-428a-b251-76142d14d550' and approvalstatustypekey = '3045' and activeflag = 0), '2025-03-13 00:00:00.000', 'COHP', '2025-03-13 00:00:00.000', NULL, NULL, '3045', now() , NULL, now(), 'a264241b-0e9c-4a9f-99a3-cf2b52ccfd98', now() , 'CJAMS-58866', 0, '2025-03-13 00:00:00.000', Null , NULL,NULL , 'e6c73eec-711b-45e5-89dd-b79c75d0d9e9', '0591be70-0a1c-428a-b251-76142d14d550', NULL, NULL);


INSERT INTO cjams.adoptioncasesuspensionrevision
(adoptionsuspensionrevisionid, adoptionsuspensionid, transactiondate, suspensionreasontypekey, suspensionbegindate, suspensionenddate, suspensionremarks, approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, effectivedate, old_id, suspensionreasonremarks, alternateid, adoptionagreementid, adoptioncaseid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), (select adoptionsuspensionid from adoptioncasesuspension a  where adoptioncaseid  = '0591be70-0a1c-428a-b251-76142d14d550' and approvalstatustypekey = '3047' and activeflag = 1), '2025-03-13 00:00:00.000', 'COHP', '2025-03-13 00:00:00.000', NULL, NULL, '3047', now() , NULL, now(), '251ca32d-4b6f-460e-ab34-0d740c55b6dd', now() , 'CJAMS-58866', 1, '2025-03-13 00:00:00.000', Null , NULL,NULL , 'e6c73eec-711b-45e5-89dd-b79c75d0d9e9', '0591be70-0a1c-428a-b251-76142d14d550', NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(),'ADSR', 'a264241b-0e9c-4a9f-99a3-cf2b52ccfd98', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', '98e48338-6869-410f-a272-ff58cfc80a00'::uuid, 'CWCW', 'CWSP', (select adoptionsuspensionid from adoptioncasesuspension a  where adoptioncaseid  = '0591be70-0a1c-428a-b251-76142d14d550' and approvalstatustypekey = '3045' and activeflag = 0), 15, 0, 'a264241b-0e9c-4a9f-99a3-cf2b52ccfd98', now(), 'CJAMS-58866', now(), true, 'Adoption Case Suspension Submitted for review', NULL, 'Adoption Case Suspension Submitted for review', '3211006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES(gen_random_uuid(),'ADSR', '251ca32d-4b6f-460e-ab34-0d740c55b6dd', 'a264241b-0e9c-4a9f-99a3-cf2b52ccfd98', '98e48338-6869-410f-a272-ff58cfc80a00'::uuid, 'CWSP', 'CWCW', (select adoptionsuspensionid from adoptioncasesuspension a  where adoptioncaseid  = '0591be70-0a1c-428a-b251-76142d14d550' and approvalstatustypekey = '3047' and activeflag = 1), 16, 1, '251ca32d-4b6f-460e-ab34-0d740c55b6dd', now(), 'CJAMS-58866', now(), true, 'Adoption Suspension Approved', NULL, 'Adoption Suspension Approved', '3211006', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
