/*
Issue: CJAMS-64045 GAP Subsidy
Category/Module: Payment / GAP
Root cause: User updated daily rate instead the Monthly rate.
            Data fix needed to update the monthly rate as 
            Case Number : 241030356692
            CJAMS PID# : 203442946
            Please update the Monthly rate as $926.80 and also update the Rate Type as ' Monthly'
Fix provided: Data fix has been to done to update the Monthly rate as $926.80 and also update the Rate Type as ' Monthly' and trigger payment batch.
Data/Code fix ticket#:  CJAMS-64045
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is user error and data fix should correct it.
*/



update gapagreementrate
set paymentamout = '926.80',
    paymenttypekey = 'Monthly',
    updatedby='CJAMS-64045',
    updatedon = now()
where gapagreementrateid ='c120d47e-41c3-4c16-aee1-48a777c5ba07' and activeflag=1;

update gapratesrevision
set paymentamt = '926.80',
    updatedby='CJAMS-64045',
    updatedon = now(),
    approvaldate =now() -- To trigger payments batch
where gaprateid in ('c120d47e-41c3-4c16-aee1-48a777c5ba07') and activeflag=1;