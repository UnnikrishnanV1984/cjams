/*
-- CDM-35490-- 

-- Issue Description: cannot locate child, CJAMS not allowing closure

-- Customer Email ID: michelle.delovich@maryland.gov

-- Root cause: Data fix to close the case
-- Resolution: Data fix is provided to close the case
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


-- 9f2d5f9c-54b1-4069-812d-3dea261237b1

delete from intakeservicerequestdispositioncode where insertedby in('47dc653d-9089-4b47-b40e-0168ef6c2321','862e2eaf-3592-475f-aa41-212c1ac3b219') and updatedby = 'CDM-35490';

delete from routing where insertedby='862e2eaf-3592-475f-aa41-212c1ac3b219' and updatedby = 'CDM-35490';

update
   intakeservicerequest 
set
   intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-35490', updatedon = now() 
where
   intakeserviceid = '9f2d5f9c-54b1-4069-812d-3dea261237b1';

INSERT INTO
   cjams.intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, insertedon, updatedby, updatedon, timestamp,
   statusdate, description, expirationdate, effectivedate, activeflag, intakeserreqstatustypeid, servicerequesttypeconfigiddispostionid, dateofsubpoena, 
   subpoenareason, lastfacetofacedate, seenwithin, dateseen, reviewcomments, reasonfordelay, old_id, closingcodetypekey, servicerequestdispositionsubtypeconfigid, 
   servicerequestdispositionsubtypenotes, approvalid, approvalnaturetypekey, entitytypetypekey, additionalkey, entitykeyid1, entitykeyid2, requestdate,
   actiondueddate, approvestaffid, approvalstatustypekey, denialreasontypekey, requestorcomments, approvalcomments) 
VALUES
   (
      gen_random_uuid(), '9f2d5f9c-54b1-4069-812d-3dea261237b1', '862e2eaf-3592-475f-aa41-212c1ac3b219', '2023-11-16 10:00:00.000', 'CDM-35490', NOW(), NULL, 
      '2023-11-16 10:00:00.000', 'Completed', NULL, '2023-11-16 10:00:00.000', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8', 'd90db0d3-f665-49db-b3ad-0edb468bc02d',
      NULL, NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );
  

INSERT INTO
   cjams.routing (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby,
   insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype,
   actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', 'c078eed8-fab6-490d-b099-47f9b968a5dc', '862e2eaf-3592-475f-aa41-212c1ac3b219', '7d7ceed0-b1f0-4132-80de-63c26ad657da', 
      'CWSP', 'CWCW', (select intakeservicerequestdispositioncodeid from cjams.intakeservicerequestdispositioncode where
       intakeserviceid = '9f2d5f9c-54b1-4069-812d-3dea261237b1' and updatedby = 'CDM-35490'),
      16, 1, '862e2eaf-3592-475f-aa41-212c1ac3b219', '2023-11-16 12:00:00.000', 'CDM-35490', now(), true,
      '', NULL, '', '231021129483', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );

 INSERT INTO
   cjams.routing (routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby,
   insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype,
   actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes) 
VALUES
   (
      cjams.gen_random_uuid(), 'INDR', '862e2eaf-3592-475f-aa41-212c1ac3b219', 'c078eed8-fab6-490d-b099-47f9b968a5dc', '7d7ceed0-b1f0-4132-80de-63c26ad657da', 
      'CWCW', 'CWSP', (select intakeservicerequestdispositioncodeid from cjams.intakeservicerequestdispositioncode where
       intakeserviceid = '9f2d5f9c-54b1-4069-812d-3dea261237b1' and updatedby = 'CDM-35490'),
      15, 0, '862e2eaf-3592-475f-aa41-212c1ac3b219', '2023-09-25 15:00:00.000', 'CDM-35490', now(), true,
      '', NULL, '', '231021129483', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
   );  

  
update
   caseassignment 
set
   enddate = '2023-11-16 00:00:00.000', updatedby = 'CDM-35490', updatedon = now() 
where
   caseassignmentid = '18e7e741-a4fb-4b7c-a428-cbefe33670b1';
  
  	
update personprogramarea set activeflag = 0, updatedby = 'CDM-35490', updatedon = now() where personprogramid in 
	('84b9637b-8043-41ec-a104-21791f8e4b03', '74f784ff-4832-4819-9906-a34308a46d38','d831347f-478e-47f5-9fb9-be3ea22b90e9',
      '255d3ac4-2e66-4b96-96e2-c6d3079ce7ac', '1d97653d-d91e-4539-a505-844e03de6940') ;
  
update
   personprogramarea 
set
   enddate = '2023-11-16 00:00:00.000', updatedby = 'CDM-35490', updatedon = now()
where
   entityid = '231021129483' 
   and activeflag = 1 
   and enddate is null;
 
delete from cjams.legislative where intakeserviceid = '9f2d5f9c-54b1-4069-812d-3dea261237b1'
and updatedby = 'CDM-35490';

INSERT INTO cjams.legislative
(legislativeid, intakeserviceid, isapprovedsafec, activeflag, updatedby, updatedon, insertedby, insertedon, isinitialfacetoface, isapprovedmfira, isapprovecansf,
isvictimperpetrator, isallpersons, isallegedvicitm, isemergency, islegislativereporting, isreasonnotprovided, isdataentrynotes, islateinitialcontact)
VALUES(gen_random_uuid(), '9f2d5f9c-54b1-4069-812d-3dea261237b1', true, 1, 'CDM-35490', now(), 
'38d79277-40be-4c69-941c-598d2e5e462b', now(), NULL, true, NULL, true, true, NULL, '', NULL, '', '', true);
    
update personprogramarea set updatedby = 'c078eed8-fab6-490d-b099-47f9b968a5dc',
   updatedon = now() where personprogramid in 
	('b5475268-937d-4636-a8c1-4a5c6dba8aca', '8f7fc591-92eb-4be9-a511-a79f4eb10208', 'dfb33c24-8e35-484e-ad1b-1d95d1ce8094',
   '47ae4a9b-e144-4d0d-86c2-4cee70c8f4a7', '7e9a08ab-7597-4660-be03-8a6f829ad13f');


