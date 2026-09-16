/*
   Issue Description: CDM-29993
   Category/ Module  : multiple sex trafficking alerts
   Root cause: Previous datafix which update the status to open reverting that.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

update usernotification set activeflag = 0,updatedby = 'CDM-29993',updatedon = now()  where usernotificationid in 
('9bfcb36b-4a3f-4588-bd2d-3cdd8e80eba5'
,'9f326c0c-a80c-49a7-8344-a6c138b37685'
,'cf2a25de-bc11-4a1f-aedd-3cd6db0821d0'
,'dfedaf9e-7349-4a0e-ba50-8b2d2e831bdc'
,'e2384665-526a-4c9c-ab1c-dd27a106f313'
,'df7f5a3d-3e39-4fac-888f-23fbcd7de865'
,'6e4738c4-e414-46d7-8ee8-2cf595d1a5c6'
,'6d25639f-b5e6-440a-9ca2-e88a867e1b52'
,'90b68cd0-9f0b-4903-80be-7375e43b5813'
,'0a536efa-54c6-485c-85cc-e6608fc68ad0'
,'64cea74a-7942-4a09-8dfb-36e0dc178412'
,'4dc8b8ed-647d-4825-8300-844d372be16d'
,'e6c0e603-86c3-40cd-bc9e-a7093fdef1e7'
,'78c9c797-8035-47e1-b7d7-34ea86f5703e'
,'be0549b7-f5de-446a-b9b7-cd4ec03c6ed5'
,'1af877fb-8ae8-4339-8d13-74167c5a637d'
,'65e2b4e7-a7e5-41cb-9209-9ecb6cd2a8e2'
,'89c08ee5-fd13-4c0d-8b8e-ff9428f9073e'
,'f085d131-334e-4781-9d8a-daaffcf28e3e'
,'a74c5f96-a454-4ea9-9b4d-60ea22af486b'
,'90c65344-92a0-43ee-9f57-8e9111279da2'
,'94c9c728-fe6a-478b-ba58-e201f185b83a'
,'24bf27da-5294-41b3-82d3-239646c6ece5'
,'3b536ce9-c722-4c5c-bbef-e25b17d9b540'
,'c6f34d65-88e4-4eda-859b-95daacc8eead'
,'096ebac4-5373-4a69-b544-b05be779a3d3'
,'1a3a1012-2843-4d34-b05e-3ce07e07a3a0'
,'dc733e85-c7e4-4a4e-83b9-ce02226f7000'
,'6c6e8812-362f-4a5b-80b5-f1f2a724b9e4'
,'671d4096-9632-49c3-92ca-f9dda0ee8558'
,'5e6194c1-6c38-4489-9133-b6b10a03a7ad'
,'80930e4c-9407-4078-8cf0-ed539b255d26'
,'9e0866a2-9ea0-4513-a9e8-fc95d048bf79'
,'245a9ab7-8c2b-4cec-bc88-02dcfc962d11'
,'92108409-ed37-4d0c-ba37-762cd0dbc4e6'
,'2fd5e1a4-deed-4570-b106-5f29c99e4d77'
,'767577ad-1662-4448-96d4-ca5b60a71f96'
,'0ecb3d15-beff-4455-a5a0-49dd6c5119f5'
,'702580ac-7b42-4c0c-8adc-710639235732'
,'131c08c6-4bf5-4a62-b231-b7cd01e841ca'
,'b3209f23-e61d-4b6c-bbc6-66d7707175a4'
,'9b5904f1-2556-47a3-8b9c-678e8715fbbe'
,'1a4028d8-8420-455f-a4a5-87be83ade2e3'
,'163ef718-106d-4ed3-9bd6-14044abbb50f'
,'cd57f31d-4906-4061-90f4-92bd67a7ef1e'
,'d975a864-f84b-4fc3-9a54-504ded3d2e9c')