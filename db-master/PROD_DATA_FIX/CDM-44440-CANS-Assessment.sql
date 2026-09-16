/*
Issue Description:231030063598:Good afternoon,It appears that Karen Michelle Rushs relationship to the youth (Parent) is not populating under the Permanency Plan tab of the CANS assessment. 
Root cause: The update command used to change the caregiver’s relationship was missing the proper format required by the database. Because of this, the system couldn’t understand the value being passed and stopped the update.
Fix provided: DB query to udate assessment.
Data/Code fix ticket#:CJAMS-61614
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:Data  error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update assessment
 set submissiondata = jsonb_set(submissiondata::jsonb,'{permanencyPlanform,relationship}',to_jsonb('Biological Mother'::text),true),updatedby = 'CDM-44440', updatedon = now()
 where assessmentid = 'c4b7dafb-42e8-40d7-805c-2596b705e707' and activeflag=1;
