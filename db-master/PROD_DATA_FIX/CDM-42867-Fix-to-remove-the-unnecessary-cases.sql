/*
  Issue Description:  CDM-42867
   Category/ Module  :  IV-E-dashboard
   Root cause: Data fix done to remove the existing iv-e case closure cases for review and 3which are not needed.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
 
 

 
 
 
 
 
 update ivecaseclosurereview
 set activeflag=0, updatedby='CDM-42867', updatedon= now()
 where activeflag=1 and ivecaseclosurereviewid in (
 '7bb4810d-a4e9-4d75-8faf-b8e15d01dbf6','e0cb3b88-002f-449f-822d-5aa822c498ed','bbf9e195-d5f8-4cc6-9173-b6afd4e259e8','9a6f8614-98b7-4dc9-99ec-b359f46cbfe5','f944e60e-4446-4327-a014-e34688aad838','5e1817fe-64eb-4c31-bd43-3aa8574333f0','7de762a0-3d15-4248-9986-f7c38f389467','45f01533-80d9-46fe-a5f8-f958dbe7a3d2','04217def-66b4-4d0d-93a1-38f77a41861b','17619a0b-26ec-48fd-b7cf-3ca8dcf27fbd','ccc399c3-123d-41fa-933d-77aa5d527cda','7e43b33c-4238-409e-857d-cde7ad3d7eb2','01dc0018-a562-407c-aa2c-e5b98312fb8b','1ac174ff-8619-4a16-9a6d-6d8498de58d0','b9e39954-23f4-4b1c-ae72-c980f183bb5e','0fe8bea3-c6c7-403d-8949-273f2a8aa988','25ba995f-8473-4e5f-bd2e-3aa69cbf1680','5e203c2d-00f6-467c-b105-9efe66d6fca4','086d9c4a-c35b-46be-9b8f-c7dffa2fb384','266acb58-d801-46fc-912c-54535da248be','8433debb-0149-4f42-8f63-c0b0b13fea67','15c7f114-ee9b-40ef-87b4-ec036209fd31','ee8b94f5-2b9e-47dd-8e62-b0a303e4fa2d','3fe9b730-4dfc-49fd-a7f7-b249cc5b31b4','28699add-1f6f-4819-aa08-90c876316a18','3ce1a139-8b06-48c6-a517-aa56550e72e4','a4b8cb09-8aaa-4ff1-ae96-ac3daab66f1a','3ea9ba5f-cc9b-498b-bd2a-e0d39d4ba0b2','375f7ead-297b-455a-a588-3959ade32412','e0fdc2d8-c14b-4afa-b7ba-47e308e319ae','32c27ae5-bb6d-40e3-a389-3fecc8e4d986','ac0e3ef3-61ff-4a19-a8ad-bc704084c23a','c1c6d6d6-9d72-4fb0-972c-1c1b7935c0dd','f7179bb1-9060-48ec-ba96-c47b01f8bb85','3caa6064-bf56-4bb3-bb7e-b2ea32b62f31','9d386d7a-266a-4b6f-bfd0-56e3989a3c63','b5ad0321-2725-4bd7-92ee-274e26f2f517','34eeaf7b-dcad-4f25-b59b-0fb68c603641','39274fa5-69e4-411c-838a-799537a1bcc4','7528aacb-b86f-41cf-8f76-fb4b19681f75','d01e1bae-79cb-473b-88af-51a27457e78c','123a304b-3cfa-4cbc-8a3e-4b46b0e9d9c4');
 