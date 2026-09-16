/*

Issue Description: Contact ID: 16317870 - contact note to be deleted
Category/Module: Case Management
Root cause: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 

*/

update progressnote
set activeflag = 0,
	updatedby = 'CJAMS-68249',
	updatedon = now()
where progressnoteid = 'cb2bb794-e6e7-44e7-826b-e2075b2595d6'
	and activeflag = 1 ;



update progressnotedetail
set activeflag = 0,
	updatedby = 'CJAMS-68249',
	updatedon = now()
where progressnoteid = 'cb2bb794-e6e7-44e7-826b-e2075b2595d6'
	and activeflag = 1 ;



    update contactparticipant
set activeflag = 0,
	updatedby = 'CJAMS-68249',
	updatedon = now()
where progressnoteid = 'cb2bb794-e6e7-44e7-826b-e2075b2595d6'
	and activeflag = 1 ;


    
update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-68249',
	updatedon = now()
where progressnoteid = 'cb2bb794-e6e7-44e7-826b-e2075b2595d6'
	and activeflag = 1 ;