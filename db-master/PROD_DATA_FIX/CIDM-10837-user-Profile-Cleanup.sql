/* Issue Description: User profile cleanup
    roman.napoli@maryland.gov --> this should match up with user ellen.kirillova@maryland.gov
    cleanup is completed for this user in sailpoint and we need to do cleanup in cjams db

-- Category/ Module:Services: Other

-- Root cause: User request 
-- Fix Provided: Datafix has been done to cleanup profile for 
    roman.napoli@maryland.gov --> this should match up with user ellen.kirillova@maryland.gov
-- Pull request# N/A
*/
update userprofile 
set primarycountycd = '3824',--DHS Central
updatedby = 'CIDM-10837', updatedon = now()
where securityusersid = '32a4166b-ceae-41f6-9d09-fc204d5ddd65' and activeflag =1;


update teammember
set teamid = 'ee4afe64-57d2-4b81-9a17-eabdaac31217', updatedby = 'CIDM-10837', updatedon = now()
where teammemberid = '80bfe18f-980c-4441-a21a-7c3e9a8d9d1c' --CW
and activeflag = 1;

update teammember
set teamid = '01d302b2-0cb3-40fa-937c-37f71a2543ea', updatedby = 'CIDM-10837', updatedon = now()
where teammemberid = 'ed6d3d90-1c7a-4218-b495-ef97533daa62' --AS
and activeflag = 1;

UPDATE cjams.userprofileaddress
SET activeflag = 0, updatedby = 'CIDM-10837', updatedon = now()
WHERE securityusersid = '32a4166b-ceae-41f6-9d09-fc204d5ddd65'and userprofileaddressid  = '51414195-d0ed-4c73-afa4-c62b76ff08f1' and activeflag = 1;


INSERT INTO cjams.userprofileaddress
(userprofileaddressid, securityusersid, activeflag, userprofileaddresstypekey, address, zipcode, pobox, city, state, country, updatedby, updatedon, insertedby, insertedon, 
effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, zipcodeplus, county, parentkeyid, adrformattypekey, adrstreetno, adrpredirtypekey, 
adrstreetname, adrstreetsuffixtypekey, adrpostdirtypekey, adrunittypekey, adrunitno, adrcountytypekey, adrdirection, adrforeign, adrdefaultflag, adrstartdate, adrenddate, 
adrforeignstate, adrcountry, adrpostalcode, adrstreet, countyid)
VALUES(gen_random_uuid(), '32a4166b-ceae-41f6-9d09-fc204d5ddd65', 1, 'P', '311 West Saratoga Street', '21201', NULL, 'Baltimore', 'MD', 'USA', 'CIDM-10837', 
now(), 'CIDM-10837', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DHS Central', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '11dc65f0-b116-45a9-a07a-8fbe171f0c9d'::uuid);
