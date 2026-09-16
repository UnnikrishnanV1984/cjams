/*
Issue:Hospitalization needs to be deleted but there is no option to do so.
      Case ID: 3206714
      Client ID: 201171080 (Mia Faye Davis)
Root Cause:This is an old record that was inserted before the hospitalization story was implemented and these fields were not mandatory during that time.
            Data fix is needed to delete those incomplete records. Users requested to Remove the Hospitalization record which was created in an error.             
Fix Provided: DB queries to Remove the blank Hospitalization record
Data/Code fix ticket#:CJAMS-63689
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is an old record that was inserted before the hospitalization story was implemented and these fields were not mandatory during that time.
Data fix is enough to delete them.
*/
update personhospitalization
set activeflag = 0, updatedby = 'CJAMS-63689', updatedon = now()
where hospitalizationid = '80693590-4c76-4eb0-ac69-9555e80e0b6a';
