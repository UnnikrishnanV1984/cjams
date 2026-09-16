/*
Issue Description: Please remove the highlighted removal & living arrangement record below.
Category/Module: Error
Root cause: Removal and Placement were approved and completed before authoriztion was withdrawn
Fix provided: DB queries to deactivate child removal and placement
Data/Code fix ticket#: CDM-41409
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

------------Deactivating approved child Removal------------
--Deactivating in intakeservreqchildremoval
update intakeservreqchildremoval
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where intakeservreqchildremovalid = 'fef31d72-624a-4f21-bb80-1026f848c765' and activeflag = 1;

--Deactivating in intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where intakeservreqchildremovalid = 'fef31d72-624a-4f21-bb80-1026f848c765' and activeflag = 1;

--Deactivating approval in routing
update routing
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where objectid = 'fef31d72-624a-4f21-bb80-1026f848c765' and activeflag = 1;

------------Deactivating approved child Placement------------
--Deactivating in placement
update placement
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where placementid = '9387aae3-59ea-4ec6-913e-76df4d22f156' and activeflag = 1;

--Deactivating in placementrevision
update placementrevision
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where placementid = '9387aae3-59ea-4ec6-913e-76df4d22f156' and activeflag = 1;

--Deactivating in livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where placementid = '9387aae3-59ea-4ec6-913e-76df4d22f156' and activeflag = 1;

--Deactivating in routing
update routing
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where objectid = '9387aae3-59ea-4ec6-913e-76df4d22f156' and activeflag = 1;

----------------Deactivating OOH program assignment-------------------
--Deactivating in personprogramarea
update personprogramarea 
set activeflag = 0, updatedby = 'CDM-41409', updatedon = now()
where personprogramid = '01c3b7e5-851e-4d49-a749-ece8bdbd61c8' and activeflag = 1;