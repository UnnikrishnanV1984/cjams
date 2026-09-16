/*
 * CDM-35110 - Best Interest Determination
 * Customer Email ID:michael.beall1@maryland.gov
 * Customer Name:Michael Beall
 * Focus Area:Assessments: Other
 * Description - Dashboard:Hamish Mueller best interest won't let me pick at date of the meeting
 * Not able to add BID education as the Placement Date dropdown is not populating any placement record date.
 * Case # 2021011107389
 * Client ID # 200005455
 * 
 */

--  select p.placementid, 'CPA Home Placement' as placement_type
--, pc.altproviderid as provider_id
--, f_ename('2953', pc.altproviderid::bigint) as provider_name
--, pc.entrydt::date as entry_date
--, pc.exitdt::date as exit_date
--        from placement p,
--            placementcpahomes pc
--        where p.placementid = pc.placementid
--            and p.personid = '8f562294-2764-41fa-8e08-12adbc4493ea'
--            and p.activeflag = 1
--            and pc.activeflag = 1
--            and p.altproviderid is not null
--            and (p.isvoided is null or p.isvoided = 0);

--select entrydt, * from placementcpahomes where placementid = '6ada8631-df02-46ed-ae0b-732db9219a68';

UPDATE cjams.placementcpahomes
SET entrydt='2022-06-06', updateuserid='CDM-35110', updatets=now() 
WHERE placementcpahomeid='a94dc47a-f01c-412b-8692-f2d66b13d05f';
