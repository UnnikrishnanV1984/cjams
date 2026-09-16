/*
   Issue Description: CDM-30772
   Category/ Module : Adoption Case 
   Root cause:  As per user request
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.adoptioncasedisposition
SET  activeflag=0, updatedby='CDM-30772', updatedon=now()
WHERE adoptioncasedispositionid='3b2edc79-e316-477a-ab27-a84199b687c3' and adoptioncaseid='afd392c7-fe70-4dd8-86c1-0eca52ded1bb';

update routing 
SET activeflag=0, updatedby='CDM-30772', updatedon=now()
where objectid = '3b2edc79-e316-477a-ab27-a84199b687c3' and activeflag = 1;

UPDATE cjams.adoptioncase
SET statustypekey='Open', enddate=null, updatedby='CDM-30772', updatedon=now()
WHERE adoptioncaseid='afd392c7-fe70-4dd8-86c1-0eca52ded1bb' and adoptioncasenumber='3004734';

UPDATE cjams.personprogramarea
SET enddate=null, updatedby='CDM-30772', updatedon=now()
WHERE personprogramid='4485bc2d-9a28-4de9-b333-edf6d20b91e6' and personid='bdd75f94-e1d7-4d7e-8430-f6493d8465f1';
