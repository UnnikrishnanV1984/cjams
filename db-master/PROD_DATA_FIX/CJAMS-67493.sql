/*
   Issue Description: CJAMS-67493
   Category/ Module  :Type of contact note change
   Root cause: re-enter contact note change type from Community to Face to Face
   Fix provided: Data fix has been done to modify the type from community to Face to Face
   Is code fix required: N
   Pull request# for code fix: na
   Reason why no related code fix: User error 
   Status of the code fix if already submitted and expected prod fix date: 
*/





update progressnote
set progressnotetypeid = '786495b2-c779-4cc4-b812-6a8439bfa96e', -- Face To Face
	updatedby = 'CJAMS-67493',
	updatedon = now()
where witsid = 16138270
	and activeflag = 1 ;