/*
Issue Description: data fix
User request remove the case assignment and close the case as intake, 
persons and contacts data are not available and need to removed it on workload.
Category/Module: Support
Root cause: remove the case assignment and close the case  as intake, 
persons and contacts data are not available and need to removed it on workload.
Fix provided: Data fix to remove the case assignment and close the case as intake, 
persons and contacts data are not available and need to removed it on workload.
Data/Code fix ticket#: CDM-43976
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed',
dispositioncode = 'Closed',
    updatedby = 'CDM-43976',
    updatedon = now()
where servicecasedispositionid in ('35d06868-01c4-42ea-9481-c54938201f67','3f60996a-d5b9-4502-b070-0dcf6646ba8c',
'f7e0c1ca-4676-4f81-941b-a3313cd35a96','fffb4885-37cc-4237-8f28-54bf9286feb7','b6815104-b50e-4cb6-b61f-c7bc10be9105',
'064c5010-f397-4637-8ad3-c9c908bf28c8','9df8b402-1eb4-4433-ac8b-e23656004022','e66d8e26-fb21-4fa6-b354-cea7c92f2253',
'bb750e8e-9d8d-4332-9424-835324a95140','59033430-8bd3-4f38-a7c8-c563bdd8cc20','0f4fa352-3a2e-4e58-adbe-6b08acecbb4d',
'5f4baffb-d36e-432a-b440-3d3f1242e9fe') and activeflag = 1;

update caseassignment
set enddate = '2025-01-22 12:54:45',
    updatedby = 'CDM-43976',
    updatedon = now()
where caseassignmentid in ('4c56a6bd-df9e-4bcd-9f44-600ccd88e1bf','71e3eb40-b4e8-408a-94e8-33fd5e4308c5','0d54dd85-d466-48d0-9b8a-26638cb7961e',
'e47a7851-e317-46ce-803e-ab5869ab479f','b6286997-0720-4443-ad35-3de436bbad89','31af6ef5-6eb1-4b20-ac3c-d934b7f41a30')
and activeflag = 1;

update caseassignment
set enddate = '2025-01-17 00:00:00',
    updatedby = 'CDM-43976',
    updatedon = now()
where caseassignmentid in ('5d9c86c0-e11f-4d06-8aa0-11707c5a4c7e','4228038a-d7cd-445b-8cc4-95dea3af315e','7f159788-d680-46e6-aa65-bd082c5f3c18',
'8ee47779-7f73-46a8-85e2-9dca17a31724','4116e7eb-2c67-4faa-a114-eef87b2f89c4','ec9fcf01-1c81-4b4c-b08e-c1ed351b47cb')
and activeflag = 1;

UPDATE servicecase
SET statustypekey='Closed', dispositioncode='Closed',
 updatedon = now(),
 updatedby = 'CDM-43976'
   where servicecaseid in ('d1849ef7-3a90-473b-a49a-e03070047883','eff97f67-abbf-4c7b-b141-91b9bfd358e2',
'a3f6653c-5eec-4390-9022-336b729f8c36','c18b9e97-bf76-4a4c-b83e-148a9eea10c3','b029ff14-965e-4b73-9339-16ef3a3356d3','56e567fc-2291-41da-b4e2-203078b6c689',
'2f0b116a-3416-487c-bc9f-cfd9e20d94e1','94922924-49dd-47d1-bbd2-b7d1c31d5847','293051f6-7a71-4032-9e1e-8c5220162554','bbf62abe-a0a4-4f9d-b25e-9daec44e9183',
'b60b4b6b-3024-486e-895c-db837db4ddd3','6bf4bcc1-ab7f-45e0-9f03-08e2690b9c7e')
and activeflag = 1;
