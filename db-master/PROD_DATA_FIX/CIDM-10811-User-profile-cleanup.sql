/* Issue Description: User profile cleanup
    stephen.liggett-creel@maryland.gov --> this should match up with user tahereh.hematian@maryland.gov
    cleanup is completed for this user in sailpoint and we need to do cleanup in cjams db

-- Category/ Module:Services: Other

-- Root cause: User request 
-- Fix Provided: Datafix has been done to cleanup profile for 
    stephen.liggett-creel@maryland.gov --> this should match up with user tahereh.hematian@maryland.gov
-- Pull request# N/A
*/

/*
 * stephen.liggett-creel@maryland.gov --> this should match up with user tahereh.hematian@maryland.gov

select supervisorid ,teammemberid ,* from v_userprofile vu where email = 'stephen.liggett-creel@maryland.gov';
b524b312-df91-4d04-8158-c4be242bbfee: secuUUID
afadd402-1ace-42bc-8f65-f8270890eace: teammeberid

taherehhematian
047a3b88-d220-4418-b9d0-4e3fd697e280 : teammemberid
5da74401-a9a3-4ff3-81df-66d49be88e1c : teamid
749d6707-62ec-4d58-a755-204f65d8beaa: securityuserid
*/

--Updating teammember in CW side
/*
select * from teammember t 
where teammemberid in ('afadd402-1ace-42bc-8f65-f8270890eace','047a3b88-d220-4418-b9d0-4e3fd697e280')
and activeflag =1;
*/
update userprofile 
set primarycountycd = '3824',--DHS Central
	updatedby = 'CIDM-10811', updatedon = now()
where securityusersid = 'b524b312-df91-4d04-8158-c4be242bbfee' and activeflag =1;

update teammember
set teamid = '5da74401-a9a3-4ff3-81df-66d49be88e1c',--623befd8-510f-4272-83af-6fb65576d7cb
	roletypekey = 'CWPS',
	updatedby = 'CIDM-10811', updatedon = now()
where teammemberid = 'afadd402-1ace-42bc-8f65-f8270890eace' --CW
and activeflag = 1;

/*
 * IN AS SIDE as well 
select * from as_teammemberassignment at2 where securityusersid in('b524b312-df91-4d04-8158-c4be242bbfee','749d6707-62ec-4d58-a755-204f65d8beaa');
teammenberid:
783a1927-f5de-467c-b3bd-b902aef5ba4d
3d693ce5-85e6-4b8e-bdd1-d8df14546268

select * from teammember t where teammemberid  in ('783a1927-f5de-467c-b3bd-b902aef5ba4d','3d693ce5-85e6-4b8e-bdd1-d8df14546268')

*/

update teammember
set teamid = '452febf8-428b-4836-b8e2-9125ace6307b',--623befd8-511195b6-0b51-4773-a30b-c122410b0803
	roletypekey = 'ASPS',
	updatedby = 'CIDM-10811', updatedon = now()
where teammemberid = '783a1927-f5de-467c-b3bd-b902aef5ba4d' --AS
and activeflag = 1;

--Updating teammemberassignment
/*
select * from teammemberassignment t 
where teammemberid in ('afadd402-1ace-42bc-8f65-f8270890eace','047a3b88-d220-4418-b9d0-4e3fd697e280')
and activeflag =1;

update teammemberassignment
set updatedby = 'CIDM-10811', updatedon = now()
where teammemberassignmentid = '809069f2-6967-4987-8ffc-cf62c5bc31f0' and activeflag = 1;
*/

--UPdating muser
/*
select * from muser where securityusersid in('b524b312-df91-4d04-8158-c4be242bbfee','749d6707-62ec-4d58-a755-204f65d8beaa')

update muser
set updatedby = 'CIDM-10811', updatedon = now()
where email = 'margaret.oni@montgomerycountymd.gov' and activeflag = 1;
*/

--Updating rolemapping
--select * from rolemapping r where principalid in('5093','39154') and activeflag =1;

update rolemapping 
set roleid = 5251, --34
	updatedby = 'CIDM-10811',
	updatedon = now()
where principalid = '5093'
	and id = '58325282'
	and activeflag = 1;

update rolemapping 
set activeflag = 0,
	updatedby = 'CIDM-10811',
	updatedon = now()
where principalid = '5093'
	and id = '58331283'
	and activeflag =1;

update rolemapping 
set roleid = 3150,--36
	updatedby = 'CIDM-10811',
	updatedon = now()
where principalid = '5093'
	and id = '155710282'
	and activeflag =1;

INSERT INTO cjams.rolemapping
(principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('USER', '5093', 154, 1, 'CIDM-10811', 'CIDM-10811', now(), now(), '', 'OLM');

--Deactivating userresource
--select * from userresource u where userid in('5093','39154') and activeflag =1;-- 5093: stephen 39154: tahereh

update userresource 
set activeflag = 0,
	updatedby = 'CIDM-10811',
	updatedon = now()
where userid = '5093' and activeflag =1;
	
--select * from userprofileaddress where securityusersid in('b524b312-df91-4d04-8158-c4be242bbfee','749d6707-62ec-4d58-a755-204f65d8beaa')

update userprofileaddress 
set activeflag =0,
	updatedby ='CIDM-10811',
	updatedon =now()
where securityusersid = 'b524b312-df91-4d04-8158-c4be242bbfee'
and userprofileaddressid = 'f9514855-6aae-495b-a9a9-fec998bf0ec3'
and activeflag =1;

INSERT INTO cjams.userprofileaddress
( securityusersid, activeflag, userprofileaddresstypekey, address, zipcode, pobox, city, state, country, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, zipcodeplus, county, parentkeyid, adrformattypekey, adrstreetno, adrpredirtypekey, adrstreetname, adrstreetsuffixtypekey, adrpostdirtypekey, adrunittypekey, adrunitno, adrcountytypekey, adrdirection, adrforeign, adrdefaultflag, adrstartdate, adrenddate, adrforeignstate, adrcountry, adrpostalcode, adrstreet, countyid)
VALUES( 'b524b312-df91-4d04-8158-c4be242bbfee', 1, 'P', '311 W Saratoga Street, Baltimore', NULL, NULL, 'Baltimore', 'MD', 'USA', 'CIDM-10811', now(), 'CIDM-10811', now(), '2024-02-28 14:15:17.186', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'MDTHINK', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11dc65f0-b116-45a9-a07a-8fbe171f0c9d'::uuid);