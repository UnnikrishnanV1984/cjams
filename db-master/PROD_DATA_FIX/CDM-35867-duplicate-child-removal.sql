
-- CDM-35867 - Removal of duplicated child removal
/*
-- Issue Description: 
   Case # 221030014829 having duplicate Removals


-- Category/ Module: Child Removals (Case Management) 
-- Root cause: TBD
-- Resolution: data fix for duplicate child removal.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

update intakeservreqchildremoval 
set activeflag = 0, updatedby = 'CDM-35867', updatedon = now()
where intakeservreqchildremovalid = '16188164-dcda-4535-bc42-ff64c4801274';

update routing
set activeflag = 0, updatedby = 'CDM-35867', updatedon = now()
where objectid = '16188164-dcda-4535-bc42-ff64c4801274' and routingid = '5c6d192c-6934-4038-b3d2-1d1bb1323548' and activeflag = 1;

select * from intakeservreqchildremoval_history
where intakeservreqchildremovalid = '16188164-dcda-4535-bc42-ff64c4801274'
and activeflag = 1;

update intakeservreqchildremoval_history
set activeflag = 0, updatedby = 'CDM-35867', updatedon = now()
where intakeservreqchildremovalid = '16188164-dcda-4535-bc42-ff64c4801274'
and activeflag = 1;