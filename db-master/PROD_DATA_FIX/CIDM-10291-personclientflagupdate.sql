/*
Issue Description: 10291: Person Clientflag Cleanup
Category/Module: Person
Data/Code fix ticket#: CIDM-10291
*/
-- Change History
-- 03/26/2025 Clientflag cleanup - Agathya 
---------------------------- Start ----------------------------

/* scenario in clientflag 0:
 * For CW - No changes for any records
 * For AS - Except 0000 all should be 1
 * For Prov - All should be 2
 */

-- Setting AS - clientflag 0 to 1. -- 648
-- AS records - set flag to 1 -- 648
update person b
set clientflag = 1 
where activeflag = 1 and clientflag = 0 
and personid <> '00000000-0000-0000-0000-000000000000'
and (exists (
select 1 from actor a where a.personid = b.personid
and a.objecttype
in (
'as_intakeserviceid',
'as_servicecase'
)
)
or b.etl_userid = 'phafctocjamsaps'
) 
;

-- Setting Prov - clientflag 0 to 2. -- 5
-- Prov - so set it to 2. -- 5
update person b
set clientflag = 2
where activeflag = 1 and clientflag = 0 
and personid <> '00000000-0000-0000-0000-000000000000'
and exists (
select 1 from actor a where a.personid = b.personid
and a.objecttype in (
'prov_referral',
'prov_application',
'prov_provider'
)
)
;

/*
 * For Clientflag null, following scenarios.
 * For CW - all null will become 1.
 * For Prov - all null will become 2.
 * For AS - all null will become 1.
 * */

-- Setting Prov - clientflag 0 to 2. -- 4622
-- Prov - set flag to 2
update person b
set clientflag = 2
where activeflag = 1 and clientflag is null
and personid <> '00000000-0000-0000-0000-000000000000'
and exists (
select 1 from actor a where a.personid = b.personid
and a.objecttype in (
'prov_referral',
'prov_application',
'prov_provider'
)
)
;

-- Setting CW & AS - clientflag 0 to 1. -- 74772
-- Seeting client flag to 1 for CW & AS records -- person
update person b
set clientflag = 1
where activeflag = 1 and clientflag is null
and personid <> '00000000-0000-0000-0000-000000000000'
and not exists (
select 1 from person where 
lower(firstname)  in ('unnamed')
and lower(lastname)  in ('unnamed')
and personid = b.personid
)
;

/*
-- Current
1	0	233967
1	1	2384833
1	2	121862
1		79722
-- New
1	0	233314
1	1	2460253
1	2	126489
1		328
 */
-------------------------------------------- End -------------------------------------