/*
Issue Description: Please carry out data fix to update the Negotiated Amount (Permanency Plan -> Subsidy Rate) as $887 against Case ID: 2020023102462 Client ID: 4471489 (KA'LEA DALE)
Root cause: User requted to updated paymentamout in  Permanency Plan -> Subsidy Rate.
Fix provided: DB queries  update gapagreementrate tables
Data/Code fix ticket#: CJAMS-63084
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreementrate
set paymentamout = '887',updatedby='CJAMS-63084',updatedon = now()
where gapagreementrateid ='f13581ad-520a-478f-9b07-ad924d7ecd50' and activeflag=1;

update gapratesrevision
set paymentamt = '887',updatedby='CJAMS-63084',updatedon = now(),approvaldate =now()
where gapratesrevisionid in ('04a0d443-b8f0-4e76-a2a1-e646be85db31','ae6da8bc-d3d9-4c51-8c48-876dd7e2e6f9') and activeflag=1;
