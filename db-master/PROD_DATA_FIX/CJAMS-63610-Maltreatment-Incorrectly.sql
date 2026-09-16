/*
Issue Description: 251023131672:Referral incorrectly reflects maltreatment as being provider-involved maltreatment; however, the child doesn't have an active removal, and the maltreatment didn't occur in a school or daycare. The Assessment worker is closing the case (due to close by 11/22) and is unable to log maltreatment information because CJAMS is requiring that a Provider be entered. Investigation #: 251023131672
Root cause: user requested to update the Provider Involved Maltreatment from YES to "NO" in the SDM & Maltreatment Allegation screen.
Fix provided: DB queries  update Intakeservicerequestsdm,intakesnapshot,intakedastaging, tables
Data/Code fix ticket#: CJAMS-63610
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


/*
select * from intakeservicerequestsdm where intakeserviceid = ''bf0381ce-68e1-47bb-ad49-74dd219d2064' and activeflag = 1;
*/

update Intakeservicerequestsdm set updatedby='CJAMS-63610', updatedon=now(), ismaltreatment= false 
where  intakeserviceid = 'bf0381ce-68e1-47bb-ad49-74dd219d2064' and activeflag=1;

/*
select * from intakesnapshot where intakenumber = 'I251013363825' and activeflag = 1;
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
    updatedby = 'CJAMS-63610',
    updatedon = now()            
WHERE intakenumber = 'I251013363825' 
  AND activeflag = 1;
 
/*
select jsondata,* from intakedastaging where intakenumber = 'I251013363825' and activeflag = 1;
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
    updatedby = 'CJAMS-63610',
    updatedon = now()            
WHERE intakenumber = 'I251013363825' 
  AND activeflag = 1;

