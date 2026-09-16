/*
Issue Description: CJAMS-62057 contact note(211030011682)
Category/Module: Contact note
Root cause: 211030011682 User requested to do data fix to change the contact note(211030011682) status from 
Completed to Attempted
Fix provided: Data fix has been promoted to change the contact note(211030011682) status from Completed to Attempted
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: Data fix needed to correct the user entry error
*/

update
    progressnote
set
    contactstatus = 'false',
    updatedby = 'CJAMS-62057',
    updatedon = now()
where
       progressnoteid = '06f98fcb-0191-4af3-90a5-c6df923b67e6'
   and servicecaseid = '4ce92a1e-6f87-47a3-8218-829eb190678f'
   and activeflag = 1;