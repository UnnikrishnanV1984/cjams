/*
   Issue Description: Role update on cjams side to clean up mohamed.mughal1@maryland.gov to match it up with phyllis.mata@maryland.gov
   Category/ Module  : role update
   Root cause: User Request, cleanup mohamed.mughal1@maryland.gov to match it up with phyllis.mata@maryland.gov as sailpoint side is done.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--select * from v_userprofile where email in ('mohamed.mughal1@maryland.gov','phyllis.mata@maryland.gov')

update userprofile 
set primarycountycd = '3824',--3828
	teamtypekey = 'FNS',--ASPROV
	updatedby = 'CJAMS-61766', updatedon = now()
where securityusersid = '1ac55852-6e77-4a66-a9f1-a73e193fe3db' and activeflag =1;

update teammember
set teamid = 'ee4afe64-57d2-4b81-9a17-eabdaac31217',--52cd6121-d53b-4e5b-af49-395854585156
	roletypekey = 'FNSCOFW',
	updatedby = 'CJAMS-61766', updatedon = now()
where teammemberid = 'b8591a9a-f2cb-4bd3-98b1-1ca14187c3c1' --CW
and activeflag = 1;

update rolemapping 
set roleid = 4201, --1053,
	updatedby = 'CJAMS-61766',
	updatedon = now()
where principalid = '67156'
	and id = '175120531'
	and activeflag = 1;

update userprofileaddress 
set activeflag =0,
	updatedby ='CJAMS-61766',
	updatedon =now()
where securityusersid = '1ac55852-6e77-4a66-a9f1-a73e193fe3db'
and userprofileaddressid = 'ba7a94d2-042d-46ec-b22f-fdadaab0f25c'
and activeflag =1;

INSERT INTO cjams.userprofileaddress
( securityusersid, activeflag, userprofileaddresstypekey, address, zipcode, pobox, city, state, country, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, zipcodeplus, county, parentkeyid, adrformattypekey, adrstreetno, adrpredirtypekey, adrstreetname, adrstreetsuffixtypekey, adrpostdirtypekey, adrunittypekey, adrunitno, adrcountytypekey, adrdirection, adrforeign, adrdefaultflag, adrstartdate, adrenddate, adrforeignstate, adrcountry, adrpostalcode, adrstreet, countyid)
VALUES( '1ac55852-6e77-4a66-a9f1-a73e193fe3db', 1, 'P', '311 West Saratoga Street', '21201', NULL, 'Baltimore', '-', 'USA', 'CJAMS-61766', now(), 'CJAMS-61766', now(), '2019-10-08 17:16:48.303', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DHS Central', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11dc65f0-b116-45a9-a07a-8fbe171f0c9d');

update userresource
set activeflag = 0,
	updatedby = 'CJAMS-61766',
	updatedon =  now()
where userresourceid = 'c8ba6021-fe46-4859-9e72-0935f889aeb6' and activeflag=1;

INSERT INTO cjams.userresource
( userid, permissiongroupid, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES(67156, '59bcd395-be08-4856-8958-65cb17f5a6c4', 4201, NULL, 1, 'CJAMS-61766', now(), 'CJAMS-61766', now(), NULL, NULL, NULL, NULL);