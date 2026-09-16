/*
Issue Description: Please remove the highlighted living arrangement record
Category/Module: Bug
Root cause: Living arrangement with the duplicate end date needed to be removed
Fix provided: Db query to remove the living arrangement
Code/Data fix ticket#: CDM-40659
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requests for AFCARS data cleanup 
Backup before update/ delete:Query:
*/

--Deactivating the record from placement
update placement 
set activeflag = 0, updatedby = 'CDM-40659', updatedon = now()
where placementid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3' and activeflag = 1;

--Deactivating the record from placementrevision
update placementrevision 
set activeflag = 0, updatedby = 'CDM-40659', updatedon = now()
where placementid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3' and activeflag = 1;

--Deactivating the record from livingarrangement
update livingarrangement
set activeflag = 0, updatedby = 'CDM-40659', updatedon = now()
where placementid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3' and activeflag = 1;

--Deactivating the record from routing
update routing 
set activeflag = 0, updatedby = 'CDM-40659', updatedon = now()
where objectid = '6fa4cb4e-8732-4521-9ecb-3b8c95f69ab3' and activeflag = 1;