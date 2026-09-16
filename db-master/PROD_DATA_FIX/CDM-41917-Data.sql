/*
  Issue Description:  CDM-41917
   Category/ Module  :  Assignments
   Root cause: User request to Data fix to remove the employees from CJAMS
   Pull request# for code fix: NA
   Reason why no related code fix: For deactivating the users from CJAMS data fix is needed
   Status of the code fix if already submitted and expected prod fix date: NO
   Backup before update/ delete: NA
*/

update teammemberassignment
set activeflag = '0', updatedby = 'CDM-41917', updatedon = now()
where securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296','3b02756e-dc36-410b-afd4-6e0e339244e2',
'1bc28ba2-6ff3-43c0-b7a4-5496bcd2506b','e71b8e7a-fac1-4a19-a4af-437846f4672d','edb88992-fffb-404d-bbfe-09fd3b53e301','7a0be298-3e34-4568-a2a0-3bec454e87ab',
'031df9a5-faaa-4470-808b-fde51b0ca0d1','ee2a8422-20bf-4943-82c8-ba8d40c41963','b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8','3baaa38f-fa56-4b57-bfa8-e7a9d203cba5','399927da-cf92-44f9-8a0a-c5bbef9661bf',
'cfd3452c-9100-457b-83c5-6408c1576746','2bd601a8-9882-43c6-ac6a-9b7dd1cf17b9','15e231ae-5ce7-4ea1-924f-2122c5a43beb','94ddb3f6-f011-44dc-92e4-ec9fca5c613b',
'788f6203-24b3-498d-b35c-83f1e9bf53d0','3b6aa8a0-3262-46b5-b0ab-f5f0d4c4caee','9cea6efb-7cf1-434e-8148-d82b2cf7a6f5',
'474c9759-cf93-4569-be91-21d68d78fb75','1bd912df-c52f-4e65-a2ee-fc1eb6c26e01','91b252c0-ef45-4784-aea1-fbda7980520c',
'56d9f5bb-41d2-4aac-a8e5-b03e8204d00c','d69fa04e-5729-4f77-9536-a5572205f3c2','9c17b622-3919-4c72-859d-8126a7ba2207','76e8e584-62ae-40a5-834c-e3562aa05d27',
'569632d8-1878-4843-b396-09e6c6656e35','ae9e4b29-25d2-4433-a4c1-0aa80c5bc1c2','54ad435a-5ab8-4914-ad34-b4b6e9051e64','cee28303-f9bc-4f4a-9f39-5c7db8caf92d');

update muser set activeflag = '0', updatedby = 'CDM-41917', updatedon = now()
where securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296','3b02756e-dc36-410b-afd4-6e0e339244e2',
'1bc28ba2-6ff3-43c0-b7a4-5496bcd2506b','e71b8e7a-fac1-4a19-a4af-437846f4672d','edb88992-fffb-404d-bbfe-09fd3b53e301','7a0be298-3e34-4568-a2a0-3bec454e87ab',
'031df9a5-faaa-4470-808b-fde51b0ca0d1','ee2a8422-20bf-4943-82c8-ba8d40c41963','b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8','3baaa38f-fa56-4b57-bfa8-e7a9d203cba5','399927da-cf92-44f9-8a0a-c5bbef9661bf',
'cfd3452c-9100-457b-83c5-6408c1576746','2bd601a8-9882-43c6-ac6a-9b7dd1cf17b9','15e231ae-5ce7-4ea1-924f-2122c5a43beb','94ddb3f6-f011-44dc-92e4-ec9fca5c613b',
'788f6203-24b3-498d-b35c-83f1e9bf53d0','3b6aa8a0-3262-46b5-b0ab-f5f0d4c4caee','9cea6efb-7cf1-434e-8148-d82b2cf7a6f5',
'474c9759-cf93-4569-be91-21d68d78fb75','1bd912df-c52f-4e65-a2ee-fc1eb6c26e01','91b252c0-ef45-4784-aea1-fbda7980520c',
'56d9f5bb-41d2-4aac-a8e5-b03e8204d00c','d69fa04e-5729-4f77-9536-a5572205f3c2','9c17b622-3919-4c72-859d-8126a7ba2207','76e8e584-62ae-40a5-834c-e3562aa05d27',
'569632d8-1878-4843-b396-09e6c6656e35','ae9e4b29-25d2-4433-a4c1-0aa80c5bc1c2','54ad435a-5ab8-4914-ad34-b4b6e9051e64','cee28303-f9bc-4f4a-9f39-5c7db8caf92d');
    
update userprofile set activeflag = '0', updatedby = 'CDM-41917', updatedon = now()
where securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296','3b02756e-dc36-410b-afd4-6e0e339244e2',
'1bc28ba2-6ff3-43c0-b7a4-5496bcd2506b','e71b8e7a-fac1-4a19-a4af-437846f4672d','edb88992-fffb-404d-bbfe-09fd3b53e301','7a0be298-3e34-4568-a2a0-3bec454e87ab',
'031df9a5-faaa-4470-808b-fde51b0ca0d1','ee2a8422-20bf-4943-82c8-ba8d40c41963','b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8','3baaa38f-fa56-4b57-bfa8-e7a9d203cba5','399927da-cf92-44f9-8a0a-c5bbef9661bf',
'cfd3452c-9100-457b-83c5-6408c1576746','2bd601a8-9882-43c6-ac6a-9b7dd1cf17b9','15e231ae-5ce7-4ea1-924f-2122c5a43beb','94ddb3f6-f011-44dc-92e4-ec9fca5c613b',
'788f6203-24b3-498d-b35c-83f1e9bf53d0','3b6aa8a0-3262-46b5-b0ab-f5f0d4c4caee','9cea6efb-7cf1-434e-8148-d82b2cf7a6f5',
'474c9759-cf93-4569-be91-21d68d78fb75','1bd912df-c52f-4e65-a2ee-fc1eb6c26e01','91b252c0-ef45-4784-aea1-fbda7980520c',
'56d9f5bb-41d2-4aac-a8e5-b03e8204d00c','d69fa04e-5729-4f77-9536-a5572205f3c2','9c17b622-3919-4c72-859d-8126a7ba2207','76e8e584-62ae-40a5-834c-e3562aa05d27',
'569632d8-1878-4843-b396-09e6c6656e35','ae9e4b29-25d2-4433-a4c1-0aa80c5bc1c2','54ad435a-5ab8-4914-ad34-b4b6e9051e64','cee28303-f9bc-4f4a-9f39-5c7db8caf92d');

