/*
-- CDM-21563 - 

-- Issue Description: Incorrect placement start and end dates.
    Subsequently it was observed that the placements in question were being duplicated because
    of living arrangement. We're deleting the duplicate now to see if placement can be updated in 
    the app itself
  
-- Root cause: Data fix
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Person: Nyjae Green (CJAMS PID: 3847531)

-- INSERT INTO cjams.livingarrangement
-- (livingid, livingarrangementtypekey, livingstartdate, livingenddate, livingprefixtypekey, livingfirstname, livingmiddlename, livinglastname, livingsuffixtypekey, livingrelationshiptypekey, livingcomment, referralclientid, caseclientid, insertedon, insertedby, updatedon, updatedby, activeflag, addresstypekey, addressformattypekey, streetnumber, boxno, addresspredirtypekey, streetname, streetsuffixtypekey, addresspostdirtypekey, addressunittypekey, addressunit, cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreigntext, homephone, workphone, workext, pager, email, fax, cellphone, url, othercontacts, livingwhereaboutflag, foreignstate, country, postalcode, personid, caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, expungementflag, placementid, datavalidflag, clientmergeid, editapplyflag, old_id, silaagreementsigneddate, etl_userid, etl_load_date, islapsesinplacement, typeoflapses, primaryrelationship, livingpriortoplacement, runawayreported, runawayreportnumber)
-- VALUES('00f25e09-4f8b-4409-b6be-0b25850aaba0'::uuid, '32944', '2020-03-19 00:00:00.000', '2022-03-10 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, 'See Placement Record for more details', NULL, NULL, '2020-11-09 14:57:03.495', '1c6a6d17-dc78-4840-ac42-60aa87b6768f', '2022-03-22 09:57:49.667', '91e90bce-6584-40a1-8314-15c6595ec490', 1, '3357', 'S', NULL, NULL, ' ', 'Olesmont', 'RD', ' ', ' ', ' ', 'Catonsville', '1430', 'MD', 21228, NULL, NULL, NULL, '4102069866', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '12bf3942-3bf0-4607-8baa-c87c0561b52d'::uuid, NULL, NULL, NULL, 'Michele  Dayhoff ', NULL, NULL, 'b5b83d3c-6238-411d-9c60-763e317188ba'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update livingarrangement set activeflag = 0, updatedby = 'CDM-21563', updatedon = now() 
where livingid = '00f25e09-4f8b-4409-b6be-0b25850aaba0' and activeflag = 1;


-- Person: Breon Green (CJAMS PID: 4140505)

-- INSERT INTO cjams.livingarrangement
-- (livingid, livingarrangementtypekey, livingstartdate, livingenddate, livingprefixtypekey, livingfirstname, livingmiddlename, livinglastname, livingsuffixtypekey, livingrelationshiptypekey, livingcomment, referralclientid, caseclientid, insertedon, insertedby, updatedon, updatedby, activeflag, addresstypekey, addressformattypekey, streetnumber, boxno, addresspredirtypekey, streetname, streetsuffixtypekey, addresspostdirtypekey, addressunittypekey, addressunit, cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreigntext, homephone, workphone, workext, pager, email, fax, cellphone, url, othercontacts, livingwhereaboutflag, foreignstate, country, postalcode, personid, caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, expungementflag, placementid, datavalidflag, clientmergeid, editapplyflag, old_id, silaagreementsigneddate, etl_userid, etl_load_date, islapsesinplacement, typeoflapses, primaryrelationship, livingpriortoplacement, runawayreported, runawayreportnumber)
-- VALUES('bbcf447c-ea21-4065-8775-99521b037808'::uuid, '32944', '2022-03-10 00:00:00.000', '2022-03-10 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, 'See Placement Record for more details', NULL, NULL, '2020-11-09 15:00:20.375', '1c6a6d17-dc78-4840-ac42-60aa87b6768f', '2022-03-28 11:49:12.282', '91e90bce-6584-40a1-8314-15c6595ec490', 1, '3357', 'S', NULL, NULL, ' ', 'Olesmont', 'RD', ' ', ' ', ' ', 'Catonsville', '1430', 'MD', 21228, NULL, NULL, NULL, '4102069866', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'b7946ce4-c276-401c-9729-99881ccbfaef'::uuid, NULL, NULL, NULL, 'Michele  Dayhoff ', NULL, NULL, '594848d7-0582-45e4-a28b-cbd2e7420a00'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update livingarrangement set activeflag = 0, updatedby = 'CDM-21563', updatedon = now() 
where livingid = 'bbcf447c-ea21-4065-8775-99521b037808' and activeflag = 1;

-- Person: Niya Green ( CJAMS PID: 4223081)

-- INSERT INTO cjams.livingarrangement
-- (livingid, livingarrangementtypekey, livingstartdate, livingenddate, livingprefixtypekey, livingfirstname, livingmiddlename, livinglastname, livingsuffixtypekey, livingrelationshiptypekey, livingcomment, referralclientid, caseclientid, insertedon, insertedby, updatedon, updatedby, activeflag, addresstypekey, addressformattypekey, streetnumber, boxno, addresspredirtypekey, streetname, streetsuffixtypekey, addresspostdirtypekey, addressunittypekey, addressunit, cityname, countytypekey, statetypekey, zip5no, zip4no, direction, foreigntext, homephone, workphone, workext, pager, email, fax, cellphone, url, othercontacts, livingwhereaboutflag, foreignstate, country, postalcode, personid, caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, expungementflag, placementid, datavalidflag, clientmergeid, editapplyflag, old_id, silaagreementsigneddate, etl_userid, etl_load_date, islapsesinplacement, typeoflapses, primaryrelationship, livingpriortoplacement, runawayreported, runawayreportnumber)
-- VALUES('b7a0808c-2164-42cd-938b-4513d2dd64af'::uuid, '32944', '2022-03-10 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'See Placement Record for more details', NULL, NULL, '2020-11-09 15:00:18.801', '1c6a6d17-dc78-4840-ac42-60aa87b6768f', '2022-03-28 10:57:57.220', '91e90bce-6584-40a1-8314-15c6595ec490', 1, '3357', 'S', NULL, NULL, ' ', 'Olesmont', 'RD', ' ', ' ', ' ', 'Catonsville', '1430', 'MD', 21228, NULL, NULL, NULL, '4102069866', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '221e7eea-b256-4937-93df-84032c50f57e'::uuid, NULL, NULL, NULL, 'Michele  Dayhoff ', NULL, NULL, '8e676366-7a2f-4ae0-88a6-6456389d7c59'::uuid, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

update livingarrangement set activeflag = 0, updatedby = 'CDM-21563', updatedon = now() 
where livingid = 'b7a0808c-2164-42cd-938b-4513d2dd64af' and activeflag = 1;


update placement 
set startdatetime = '2020-03-19T10:00:00', starttime = '10:01', endtime = '09:00', updatedon = now(), updatedby = 'CDM-21563'
where placementid = '594848d7-0582-45e4-a28b-cbd2e7420a00';

update placement 
set startdatetime = '2020-03-19T10:00:00', starttime = '10:01', endtime = '09:00', enddatetime = '2022-03-10T10:00:00',
updatedon = now(), updatedby = 'CDM-21563'
where placementid = '8e676366-7a2f-4ae0-88a6-6456389d7c59';

-- placement revision

select entrydate, exitdate, * from placementrevision p 
where placementid = '594848d7-0582-45e4-a28b-cbd2e7420a00'
order by insertedon desc 
limit 2;

update placementrevision set entrydate = '2020-03-19T00:00:00', entrytime = '10:01', updatedon = now(),
updatedby = 'CDM-21563' where placementid = '594848d7-0582-45e4-a28b-cbd2e7420a00'
and placementrevisionid in ('412396b2-131d-44d5-9126-06d9007feb5d', '3e380df9-28a0-4b5b-86de-935aed8b9bbd');

select entrydate, exitdate, * from placementrevision p 
where placementid = '8e676366-7a2f-4ae0-88a6-6456389d7c59'
order by insertedon desc 
limit 2;

update placementrevision set entrydate = '2020-03-19T00:00:00', entrytime = '10:01',
exitdate = '2022-03-10T00:00:00', exittime = '09:00',
updatedon = now(),updatedby = 'CDM-21563' where placementid = '8e676366-7a2f-4ae0-88a6-6456389d7c59'
and placementrevisionid in ('0e54edd1-ce34-487f-be2a-e29651bfe3d1', '230d26c1-9306-441f-bb4b-6ec10a247ab2');

-- tb_placement_validation

update tb_placement_validation 
set delete_sw  = 'N',
        placement_entry_dt = '2020-03-19',
        placement_exit_dt  = '2022-03-10',
        validation_status_cd  = '1750',
        update_ts =  now(),
        update_user_id  = 'CDM-21563'
where placement_id  = 1558942
 and delete_sw  = 'Y' ;


update tb_placement_validation 
set placement_entry_dt = '2020-03-19',
        placement_exit_dt  = '2022-03-10',
        validation_status_cd  = '1750',
        update_ts =  now(),
        update_user_id  = 'CDM-21563'
where placement_id  = 1558941
 and delete_sw  = 'N' ;