/*
-- CDM-35822-- 

-- Issue Description: 
-- Unable to Close Case

-- Customer Email ID: briana.stern3@maryland.gov

-- Root cause:The worker is not able to send the case for closure due to there not being a completed face-to-face contact with one of the victim children. 
-- Resolution: Data fix is provided to close the case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/




-- 486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7   

select * from intakeservicerequest
where intakeserviceid = '486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7';

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-35822', updatedon = now() 
where
   intakeserviceid = '486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7';
  
select * from userprofile where firstname = 'Dana' and lastname = 'Parker';
  
  
select intakeservicerequestdispositioncodeid  from cjams.intakeservicerequestdispositioncode where
  intakeserviceid = '486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7' and intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
 
 select * from cjams.intakeservicerequestdispositioncode
 where intakeservicerequestdispositioncodeid = '5546e8ec-10f7-431a-95ef-fce566fe792d';

select * from cjams.intakeservicerequestdispositioncode where
       intakeserviceid = '486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7' and updatedby = 'CDM-35822';
       
select * from routing where servicerequestnumber = '231021218158' and activeflag = 1 and eventcode in ('INDR', 'INVT');


INSERT INTO
   cjams.intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon,
   updatedby, updatedon, timestamp, statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid,
   servicerequesttypeconfigiddispostionid, dateofsubpoena, subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, 
   reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, servicerequestdispositionsubtypenotes,
   approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate, actiondueddate,
   approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments) 
VALUES
   (
      gen_random_uuid(), '486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7', '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', '2023-12-04 15:13:02',
      'CDM-35822', NOW(), NULL, '2023-10-06 11:34:59', 'Completed', NULL, '2023-10-06 11:34:59', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8',
      'd90db0d3-f665-49db-b3ad-0edb468bc02d', NULL, NULL, NULL, NULL, NULL, '12/5/23 Case approved and ready for closure.  CJAMS ticket submitted due to worker''s inability to complete case closure.  Reasonable efforts for face-to-face visit with the alleged victim are documented', 
      '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );
   
INSERT INTO
   cjams.routing (routingid, eventcode, fromsecurityusersid,
   tosecurityusersid, teamid, fromroleid, toroleid,
   objectid, routingstatustypeid, activeflag,
   insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey,
   old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', '3e3e1941-751b-49b1-bdbf-af8d32c8bfb9', 
      '47d1f252-c156-479f-a7c2-414f16a85a63','02f1f1a8-b46a-42e2-afbf-6b83fe1ad5cd', 'CWSP', 'CWSP',
      (select intakeservicerequestdispositioncodeid from cjams.intakeservicerequestdispositioncode where
       intakeserviceid = '486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7' and updatedby = 'CDM-35822'), 16, 1,
      '47d1f252-c156-479f-a7c2-414f16a85a63', '2023-12-05 00:00:00.000', 'CDM-35822', now(), true, '',
      NULL, '', '231021218158', NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );
  
    select * from caseassignment where objectid = '486bebfa-8ad8-41ad-ae6d-f8474f6ba1b7';
   
  update
   caseassignment 
set
   enddate = '2023-12-05 00:00:00.000', updatedby = 'CDM-35822', updatedon = now() 
where
   caseassignmentid = '4cb22185-6a79-450f-9d43-4f69c412648f';
  
  
update
   personprogramarea 
set
   enddate = '2023-12-05 00:00:00.000', updatedby = 'CDM-35822', updatedon = now()
where
   entityid = '231021218158' 
   and activeflag = 1 
   and enddate is null;


---- Removing the contact as requested----

update progressnote set activeflag=0, updatedby = 'CDM-35822', updatedon = now()
where progressnoteid = '549474b1-6edd-4cd0-93fe-e6db0b323493';
 
update progressnotedetail set activeflag=0, updatedby = 'CDM-35822', updatedon = now()
where progressnotedetailid = '07e5f0a6-a077-4d80-8060-eef8137e1219';

select auditdetailid from progressnote_audit_detail where conatctid = 11792201;

update progressnote_audit_detail set activeflag=0, updatedby = 'CDM-35822', updatedon = now()
where auditdetailid = '711ab10f-4d96-4172-93be-45d229529bb3';

update  contactparticipant set  activeflag=0, updatedby = 'CDM-35822', updatedon = now()
where progressnoteid = '549474b1-6edd-4cd0-93fe-e6db0b323493'
and activeflag=1;

