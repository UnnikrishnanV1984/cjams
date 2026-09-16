/*
Issue Description: Need to extend the agreement date to the 2028 year but an error is occurring that the rate start date can not be prior to the agreement starts date. I can not go back to change this information - the rate start date is 7/23/2018 and the agreement start date is 7/24/2018. I need to extend the agreement as soon as possible so the subsidy does not lapse in June.
Root cause:The current Subsidy start date was 07/23/2018, but in order to allow the user to extend the GAP agreement End Date, it needed to begin on or after 07/24/2018. This was causing a validation or system logic error.
We have implemented the user story "B-195079 - Maintenance Payments" to production. As per system design, the adoption agreement can not be updated/edited if the bio child placement exit date is overlapping with the adoption agreement start date.This is a migrated case from Chessie and In this case, the adoption agreement start date is entered prior to the bio placement exit date so Data fix is needed to extend the adoption agreement from backend.
Fix provided: Data fix has been promoted to extend the adoption agreement to 04/18/2028 (Child 21st birthday)
Data/Code fix ticket#: CJAMS-59967
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
why no code fix?:business logic was already correct, only the data was invalid.H
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate
set startdate = '2018-07-24 00:00:00',updatedby = 'CJAMS-59967', updatedon = now()
where gapagreementrateid = 'cde455d4-9a56-4241-a700-9bcd500867ee' and activeflag =1;


update gapratesrevision
set ratestartdate = '2018-07-24 00:00:00',updatedby = 'CJAMS-59967', updatedon = now()
where gapratesrevisionid = 'f7c7b68e-5add-47b7-b805-71593d5eedb9' and activeflag =1;
