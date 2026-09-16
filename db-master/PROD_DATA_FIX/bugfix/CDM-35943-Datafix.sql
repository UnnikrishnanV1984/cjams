/*
-- CDM-35943-- 

-- Issue Description: 
-- Unable to Close Case

-- Customer Email ID: briana.stern3@maryland.gov

-- Root cause:The worker is not able to send the case for closure due to there not being  completed face-to-face contact with  the victim children. 
-- Resolution: Data fix is provided to close the case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 7292f5a3-952a-44ce-a8b8-9827e125c9ad   

select * from intakeservicerequest
where intakeserviceid = '7292f5a3-952a-44ce-a8b8-9827e125c9ad';

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-35943', updatedon = now() 
where
   intakeserviceid = '7292f5a3-952a-44ce-a8b8-9827e125c9ad' and activeflag=1;
  
select * from userprofile where   firstname = 'Nia' and lastname = 'Edmundson';

select * from cjams.intakeservicerequestdispositioncode where
  intakeserviceid = '7292f5a3-952a-44ce-a8b8-9827e125c9ad' and intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
 
select * from cjams.intakeservicerequestdispositioncode
where intakeservicerequestdispositioncodeid = '17e94bda-33fd-48f2-8e68-82d0c6705840';

select * from cjams.intakeservicerequestdispositioncode where
intakeserviceid = '7292f5a3-952a-44ce-a8b8-9827e125c9ad' and updatedby = 'CDM-35943';
       
select * from routing where servicerequestnumber = '231021250781' and activeflag = 1 and eventcode in ('INDR', 'INVT');

delete from intakeservicerequestdispositioncode where updatedby='CDM-35943' and intakeserviceid='7292f5a3-952a-44ce-a8b8-9827e125c9ad';

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate,
effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin,
dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid,
approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('17e94bda-33fd-48f2-8e68-82d0c6705840', '7292f5a3-952a-44ce-a8b8-9827e125c9ad', '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2023-12-10 12:45:00.000', 'CDM-35943', now(), NULL,
'2023-12-10 14:45:00.000', 'Completed', NULL, '2023-12-10 14:45:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL, NULL, NULL, NULL,
'12/10/23 Case approved and ready for closure.  CJAMS ticket submitted due to worker''s inability to complete case closure.  Reasonable efforts for face-to-face visit with the alleged victim are documented', '', 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete from routing where updatedby= 'CDM-35943' and eventcode = 'INDR' and servicerequestnumber = '231021250781';

select * from routing where objectid='17e94bda-33fd-48f2-8e68-82d0c6705840';

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby,
insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype,
actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('dc6a8ca2-b26c-46aa-9fa9-65a548a909d4', 'INDR', '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', '1e72fd87-c3f0-4c21-a67f-39099dea4843', '02f1f1a8-b46a-42e2-afbf-6b83fe1ad5cd',
'CWSP', 'CWCW', '17e94bda-33fd-48f2-8e68-82d0c6705840', 16, 1, '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2023-12-10 14:45:00.000', 'CDM-35943', now(), true, '', 
NULL, '', '231021250781', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby,
insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype,
actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('d9235ae9-9d00-4d2e-b95c-e233c511d476', 'INDR', '1e72fd87-c3f0-4c21-a67f-39099dea4843', '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', '02f1f1a8-b46a-42e2-afbf-6b83fe1ad5cd',
'CWCW', 'CWSP', '17e94bda-33fd-48f2-8e68-82d0c6705840', 15, 0, '1e72fd87-c3f0-4c21-a67f-39099dea4843', '2023-12-10 14:45:00.000', 'CDM-35943', now(), true, '',
NULL, '', '231021250781', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
  

select * from caseassignment where objectid = '7292f5a3-952a-44ce-a8b8-9827e125c9ad';
   
update
   caseassignment 
set
   enddate = '2023-12-10 14:45:00.000', updatedby = 'CDM-35943', updatedon = now() 
where
   caseassignmentid = '5b4bbcbc-d6b9-48ec-8db1-7ca526234201';
  
select * from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid='17e94bda-33fd-48f2-8e68-82d0c6705840';

--Updating the end date and updtaedby in person

update personprogramarea set enddate='2023-12-10 14:45:00.000', updatedby = '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', updatedon = now() where personprogramid='8dd3dd20-d07b-49f3-870c-3dcad3d1fcc0';

update personprogramarea set enddate='2023-12-10 14:45:00.000', updatedby = '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', updatedon = now() where personprogramid='a664e64b-957b-4547-8763-ad1af6f1f948';

update personprogramarea set enddate='2023-12-10 14:45:00.000', updatedby = '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', updatedon = now() where personprogramid='3a90b1dd-2627-4c69-ab77-ab13408d35af';