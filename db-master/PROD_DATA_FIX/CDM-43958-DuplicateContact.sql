/*
Issue Description: The contact ids 14749113 and 14749112 are duplicates. Please remove one note as data fix
Category/Module: Bug
Root cause: Seems network error or glitch caused a duplicate copy of the same contact note to be saved
Fix provided: DB query to deactivate the duplicate contact note 
Data/Code fix ticket#: CDM-43958
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating progressnote
update progressnote
set activeflag = 0, updatedby = 'CDM-43958', updatedon = now()
where progressnoteid = '50bf8340-7eed-425d-8b67-f2a158de1c93' and activeflag = 1;

--Updating progressnotedetail
update progressnotedetail
set activeflag = 0, updatedby = 'CDM-43958', updatedon = now()
where progressnotedetailid = '21b0e420-2262-4b3d-8b66-237b2db8786d' and activeflag = 1;

--Updating contactparticipant
update contactparticipant
set activeflag = 0, updatedby = 'CDM-43958', updatedon = now()
where contactparticipantid = '040f8205-b08a-4085-aedf-e14a50eb6366'and activeflag = 1;