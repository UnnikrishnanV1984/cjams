/*
Issue:
251023161190:Unable to complete parts of the 1080. The form is not allowing for drop downs and all fillable areas to be completed. 
Root Cause: Person in the case 251023161190 was there in 251022993683, 251022993683 was the dummy case which was created in error without the case action type or the program/sub-program type.
In 1080 A form we are checking for the subprogram or the person program areas where the validatation was missing for the null check 
leading to error in console and stoping further to reload the user/child information.
Fix Provided (Data Fix Only): datafix as well as codefix is provided so that system will handle the null check for those cases who is having missing subprogram type
so that there won't be any blocker for the user to create 1080 A form.
Removed the dummy case 251022993683 related personprogram area.
Data/Code fix ticket#: CDM-44587
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: N/A
Reason why no related code fix: Data-only issue; logic/code changes required.
Status of the code fix: Data fix completed as well as codefix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update personprogramarea 
set activeflag =0,
	updatedon = now(),
	updatedby = 'CIDM-10907'
where entityid = '251022993683'
	and activeflag =1;