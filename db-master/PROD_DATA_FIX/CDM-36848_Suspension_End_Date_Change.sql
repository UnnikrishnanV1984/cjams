/*
   Issue Description: CDM-36848
   Category/ Module  : Agreement Documents 
   adoptioncaseid: '420858f0-05a4-4861-99b8-4e13311e0fbb'
   Root cause: suspension end date was wrong
   Pull request# for code fix: NA
   Reason why no related code fix: Requested a data fix to resolve
*/

update adoptioncasesuspensionrevision 
set suspensionenddate ='2023-11-20 00:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-36848'
where adoptionsuspensionrevisionid = 'ac716bd1-b746-412a-b882-d73749745570';

update adoptioncasesuspension
set suspensionenddate ='2023-11-20 00:00:00', updatedon =now(), updatedby ='CDM-36848'
where adoptionsuspensionid ='90351fec-7745-430f-927b-9cb1aabe92d8';
