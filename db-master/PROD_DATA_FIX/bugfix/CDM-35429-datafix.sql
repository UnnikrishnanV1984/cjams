/*
   Issue Description: CDM-35429 - Unable to close case due to response timer
   Category/ Module  : Assessments: Other
   Root cause: Unable to close case due to response timer
   Fix Privided: data fix Closed the case
*/

-- reverted the previously deleted changes 

---- Removing the contact as requested----
update progressnote set activeflag=0, updatedby = 'CDM-35429', updatedon = now()
where progressnoteid = 'b50bd6e5-0e27-4dc4-85f7-c8929afb3b68';

 
update progressnotedetail set activeflag=0, updatedby = 'CDM-35429', updatedon = now()
where progressnotedetailid = '49f47d3f-735a-4444-922f-656cc40d9ac4';

--select auditdetailid from progressnote_audit_detail where conatctid = 11792189;

update progressnote_audit_detail set activeflag=0, updatedby = 'CDM-35429', updatedon = now()
where auditdetailid = 'c0242a74-28d1-45a5-ba96-1d1e2bf0a632';

update  contactparticipant set  activeflag=0, updatedby = 'CDM-35429', updatedon = now()
where progressnoteid = 'b50bd6e5-0e27-4dc4-85f7-c8929afb3b68'
and activeflag=1;

--- set initial face to face to false --
update legislative set isinitialfacetoface=false, updatedby = 'CDM-35429', updatedon = now()
where legislativeid='765af9d5-1d41-4118-bc0f-ecc25679c7c2';

-- Changed the routing submitted by caseworker and approved by supervisior

select intakeservicerequestdispositioncodeid  from cjams.intakeservicerequestdispositioncode where
intakeserviceid = '175da4ac-f6b3-46ff-84c1-0860e868ca97' and intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8';
--  b5a49238-7cc9-47a3-afe3-449b574447ba

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
      'b5a49238-7cc9-47a3-afe3-449b574447ba', 16, 1,
      '24b7331d-f52d-4e13-bb62-ae8bc29dcbbf', '2023-11-29 00:00:00.000', 'CDM-35429', now(), true, '', NULL, '', '231021281746', NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );

update
   caseassignment 
set
   enddate = '2023-11-29 00:00:00.000', updatedby = 'CDM-35429', updatedon = now() 
where
   caseassignmentid = '9ca1b865-90c7-4119-b192-f94fc232d157';
   
update
   personprogramarea 
set
   enddate = '2023-11-29 00:00:00.000', updatedby = 'CDM-35429', updatedon = now()
where
   entityid = '231021281746' 
   and activeflag = 1 
   and enddate is null;
   
 -- changed the intakeserreqstatustypeid
 
update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-35429', updatedon = now() 
where
   intakeserviceid = '175da4ac-f6b3-46ff-84c1-0860e868ca97';