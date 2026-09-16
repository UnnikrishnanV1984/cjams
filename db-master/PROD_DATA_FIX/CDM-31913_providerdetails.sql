/*
   Issue Description: CDM-31913
   Category/ Module  : Provider Address default active switch
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE prov.tb_provider_addresses
SET adr_default_sw='Y', update_ts=now(), update_user_id='CDM-31913'
WHERE address_id=114972 and parent_key_id='5089290';
