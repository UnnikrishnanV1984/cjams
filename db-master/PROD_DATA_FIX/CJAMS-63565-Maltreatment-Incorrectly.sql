/*
Issue Description: 
Dashboard:This case is ready for closure; however, screening had clicked on "provider maltreatment", which this child is not committed to DSS, but DJS. Can you please change the provider maltreatment button to "no".
Root cause: user requested to update the Provider Involved Maltreatment from YES to "NO" in the SDM & Maltreatment Allegation screen.
Fix provided: DB queries  update Intakeservicerequestsdm,intakesnapshot,intakedastaging, tables
Data/Code fix ticket#: CJAMS-63565
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


/*
select * from intakeservicerequestsdm where intakeserviceid = 'b5b149f4-1016-4cf5-82e7-2f09ae7c20a4' and activeflag = 1;
*/

update Intakeservicerequestsdm set updatedby='CJAMS-63565', updatedon=now(), ismaltreatment= false 
where  intakeserviceid = 'b5b149f4-1016-4cf5-82e7-2f09ae7c20a4' and activeflag=1;

/*
select * from intakesnapshot where intakenumber = 'I251013363317' and activeflag = 1;
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
    updatedby = 'CJAMS-63565',
    updatedon = now()            
WHERE intakenumber = 'I251013363317' 
  AND activeflag = 1;
 
/*
select jsondata,* from intakedastaging where intakenumber = 'I251013363317' and activeflag = 1;
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
    updatedby = 'CJAMS-63565',
    updatedon = now()            
WHERE intakenumber = 'I251013363317' 
  AND activeflag = 1;

