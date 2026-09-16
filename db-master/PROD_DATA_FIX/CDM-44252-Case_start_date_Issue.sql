/*
   Issue Description: CJAMS-44252
   Category/ Module  : Service Case
   Root cause: User requested to change case start date to assignment start date 
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

update servicecase set insertedon='2025-01-28 14:44:00', updatedon =now(), updatedby = 'CDM-44252'
where servicecasenumber ='251030464853';

update servicecase set startdate='2025-01-28 14:44:00', updatedon =now(), updatedby = 'CDM-44252'
where servicecasenumber ='251030464853';

update servicecasedisposition set statusdate='2025-01-28 14:44:00', updatedon =now(), updatedby = 'CDM-44252'
where servicecaseid = 'eb2b6c37-2d58-4712-bcbc-1bf4556c64e4';