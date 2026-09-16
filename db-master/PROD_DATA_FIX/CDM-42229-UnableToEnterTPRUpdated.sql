/*
Issue Description: Dev Team - For Mother Kristy for all kids at permancy tab ---> Termination appeal and court tab, Termination appealed should be selected
Category/Module: Bug
Root cause: Issues with prod and previous datafix
Fix provided: DB queries to rectify issues with previous datafix
Data/Code fix ticket#: CDM-42229
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating tprdetails
update tprdetails
set isappealed = 1, updatedby = 'CDM-42229', updatedon = now()
where tprdetailsid in ('f2930a6f-c43a-471b-862c-a2dffadac11b', 'b154dd32-d509-4c79-8e4c-5c9acbc11e88') and activeflag = 1;

--Changing client details
update tprrecommendation
set intakeservicerequestactorid = 'b693c47c-8b08-49bd-9fb5-353c3270f584', updatedby = 'CDM-42229', updatedon = now()
where tprrecommendationid = 'f11caf65-23e8-401d-aa66-6173086824f8' and activeflag = 1;