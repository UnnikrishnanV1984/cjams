/* 
   Issue Description: CDM-40399 MDTHINK- removal of offboarded staff
   Category/ Module  : Permanency Plan
   Root cause:The following staff are no longer employed with CalDSS. They have been off boarding however they still appear in CJAMS staff drop downs.
            Cassidy Cooper - Placement and Permanency
            Courtney Kneece - Placement and Permanency
            Nailah Dawkins - Placement and Permanency
            Shantel Green - Placement and Permanency
            Yndia Coates - Placement and Permanency
            Elizabeth Kolbe - finance
            Karmala Johnson - CPS
            Kayla Shanholtz - CPS
            Bonnie Horton - Family Preservation
            Carla Jones - Family Preservation
            Dayonna Parker - Family Preservation
            Kelly Small - Family Preservation
            Martha Mabe - Family Preservation
            Nicole Ford - Family Preservation
            Adrienne Robinson - Screening unit
            Cynthia Dodson - Screening unit
   Fix Provided : Data fix has been provided Deactive the users from user profile related tables.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update userprofile 
set activeflag=0,updatedon=now(), updatedby = 'CDM-40399'
where securityusersid in ('ba84fe0a-1f1c-4585-9613-a3c15fbca1aa','5ba936d4-5da9-48d2-89aa-95a5f57d4c38','32faa66a-516a-4b64-b67b-dc43500d33d5','ee3a1a4f-ac1a-42a7-aa56-1c2f9972f814','a63cd2d1-5c74-43c8-a29e-82764ecbd60e','94f6b2b9-4de6-4a5f-9374-e0be32005889','5b6f8fab-f495-494a-ada8-675474160b17','e94c9b58-3265-4c2a-adaa-8429bba3c1ce','c27c8d8e-7afe-41c4-99e8-fde40015590c','f6254a50-be36-464d-82a2-c65f5925fb21','6c785f76-2c27-40cf-8f5a-a6d49d17f7d0','059ed7b3-bb48-4ee5-9156-5f785bb492b2','b45093bc-9f80-4253-b958-080e916afc29','a8ac00a8-380a-43fc-9a6c-5eb0d59c2b45','295ee840-7b7a-4502-be01-6133db1334e8','aa57f06f-3abe-479f-aa52-f2c24ccc8cc9');

update muser 
set activeflag=0,updatedon=now(), updatedby = 'CDM-40399'
where securityusersid in ('ba84fe0a-1f1c-4585-9613-a3c15fbca1aa','5ba936d4-5da9-48d2-89aa-95a5f57d4c38','32faa66a-516a-4b64-b67b-dc43500d33d5','ee3a1a4f-ac1a-42a7-aa56-1c2f9972f814','a63cd2d1-5c74-43c8-a29e-82764ecbd60e','94f6b2b9-4de6-4a5f-9374-e0be32005889','5b6f8fab-f495-494a-ada8-675474160b17','e94c9b58-3265-4c2a-adaa-8429bba3c1ce','c27c8d8e-7afe-41c4-99e8-fde40015590c','f6254a50-be36-464d-82a2-c65f5925fb21','6c785f76-2c27-40cf-8f5a-a6d49d17f7d0','059ed7b3-bb48-4ee5-9156-5f785bb492b2','b45093bc-9f80-4253-b958-080e916afc29','a8ac00a8-380a-43fc-9a6c-5eb0d59c2b45','295ee840-7b7a-4502-be01-6133db1334e8','aa57f06f-3abe-479f-aa52-f2c24ccc8cc9');

update rolemapping
set activeflag = 0, updatedby = 'CDM-40399', updatedon = now() 
where principalid in ('24571','12775','13420','5223','13330','5174','4961','13310','4975','9520','20301','5164','5193','5141','5107','4954') and activeflag = 1;

update userresource
set activeflag = 0, updatedby = 'CDM-40399', updatedon = now() 
where userid in (24571,12775,13420,5223,13330,5174,4961,13310,4975,9520,20301,5164,5193,5141,5107,4954) and activeflag = 1;

update teammemberassignment 
set activeflag =0, updatedby = 'CDM-40399', updatedon = now() 
where securityusersid in ('ba84fe0a-1f1c-4585-9613-a3c15fbca1aa','5ba936d4-5da9-48d2-89aa-95a5f57d4c38','32faa66a-516a-4b64-b67b-dc43500d33d5','ee3a1a4f-ac1a-42a7-aa56-1c2f9972f814','a63cd2d1-5c74-43c8-a29e-82764ecbd60e','94f6b2b9-4de6-4a5f-9374-e0be32005889','5b6f8fab-f495-494a-ada8-675474160b17','e94c9b58-3265-4c2a-adaa-8429bba3c1ce','c27c8d8e-7afe-41c4-99e8-fde40015590c','f6254a50-be36-464d-82a2-c65f5925fb21','6c785f76-2c27-40cf-8f5a-a6d49d17f7d0','059ed7b3-bb48-4ee5-9156-5f785bb492b2','b45093bc-9f80-4253-b958-080e916afc29','a8ac00a8-380a-43fc-9a6c-5eb0d59c2b45','295ee840-7b7a-4502-be01-6133db1334e8','aa57f06f-3abe-479f-aa52-f2c24ccc8cc9') and activeflag = 1;

update securityusers 
set activeflag =0, updatedby = 'CDM-40399', updatedon = now() 
where securityusersid in ('ba84fe0a-1f1c-4585-9613-a3c15fbca1aa','5ba936d4-5da9-48d2-89aa-95a5f57d4c38','32faa66a-516a-4b64-b67b-dc43500d33d5','ee3a1a4f-ac1a-42a7-aa56-1c2f9972f814','a63cd2d1-5c74-43c8-a29e-82764ecbd60e','94f6b2b9-4de6-4a5f-9374-e0be32005889','5b6f8fab-f495-494a-ada8-675474160b17','e94c9b58-3265-4c2a-adaa-8429bba3c1ce','c27c8d8e-7afe-41c4-99e8-fde40015590c','f6254a50-be36-464d-82a2-c65f5925fb21','6c785f76-2c27-40cf-8f5a-a6d49d17f7d0','059ed7b3-bb48-4ee5-9156-5f785bb492b2','b45093bc-9f80-4253-b958-080e916afc29','a8ac00a8-380a-43fc-9a6c-5eb0d59c2b45','295ee840-7b7a-4502-be01-6133db1334e8','aa57f06f-3abe-479f-aa52-f2c24ccc8cc9') and activeflag = 1;

update teammember set activeflag = 0, updatedby = 'CDM-40399', updatedon = now()
where teammemberid in ('cab90e25-f10e-4d53-886f-69eb679c6e66','b40ba320-8742-41a2-8431-92fff78cebb2','cecf4f06-35ac-41ed-b11a-1b1b98f618f8','48b86ccf-63f8-49db-a091-1e5f4e6dbe49','37f5d89a-f506-44e7-9222-3989d19550c5','80bb5f0e-e2c2-4ef0-b444-227525a192d3','53db4f04-b153-44b6-a370-d1e2f696b4d2','0a482eaf-de29-45f0-85e6-c04bb1faf7d2','9703ef7f-49d4-437b-9f56-aff8c035c326','cf644003-82de-4710-9490-8bcfb9c14640','a003fdf8-5bba-4ccb-9d77-7437ed144e1f','916c2153-8d22-47ca-a09f-9351ea6afdcb','e293a6cd-f6e7-41d7-9f3d-ed51c694f39a','42efc3fd-e2d5-4b96-aab9-82235cd817b7','12306cf1-b4a5-4509-a88a-3a64a7888975','203c90c6-b2c2-4a63-b3a6-13fecd820d78') and activeflag = 1;
