/*
Issue Description: Please proceed with the data fix to updated the contact location as below:
Contact ID: 14552016
Contact Location : Child Residence
Category/Module: Error
Root cause: User incorrectly entered wrong location in contact note
Fix provided: DB query to rectify the location name in contact note
Data/Code fix ticket#: CDM-42513
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating progressnote
update progressnote
set progressnotesubtypeid = '3fde914b-1a85-44c7-b4eb-a0c0783bef55', updatedby = 'CDM-42513', updatedon = now()
where progressnoteid = '815db7f6-d827-418e-8399-e0e8c0a8c020' and activeflag = 1;