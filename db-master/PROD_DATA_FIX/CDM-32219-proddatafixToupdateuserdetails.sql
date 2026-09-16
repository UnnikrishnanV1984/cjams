/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--9c424094-8dc4-4015-9a32-3a7020615f11
--28af306c-b875-4ec1-8bde-31fd3800a2d5
--7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1
--23b992f4-3293-4fa2-b50a-e031d837c77b
--fb7f4090-a281-4ead-b008-526312a230ca
--642b470f-9d48-422a-a912-49e139800963
--7c3afaae-fb02-40fd-8905-2023b4bc8e46
--c540108a-5639-405a-b947-7552526dcee7
--07a546d5-9823-49d4-9167-5228b43e47d1
--769bdaba-c2a0-4757-a294-9d0375dc5882
--5459bee1-15b5-43a7-ba89-4a881351ffe8
--cebf9012-a894-4acc-a9e1-441d0e01fdc3
update documentproperties set insertedby =  '642d8fd5-5615-4464-acbf-70c283c190df', updatedby = 'CDM-32219'
where documentpropertiesid in (
'ea0dd1cb-7630-4ec5-a789-15bf805c285b',
'6a1f07b5-b0bf-44d1-b74e-b74e75754deb',
'f97186c7-f070-4e9b-8c3f-f0cdb2c54d2c',
'c72c2ed0-ceec-49c7-addc-12faf02d8132',
'232a33d1-4b60-4637-870b-df3397089daa',
'4f590785-014c-4b26-b2c8-30fedfcfd691',
'96eb5875-4ecb-4727-ae28-5be6e135d63a',
'c5b4f518-a87d-422f-a987-685205112409',
'91097d4b-1623-4811-afe7-4b8a7d3a9972',
'fde75553-a026-43e8-9516-b0be5ca83606',
'42ecd31e-bf8f-4494-b67d-93ab4d6b49e9',
'81b8ea45-424f-4e8a-8ddb-f027e0761a5c'
) ;


--9c424094-8dc4-4015-9a32-3a7020615f11
--28af306c-b875-4ec1-8bde-31fd3800a2d5
--7a55e5b6-4aa7-45a7-bad9-1d3bd0dc0fb1
--23b992f4-3293-4fa2-b50a-e031d837c77b
--fb7f4090-a281-4ead-b008-526312a230ca
--642b470f-9d48-422a-a912-49e139800963
--7c3afaae-fb02-40fd-8905-2023b4bc8e46
--c540108a-5639-405a-b947-7552526dcee7
--07a546d5-9823-49d4-9167-5228b43e47d1
--769bdaba-c2a0-4757-a294-9d0375dc5882
--5459bee1-15b5-43a7-ba89-4a881351ffe8
--cebf9012-a894-4acc-a9e1-441d0e01fdc3
update documentattachment set insertedby =  '642d8fd5-5615-4464-acbf-70c283c190df', updatedby = 'CDM-32219'
where documentpropertiesid in (
'ea0dd1cb-7630-4ec5-a789-15bf805c285b',
'6a1f07b5-b0bf-44d1-b74e-b74e75754deb',
'f97186c7-f070-4e9b-8c3f-f0cdb2c54d2c',
'c72c2ed0-ceec-49c7-addc-12faf02d8132',
'232a33d1-4b60-4637-870b-df3397089daa',
'4f590785-014c-4b26-b2c8-30fedfcfd691',
'96eb5875-4ecb-4727-ae28-5be6e135d63a',
'c5b4f518-a87d-422f-a987-685205112409',
'91097d4b-1623-4811-afe7-4b8a7d3a9972',
'fde75553-a026-43e8-9516-b0be5ca83606',
'42ecd31e-bf8f-4494-b67d-93ab4d6b49e9',
'81b8ea45-424f-4e8a-8ddb-f027e0761a5c'
) ;
