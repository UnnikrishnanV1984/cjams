-- CDM-35372 - Invalid Removal End Date
/*
 -- Issue Description: In case 3305446;
 -- Category/ Module: case worker > case > childremoval & placement
 -- Root cause: Incorrect entry.
 -- Fix Provided: Datafix has been added to delete the duplicate record, set the end date and change the plcaement structure
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */
-- Queries to relevant ids
--select personid ,exitdate ,removaldate, removalid  ,activeflag, removalexitreason * 
--from cjams.intakeservreqchildremoval 
--where servicecaseid ='8cce42b3-9042-43b5-ae32-f30123bc9392' and personid ='a87ca565-9251-4c60-8fc8-6e537f2aafa9';--intakeservreqchildremovalid ='71f9271b-79be-474d-91ed-121ff0c7e940';
--
--- getting OOH info
--select personprogramid,alternateid ,* from personprogramarea 
--where personid ='a87ca565-9251-4c60-8fc8-6e537f2aafa9' and programkey = 'OOH' and activeflag = 1; -- returning two results, how to get relevant programid? should i filter by end date?
--
--- Getting eligibility table
--select removal_id, client_id, start_dt, end_dt, update_ts, update_user_id 
--	from cjams.tb_client_eligibility
--where removal_id = 252448;
--
--
--- Get placement 
--select alternateid, 
--	exitreasontypekey, -- ADNRE
--	exittypekey, -- PLCC
--	exittypetypekey, -- NULL
--	leastrestrictiveplacement,  -- Child has been adopted by her foster parents. 
--	remarks, -- Initial exit date was wrong.
--	updatedby, -- 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e'
--	updatedon -- '2023-10-03 11:48:34'
--from placement 
--where placementid ='ee8f0902-5fa4-4dcc-8ca6-7a006043620f'; -- not returning results personid ='a87ca565-9251-4c60-8fc8-6e537f2aafa9' and placementid ='ee8f0902-5fa4-4dcc-8ca6-7a006043620f'
--
--select removalid, removaldate, exitdate, returntransts, removalexitreason, updatedby, updatedon, activeflag 
--	from cjams.intakeservreqchildremoval
--where removalid = 252448
--	and activeflag = 1;
-- For programarea table
--select programkey, startdate, enddate, updatedby, updatedon
--	from cjams.personprogramarea 
--where personprogramid = '604440c1-2ba7-4834-b935-cff3c3640135'
--	and activeflag = 1; 
-- For tb_client_eligibilty
--select * from tb_client_eligibility tce where removal_id = 252448;
--select exitreasontypekey ,* from placement p where personid ='a87ca565-9251-4c60-8fc8-6e537f2aafa9';


--- queries
-- Updating end date
update
    cjams.intakeservreqchildremoval
set
    exitdate = Null,
    returndate = Null,
    returntime = Null,
    returntransts = Null,
    removalexitreason = NULL,
    updatedby = 'CDM-35372',
    updatedon = now()
where
    removalid = 252448
    and activeflag = 1;

update
    cjams.personprogramarea
set
    enddate = Null,
    updatedby = 'CDM-35372',
    --Inserted by 44ae52aa-6389-425a-a422-2a8bf24c3aae(Detra Kelly) is replaced by audit value
    updatedon = now()
where
    personprogramid = '604440c1-2ba7-4834-b935-cff3c3640135'
    and activeflag = 1;

update
    cjams.tb_client_eligibility
set
    end_dt = Null,
    update_user_id = 'CDM-35372',
    update_ts = now()
where
    removal_id = 252448
    and delete_sw = 'N';

-- updating placement exit key type
update
    placement
set
    exitreasontypekey = null,
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    updatedby = 'CDM-35372',
    updatedon = now()
where
    alternateid = 1570628
    and activeflag = 1;

-- Deleting the duplicate record
update
    cjams.personprogramarea
set
    activeflag = 0
where
    personprogramid = '4fb2e171-4186-4afe-80c7-2cd4b55a5a94'
    and activeflag = 1;

-- get placementrevision rows
select
    approvalstatustypkey,
    exittypekey,
    exitreasontypkey,
    exittypetypkey,
    updatedby,
    updatedon,
    *
from
    placementrevision
where
    placementid = 'ee8f0902-5fa4-4dcc-8ca6-7a006043620f'
    and activeflag = 1;

-- updating placement revision
update
    placementrevision
set
    exittypekey = 'CIPS',
    -- Change in Placement Structure
    updatedby = 'CDM-35372',
    updatedon = now()
where
    placementid = 'ee8f0902-5fa4-4dcc-8ca6-7a006043620f'
    and activeflag = 1;

----
update
    placement
set
    intakeservreqchildremovalid = '5dd86355-fc13-4d96-80c0-2cbaad6a7372',
    updatedby = 'CDM-35372',
    updatedon = now()
where
    intakeservreqchildremovalid = 'a42bd2f4-c5c9-4bf0-a4f6-bbfb1f765d9b'
    and activeflag = 1;

-- Updating activeflag = 0
--select removalid, removaldate , exitdate , activeflag , personid ,*
update
    cjams.intakeservreqchildremoval
set
    activeflag = 0
where
    removalid = 293176
    and activeflag = 1;

-- Updating activeflag = 0   
--select *
update
    cjams.intakeservreqchildremoval_history ih
set
    activeflag = 0
where
    intakeservreqchildremovalid = '5dd86355-fc13-4d96-80c0-2cbaad6a7372' -- removalid = 293176
    and activeflag = 1;

-- Updating activeflag = 0   
--select *
update
    cjams.routing r
set
    activeflag = 0
where
    objectid = '5dd86355-fc13-4d96-80c0-2cbaad6a7372' -- removalid = 293176
    and activeflag = 1;