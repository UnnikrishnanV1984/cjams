/*
- Category/ Module: Adoption case suspension (CDM-29879)
-- Root cause: Data fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update adoptioncasesuspensionrevision 
set suspensionenddate ='2022-09-21 04:00:00', approvaldate =now(), updatedon =now(), updatedby ='CDM-29879'
where adoptionsuspensionrevisionid in ('94ac822e-75ea-4d85-ba71-34c6fd57412e');

update adoptioncasesuspension
set suspensionenddate ='2022-09-21 04:00:00', updatedon =now(), updatedby ='CDM-29879'
where adoptionsuspensionid ='cef681ad-5535-449d-950f-56b671545383';

update adoptioncasesuspensionrevision 
set activeflag = 0, updatedon =now(), updatedby ='CDM-29879'
where adoptionsuspensionid ='42553be8-2976-418c-be60-55f2f8dfb919';

update adoptioncasesuspension
set activeflag = 0, updatedon =now(), updatedby ='CDM-29879'
where adoptionsuspensionid ='42553be8-2976-418c-be60-55f2f8dfb919';

update routing 
set activeflag = 0, updatedon =now(), updatedby ='CDM-29879'
where objectid = '42553be8-2976-418c-be60-55f2f8dfb919';

