/*
   Issue Description: CIDM-8714
   Category/ Module : Data cleanup for isbioadoptedflag which was implemented as part of CIDM-6864
   Root cause: Code fix has been done as part CIDM-6864 to restricted bio adopted child 
   Fix: Data fix to update the isbioadoptedflag for the adopted child bio cjamspid
*/

-- select
-- (select cjamspid from person where personid = adoptionclientid) as adoption_client,
-- (select adoptioncasenumber from adoptioncase where adoptioncaseid = a.adoptioncaseid) as adoption_case,
-- (select cjamspid from person where personid = a.preadoptionclientid) as bio_client,
-- (select servicecasenumber from servicecase
-- where servicecaseid = ( select ap.servicecaseid
-- from adoptionbreakthelink adb,adoptionplanning ap
-- where adb.adoptionplanningid = ap.adoptionplanningid
-- and adb.adoptionplanningid = a.preadoptioncaseid)
-- )as Bio_case
-- from adoptionlink a
-- where activeflag = 1
-- and adoptionclientid in (select personid
-- from person
-- where cjamspid in ( Adoption Client cjamspids ?? ))

update person p 
set isbioadoptedflag = 1--, updatedon = now(), updatedby = 'CIDM-8714'
where activeflag = 1 and isbioadoptedflag is null and 
p.personid in (select a.preadoptionclientid from adoptionlink a where activeflag = 1);

