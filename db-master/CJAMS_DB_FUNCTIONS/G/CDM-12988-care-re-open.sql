update intakeservicerequest set
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
updatedby = 'CDM-12988',
updatedon = now()
where
servicerequestnumber = '2021084095412';

delete from Intakeservicerequestdispositioncode where
Intakeservicerequestdispositioncodeid in ('a9b4ad87-facc-49f8-acb4-4bbb572b3f93', '417da710-0c27-4f84-97bd-3e4c0bfcb5d4');


update personprogramarea 
set
enddate = null,
updatedon = now(),
updatedby = 'CDM-12988'
where personprogramid in 
('cc50357a-83bc-4fbc-b555-47cbccae276d', 'b2142779-09c5-437d-9b58-ac53ecf62dd3', 'c5bdc05d-842f-427c-9bfd-20aae0e8d45f', '62350579-0064-4077-978b-8f57b4092611', 'bb66432b-0073-4841-acff-f58b0cf3dcd2');