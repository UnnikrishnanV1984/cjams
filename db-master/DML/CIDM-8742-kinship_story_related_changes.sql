delete from cjams.agencyprogramarea where programkey in ('KN', 'KNS', 'KIN') and activeflag = 1;

INSERT INTO cjams.agencyprogramarea
(programname, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, old_id, programkey, effectivedate)
VALUES('Kinship Navigator', now(), NULL, now(), 'CIDM-8139', now(), 'CIDM-8139', 1, null, 'KIN', now());


delete from cjams.programareaconfig where programkey in ('KN', 'KNS', 'KIN') and subprogramkey in ('IN', 'FO', 'INF', 'FOR') and activeflag = 1;

INSERT INTO cjams.programareaconfig
(programkey, subprogramkey, servicerequestsubtypekey, isdefault, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id)
values('KIN', 'INF', null, 1, 1, now(), 'CIDM-8139', now(),  'CIDM-8139', now(), null);

INSERT INTO cjams.programareaconfig
(programkey, subprogramkey, servicerequestsubtypekey, isdefault, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id)
VALUES('KIN', 'FOR', null, 1, 1, now(), 'CIDM-8139', now(),  'CIDM-8139', now(), NULL);delete from cjams.referencevalues where referencetypeid  = 12 and ref_key  in  ('IN', 'INF', 'FO', 'FOR');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('INF', 12, 'Informal', 'Informal', 'CW', 1, null, 'CIDM-8139', now(), 'CIDM-8139', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FOR', 12, 'Formal', 'Formal', 'CW', 1, null, 'CIDM-8139', now(), 'CIDM-8139', now(), NULL, NULL, NULL);

delete from cjams.progressnotereasontype where progressnotereasontypekey in  ('KNS', 'KIN');

INSERT INTO cjams.progressnotereasontype
(progressnotereasontypekey, activeflag, typedescription, effectivedate, insertedby, updatedby, insertedon, updatedon, old_id, isas)
VALUES('KIN', 1, 'Kinship Navigation Services', now(), 'CIDM-8139', 'CIDM-8139', now(),now(), '', false);

delete from cjams.referencevalues where referencetypeid = 357 and ref_key in ('LP', 'GU', 'AP');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LP', 357, 'Reunification with legal parent', 'Reunification with legal parent', 'CW', 1, 2, 'CIDM-8139', now(), 'CIDM-8139', 
now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GU', 357, 'Reunification with guardian', 'Reunification with guardian', 'CW', 1, 3, 'CIDM-8139', now(), 'CIDM-8139', 
now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AP', 357, 'Reunification with adoptive parent', 'Reunification with adoptive parent', 'CW', 1, 4, 'CIDM-8139', now(), 'CIDM-8139', 
now(), NULL, NULL, NULL);

--PURPOSE
INSERT INTO cjams.intakeservicerequesttype
( intakeservreqtypeid,intakeservreqtypekey, description, insertedby, insertedon, updatedby, updatedon, archiveon, archiveby, "timestamp", workloadweight, investigatable, activeflag, old_id, sequencenumber)
select '7933508f-0350-4552-be50-350598a387a7'::uuid,'Kinship Navigator', 'Kinship Navigator', 'CIDM-8139', now(), 'CIDM-8139', now(), NULL, NULL, NULL, 1, false, 1, NULL, null
where not exists (select 1 from cjams.intakeservicerequesttype where intakeservreqtypeid = '7933508f-0350-4552-be50-350598a387a7'::uuid);


INSERT INTO cjams.intakeagencypurpose
( insertedby, insertedon, updatedby, updatedon, activeflag, teamtypekey, intakeservreqtypeid, old_id)
select  'CIDM-8139', now(),'CIDM-8139', now(), 1, 'CW', '7933508f-0350-4552-be50-350598a387a7'::uuid, null
where not exists (select 1 from cjams.intakeagencypurpose where intakeservreqtypeid = '7933508f-0350-4552-be50-350598a387a7'::uuid);

--Informal

INSERT INTO cjams.intakeserv
(intakeservid, description, insertedby, insertedon, updatedby, updatedon, activeflag, old_id, intakeservtypekey)
select '3c980561-c10d-42a4-8f09-cd087922eee0', 'Informal', 'CIDM-8139', now(), 'CIDM-8139', now(), 1, NULL, null
where not exists (select 1 from cjams.intakeserv where intakeservid = '3c980561-c10d-42a4-8f09-cd087922eee0');

INSERT INTO cjams.intakeagencyserv   
( intakeservid, insertedby, insertedon, updatedby, updatedon, activeflag, teamtypekey, intakeservreqtypeid, old_id, servicerequesttypeconfigid, plantypekey)
select '3c980561-c10d-42a4-8f09-cd087922eee0', 'CIDM-8139', now(), 'CIDM-8139', now(), 1, 'CW', '7933508f-0350-4552-be50-350598a387a7', NULL, NULL, 'FC'
where not exists (select 1 from cjams.intakeagencyserv where intakeservid = '3c980561-c10d-42a4-8f09-cd087922eee0');

--Formal

INSERT INTO cjams.intakeserv
(intakeservid, description, insertedby, insertedon, updatedby, updatedon, activeflag, old_id, intakeservtypekey)
VALUES('f6b37c9b-2241-4e7f-9ee1-713b94f35fbc', 'Formal', 'CIDM-8139', now(), 'CIDM-8139', now(), 1, NULL, NULL)
on conflict (intakeservid) do nothing;


