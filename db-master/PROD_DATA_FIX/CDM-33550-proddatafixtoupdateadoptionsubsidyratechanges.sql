
/*
   Issue Description: CDM-33550
   Category/ Module  : Prod data fix to remove adoption agreement
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2023-01-11 05:00:00.000
update adoptioncasesuspension set suspensionbegindate = '2022-10-01 05:00:00.000', updatedon = now(), updatedby = 'CDM-33550'
where adoptionsuspensionid  = 'd183ce98-afe3-4a89-837c-d75fab80e59b';


-- 2023-01-11 05:00:00.000
update adoptioncasesuspensionrevision set suspensionbegindate = '2022-10-01 05:00:00.000', updatedon = now(), updatedby = 'CDM-33550', approvaldate = now()
where adoptionsuspensionid  = 'd183ce98-afe3-4a89-837c-d75fab80e59b';


update adoptioncaseagreementrate set activeflag = 0 , updatedon = now(), updatedby = 'CDM-33550', approvaldate = now()
where adoptionagreementrateid = '9af05385-95ff-41d8-8041-3fdae7226b68';


update adoptionagreementraterevision set activeflag = 0 , updatedon = now(), updatedby = 'CDM-33550',approvaldate = now()
where adoptionagreementrateid = '9af05385-95ff-41d8-8041-3fdae7226b68';



-- 2022-12-31 10:00:00.000
update adoptioncaseagreementrate set enddate = '2022-09-30 10:00:00.000' , updatedon = now(), updatedby = 'CDM-33550',approvaldate = now()
where adoptionagreementrateid = '5af88d1d-b8fd-4dff-a6f2-25877b3e7c16';


-- 2022-12-31 10:00:00.000
update adoptionagreementraterevision set enddate = '2022-09-30 10:00:00.000' , updatedon = now(), updatedby = 'CDM-33550',approvaldate = now()
where adoptionagreementrateid = '5af88d1d-b8fd-4dff-a6f2-25877b3e7c16';