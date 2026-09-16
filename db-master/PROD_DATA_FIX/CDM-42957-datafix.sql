/*
 Issue Description:  CDM-42957
 Category/ Module: Permanency Plan
 Root cause: Adoption planning has multiple agreementid which was leading to this error
 Pull request# for code fix: NA
 Reason why no related code fix: NA
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */

update adoptionagreement set activeflag = 0, updatedby ='CDM-42957', updatedon = now() 
where adoptionagreementid ='3f0c04e6-bdf0-496b-ad33-eab513f3f6f0' and activeflag = 1 ;
