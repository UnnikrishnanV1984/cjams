 /*
  Issue Description: CDM-19696
   Category/ Module  :  Edit Person Profile
   Root cause: case closed
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/
update person set dob='1968-11-12',gendertypekey= 'M',ethnicgrouptypekey='X',updatedby='CDM-19696',updatedon=now() where 
cjamspid=200822990 and personid='14990f69-eb52-4f68-ab0d-366da12feccd';

update personracetypemap set racetypekey='AS',updatedby='CDM-19696',updatedon=now()  where personid='14990f69-eb52-4f68-ab0d-366da12feccd'
and activeflag=1;