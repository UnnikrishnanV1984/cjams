/*
   Issue Description: CDM-21967
   Category/ Module  : duplicate adoption planning records
   Root cause: user wants to remove the duplicate intake and delete service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



--3190312
update adoptionplanning set activeflag= 0, updatedby='CDM-21967', updatedon= now()
where adoptionplanningid in (
'7886d4d2-643c-43ba-8c81-2f96424be6d3',
'6a06e2b6-8be7-4966-b27f-535c9d92ead3',
'd89b2e08-3b03-4e50-90a2-83b1bdac1b66',
'd13029a9-73a4-4c9c-beb5-ba97f955bce1',
'585f4e41-f760-41a8-bdc7-7bb40b97327c',
'34caf5ee-753f-4727-8925-105b7e0aecd1',
'deb61a62-8919-42d9-b174-50977ae08fe2',
'0b365945-c442-482a-80d7-c0abff83fec2',
'387ba87f-e3fb-404a-9927-641b93da0ada',
'950199ec-0349-4ebd-a112-87c116bf04bd',
'827f977f-965e-4103-9f33-6d01adb90b2e',
'32ed794e-eecb-4483-9d59-d5485dbb6515',
'6333a122-67a6-4fcc-9cec-3008e1c411a5',
'77a73928-a681-48bb-862a-ba69cac9a01f',
'3e02666c-c4b5-491f-9abc-98d0518d98da',
'a74e23ae-3db8-45cf-b2dd-4e26fcd18860',
'f9607212-22bd-4dd2-88c8-46798a82b590',
'd1172a9f-9eb7-44f1-9f4b-1a809de512bd',
'bac71476-81d2-4229-b4b0-d52e85a95bd6',
'd051b59c-972d-4235-ac15-21ee18a351f6',
'79c8c42b-a7cf-433c-8228-d1e55b0e7c30',
'8700eb8e-a900-4b1a-b89b-a2d0881534f7',
'354beebc-6d79-4ca7-b690-1325b9106d0f',
'f419f8f8-b1e2-4522-9db2-b226fd9de944',
'1079152a-18d5-40cb-9f16-37d26a41e0c1'
) and activeflag = 1;




--3218952
update adoptionplanning set activeflag= 0, updatedby='CDM-21967', updatedon= now()
where adoptionplanningid in (
'5cec8511-ae0f-4a00-bfc2-a8c8b7235e13',
'272632ce-e1f8-4ddb-a810-1d3b43efea2b',
'17715b3a-2ded-4fa1-b029-99a6c972bb16',
'876d7603-4457-43e5-9bab-cfadb7bd3f36',
'5730ef04-d48e-47b8-804f-6b85d78611fc',
'a59ab295-473b-4673-ad27-53e293f8f88d',
'b768bebc-2681-4b37-840d-ebc35b06f91f',
'804ab671-c497-4fd5-bc27-d476021109ff',
'd7e237f0-2b29-4184-a539-5aaa6b5fcfc0',
'40d85b53-1b7a-44dd-ac96-06dc57b4d5d9',
'7cb806f9-dc12-4202-aeee-55e7f4009965',
'00052ae8-c47c-4e92-a1ca-c436010a2a2f',
'b819ac17-4909-4909-a539-120d35bf8720',
'b10d03ae-9fbd-4b8c-b859-215573342755',
'4d41af84-12bc-431e-a5f5-b52af470b18b',
'5d5cc7d5-d19b-434f-86b6-6b4dde1f8d87',
'ca6cda9e-05fe-4e98-86b1-026e62bcb498',
'78ca85f9-6da1-466b-b735-e21cfad55aa4'
) and activeflag = 1;