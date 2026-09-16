 /*
  Issue Description:  CDM-30662 - Missing DOB
   Category/ Module  :  User asked to update the wrong bio info due to completed case
   Root cause:
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/


update cjams.person set lastname='Thorne', dob='08/17/1995',updatedby='CDM-30662',updatedon=now()
where cjamspid=200975820 and activeflag=1;
-- SELECT json_agg(a) from sp_get_person_mdm('49d3850f-5bc8-44de-a3fc-1902c0d1166c') a;