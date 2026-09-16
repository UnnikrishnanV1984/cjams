/*
- Category/ Module: Adoption case suspension (CDM-29903)
-- Root cause: Data fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update adoptioncasesuspensionrevision 
set approvaldate =now(), updatedon =now(), updatedby ='CDM-29903'
where adoptionsuspensionrevisionid in ('2452d3fc-2e5c-4e26-9b41-678e528efa37')
and adoptionsuspensionid = 'e1d2b922-1336-4772-aef2-eb943fef525a';

update adoptioncasesuspension
set activeflag = 0, updatedon =now(), updatedby ='CDM-29903'
where adoptionsuspensionid ='011a7f5b-8937-4c9b-b553-6e72b2558736';

update adoptioncasesuspensionrevision
set activeflag = 0, updatedon =now(), updatedby ='CDM-29903'
where adoptionsuspensionid ='011a7f5b-8937-4c9b-b553-6e72b2558736';

update routing
set activeflag = 0, updatedon =now(), updatedby ='CDM-29903'
where objectid ='011a7f5b-8937-4c9b-b553-6e72b2558736';