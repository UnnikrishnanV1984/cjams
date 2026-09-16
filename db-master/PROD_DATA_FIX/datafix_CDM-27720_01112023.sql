-- CDM-27720 - Add Person Card to receive Adoption Subsidy
/*
-- Issue Description: 
   User request to add New Adoptive Parent Person card under the following Adoption Cases

	1. Case #3276101 (Child Name/ID: Clayton Spencer / PID: #4078681)
	2. Case #3276107 (Child Name/ID: Lee Spencer / PID: #4078774)
	3. Case #3276108 (Child Name/ID: Leigha Spencer / PID: #4078777)
	4. Case #3276109 (Child Name/ID: Timmy Spencer PID: #4078779)

    5. Enter the Death of Date (DOD) for Deborah Fletcher (CJAMS PID# 144491) as 09/17/2022
	
-- Category/ Module: Adoption Cases (Case Management) 
-- Root cause: As per current design CJAMS is NOT creating a new adoptive person card upon provider change on Adoption Agreement screen. User story is required to develop this feature.
-- Fix Provided: Datafix has been promoted to update DOD for prior provider and New Adoptive Parent Person card under the following Adoption Cases
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update the Death of Date (DOD) for Deborah Fletcher (CJAMS PID# 144491) as 09/17/2022
select cjamspid, firstname, lastname, dob, dateofdeath, updatedby, updatedon
	from person 
where cjamspid = 144491 
	and activeflag = 1 ;

update person
set dateofdeath = '2022-09-17 00:00:00',
	updatedon = now(), 
	updatedby = 'CDM-27720'
where cjamspid = 144491 
	and activeflag = 1 ;

-- Create New Person Card
-- Name: Tarron Fletcher (Provider ID: 6012824)
-- DOB: 11/9/1982
-- Race: Black
-- 214020053
-- Address: 122 Teal Lane Cambridge, MD 21613

INSERT INTO cjams.person
	(	personid, activeflag, principalident, firstname, lastname, middlename, salutation, suffix, dangerlevel, dangerreason, 
		updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, 
		old_id, "timestamp", dob, religiontypekey, maritalstatustypekey, gendertypekey, 
		racetypekey, deceaseddate, ethnicgrouptypekey, incometypekey, interpreterrequired, firstnamesoundex, 
		lastnamesoundex, ssnverified, userphoto, refusessn, refusedob, dangertoself, dangertoselfreason, 
		personphysicalattributetypeid, maidenname, socialmediasource, dateofdeath, prefx, occupation, deceased, stateid, 
		fein, complaintnumber, cjisnumber, petitionid, tribalassociation, physicalattributes, 
		isdraft, interfaceid, cjamspid, 
		strengths, needs, nationalitytypekey, isapproxdod, primarylanguageid, secondarylanguageid, livingsituationkey, 
		licensedfacilitykey, otherlicensedfacility, livingsituationdesc, reporteranonymousflag, url, expungementflag, 
		dobflag, nameunknownflag, actiontypekey, adoptedflag, everbeenadoptedflag, sysdetadptflag, 
		previousadoptionagetypekey, confirmationentitytypekey, clientflag, approximateageno, ssnno, 
		citizenalenagetypekey, alienregistrationtext, doddate, physicalbuildtypekey, skintonetypekey, eyecolortypekey, 
		haircolortypekey, hairtexturetypekey, distinguishedcomments, criminalrecordflag, stateverifieddate, 
		countytypekey, primarycitizenshiptypekey, seccitizenshiptypekey, providerid, cisclientid, datepictaken, 
		datavalidflag, outofstateflag, disabilityflag, afcarsageoutflag, afcarsperiodsent, fetalalcoholspctrmdisordflag, 
		substanceexposednewbornflag, otherdrugs, substanceexposednewbornsourcetypekey, substanceexposednewbornsourceid, 
		substanceexposednewborntimetamp, isapproxdob, otherprimarylanguagetypekey, citizenalenageflag, otherreligion, 
		isqualifiedalien, verificationremarks, alienstatustypekey, safehavenbabyflag, fk_id, personflag, preadoptiondate, 
		aname, batchrunflag, isuscitizen, hairtextureotherdesc, haircolorotherdesc, isglasses, employername, 
		clienttitle, biologicalmothermarriedsw, etl_userid, etl_load_date, livingarrangementkey, livingarrangementdesc, 
		cferesourcehomechild, icwastatusinquiry, icwaeligibleformembership, icwatribename, icwaunderdefinition, 
		icwanotification, icwatribelegalnotice, intercountryadoption, priorlegalguardianship, preplacementguardianshipdate, 
		federallyrecognizedtribe, substanceclasses, othersubstances, senstatusflag, ispostmdmflag, postmdmreturnstatus)
VALUES
	(	cjams.gen_random_uuid(), 1, NULL, 'Tarron', 'Fletcher', NULL, NULL, NULL, NULL, NULL, 
		'CDM-27720', now(), 'CDM-27720', now(), now(), NULL, 
		'6012824', NULL, '1982-11-09 00:00:00.000', NULL, NULL, 'M', 
		'[{"racetypekey":"BA"}]', NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, false, false, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		0, NULL, nextval('sequence_for_alpha_numerics'::regclass), 
		NULL, NULL, NULL, NULL, NULL, NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, 2, NULL, '214020053', 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL
	);


INSERT INTO cjams.personracetypemap
	(	personracetypemapid, 
		personid, 
		racetypekey, activeflag, updatedby, updatedon, insertedby, insertedon, 
		effectivedate, expirationdate, old_id, etl_userid, etl_load_date)
VALUES
	(	cjams.gen_random_uuid(),
		(select personid from cjams.person where insertedby = 'CDM-27720'), 
		'BA', 1, 'CDM-27720', now(), 'CDM-27720', 
		now(), now(), NULL, NULL, NULL, NULL
	);


-- 1. Case #3276101 (Child Name/ID: Clayton Spencer / PID: #4078681) -- 07a73d8a-12f7-4109-940e-6e4cede49b86
-- 4078681	495a0f79-9d13-4641-b9cd-688ba1b56ea7	CLAYTON	SPENCER
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, 
		actortypekey, old_id, activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '07a73d8a-12f7-4109-940e-6e4cede49b86', 
		(select personid from cjams.person where insertedby = 'CDM-27720'), 
		'ADOPTIVEPARENT', '3276101', 1, 
		now(), 'CDM-27720', now(), 'CDM-27720', NULL, NULL
	);
	
-- 2. Case #3276107 (Child Name/ID: Lee Spencer / PID: #4078774) -- 65f326e7-63b0-4426-b4de-f1960b53c7e9
-- 4078774	22534338-8cd4-4657-b917-db9a16016d9a	LEE	SPENCER
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, 
		actortypekey, old_id, activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '65f326e7-63b0-4426-b4de-f1960b53c7e9', 
		(select personid from cjams.person where insertedby = 'CDM-27720'), 
		'ADOPTIVEPARENT', '3276107', 1, 
		now(), 'CDM-27720', now(), 'CDM-27720', NULL, NULL
	);
	
-- 3. Case #3276108 (Child Name/ID: Leigha Spencer / PID: #4078777) -- 2e0467cf-e32c-4bdb-8864-55e42a7de747
-- 4078777	971fa9fc-2602-4dd3-b4af-ed3dce560756	LEIGHA	SPENCER
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, 
		actortypekey, old_id, activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), '2e0467cf-e32c-4bdb-8864-55e42a7de747', 
		(select personid from cjams.person where insertedby = 'CDM-27720'), 
		'ADOPTIVEPARENT', '3276108', 1, 
		now(), 'CDM-27720', now(), 'CDM-27720', NULL, NULL
	);
	
-- 4. Case #3276109 (Child Name/ID: Timmy Spencer PID: #4078779) -- a02e3ee2-686f-4652-b13f-898055c07733
-- 4078779	fb3d2807-59bd-407a-b886-20f2f85f586e	TIMMY	SPENCER
INSERT INTO cjams.adoptioncaseactor
	(	adoptioncaseactorid, adoptioncaseid, 
		personid, 
		actortypekey, old_id, activeflag, 
		insertedon, insertedby, updatedon, updatedby, etl_userid, etl_load_date
	)
VALUES
	(	cjams.gen_random_uuid(), 'a02e3ee2-686f-4652-b13f-898055c07733', 
		(select personid from cjams.person where insertedby = 'CDM-27720'), 
		'ADOPTIVEPARENT', '3276109', 1, 
		now(), 'CDM-27720', now(), 'CDM-27720', NULL, NULL
	);

INSERT INTO cjams.personaddress
	(	personaddressid, 
		personid, 
		activeflag, personaddresstypekey, address, zipcode, city, state, country, county, 
		updatedby, updatedon, insertedby, insertedon, 
		effectivedate, expirationdate, old_id, "timestamp", address2, directions, danger, dangerreason, 
		adrstreetsuffixtypekey, streetname, changereason, acknowledgement, acknowledgementflag, adrboxno, 
		adrdefaultflag, adrenddate, adrforeign, adrforeignstate, adrformattypekey, adrpostalcode, adrpostdirtypekey, 
		adrpredirtypekey, adrstartdate, adrstreetno, adrunitno, adrunittypekey, adrzip4no, currentlocation, 
		currentlocationflag, datavalidflag, empschoolname, expungementflag, formattedcityname, formattedstreetname, 
		incidentlocation, incidentlocationflag, mergeid, personaddresssubtypekey, personadrstartdate, personadrenddate, 
		addressstatus, durationday, ishouseholdmember, addressstartdate, etl_userid, etl_load_date, addressid, 
		nameoffacility, "comments"
	)
VALUES
	(	cjams.gen_random_uuid(), 
		(select personid from cjams.person where insertedby = 'CDM-27720'),
		1, 'HO', '122 Teal Lane', '21613', 'Cambridge', 'MD', 'USA', '971e5c71-6f29-4918-a1f2-f880fe5702b1', 
		'CDM-27720', now(), 'CDM-27720', now(), 
		'2022-10-01 00:00:00.000', NULL, NULL, NULL, '', NULL, false, NULL, 
		'LN', 'Teal', NULL, NULL, NULL, NULL, 
		1, NULL, NULL, NULL, 'S', NULL, NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		1, 1, NULL, NULL, NULL, NULL,
		NULL, NULL, NULL, NULL, '2022-10-01 00:00:00.000', NULL, NULL, 
		NULL, false, NULL, NULL, NULL, NULL, NULL, NULL
	);

