/*
-- Issue Description:
-- Category/ Module: Investigation Finding   
-- Root cause:  User request to Remove duplicated system error Investigation findings
--Fix provided: data fix has been done to remove the additional investigation findings
--Is code fix required: Yes CIDM-11232
-- Pull request :
-- Reason why no related code fix: code fix ticket has been raised 
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update investigationallegation set activeflag =0, updatedby ='CJAMS-67747', updatedon =now() 
where investigationallegationid in ('7931fb49-d15d-48eb-9810-f7cd77543267','dec2a0a5-6c81-468c-8b8d-445e4523fce7','6e83f10a-6ad5-45a5-91e3-e7901c659dce','c1d5e9d2-a607-445e-95e1-9a113a6d9ae0',
'f2817c36-0f8a-4ec1-8fde-1c021f45761f','8b220215-02d4-4e48-a3ee-b00dcf2cb067','1868f5fc-e770-4cc1-abf7-b460d2f976ea','d3e61220-88c5-4b57-96a0-53f85c4d492b','b2ea33e8-2f7a-43ef-b807-fca0665ec183','b17dd43c-42fc-4a1d-b665-4bd91746546e') and activeflag =1;