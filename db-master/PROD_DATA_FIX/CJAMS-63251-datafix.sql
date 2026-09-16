/*
   Issue Description: CJAMS-63251
   Category/ Module  : Contact Notes
   Root cause: User requested to remove the incorrect contact from the CPS AR case.
       CPS AR# 251023151298
       Contact ID: 15426644
   Fix provided: Data fix has been done to remove the incorrect contact from the CPS AR case.
       CPS AR# 251023151298
       Contact ID: 15426644
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CJAMS-63251' , updatedon = now()
WHERE progressnoteid = 'db6f4e63-0d45-4f50-a8b1-656fd1ef0fc7' and activeflag=1;

update progressnotedetail set activeflag = 0, updatedby = 'CJAMS-63251' , updatedon = now()
WHERE progressnoteid ='db6f4e63-0d45-4f50-a8b1-656fd1ef0fc7' and activeflag=1;

update contactparticipant
SET activeflag = 0, updatedby = 'CJAMS-63251' , updatedon = now()
WHERE progressnoteid = 'db6f4e63-0d45-4f50-a8b1-656fd1ef0fc7' and activeflag = 1;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-63251',
	updatedon = now()
where progressnoteid = 'db6f4e63-0d45-4f50-a8b1-656fd1ef0fc7'
	and activeflag = 1 ;
	