 /*
  Issue Description: CDM-30602 Person Profile Race Entry Error
   Category/ Module  :  User error
   Root cause:
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
select * from cjams.person where cjamspid=2382817; --6d6d7197-8536-4f09-98d2-72bdc47031bf
select * from personracetypemap prtm where prtm.personid = '6d6d7197-8536-4f09-98d2-72bdc47031bf'  and activeflag=1
and racetypekey='UN';

update cjams.personracetypemap set activeflag=0, updatedby='CDM-30602', updatedon=now() where personid = '6d6d7197-8536-4f09-98d2-72bdc47031bf'
and activeflag=1
and racetypekey='UN';