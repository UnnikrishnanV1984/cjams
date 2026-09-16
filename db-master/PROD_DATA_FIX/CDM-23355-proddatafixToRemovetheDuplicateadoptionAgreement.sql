/*
   Issue Description: CDM-23355
   Category/ Module  : Prod data fix to remove duplicately created adoption agreement record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update adoptionagreement set activeflag = 0 , updatedby = 'CDM-23355', updatedon = now()
where adoptionagreementid = '9483b3f9-661c-4161-bf30-3f018e8438ae' and activeflag = 1;

update adoptionagreementrevision set activeflag = 0 , updatedby = 'CDM-23355', updatedon = now()
where adoptionagreementid = '9483b3f9-661c-4161-bf30-3f018e8438ae' and activeflag = 1;