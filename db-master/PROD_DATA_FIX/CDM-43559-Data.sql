/*
  Issue Description:  CDM-43559
   Category/ Module  :  Case Timeline
   Root cause: User error to change the purpose. The intakesnapshot and intakedastaging were mismatched.
   So, updated accordingly
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

UPDATE intakedastaging 
SET
    jsondata = jsonb_set(
        jsonb_set(
            jsondata,
            '{General,PurposeName}',
            '"<p>Child Protective Services</p>"'::jsonb
        ),
        '{General,Purpose}',
        '"247a8b26-cdee-4ce8-b36e-b37e49fd0103~CW"'::jsonb
    ),
    updatedon = now(),
     updatedby = 'CDM-43359'
WHERE
    intakenumber = 'I251013200859'
    AND activeflag = 1;