/*
   Issue Description: CDM-43152
   Category/ Module  :  SDM, maltreatment allegation
   Root cause: user requested to update the Provider Involved Maltreatment from YES to "NO" in the SDM & Maltreatment Allegation screen.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
/*
select * from intakeservicerequestsdm where intakeserviceid = '0f3a3252-ecda-4f46-ab78-2a9a9b0ddf07' and activeflag = 1;
*/

update Intakeservicerequestsdm set updatedby='CDM-43152', updatedon=now(), ismaltreatment= false 
where  intakeserviceid = '0f3a3252-ecda-4f46-ab78-2a9a9b0ddf07' and activeflag=1;

/*
select * from intakesnapshot where intakenumber = 'I241013157912' and activeflag = 1;
*/
UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"no"' 
        )
    ),
    updatedby = 'CDM-43152',
    updatedon = now()            
WHERE intakenumber = 'I241013157912' 
  AND activeflag = 1;
 
/*
select jsondata,* from intakedastaging where intakenumber = 'I241013157912' and activeflag = 1;
*/
 
UPDATE intakedastaging
SET 
    jsondata = jsonb_set(
        jsondata, 
        '{sdm}', 
        jsonb_set(
            jsondata->'sdm', 
            '{maltreatment}', 
            '"no"' 
        )
    ),
    updatedby = 'CDM-43152',
    updatedon = now()            
WHERE intakenumber = 'I241013157912' 
  AND activeflag = 1;

