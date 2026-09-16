update cjams.intakeservicerequestactor
set isheadofhousehold = true, updatedon =now(), updatedby = 'CDM-12403'
where intakeservicerequestactorid = 'dd4978a0-348c-4a4e-907e-e9da0b5dd398';

update cjams.intakeservicerequestactor
set isheadofhousehold = false, updatedon =now(), updatedby = 'CDM-12403'
where intakeservicerequestactorid in ('c0fc8448-73d3-4466-923b-fa83055fea38',
'0279cba7-63ab-4794-9067-435ca347ea70',
'cab8fb3d-94ea-4d0e-89ef-4880b1961430');

update cjams.servicecase
set caseheadname = 'Dunn, Steve W', updatedon =now(), updatedby = 'CDM-12403'
where servicecasenumber = '3255783';