/*

Issue Description: Contact ID: 16317781 - Need to delete duplicate contact
Category/Module: Case Management
Root cause: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 

*/

update progressnote
set activeflag = 0,
	updatedby = 'CJAMS-68248',
	updatedon = now()
where progressnoteid = '2d59f81a-6357-4143-b620-66dc6e821982'
	and activeflag = 1 ;



update progressnotedetail
set activeflag = 0,
	updatedby = 'CJAMS-68248',
	updatedon = now()
where progressnoteid = '2d59f81a-6357-4143-b620-66dc6e821982'
	and activeflag = 1 ;



    update contactparticipant
set activeflag = 0,
	updatedby = 'CJAMS-68248',
	updatedon = now()
where progressnoteid = '2d59f81a-6357-4143-b620-66dc6e821982'
	and activeflag = 1 ;


    
update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-68248',
	updatedon = now()
where progressnoteid = '2d59f81a-6357-4143-b620-66dc6e821982'
	and activeflag = 1 ;