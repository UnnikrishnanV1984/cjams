/*
Issue: CJAMS-63450 personal phone number appearing on voucher
Category/Module: User phone number
Root cause: User phone number is update in sailpoint but not reflecting in cjams DB.
Fix provided:  Data fix has been done to correct the user phone number in CJAMS DB.
               Worker email :  lindsey.diehl@maryland.gov
               phone number : 240-727-8425
Data/Code fix ticket#: CJAMS-63450
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: It's a Known Sailpoint Integration issue
*/


update userprofilephonenumber
set updatedby='CJAMS-63450', updatedon=now(),phonenumber='240-727-8425'
where securityusersid='f4d47211-6cba-4e68-8150-1ed0428037c8' and activeflag=1;

update tb_slpa_snapshot
set worker_phone = '240-727-8425',
    update_ts = now(),
    update_user_id = 'CJAMS-63450'
where worker_name = 'Lindsey Diehl'
and delete_sw = 'N';

update tb_slpa_snapshot
set requestor_phone = '240-727-8425',
    update_ts = now(),
    update_user_id = 'CJAMS-63450'
where requestor_name = 'Lindsey Diehl'
and delete_sw = 'N';