
/*
Issue Description: 3268139:Beth Davis is receiving work related calls on her personal phone 240-727-5453 because her personal number is listed on CJAMS vouchers. Please correct her phone number to use her work number 240-727-6631. 
Root cause: Sailpoint update is completed, work phone number is set as 240-727-6631. Need datafix to update worker's phonenumber in cjams db as well
Fix provided: datafix to update worker's phonenumber in cjams db as well
Data/Code fix ticket#: CJAMS-68117
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update userprofilephonenumber
set updatedby='CJAMS-68117', updatedon=now(),phonenumber='240-727-6631'
where securityusersid='20f36ffc-7242-4658-b708-292af69bf357' and activeflag=1;

update tb_slpa_snapshot
set worker_phone = '240-727-6631',
    update_ts = now(),
    update_user_id = 'CJAMS-68117'
where worker_name = 'Beth Davis'
and delete_sw = 'N' and worker_phone not in ('2407276631', '240-727-6631');

update tb_slpa_snapshot
set requestor_phone = '240-727-6631',
    update_ts = now(),
    update_user_id = 'CJAMS-68117'
where requestor_name = 'Beth Davis'
and delete_sw = 'N' and worker_phone not in ('2407276631', '240-727-6631');