update rolemapping set activeflag = '0', updatedby = 'CDM-41917', updatedon = now()
where principalid in ('14896','13493','32626','9820','35375','9728','9936','9890','14798','44298','9562','10006','14433','12839','14700','14999',
'9727','13290','15585','30474','9899','10054','14909','9628','13380','13467','9911','9966','10130') and teamtypekey = 'CW';

update rolemapping  set activeflag = 0, updatedby = 'CDM-41917', updatedon = now()
where principalid = '53117' and id = '152101746' and activeflag = 1;
    
update securityusers set activeflag = '0',updatedby = 'CDM-41917', updatedon = now()
where securityusersid in('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296','3b02756e-dc36-410b-afd4-6e0e339244e2',
'1bc28ba2-6ff3-43c0-b7a4-5496bcd2506b','e71b8e7a-fac1-4a19-a4af-437846f4672d','edb88992-fffb-404d-bbfe-09fd3b53e301','7a0be298-3e34-4568-a2a0-3bec454e87ab',
'031df9a5-faaa-4470-808b-fde51b0ca0d1','ee2a8422-20bf-4943-82c8-ba8d40c41963','b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8','3baaa38f-fa56-4b57-bfa8-e7a9d203cba5','399927da-cf92-44f9-8a0a-c5bbef9661bf',
'cfd3452c-9100-457b-83c5-6408c1576746','2bd601a8-9882-43c6-ac6a-9b7dd1cf17b9','15e231ae-5ce7-4ea1-924f-2122c5a43beb','94ddb3f6-f011-44dc-92e4-ec9fca5c613b',
'788f6203-24b3-498d-b35c-83f1e9bf53d0','3b6aa8a0-3262-46b5-b0ab-f5f0d4c4caee','9cea6efb-7cf1-434e-8148-d82b2cf7a6f5',
'474c9759-cf93-4569-be91-21d68d78fb75','1bd912df-c52f-4e65-a2ee-fc1eb6c26e01','91b252c0-ef45-4784-aea1-fbda7980520c',
'56d9f5bb-41d2-4aac-a8e5-b03e8204d00c','d69fa04e-5729-4f77-9536-a5572205f3c2','9c17b622-3919-4c72-859d-8126a7ba2207','76e8e584-62ae-40a5-834c-e3562aa05d27',
'569632d8-1878-4843-b396-09e6c6656e35','ae9e4b29-25d2-4433-a4c1-0aa80c5bc1c2','54ad435a-5ab8-4914-ad34-b4b6e9051e64','cee28303-f9bc-4f4a-9f39-5c7db8caf92d');


update teammember set activeflag = 0, updatedby = 'CDM-41917', updatedon = now() 
where teammemberid in ('f1aa978d-bad2-4c00-8586-33ef875f31e1','5eea7a4f-cadb-4a88-8d2b-f052f243d2bf') and activeflag = 1;

UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-41917',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in ('bda3f50c-0afa-4185-a2f5-a51e832c0063','08679475-416c-4b26-8880-9104ac839296','3b02756e-dc36-410b-afd4-6e0e339244e2',
'1bc28ba2-6ff3-43c0-b7a4-5496bcd2506b','e71b8e7a-fac1-4a19-a4af-437846f4672d','edb88992-fffb-404d-bbfe-09fd3b53e301','7a0be298-3e34-4568-a2a0-3bec454e87ab',
'031df9a5-faaa-4470-808b-fde51b0ca0d1','ee2a8422-20bf-4943-82c8-ba8d40c41963','b00f0bb0-1872-4ba6-b4f0-642a7f83c4b8','3baaa38f-fa56-4b57-bfa8-e7a9d203cba5','399927da-cf92-44f9-8a0a-c5bbef9661bf',
'cfd3452c-9100-457b-83c5-6408c1576746','2bd601a8-9882-43c6-ac6a-9b7dd1cf17b9','15e231ae-5ce7-4ea1-924f-2122c5a43beb',
'788f6203-24b3-498d-b35c-83f1e9bf53d0','3b6aa8a0-3262-46b5-b0ab-f5f0d4c4caee','9cea6efb-7cf1-434e-8148-d82b2cf7a6f5',
'1bd912df-c52f-4e65-a2ee-fc1eb6c26e01','91b252c0-ef45-4784-aea1-fbda7980520c',
'56d9f5bb-41d2-4aac-a8e5-b03e8204d00c','d69fa04e-5729-4f77-9536-a5572205f3c2','9c17b622-3919-4c72-859d-8126a7ba2207','76e8e584-62ae-40a5-834c-e3562aa05d27',
'569632d8-1878-4843-b396-09e6c6656e35','ae9e4b29-25d2-4433-a4c1-0aa80c5bc1c2','54ad435a-5ab8-4914-ad34-b4b6e9051e64','cee28303-f9bc-4f4a-9f39-5c7db8caf92d'))
		and activeflag = 1; 
		
