

/*
Issue: CJAMS-68470 Remove Participant from Contact Note
Category/Module: screen out referral
Root cause: Need data fix to remove Jessica Orth from the participants in contact note Contact ID: 16350609 dated 06/08/2026.
Fix provided:  Data fix is done to  remove Jessica Orth from the participants in contact note Contact ID: 16350609 dated 06/08/2026.
Data/Code fix ticket#: CJAMS-68470
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data fix
*/
update contactparticipant
set activeflag = 0, updatedby='CJAMS-68470', updatedon=now()
where contactparticipantid= 'a37ae32b-5922-4763-a610-e7b46c48d7eb' and activeflag=1;