			 
update  cjams.Investigationallegation set activeflag = 0,updatedby = 'CDM-10867',updatedon = now() where investigationallegationid in 
('44e57807-0050-4104-a884-5d8d5a910b8a','c4b5a3a3-8d83-40b6-9ca0-516cb2f1cc89','09bd3091-ca57-4a73-a081-6856a424fded','0189d18d-7890-48ab-9209-f5f690ecff01',
'babd2209-0c54-469a-978f-439b8bfa3f3d','1408c74f-de25-42fa-a78d-79675498bb5c','685eb6f2-e74a-4bbf-aee6-4dc2ec6d0b39','d998fbb7-9edc-4ec9-b29d-92ccc758ea0c',
'6360b933-df8f-4d7b-aa85-14605519dc7a','38fb88f6-3278-468e-b1f7-7e2103eab283' , 'e6ff64bc-6f93-4204-a099-c588df1c4546','4a359af9-d994-488f-a7e9-32471a08dadb', 'c0dca4d1-a2d0-431e-8a64-8ab33a0bed3b','4b21b564-3eef-435f-954b-ea1b0ddf1f4a'
) and activeflag = 1;