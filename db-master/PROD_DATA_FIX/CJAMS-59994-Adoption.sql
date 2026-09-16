/*
Issue Description: Need data fix to extend the adoption agreement end date to 02/06/2026.
Root cause:
We have implemented the user story "B-195079 - Maintenance Payments" to production. As per system design, the adoption agreement can not be updated/edited if the bio child placement exit date is overlapping with the adoption agreement start date.This is a migrated case from Chessie and In this case, the adoption agreement start date is entered prior to the bio placement exit date so Data fix is needed to extend the adoption agreement from backend.
Fix provided: Data fix has been promoted to extend the adoption agreement to 04/18/2028 (Child 21st birthday)
Data/Code fix ticket#: CJAMS-59301
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: There was no defect in the system logic or design. The restriction is intentional to maintain data integrity between placement and agreement timelines. Therefore, no code change was required.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update adoptioncaseagreement 
set enddate = '2027-12-01 00:00:00',
    agreementtyperefid = 'STAAA',
	childplacedby = 'iveag',
	updatedby = 'CJAMS-59994',
	updatedon = now()
where adoptionagreementid='15b09786-6f69-4130-acce-5abf30dfb0a5'
and activeflag = 1;

update adoptioncaseagreementrate
set updatedon = now(),
    updatedby = 'CJAMS-59994'
where adoptionagreementrateid = '17a613bb-02e8-4e4c-983b-db11a42087a9'
and activeflag = 1;    


update adoptioncase
set  enddate = '2027-12-01 00:00:00', updatedby = 'CJAMS-59994', updatedon = now()
where adoptioncaseid = '26c412a3-6db7-4493-ba44-a11d6a4a8956' and activeflag = 1 ;
