/*
   Issue Description: CDM-20327
   Category/ Module  : TY case plan is approved but is still showing in my Approval Inbox. Appears to be stuck.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update progressnote set activeflag = 0, updatedby = 'CDM-20123', updatedon = now where progressnoteid ='43e2bc55-8815-4ee3-bc1e-ac3b9b54cc78';

update progressnotedetail set activeflag = 0, updatedby = 'CDM-20123', updatedon = now where progressnoteid ='43e2bc55-8815-4ee3-bc1e-ac3b9b54cc78';