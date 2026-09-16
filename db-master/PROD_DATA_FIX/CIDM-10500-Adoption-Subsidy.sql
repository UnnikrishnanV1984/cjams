
/*
Issue Description: Need data fix to extend the adoption agreement end date to 02/06/2026.
Root cause: The system failed to recognize the newly entered end date for the switched adopted parent, preventing the adoption agreement from being submitted for supervisor approval.
Fix provided: Data fix has been done to update the data in adoption subsidy agreement table as requested by the user.
Data/Code fix ticket#: CIDM-10500
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update adoptioncaseagreement 
set enddate = '2026-02-06 00:00:00',
	updatedby = 'CIDM-10500',
	updatedon = now()
where adoptionagreementid='4e343f13-0178-4e86-b577-105c7099e221'
and activeflag = 1;


