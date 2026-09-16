delete from placementrevision where placementrevisionid in ('eaac156d-3bde-475f-9e21-f9a8737d289f',
'e22c60f1-76b8-42d5-b5bf-dc726a053eb3');

update placementcpahomes 
set exittypecd ='CIP', 
exitreasoncd ='CIPTWV', 
exitdt ='2020-09-28 16:00:00', 
exittm ='2020-09-28 16:00:00',
updatets =current_timestamp ,
updateuserid ='CDM-10388'
where placementcpahomeid ='ef69a6e9-165a-4721-afaf-d14f85e55892';