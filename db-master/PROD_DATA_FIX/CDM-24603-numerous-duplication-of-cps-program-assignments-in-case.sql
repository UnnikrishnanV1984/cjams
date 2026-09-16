/* 
    Issue Description : CDM-24603
    Category/ Module : Program assignment
    Root cause : User wants to delete duplicate program area
*/


-- Client ID: 200891187
-- Client Name: Andrew Sweitzer

-- select * from personprogramarea where personid = '315970d8-cc2f-4029-ba1e-1c7c08ce52da'
-- and activeflag = '1'


UPDATE
    personprogramarea
SET
    activeflag = 0,
    updatedby = 'CDM-24603',
    updatedon = now()
WHERE
    personprogramid in ('ae71faa5-1077-4eb5-b66c-3ba79d1e510f',
'bf87774e-72a9-40d7-a1ca-f9ed8f9768e6',
'ddfbc2e3-749b-4ce5-9b48-081362af0188',
'61c8a8bc-fd46-4171-8b50-2af04011d2f1',
'35b9b32f-3320-4080-bc59-1d203c2202f1',
'f6e00760-0226-49df-81b8-c43d6952c897',
'd9c658ad-5163-4839-a942-884cc1ac70a3',
'75bcc604-2d87-445a-bd6c-765c966de65f',
'08587374-d5d1-425f-aafb-3a624141b2dd',
'70c890b3-add6-47d7-b1b7-aad5720fb091',
'7661b2bd-76be-4240-b13e-c7381be938c0',
'1d16f161-2a5a-43c4-bd18-9d51dfcc4d1a',
'ca68dcbb-d2d3-4def-a4d1-31c072470763',
'b9386374-59c4-44fa-b043-389c784ae927',
'86a417bd-5299-4a85-8ad7-9e285d70432d');


-- Client ID: 2515093
-- Client Name: TAYLOR HAMILTON

-- select * from personprogramarea where personid = '1a8dc526-a9cd-407f-8a0a-e20bb4e269a7' and activeflag = '1'

UPDATE
    personprogramarea
SET
    activeflag = 0,
    updatedby = 'CDM-24603',
    updatedon = now()
WHERE
    personprogramid in ('520166b5-01ce-44b9-ac2a-f722df34c8c7',
'20137d9c-c79e-4e9d-afee-308123ab1ce1',
'9c0eff38-21b7-49a5-8b4a-1471e630571b',
'1b12e5f7-282e-4031-87e4-7ec219fab959',
'84ffd9dc-428a-4669-ad5a-a12276d45162',
'93702177-83ac-4398-9188-073f49b17b38',
'cd61e7c5-e486-467e-805b-5cd7b767227d',
'fc8c417a-4550-4c22-96d5-8c3ce0ac034c',
'ecadebcb-141e-467e-9111-461c136dfff1',
'15bd3ef7-3724-4863-9017-904f4111e11a',
'f6fe008f-24ce-4f43-b703-97ea53bb1ec7',
'fdf8782e-f0d0-4910-88ed-d4783db5f25e',
'5614fb69-ad7e-4943-8202-cff0bcbddf03',
'0ec5b754-273f-4b0c-96af-16d94a74ee50',
'd1e69cce-bcc3-40fa-8ef8-76321e7d4aae');



-- Client ID: 200891174
-- Client Name: Audrina Sweitzer

-- select * from personprogramarea where personid = '88275704-6d0f-4509-a833-91f8757f31bc' and activeflag = '1'

UPDATE
    personprogramarea
SET
    activeflag = 0,
    updatedby = 'CDM-24603',
    updatedon = now()
WHERE
    personprogramid in ('fe5ef640-0f81-43cf-bdac-387d71801beb',
'4a0af24d-0566-4bc9-924d-d43ee5eb84f7',
'afc85e40-fc18-4c4b-855e-5bbcef9222c3',
'f47a5f0b-3274-4560-a51b-8d65746bcecb',
'd75bbeb4-a182-4ab8-856f-1b42b4c5ddf0',
'64ff2a81-8535-44ae-be84-ff156bb13764',
'ed0325b4-6ad0-4fca-b537-7b887117b4d5',
'258fca10-97e4-4807-95dc-228930c81371',
'43ad7a61-df48-4749-8e46-42bed05b375b',
'6bee57a1-4c70-4072-a0bb-881e2d06f7c2',
'950b823a-e27c-41de-83d1-a661d0934ada',
'a8a5ffe9-b5df-4980-a909-7c0ca00a66de',
'7cd7bf9d-b8bd-440b-9bcd-f4ad298aecbd',
'0e841e6d-a2fa-4e78-9624-de59910637f9',
'35eedf9a-7766-4d5e-bdff-4768b938c74f');