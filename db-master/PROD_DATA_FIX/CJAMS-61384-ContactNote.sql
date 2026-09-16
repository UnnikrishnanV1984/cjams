/*
Issue Description:251023105770:The addendum to contact note 15236104 was incorrectly copy and pasted into the wrong contact note. Could this addendum be deleted please? The addendum contact note was entered into the appropriate contact note of 15238290 (twice). The addendum contact completed by Missy Orr with #15236104 dated 8/12/2025 and time of: 8:49am to 8:50pm needs to be removed
Root cause: User request to delete the incomplete contact note, They can only able to update 
Fix provided: DB queries to update query to progressnote table
Data/Code fix ticket#: CJAMS-61384
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-61384', updatedon = now()
where progressnotedetailid = '20f35b1d-b35b-4c9f-b734-38ed59622973' and activeflag =1;