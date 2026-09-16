/*
   Issue Description: CDM-30868
   Category/ Module  : Prod data fix to Update Private Adoption Details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

-- Update alternateid (adoption_id) used for Payment generation tb_adoption
select adoptioncasenumber, alternateid, updatedby, updatedon , statustypekey
	from adoptioncase 
where adoptioncasenumber in ('231040082847')
	and activeflag = 1 ;

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
    statustypekey = 'Open',
	updatedby = 'CDM-30868',
	updatedon = now()
where adoptioncasenumber in ('231040082847')
	and activeflag = 1 ;


--231040082847
INSERT INTO cjams.adoptioncaseagreement
(adoptionagreementid ,adoptioncaseid, startdate, enddate, effectivedate, parent1providerid, parent2providerid,
parent1providername, parent2providername, agreementcomments, activeflag, insertedby, insertedon, updatedby, updatedon, 
providerid,parent1signdate,parent2signdate,ldssdate,alternateid)
VALUES('de2446b8-59bd-48f2-96ae-3c964dca88a0', '005b0419-ac13-4c31-8b12-28f095ff87eb', '2023-02-15 05:00:00.000', '2024-02-14 05:00:00.000','2023-02-15 05:00:00.000',
 6034037, 6034037, 'Lindsey Wilkins', 'Robert Wilkins', 'Another state Child placed by Private Agency',
 1, '0f21b527-afbb-4a4f-94b7-ce0ade354f99', now(), 'CDM-30868', now(),6034037,'2023-01-26 14:00:00.000','2023-01-26 14:00:00.000','2023-01-26 16:00:00.000', nextval('sequence_adoptionagreement'::regclass)
);

INSERT INTO cjams.adoptioncaseagreementrevision
(adoptioncaseagreementid, isofferedsubsidy, offeraccepteddate, startdate, enddate, finalizationdate, isunderappeal, parent1signdate, 
parent2signdate, ldssdate, issubsidypaid, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id,
ismedassist, parent1providerid, parent2providerid, parent1providername, parent2providername, issingleparent, singleparentadoptioncheck, agreementcomments, 
childplacedby, childplacedfrom, providerid, adoptiveparent1id, adoptiveparent2id, approvalstatustypekey, approvaldate, switchproviderreason, effectiveswitchdate, switchprovider, agreementtyperefid)
VALUES('de2446b8-59bd-48f2-96ae-3c964dca88a0', 1, '2023-01-26 05:00:00.000', '2023-02-15 05:00:00.000', '2024-02-14 05:00:00.000', NULL, NULL, '2023-01-26 14:00:00.000', 
'2023-01-26 14:00:00.000', '2023-01-26 16:00:00.000', 1, 1, now(), '0f21b527-afbb-4a4f-94b7-ce0ade354f99', now(), 'CDM-30868', now(), NULL, 
NULL, 6034037, 6034037, 'Lindsey Wilkins','Robert Wilkins', NULL, NULL, NULL, 
'priaug', 'anst', NULL, NULL, NULL, '3045', NULL, NULL, NULL, NULL, 'TIAAA');

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid, reassignnotes)
VALUES('ASAR', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', 'a37cfda9-e898-4c94-8eef-7f565e129bf2', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWSP', 'CWSP', 'de2446b8-59bd-48f2-96ae-3c964dca88a0', 15, 1, '0f21b527-afbb-4a4f-94b7-ce0ade354f99', now(), 'CDM-30868', now(), true, 'Adoption Agreement Submitted for Review', NULL, 'Adoption Agreement Submitted for Review', '231040082847', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
