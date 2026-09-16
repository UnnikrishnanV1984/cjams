/*
Issue Description: CJAMS-63624 AR FOR GAP PROVIDER NEEDS CORRECTION
Category/Module: GAP Subsidy
Root cause:  The Provider Overpayment was identified on 12/07/2021 and created an AR (Account Receivable) as the subsidy rate start date was changed from 10/23/2021 to 12/01/2021 on 12/07/2021 01:11 PM. So CJAMS created an AR for month of October & November 2021.
              
Fix provided: Data fix has been done to correct the subsidy date to 08/01/2025 and trigger the payments batch.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix to correct it.
*/

update gapagreementrate
set enddate = '2021-11-30 08:00:00',
    updatedby = 'CJAMS-63624',
    updatedon = now()
where gapagreementrateid = 'bd09c420-73d0-4f93-b834-6c2162f45cf4'
and activeflag=1;

update gapratesrevision
set rateenddate = '2021-11-30 08:00:00',
    updatedon = now(),
    updatedby = 'CJAMS-63624'
where gaprateid in ('bd09c420-73d0-4f93-b834-6c2162f45cf4')
and activeflag = 1;

update gapratesrevision
set approvaldate = now(), /*Triggering the payment batch*/
    updatedon = now(),
    updatedby = 'CJAMS-63624'
where gaprateid in ('bd09c420-73d0-4f93-b834-6c2162f45cf4','65235226-69e9-42bc-be16-c8e998401f2b','4a582a45-5c60-4eab-8ef6-630497c3eb23','75a7804e-5c09-40bc-96d8-d6aa528b6f23','e20f8980-e832-45d2-af6d-c931babc4467','967fd0db-0383-4fd8-bf13-468ded9733bd')
and activeflag = 1;

update gapagreementrate
set updatedby = 'CJAMS-63624',
updatedon = now()
where gapagreementrateid in ('bd09c420-73d0-4f93-b834-6c2162f45cf4','65235226-69e9-42bc-be16-c8e998401f2b','4a582a45-5c60-4eab-8ef6-630497c3eb23','75a7804e-5c09-40bc-96d8-d6aa528b6f23','e20f8980-e832-45d2-af6d-c931babc4467','967fd0db-0383-4fd8-bf13-468ded9733bd')
and activeflag = 1;