/*
Issue Description: 3294115:Good afternoon, I am working to close out services for this family and accidentally closed out a Program Assignment with the wrong date and reason. Is this something that I could receive assistance with correcting? Thank you!!Correct End date: 11/10/2025 Correct Reason: 
Root cause: The program assignment was closed with an incorrect end date and reason due to user input error during service closure.
Fix provided: DB queries  update personprogramarea tables
Data/Code fix ticket#: CJAMS-63677
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update personprogramarea
set enddate ='2025-11-10 00:00:00', updatedby ='CJAMS-63677',updatedon=now(),endreasonkey='3379'
where personprogramid ='f1ae07de-0857-4163-b172-cdbbf491716b' and activeflag=1;
