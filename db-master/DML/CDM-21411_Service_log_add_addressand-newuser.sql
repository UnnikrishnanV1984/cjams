/*
   Issue Description: CDM-21411
   Category/ Module  : FUNDING REQUEST FORM
   Root cause: Address details missing 
   Pull request# for code fix:  N/A 
   Reason why no related code fix:  N/A
   Status of the code fix if already submitted and expected prod fix date: 
   
*/


DELETE  from cjams.userprofileaddress
where securityusersid='3006a8ed-4ee0-485e-a4d5-1d3a4ac11ace' ;

INSERT INTO cjams.userprofileaddress
( securityusersid, activeflag, userprofileaddresstypekey, address, zipcode, pobox, city, state, country, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, old_id, "timestamp", voidedby, voidedon, voidreasonid, zipcodeplus, county, parentkeyid, adrformattypekey, adrstreetno, adrpredirtypekey, adrstreetname, adrstreetsuffixtypekey, adrpostdirtypekey, adrunittypekey, adrunitno, adrcountytypekey, adrdirection, adrforeign, adrdefaultflag, adrstartdate, adrenddate, adrforeignstate, adrcountry, adrpostalcode, adrstreet, countyid)
VALUES( '3006a8ed-4ee0-485e-a4d5-1d3a4ac11ace', 1, 'P', '1800, Charles', '21201', NULL, 'Baltimore', 'MD', 'USA', 'AS-ADMIN', '2021-01-28 11:38:05.387', 'admin', '2020-06-19 20:39:13.481', '2020-06-19 20:39:13.481', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Baltimore City', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c'::uuid);