INSERT INTO cjams.intakeagencyserv   
( intakeservid, insertedby, insertedon, updatedby, updatedon, activeflag, teamtypekey, intakeservreqtypeid, old_id, servicerequesttypeconfigid, plantypekey)
select 'f6b37c9b-2241-4e7f-9ee1-713b94f35fbc', 'CIDM-8139', now(), 'CIDM-8139', now(), 1, 'CW', '7933508f-0350-4552-be50-350598a387a7', NULL, NULL, 'FC'
where not exists (select 1 from cjams.intakeagencyserv where intakeservid = 'f6b37c9b-2241-4e7f-9ee1-713b94f35fbc');

--I&R

INSERT INTO cjams.intakeserv
(intakeservid, description, insertedby, insertedon, updatedby, updatedon, activeflag, old_id, intakeservtypekey)
select 'a6114db3-48b8-43dc-bdfe-7efb327cc0ba', 'I&R', 'CIDM-8139', now(), 'CIDM-8139', now(), 1, NULL, null
where not exists (select 1 from cjams.intakeagencyserv where intakeservid = 'a6114db3-48b8-43dc-bdfe-7efb327cc0ba');


INSERT INTO cjams.intakeagencyserv   
( intakeservid, insertedby, insertedon, updatedby, updatedon, activeflag, teamtypekey, intakeservreqtypeid, old_id, servicerequesttypeconfigid, plantypekey)
select  'a6114db3-48b8-43dc-bdfe-7efb327cc0ba', 'CIDM-8139', now(), 'CIDM-8139', now(), 1, 'CW', '7933508f-0350-4552-be50-350598a387a7', NULL, NULL, 'FC'
where not exists (select 1 from cjams.intakeagencyserv where intakeservid = 'a6114db3-48b8-43dc-bdfe-7efb327cc0ba');

-- TODO: This query will be revisited.
insert into programcategorylink (agencyprogramareaid,insertedby,
insertedon,updatedby,updatedon,activeflag,old_id,fiscalcategoryid,etl_userid,etl_load_date)
select (select agencyprogramareaid from agencyprogramarea where programkey = 'KIN' and activeflag = 1 limit 1),'CIDM-8139',now() :: date, 'CIDM-8139',now(),
activeflag,old_id,fiscalcategoryid,etl_userid,etl_load_date from programcategorylink pl 
where agencyprogramareaid in (select agencyprogramareaid from agencyprogramarea where programkey = 'IHSFP' and activeflag = 1) and activeflag = 1 
and not exists (select 1 from programcategorylink where  agencyprogramareaid in 
(select agencyprogramareaid from agencyprogramarea where programkey = 'KIN' and activeflag = 1) and activeflag = 1 limit 1);
       

-- Name update for kinship Navigator dropdown value
update agencyprogramarea set programname = 'Kinship Navigation', updatedby='CIDM-8742', updatedon=now() where programkey = 'KIN';


-- description update
update intakeservicerequesttype set description = 'Kinship Navigation',updatedby='CIDM-8742', updatedon=now()  
where intakeservreqtypeid ='7933508f-0350-4552-be50-350598a387a7';

-- inserting kinship navigation services intake

delete from cjams.intakeserv where intakeservid='f83b0f81-55a3-4bcb-ad4f-594cacf6c980' and insertedby='CIDM-8742';

INSERT INTO cjams.intakeserv
(intakeservid, description, insertedby, insertedon, updatedby, updatedon, activeflag, old_id, intakeservtypekey)
VALUES('f83b0f81-55a3-4bcb-ad4f-594cacf6c980', 'Kinship Navigation Services', 'CIDM-8742', now(), 'CIDM-8742', 
now(), 1, NULL, NULL)
on conflict (intakeservid) do nothing;


delete from intakeagencyserv where intakeservid='f83b0f81-55a3-4bcb-ad4f-594cacf6c980' and insertedby='CIDM-8742';

INSERT INTO cjams.intakeagencyserv   
( intakeservid, insertedby, insertedon, updatedby, updatedon, activeflag, teamtypekey, intakeservreqtypeid, 
old_id, servicerequesttypeconfigid, plantypekey)
select 'f83b0f81-55a3-4bcb-ad4f-594cacf6c980', 'CIDM-8742', now(), 'CIDM-8742', now(), 1, 'CW',
'7933508f-0350-4552-be50-350598a387a7', NULL, NULL, 'FC'
where not exists (select 1 from cjams.intakeagencyserv where intakeservid = 'f83b0f81-55a3-4bcb-ad4f-594cacf6c980');


delete from cjams.programareaconfig where programkey='KIN' and insertedby='CIDM-8742';

INSERT INTO cjams.programareaconfig
(programkey, subprogramkey, servicerequestsubtypekey, isdefault, activeflag, effectivedate, insertedby, insertedon, updatedby, updatedon, old_id)
VALUES('KIN', 'NON', null, 1, 1, now(), 'CIDM-8742', now(),  'CIDM-8742', now(), NULL);

delete from cjams.referencevalues where ref_key='NON' and insertedby='CIDM-8742';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NON', 12, 'None', 'None', 'CW', 1, null, 'CIDM-8742', now(), 'CIDM-8742', now(), NULL, NULL, NULL);


-- update programareconfig
update programareaconfig set servicerequestsubtypekey = 'IHM', updatedby='CIDM-8742', updatedon=now() where programkey='KIN' ;

/*
-- Issue Description: CIDM-8997: Program Assignment - Reason For Closure - Emanicipation needs spelling correction
-- Root cause: The spelling for Emancipation is spelled wrong. requested to update.
-- Fix Provided: Updated the referencevalues table with correct spelling
*/

update cjams.referencevalues set value_text='Legal Emancipation', description='Legal Emancipation',  updatedby='CIDM-8997', updatedon=now()
where referencevaluesid='9efec9d0-068b-4a6c-b86a-dc3258e0abc3' and activeflag = 1;