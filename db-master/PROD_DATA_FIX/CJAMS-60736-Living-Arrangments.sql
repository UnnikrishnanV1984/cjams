
/*
Issue:241030335718:Please delete the living arrangements for Pais'lee and Wynter that started on 6/10/25 as they were entered in error
Root cause: The user request to delete LA record with respective persons.
Fix provided: DB queries  update livingarrangement placement placementrevision tables
Data/Code fix ticket#: CJAMS-60553
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update livingarrangement 
set activeflag = 0, updatedby = 'CJAMS-60736', updatedon = now()
where livingid in ('ac82a796-43d0-4bc9-a9bf-ea19c69a2ca4',
'02c79d00-b117-4dac-8d44-69e48fe7d808') and activeflag =1;


update placement 
set activeflag = 0, updatedby = 'CJAMS-60736', updatedon = now()
where placementid in ('97f2b0bc-75c8-4032-9e0d-19a4dc6f3844',
'42d7cf7d-6c38-42ee-9de4-b8e3160001dd') and activeflag =1;


update placementrevision
set activeflag = 0, updatedby = 'CJAMS-60736', updatedon = now()
where placementrevisionid in ('ebb59689-e0c0-43f0-878d-4dccea0a1db8',
'7fba8e33-716f-48f7-be15-c5f99ccb85b1') and activeflag=1;


update routing 
set activeflag =0 ,updatedby = 'CJAMS-60736', updatedon = now()
where routingid in ('cd7db769-d15b-4978-8d19-382123cfebd0',
'8f93de79-1b0f-4005-9bde-cc68e978ab02',
'2463c061-a7de-4658-a8eb-ba908cd14501',
'6c4c4314-2280-4559-babd-5d65467e6112',
'54fd33ee-75be-4bf3-97a2-5c5e911cb8d0',
'2adcf923-20b4-452a-84e0-4d5bebe411c9',
'85d3188c-73ed-4f4b-8173-e675844dcd8d',
'3449fcc8-938f-4139-a1ac-1363081d88e2',
'acdfdaa2-89be-477a-9043-b57e60fbb7ce') and activeflag=1;

