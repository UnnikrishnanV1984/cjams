/*
   Issue Description: CDM-29090
   Category/ Module  : Agreement Documents 
   Root cause: suspension end date was wrong
   Pull request# for code fix: 8457
   Reason why no related code fix: requested a data fix to resolve
*/
update adoptioncasesuspensionrevision 
set suspensionenddate ='2022-12-01 00:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-29909'
where adoptionsuspensionrevisionid = '9084d347-adc0-426a-8a6c-40bb4ee2bf9b';

update adoptioncasesuspension
set suspensionenddate ='2022-12-01 00:00:00', updatedon =now(), updatedby ='CDM-29909'
where adoptionsuspensionid ='84b397c4-cc6b-4511-9a20-f1de403e4e6c';