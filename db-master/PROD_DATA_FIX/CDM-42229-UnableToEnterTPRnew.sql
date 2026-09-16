/*
Issue Description: TPR Reversal unable to be entered in CJAMS court tab.
Category/Module: Bug
Root cause: new prod data requires new data fix.
Fix provided: DB query to update necessary detail
Data/Code fix ticket#: CDM-42229
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--updateing Tprdetails
update tprdetails 
set updatedby = 'CDM-42229', updatedon = now(), isappealed = 1
where tprdetailsid = '28a7aaa3-bea6-4e06-915e-7601d2b18b48' and activeflag = 1;