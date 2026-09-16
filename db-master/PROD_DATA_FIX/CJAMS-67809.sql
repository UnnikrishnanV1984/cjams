
/*
Issue Description: CJAMS-67809 -Wrong info entered in note in error
Category/Module: Case Management
Root cause: 3188966:I entered wrong client information in this case note. This note was intended for a different case head. Information in the note is sensitive and must be removed and corrected in CJAMS.
Fix provided: Data fix has been promoted to remove the Contact ID# 16219947 from Case# 3188966 from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update progressnote
set activeflag = 0, updatedby = 'CJAMS-67809', updatedon = now()
where progressnoteid = 'f5938857-0e1e-4391-83a2-a6dfe6ded033' and activeflag =1;


update progressnotedetail
set activeflag = 0, updatedby = 'CJAMS-67809', updatedon = now()
where progressnoteid = 'f5938857-0e1e-4391-83a2-a6dfe6ded033' and activeflag =1;

update contactparticipant
set activeflag = 0, updatedby = 'CJAMS-67809', updatedon = now()
where progressnoteid = 'f5938857-0e1e-4391-83a2-a6dfe6ded033' and activeflag =1;
