/*
   Issue Description: CDM-34914
   Category/ Module  : Prod data fix to remove the duplicate adoption agreement ids
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


 
update adoptionagreement set activeflag = 0, updatedby ='CDM-34914', updatedon = now() 
where adoptionagreementid in ('c1f9cd7b-bc21-4cbb-bfd4-95f85b404b1a','f5bedc19-aca6-404d-8da2-b88f134a7d66') and activeflag = 1;


update adoptionagreementrevision set activeflag = 0, updatedby ='CDM-34914', updatedon = now() 
where adoptionagreementid in ('c1f9cd7b-bc21-4cbb-bfd4-95f85b404b1a','f5bedc19-aca6-404d-8da2-b88f134a7d66') and activeflag = 1;


update routing set activeflag = 0, updatedby ='CDM-34914', updatedon = now() 
where objectid in ('c1f9cd7b-bc21-4cbb-bfd4-95f85b404b1a','f5bedc19-aca6-404d-8da2-b88f134a7d66') and activeflag = 1;