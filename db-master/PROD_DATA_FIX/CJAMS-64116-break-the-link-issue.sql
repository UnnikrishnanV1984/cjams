/*
Issue: CJAMS-64116 TPR break the link issue
Category/Module: Permanency Plan
Root cause: Unable to proceed with adoption planning in TPR flow to complete break the link as we can see that appealdecision is missin in the tprdetails table.
            We tried to replicate this issue in stage-3 but it is not replicable.
Fix provided: Data fix has been done to update the decision key in adoption tprdetails table. 
Data/Code fix ticket#: CJAMS-64116
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We will closely monitor this issue and check if this happens again.
*/

update tprdetails
set appealdecisiontypekey = 'APOR',
    updatedon = now(),
    updatedby = 'CJAMS-64116'
where tprdetailsid = '28c48404-b1a3-401b-9164-be2659bf27f4'
and activeflag =1;   