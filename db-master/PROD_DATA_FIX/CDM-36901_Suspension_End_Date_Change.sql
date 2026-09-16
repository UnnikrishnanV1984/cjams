/*
   Issue Description: CDM-36901
   Category/ Module  : Agreement Documents 
   adoptioncaseid: 3272890 (5e543494-a0c0-4f83-842a-0bb3db7512a9)
   Root cause: suspension end date was wrong
   Pull request# for code fix: NA
   Reason why no related code fix: Requested a data fix to resolve
*/

update adoptioncasesuspension
set suspensionenddate ='2023-12-12 00:00:00', updatedon =now(), updatedby ='CDM-36901'
where adoptionsuspensionid ='2c2c92b8-c711-4641-8db6-da27dba2c08b';

update adoptioncasesuspensionrevision 
set suspensionenddate ='2023-12-12 00:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-36901'
where adoptionsuspensionrevisionid = '420d78d7-9661-4889-852d-22ea1b283d66';