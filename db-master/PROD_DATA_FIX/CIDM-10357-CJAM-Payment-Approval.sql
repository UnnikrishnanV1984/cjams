/*
 Issue Description:
 Colleen Corrigan role as financial supervisor wasn't populating in the financial approval supervisor name.
 Category/ Module: Placement
 Root cause: 	User Error, Hospital discharge date and placement exit date should be 3/6/25.
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
--select teamtypekey ,* from userprofile u where securityusersid  = '94904d66-78cd-4c6b-9794-f18531eb4bc1'
update userprofile 
set teamtypekey = 'FNS',
	updatedby = 'CIDM-1035',
	updatedon = now()
where securityusersid = '94904d66-78cd-4c6b-9794-f18531eb4bc1' 
and activeflag =1;