/*
   Issue Description: CDM-31938
   Category/ Module  :Contact 
   Root cause: user requested to delete the erronousely added contact
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

update ProgressNote set activeflag = 0, updatedon = now(),
updatedby = 'CDM-31938' where progressnoteid= 'e0359bd9-5909-44a8-badb-ad8d9304fcd3';

update progressnotedetail set activeflag = 0, updatedon = now(),
updatedby = 'CDM-31938' where progressnotedetailid= '59640346-0254-42fb-bb27-7c4ae903a757';

update contactparticipant set activeflag = 0, updatedon = now(),
updatedby = 'CDM-31938' where progressnoteid= 'e0359bd9-5909-44a8-badb-ad8d9304fcd3';


update progressnote_audit_detail set activeflag = 0, updatedon = now(),
updatedby = 'CDM-31938' where auditdetailid = 'b03275c6-3de6-43d2-9cbe-4b416705dada';