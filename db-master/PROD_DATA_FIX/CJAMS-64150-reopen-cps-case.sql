/*
Issue Description: 
Root cause: Case assignment was deactivated for changes related to CIDM-9543 and the pending case closure record is also deactivated
Fix provided: Data fix remove the case assignment
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Code fix ticket#: N/A
Reason why no related code fix: User Error.
*/



update caseassignment set activeflag = 0, updatedby = 'CJAMS-64150', updatedon = now() 
where caseassignmentid = 'd59497c2-8f9a-4b8b-b9f9-b69e275ebd56' and activeflag = 1;

update caseassignment set enddate = null, updatedby = 'CJAMS-64150', updatedon = now()
where caseassignmentid in ('559c4c21-1318-48ab-b490-1715fa68ccf5', '881b06ce-e664-4fd7-bb5a-fa58fd6487fd');

update routing set activeflag = 1, updatedby = 'CJAMS-64150', updatedon = now()
where routingid = 'fe1bf051-0d2e-4669-8531-31706066a8b3' and objectid = '62ae5413-38a3-4d45-b362-8ef1a6dd1c36';

-- 2025-12-15 16:25:33.592	0bdda2ab-b74f-4d74-ba17-3b9b37a9ca19
update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
updatedon= now(), updatedby='CJAMS-64150'
where intakeserviceid = '7d8e9981-ccfc-433b-bdc0-eb713b04c44a';
