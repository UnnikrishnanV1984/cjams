/*
Issue no : CDM-16275
Root cause : user asked to delete the particular child removal
Case number : 3284355
*/
update intakeservreqchildremoval 
set updatedby = 'CDM-16275', updatedon = now(), activeflag = 0
where intakeservreqchildremovalid = '4753e2df-4e9d-48ae-8a20-02c39c1895b9';
