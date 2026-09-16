/*
   Issue Description: CDM-36900
   Category/ Module  : Agreement Documents 
   adoptioncaseid: 3272888 (8e58fbd6-a8e8-4713-a7b1-03befd04fc0c)
   Root cause: suspension end date was wrong
   Pull request# for code fix: NA
   Reason why no related code fix: Requested a data fix to resolve
*/

update adoptioncasesuspension
set suspensionenddate ='2023-12-12 00:00:00', updatedon =now(), updatedby ='CDM-36900'
where adoptionsuspensionid ='9d774f98-84cf-4f03-b4de-6bbe49a5f21b';

update adoptioncasesuspensionrevision 
set suspensionenddate ='2023-12-12 00:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-36900'
where adoptionsuspensionrevisionid = 'f6578dc7-1d89-49d0-9de4-da6ebcb0b316';