/*
Issue Description: Please carry out data fix to update the Negotiated Amount (Permanency Plan -> Subsidy Rate) as $887 against Case ID: 2020023102462 Client ID: 4471489 (KA'LEA DALE)
Root cause: User entered the subsidy rate amount incorrectly and requested to update the rate amount from $30.47 to $929.00.
Fix provided: Data fix has been done to correct the susidy amount for the case
             Case ID: 241030437251
             Client ID: 202876790 (Tiara Newton)
             Provider ID: 6113949 (THERESA D CHASE- Gantt)
Data/Code fix ticket#: CJAMS-63862
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
*/

update gapagreementrate
set paymentamout = '929',
    updatedby='CJAMS-63862',
    updatedon = now()
where gapagreementrateid ='0706672c-ce4d-488a-9946-56ff6e0ba78f' and activeflag=1;

update gapratesrevision
set paymentamt = '929',
    updatedby='CJAMS-63084',
    updatedon = now(),
    approvaldate =now() -- To trigger payments batch
where gaprateid in ('0706672c-ce4d-488a-9946-56ff6e0ba78f') and activeflag=1;