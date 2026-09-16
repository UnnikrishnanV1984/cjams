 /*
 Issue Description:CDM-17930
 Category/ Module:case missing
 Root cause: case reverted
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
 update intakeservicerequest set activeflag=1,updatedby='CDM-17930',updatedon=now() where servicerequestnumber='211020148833' and intakeserviceid='d7233f94-7744-402a-979b-de70b1427d52';