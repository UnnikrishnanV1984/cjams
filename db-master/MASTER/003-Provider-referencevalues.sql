
delete from cjams.provprogramtypename;
delete from cjams.publicproviderhouseholdchecklist;

-- Insert data
INSERT INTO cjams.provprogramtypename (programid,programtype,programname,updatedby,insertedby,insertedon,updatedon,activeflag,providertype) VALUES 
('a0ef2547-6952-4af9-a436-570ab97437e9','RCC','Respite','','','2018-11-02 18:58:29.363','2018-11-02 18:58:29.363',1,NULL)
,('cfcf531d-5a84-4326-a943-21010d36bf85','CPA','Independent Living Program','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('2fba8f70-49a9-4e04-abf9-0c7f5db3b994','CPA','Independent Living Program Teen Parent','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('066acf53-2ac0-4492-b52f-8f4546c4cb6e','CPA','Traditional Foster Care','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('f99e4ed2-cb93-45b2-b4bc-60891546edbe','CPA','Treatment Foster Care','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('d901987a-9d6e-405b-b15d-4bfa3410e26c','CPA','Medically fragile Foster Care','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('f040a910-2c69-43ea-b73a-657ce2f7c40e','CPA','Teen Parent Foster Care','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('b55be552-ec66-43a3-8f80-fdea5397d597','RCC','Diagnostic Evaluation and Treatment Programs(DETP)','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('93bbed8f-9bed-4dc6-be02-9c272605028e','RCC','Group Home Programs(GHP)','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('a803f8ea-ff72-4ea3-a11b-2440c709b60a','RCC','Medically Fragile Programs(MFP)','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
;
INSERT INTO cjams.provprogramtypename (programid,programtype,programname,updatedby,insertedby,insertedon,updatedon,activeflag,providertype) VALUES 
('e0c3dede-29bf-43f8-8fb7-377699ff13ee','RCC','Psychiatric Respite Programs(PRP)','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('677972bc-2311-4b74-b94f-350dac9c8820','RCC','Teen Parent Program','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('751dbcd7-5a59-4cb6-9ccb-87c3292a64fb','RCC','State Operated Residential Educational Facility','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('5fcc6720-f3ac-47ca-acc5-50f09caa9b6f','RCC','Secured Care Program','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('188295c3-5f5a-4925-8686-59fd29c0024d','RCC','Residential Crisis Services','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('13812084-638d-4ba2-9313-4a0564c0ad96','RCC','Pregnant Adolescents Program','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('d563a497-5b36-4877-b63d-5f555a7b9dc9','RCC','Wilderness Program','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('05bfcddd-01d8-4c75-b59d-411e36fde96d','RCC','Shelter Care Program','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('ef93d959-9fd1-4af3-9fb0-b5d4e7c43922','OOS','RTC','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('f1a89d83-127a-469f-99fc-b6deccbb4480','OOS','RCC(Staff Secure)','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
;
INSERT INTO cjams.provprogramtypename (programid,programtype,programname,updatedby,insertedby,insertedon,updatedon,activeflag,providertype) VALUES 
('bf615c5d-3af0-4603-86bb-c15e68974629','OOS','Hardware secure','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('bcbf2bec-0280-4577-bcb1-03c0c6ced453','OOS','Hospital - Psychiatric','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('f8499a19-4318-43e6-8941-e2772af251f1','OOS','Hospital - Medical','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Private')
,('395313ae-be90-4a93-9636-879c4a63bb0d','Resource Home','Regular Resource Home','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Public')
,('deec5c03-1f14-4cf4-b6c1-72533c4864cb','Resource Home','Treatment Resource Home','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Public')
,('8056e48e-9fb3-43fc-bb37-0fc663fdf769','Kinship','Informal','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Public')
,('f379bef5-b4b2-4fe0-9571-9c7fbe16942d','Kinship','Formal','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Public')
,('9fda0a0f-7de7-4cf1-aecc-ecc01445071d','Kinship','SILA (Semi-Independent Living Arrangement)','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Public')
,('bfe9f271-e7ae-42f3-b26e-4b4040a3fe14','Adult service','Need Adult services input','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Public')
,('8abf72db-abf2-4e13-8220-1066cc1eb8d1','Paid','Eyeglasses','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Vendor')
;
INSERT INTO cjams.provprogramtypename (programid,programtype,programname,updatedby,insertedby,insertedon,updatedon,activeflag,providertype) VALUES 
('b569dde9-be37-480b-ae80-bfc8847bb748','Paid','Clothing','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Vendor')
,('6b045877-a2fa-4b75-a0d4-085f39b9a9e0','Non-Paid','AAA','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Vendor')
,('68db6a53-5362-4350-a5bd-bcc79e826c72','Non-Paid','Drug counseling','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Vendor')
,('6788f2e3-bf91-4c8f-8009-31c4307ed503','Resource Home','Restricted Home','','','2018-11-30 21:13:23.008','2018-11-30 21:13:23.008',1,'Public')
;


----------------------



INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('079be520-9dd7-45b3-89c6-2871ebc7343c','Application','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('4b00912a-da57-4274-93b1-31fce85dd822','27 Hour PRIDE Training Certificate','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('5ec3186b-908f-4393-8cce-0d733e38b519','Discipline of Foster Children Policy Statement','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('1a419f2f-7358-462d-a143-b66d1874c977','Resource Parent Agreement','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('a15c5927-f66d-42d4-a0cf-f262d1129e20','Pet / Rabies','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('2688f9b4-4840-474f-b27e-e97e75d237b5','Proof of Income','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('f60a82ff-13d1-47ba-8886-8678cbfb779e','Home Safety Survey','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('4aeace45-7c5c-410d-b9fe-8c0e08d989f7','Health Department Inspection','HH','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('2990da83-f6be-4e01-863f-ec01869a48aa','Fire Department Inspection','HH','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('2e71fe63-20a1-4c94-a28c-3bc7ae0bc4c1','Criminal Disclosure form','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('deab9cbb-955c-4411-86e5-78de335176ae','Marriage License','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('a800c57e-b5f7-4373-8ba8-4d192b9430df','Proof of Auto Insurance','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('b9281f20-0181-43b6-bf92-96137ca91f7f','Emergency Preparedness Form','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('21a71419-e716-44a7-8d1b-019e79b5dda6','AdoptUsKids','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('71743ece-556c-4f43-a5b4-335465fb400c','Firearm Registration','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('cfe54e53-0adc-4dd3-869f-b4ea0032aaf3','Lead-Safe Environment','HH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('e50da236-2225-4e8e-a639-830dcee44a36','Medical Report','HHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('a8a6bd01-43ba-41d5-b3ef-27d5f29d1b9a','Immunization Records (under 18)','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('c0c973ba-e15e-4e9d-9cf8-ba74cb3a742e','TB Test','HHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('8b079a27-67f7-47e6-9086-bcf01216dd82','CPR and First Aid Certification (18+)','HHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('a927d32d-a4ef-41d1-9f67-ca308886f9a5','MD Clearance','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('fd3b2733-3d78-49ba-b8f3-bf0aab32d131','FBI Clearance','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('eaea5b86-e8a6-4aed-ac5d-506a204b4219','Out of State Clearance(s)','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('ce6b7c94-fda3-4ba2-b66c-6923703bdf7e','MVA Clearance','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('35bc0e70-b2f2-4486-ad08-4c7ce39a7c82','CPS Clearance','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('e3e3f27e-f2df-451a-973f-b9a3b621e9f1','Out of State CPS Clearance(s)','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('93bd29d6-bb6d-4590-897a-6c332a7ade66','Child Support Clearance','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('c81cf2af-8278-48ee-bcef-2def556515c6','FIA Clearance','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('18fda1b3-6667-4033-a293-aa387fd470bf','MD Sex Offender Registry','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('ffc2eaad-d788-40c7-bcaf-273646917bf4','National Sex Offender Registry','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('d91a4b6d-00ab-4052-8f84-b174809e731b','Judiciary Case Search','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('df18fbed-fe08-4675-8483-4ae7de845745','Confidentiality Statement','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('08ed6eae-f7f3-49de-88b5-5c4be0460606','Divorce Decree','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('89e07931-760b-4190-b71e-3e329ef48894','Proof of Citizenship','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('6bfaf9c1-ba62-43e7-acbe-400cf500e15d','Personal References','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('32603dab-70af-4c64-a226-5bca50c17ca2','School References','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('e959b66f-9cc5-42cd-8223-8b74fc5c7812','Photograph of Resource Home Provider','HHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('a2f3ec42-cbb4-4bee-a3b5-66d1773c97cc','Reconsideration Update Form','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('23b67654-753e-4e1a-8a4a-b1ae2dd83915','Home visit completed','RECONHH','Date Received','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('ca4ee8e3-1f6a-484c-80fc-25ce8e7e9557','Pet / Rabies','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('b4a1c470-5790-4d77-bf08-cd305c53c3da','Proof of Income','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('ab848e23-227e-43c6-a10e-83f0cf695106','Home Safety Survey','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('3d72b9f2-037d-4d10-8e3f-cda936311eef','Proof of Auto Insurance','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('ca1738bd-3836-46f4-abcd-ca7810c981b1','Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('6e892124-ce0c-44c4-b919-d4444a2064c7','Discipline Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('e694285e-656d-48e0-aba3-faa84a097bf8','Medical Report','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('08ad2217-e0ac-48f7-86a2-592f019fc25e','CPR and First Aid Certification (18+)','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('8bf5bedd-6b0b-4c0e-ae8c-178c39af593f','MVA Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('385d716d-5ba8-424e-968d-e899822a04d1','CPS Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('b542d58e-10a3-401d-aa18-feee83555318','Child Support Clearance(s)','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('11438ea8-f0bd-417e-a98f-ec92dd039f81','MD Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('2e14551c-7cc9-47b6-b87a-f31623b34d77','National Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('e3341c6e-ae6e-43f4-b1eb-3817db69f325','Judiciary Case Search','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('6b9e06a7-3843-4684-aecc-b4f734a859b9','Divorce Decree','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('c8bfb8a7-42b7-4fa9-bcbc-75d9b9414ba0','Reconsideration Update Form','ReconHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('97afe0f9-eea4-422f-89ca-09ff387e1927','Home visit completed','ReconHH','Date Received','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('12e5ea32-c009-4482-9539-83bf6e170be7','Pet / Rabies','ReconHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('08c6b9e5-b53a-4d75-9190-c6260d244c28','Proof of Income','ReconHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('c087dff1-4967-4c26-8d68-18ef6b516f1e','Home Safety Survey','ReconHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('f69c8134-3908-4967-9d02-d1dc337c553c','Proof of Auto Insurance','ReconHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('75b5fe8c-f11b-4dfb-bd88-6b9cfe2df9fb','Reconsideration Update Form','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('87224b53-e8d3-4a1a-8e5a-75481d40cddc','Home visit completed','RECONHH','Date Received','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('f2458c25-71b8-49b1-b505-6e19a2615c9a','Pet / Rabies','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('3257c000-e5c4-434d-a57e-01a5328a9a41','Proof of Income','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('046d13ff-5c79-4e9b-a06c-d8de4a7cd712','Home Safety Survey','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('a8d8f263-d4e4-45bd-b026-f5cf9107a0f0','Proof of Auto Insurance','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('5a414480-521b-4e72-bb28-b637f527620f','Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('982795e6-37ce-4b82-ba01-af834214d3a7','Discipline Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('6aebfa1b-3a37-4f80-aeb8-44b6b0db6b72','Medical Report','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('a28278fb-68fa-41d0-886e-6deef76d16d5','CPR and First Aid Certification (18+)','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('eaddd0da-a216-4207-9f00-9e71375908eb','MVA Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('1323f352-ea5f-495e-ba6e-101dcf5800e6','CPS Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('f1e77f43-2c36-40be-a9fe-5b768dbcdba3','Child Support Clearance(s)','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('2aad13b4-a20c-4594-8004-4846d483c8e8','MD Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('23949041-ef74-4c5e-96c9-ebf1279146a8','National Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('9056f185-67d1-4131-8ae9-6a3a67abbbe4','Judiciary Case Search','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('c2461381-abb6-415e-80c4-781d33fd2023','Divorce Decree','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('4f419dd1-37b5-4efa-b305-6724bf08aa8c','Reconsideration Update Form','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('3896d79b-a6a7-4d6b-8611-42f9dbfc9661','Home visit completed','RECONHH','Date Received','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('be167948-09e1-4190-a5fe-12dd739c499b','Pet / Rabies','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('daaf6e86-8cbe-4f64-932e-66a97db20784','Proof of Income','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('38f86460-cedc-4f2f-a097-51ee2e002983','Home Safety Survey','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('4bca05eb-4eba-44a6-a11c-dcfaea4f0ddc','Proof of Auto Insurance','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('f90cca6f-0310-4fd4-ba5b-d4ccf75451be','Reconsideration Update Form','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('30882d58-8da3-4811-9b02-fcafb39e3edc','Home visit completed','RECONHH','Date Received','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('8d23d1a8-73e8-4bcf-a5f2-04fd84860ec8','Pet / Rabies','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('59e039ed-58a1-4462-92ef-f9e70d2203cd','Proof of Income','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('958483de-50ea-4bdc-935c-3d3d3307df1c','Home Safety Survey','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('5a339b4a-e3b1-44a8-8c36-e10275b68def','Proof of Auto Insurance','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('b61bc658-482a-486e-8e10-279fb08871d7','Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('f4153abd-73e2-4f54-af09-8fab700d4110','Discipline Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('b77b5bbc-d679-4df6-80e8-4b99d3177fbf','Medical Report','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('c858160e-4949-4102-ab01-c6bd8addbba1','CPR and First Aid Certification (18+)','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('52365e5d-c5df-4d92-afbb-3a5f84900435','MVA Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('40793271-839b-4af1-8149-01cf1ff6662d','CPS Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('b1f506aa-765c-42c7-8e55-e7b7b81760cb','Child Support Clearance(s)','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('4669c692-bf19-4903-8c6b-d009bb25baaf','MD Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('b2eb6bc8-0bec-4c44-90a1-e517039c410d','National Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('8f9a4d4e-0266-4058-92ca-12e78f2f89c6','Judiciary Case Search','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('150731af-88ca-411a-8299-aad66244a684','Divorce Decree','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('69aeb392-3d25-4efd-903c-da1609dafd89','Reconsideration Update Form','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('1240a28c-1d8b-45c1-9925-bdc746a5c4f3','Home visit completed','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('effae1a0-bb7c-477d-8a5d-f5a8fc76c2e5','Pet / Rabies','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('0554a47b-4b6a-4ab5-a579-618edd969a0a','Proof of Income','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('f60ea1ec-4417-4f62-bdd0-dbd91c8a81da','Home Safety Survey','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('83b6c2e7-3e3e-4cb9-b891-f88938f61f22','Proof of Auto Insurance','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('3aa169f8-9f06-4761-880f-35675dc473a5','Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('afd6a252-e599-4a3c-87a5-03f820db539c','Discipline Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('df164246-e2f0-4a88-96ce-f839ae0db90e','Medical Report','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('be77175f-8529-490b-92c5-430cd701bfa1','CPR and First Aid Certification (18+)','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('fcb7986d-3a96-4d37-8123-464ddfde6c98','MVA Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('91a3d849-4530-4640-8341-9286a23d2d61','CPS Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('7386b9dc-ba38-451a-9d5c-c55304e0dc05','Child Support Clearance(s)','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('36c5b576-09b5-483d-abb0-38ccd9df8e82','MD Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('41e4b0eb-ecd2-4922-b496-759e0e55ede6','National Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('7a7142f2-a92f-4358-af03-e8455d588834','Judiciary Case Search','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('adac8ebd-8dfd-4c17-b5b1-20fe38d9c20d','Divorce Decree','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('c5a3d974-e20e-41be-9897-aaf68eb2a329','Reconsideration Update Form','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('79be2a9e-67d0-4572-a9f5-ae2c1a31f57c','Home visit completed','RECONHH','Date Received','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('0c0af544-ecfe-410f-99a1-a60efd43775c','Pet / Rabies','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('2d4a2e71-27fe-496a-b01d-4cba4a5f7eff','Proof of Income','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('55e8cb6f-f9d9-4de6-8f47-0d051e0710da','Home Safety Survey','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('317401c6-a985-4f5b-9eb5-0a1715fdea5a','Proof of Auto Insurance','RECONHH','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('662b626f-432a-4ece-b531-3a3868a5b5fb','Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('a5f70524-3901-429a-aa39-1f4d294bb39e','Discipline Training Completed','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('53f40b1f-af9a-4320-a473-ae3f1be63dab','Medical Report','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('e90a0ce2-aec0-488e-8a34-fe374ba7a0f3','CPR and First Aid Certification (18+)','RECONHHM','Completed by Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('1f644c39-abbf-4756-aab7-3abd79610bcb','MVA Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('2112649c-e0f5-490d-b3d8-60059f6d5847','CPS Clearance','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('3f37c05c-a0fd-4edb-92ea-8eb742702d57','Child Support Clearance(s)','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
INSERT INTO cjams.publicproviderhouseholdchecklist (checklist_id,checklist_task,checklist_type,date_type,create_ts,create_user_id,update_ts,update_user_id) VALUES 
('7e1db25d-5c45-49ec-80ca-6231eb3157ec','MD Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('2c4cf68d-549a-4e04-b889-523652ab29ae','National Sex Offender Registry','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('8ffd8d28-06c0-4cdf-9348-521cf51adbb1','Judiciary Case Search','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
,('d0c0f382-3d3e-4269-b4db-260145a481ed','Divorce Decree','RECONHHM','Received Date','2019-03-21 21:42:48','Admin','2019-03-21 21:42:48','Admin')
;
------------------------
