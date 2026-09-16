/*
   Issue Description: CDM-35247
   Category/ Module  Investigation findings
   Root cause: User wants to remove the investigation findings  
*/

update investigationmaltreatment 
SET activeflag = 0,
    updatedon = now(), 
    updatedby = 'CDM-35247'  
where maltreatmentid = 'aba18627-80b3-4904-8afb-2a67d8e57ecb';