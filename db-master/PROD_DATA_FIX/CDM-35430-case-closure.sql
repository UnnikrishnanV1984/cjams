/*
-- CDM-35430-- 

-- Issue Description: 
-- Unable to Close Case

-- Customer Email ID: shunnecia.baker@maryland.gov

-- Root cause:Request to close the case as there is no solution to provide data fix to check initial face to face.
-- Resolution: Data fix is provided to close the case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



-- 749a5cb0-8ce6-4480-a4f7-774d8b524e62    

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-35430', updatedon = now() 
where
   intakeserviceid = '749a5cb0-8ce6-4480-a4f7-774d8b524e62';
  
  
  select intakeservicerequestdispositioncodeid  from cjams.intakeservicerequestdispositioncode where
      intakeserviceid = '749a5cb0-8ce6-4480-a4f7-774d8b524e62' and intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8';
   
INSERT INTO
   cjams.routing (routingid, eventcode, fromsecurityusersid,
   tosecurityusersid, teamid, fromroleid, toroleid,
   objectid, routingstatustypeid, activeflag,
   insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey,
   old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', '6af7a326-0572-4e9c-9d19-e15e2949c5fe', 
      '24b7331d-f52d-4e13-bb62-ae8bc29dcbbf','f2f7d045-6caa-4363-ad9d-139c7ac11f0d', 'CWSP', 'CWSP',
      'b8963db3-89c5-4a7f-a006-7800677c9bae', 16, 1,
      '24b7331d-f52d-4e13-bb62-ae8bc29dcbbf', '2023-11-29 00:00:00.000', 'CDM-35430', now(), true, '', NULL, '', '231021281708', NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );
   
  update
   caseassignment 
set
   enddate = '2023-11-29 00:00:00.000', updatedby = 'CDM-35430', updatedon = now() 
where
   caseassignmentid = '8a7f7c4f-bd4c-4d8a-8487-68587793d988';
  
  
update
   personprogramarea 
set
   enddate = '2023-11-29 00:00:00.000', updatedby = 'CDM-35430', updatedon = now()
where
   entityid = '231021281708' 
   and activeflag = 1 
   and enddate is null;


---- Removing the contact as requested----

update progressnote set activeflag=0, updatedby = 'CDM-35430', updatedon = now()
where progressnoteid = '549474b1-6edd-4cd0-93fe-e6db0b323493';
 
update progressnotedetail set activeflag=0, updatedby = 'CDM-35430', updatedon = now()
where progressnotedetailid = '07e5f0a6-a077-4d80-8060-eef8137e1219';

select auditdetailid from progressnote_audit_detail where conatctid = 11792201;

update progressnote_audit_detail set activeflag=0, updatedby = 'CDM-35430', updatedon = now()
where auditdetailid = '711ab10f-4d96-4172-93be-45d229529bb3';

update  contactparticipant set  activeflag=0, updatedby = 'CDM-35430', updatedon = now()
where progressnoteid = '549474b1-6edd-4cd0-93fe-e6db0b323493'
and activeflag=1;


--- set initial face to face to false --
update legislative set isinitialfacetoface=false, updatedby = 'CDM-35430', updatedon = now()
where legislativeid='75407124-1dad-4117-9330-bc607080a4d3';
