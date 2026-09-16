
/*
Issue Description: please proceed with the data fix to remove the alleged maltreator name "David Love" from the COMAR screen and Investigation Summary Report PDF.
Root cause: As per system design, there is no functionality to edit the COMAR entered description once it is saved. So this will need data fix to remove the alleged maltreator name from the entered COMAR findings and it will need SSA/Product Owner review and approval to proceed further.
Fix provided: DB queries  update investigationfinding tables
Data/Code fix ticket#: CJAMS-61038
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


 update investigationfinding
 set intentionalinjurydesc = 'Allegedly closed fist punched the minor child',omissiondesc ='step grandfather',updatedby ='CJAMS-61038',updatedon =now()
 where investigationfindingid ='baeb6e19-4bff-4a13-b01a-152787089644' and activeflag=1;