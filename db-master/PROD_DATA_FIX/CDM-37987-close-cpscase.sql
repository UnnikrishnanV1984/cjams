/*
-- CDM-37987-- 

-- Issue Description: 
-- Unable to Close Case

-- Customer Email ID: natasha.powell@maryland.gov

-- Root cause:The worker is not able to send the case for closure due to there not being  completed face-to-face contact with  the victim children. 
-- Resolution: Data fix is provided to close the case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- 817f9984-5d0f-4945-be01-4d13d06b3244   

select * from intakeservicerequest
where intakeserviceid = '817f9984-5d0f-4945-be01-4d13d06b3244';

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-37987', updatedon = now() 
where  intakeserviceid = '817f9984-5d0f-4945-be01-4d13d06b3244' and activeflag=1;
  
select * from userprofile where email = 'natasha.powell@maryland.gov' and activeflag = 1;

select * from cjams.intakeservicerequestdispositioncode where
  intakeserviceid = '817f9984-5d0f-4945-be01-4d13d06b3244' and intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690' and activeflag = 1;
 
select * from cjams.intakeservicerequestdispositioncode
where intakeservicerequestdispositioncodeid = '67eaec56-963f-410b-be01-edf483e65543';

select * from cjams.intakeservicerequestdispositioncode where
intakeserviceid = '817f9984-5d0f-4945-be01-4d13d06b3244' and updatedby = 'CDM-37987';
       
select * from routing where servicerequestnumber = '241021873131' and activeflag = 1 and eventcode in ('INDR', 'INVT');

delete from intakeservicerequestdispositioncode where updatedby='CDM-37987' and intakeserviceid='817f9984-5d0f-4945-be01-4d13d06b3244';

INSERT INTO cjams.intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, "timestamp", statusdate, description, expirationdate,
effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin,
dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes, approvalid,
approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey,
requestorcomments, approvalcomments, currentstatustypekey, forwardcountytypekey, forwardunitid, administratorid, datavalidflag, clientmergeid, etl_userid, etl_load_date, adultassignedsecurityid)
VALUES('67eaec56-963f-410b-be01-edf483e65543', '817f9984-5d0f-4945-be01-4d13d06b3244', '804d2372-7dc2-4251-a282-556b39940179', '2024-03-26 14:15:00.000', 'CDM-37987', now(), NULL,
'2024-03-26 14:45:00.000', 'Completed', NULL, '2024-03-26 14:45:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL, NULL, NULL, NULL,
'Approved', '', 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

delete from routing where updatedby= 'CDM-37987' and eventcode = 'INDR' and servicerequestnumber = '241021873131';

select * from routing where objectid='67eaec56-963f-410b-be01-edf483e65543';

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby,
insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype,
actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INDR', '256457bc-cd36-40ed-9716-c76835b9b8cc', '804d2372-7dc2-4251-a282-556b39940179', '862ff553-6c2c-4f28-89a2-69136865992a',
'CWSP', 'CWCW', '67eaec56-963f-410b-be01-edf483e65543', 16, 1, '804d2372-7dc2-4251-a282-556b39940179', '2024-03-26 14:45:00.000', 'CDM-37987', now(), true, '', 
NULL, '', '241021873131', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby,
insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype,
actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('INDR', '804d2372-7dc2-4251-a282-556b39940179', '256457bc-cd36-40ed-9716-c76835b9b8cc', '862ff553-6c2c-4f28-89a2-69136865992a',
'CWCW', 'CWSP', '67eaec56-963f-410b-be01-edf483e65543', 15, 0, '804d2372-7dc2-4251-a282-556b39940179', '2024-03-26 14:45:00.000', 'CDM-37987', now(), true, '',
NULL, '', '241021873131', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
  

select * from caseassignment where objectid = '817f9984-5d0f-4945-be01-4d13d06b3244';
   
update
   caseassignment 
set
   enddate = '2024-03-26 14:45:00.000', updatedby = 'CDM-37987', updatedon = now() 
where
   caseassignmentid = '475d9a64-333d-4311-a699-05ef683bdc4e';
  
select * from intakeservicerequestdispositioncode where intakeservicerequestdispositioncodeid='67eaec56-963f-410b-be01-edf483e65543';

--Updating the end date and updtaedby in person

update personprogramarea set enddate='2024-03-26 14:45:00.000', updatedby = '256457bc-cd36-40ed-9716-c76835b9b8cc', updatedon = now() 
where personprogramid in ('0ae2c4e6-7394-4c79-87c9-78522a215545', 'c77ee595-5126-443c-8b47-655d1aac856c', '98ef186f-1f4d-43dc-82ff-3965cfa782bd') and activeflag = 1 
and enddate is null;