/*

Issue Description: 261030685981:Duplicate contact entered by accident for 6/4/2026, please delete Contact ID: 16324046
Category/Module: Case Management
Root cause: 
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 

*/

update progressnote
set activeflag = 0,
	updatedby = 'CJAMS-68255',
	updatedon = now()
where progressnoteid = 'd2f1d076-70fb-48d6-8931-f068c5846d88'
	and activeflag = 1 ;



update progressnotedetail
set activeflag = 0,
	updatedby = 'CJAMS-68255',
	updatedon = now()
where progressnoteid = 'd2f1d076-70fb-48d6-8931-f068c5846d88'
	and activeflag = 1 ;



    update contactparticipant
set activeflag = 0,
	updatedby = 'CJAMS-68255',
	updatedon = now()
where progressnoteid = 'd2f1d076-70fb-48d6-8931-f068c5846d88'
	and activeflag = 1 ;


    
update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-68255',
	updatedon = now()
where progressnoteid = 'd2f1d076-70fb-48d6-8931-f068c5846d88'
	and activeflag = 1 ;