
/*
Issue Description: delete the contact (Contact ID: 14846837) from the CPS IR # 251022976741
Category/Module: Support
Root cause: user could not abe to delete contact
Fix provided: DB queries delete record in progressnote
Data/Code fix ticket#: CJAMS-58080
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/


update progressnote
set activeflag = 0, updatedby = 'CJAMS-58080', updatedon = now()
where progressnoteid = '56e6a370-d449-4346-9836-89d4451ab664' and activeflag = 1;

update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-58080', updatedon = now()
where progressnotedetailid  = '35eeea3d-0994-4df6-a1d3-a243d6a9e7cd' and activeflag = 1;

update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-58080', updatedon = now()
where contactparticipantid  in ('baed77ff-6edd-476b-b31c-4aa8015bf038', 'ad222549-799e-4563-9d55-55b4efed483e') and activeflag = 1;