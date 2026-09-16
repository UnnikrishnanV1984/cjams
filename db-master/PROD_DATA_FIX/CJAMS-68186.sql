/*
Issue: CJAMS-68186 break the link issue
Category/Module: Permanency Plan
Root cause: Unable to proceed with adoption planning in TPR flow to complete break the link as we can see that appealdecision is missing in the tprdetails table.
Fix provided: Data fix has been done to update the decision key in adoption tprdetails table. 
Data/Code fix ticket#: CJAMS-68186
Regression Impacts: N/A
Is Code fix Required?: Y
Code fix ticket#: CIDM-11169
Reason why no related code fix: 
*/

update tprdetails
set appealdecisiontypekey = 'APOR',
    updatedon = now(),
    updatedby = 'CJAMS-68186'
where tprdetailsid = '01559c9d-79a5-4f5b-963d-6fd459503902'
and activeflag =1;  