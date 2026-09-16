/*
   Issue Description:Need data fix to delete the CPS program assignment for the deleted cases 251023044611, 251023044610 on the person card for all the clients in the Case# 251023044623.
   Also need to end the CPS program assignment with "05/06/2025" for all clients for the Case# 251023044623.
   Category/ Module  : Service log
   Root cause: removal of the case datafix has been done as a part of CIDM-10505 and for duplicate intake codefix has been done as a part of CDM-44378.
   But the program area was having those removed case record.
   Fix Provided: Data fix to deactivate the removed case program area and ended CPS program assignment with "05/06/2025" for all clients for the Case# 251023044623.
*/

/*
--204129614
d81a2393-6d6f-48c4-99af-aa50598d8104
1f7bfcb9-bcaf-4a10-ab64-6f79435fe849
f5c15ae1-87e8-4f95-94aa-65be41f56686--
--204129603

4dd40f6e-a6a2-47a8-bc9d-cf6df7e1c1d1
49043dc2-3e89-464a-b82d-3710efdb00da
e659bd1e-c43b-4870-a5fd-8f12273d65bd--

--204129612
a6ae56cb-367a-4993-a562-acae37404177
8f17052e-7de4-49ca-be24-4d72214c5020
e6baa8ba-8c71-4272-b55d-add733177c37--

--204129610
affff705-913d-4322-a1a9-7557d22a3492
59a06583-6d01-4ae9-aa53-3e20ffc39ad8
e7a73ade-390f-4437-a633-3ef167329d34--

--204129607
e00b2ff7-47b9-4222-ab74-3447bf79aff2
cf28c515-b920-4c97-83f7-4d6ac3ba7fba
3d0640cf-7a30-4503-9038-f66e01ccfbf4--

--204129609
ad5e22b8-47df-45a7-a079-6b5ef34d9f39
77cf1287-b987-4ab1-9527-81420bef1894
cdcd6320-a03c-4c22-b935-62758ae9d4dc-- 2025-05-06 16:06:34
*/
update personprogramarea
set activeflag = 0,
	updatedby = 'CIDM-10540',
	updatedon = now()
where personprogramid in (
'd81a2393-6d6f-48c4-99af-aa50598d8104',
'1f7bfcb9-bcaf-4a10-ab64-6f79435fe849',
'4dd40f6e-a6a2-47a8-bc9d-cf6df7e1c1d1',
'49043dc2-3e89-464a-b82d-3710efdb00da',
'a6ae56cb-367a-4993-a562-acae37404177',
'8f17052e-7de4-49ca-be24-4d72214c5020',
'affff705-913d-4322-a1a9-7557d22a3492',
'59a06583-6d01-4ae9-aa53-3e20ffc39ad8',
'e00b2ff7-47b9-4222-ab74-3447bf79aff2',
'cf28c515-b920-4c97-83f7-4d6ac3ba7fba',
'ad5e22b8-47df-45a7-a079-6b5ef34d9f39',
'77cf1287-b987-4ab1-9527-81420bef1894'
)
and activeflag =1;

update personprogramarea
set enddate = '2025-05-06 16:06:34',
	updatedby = 'CIDM-10540',
	updatedon = now()
where personprogramid in (
'f5c15ae1-87e8-4f95-94aa-65be41f56686',
'e659bd1e-c43b-4870-a5fd-8f12273d65bd',
'e6baa8ba-8c71-4272-b55d-add733177c37',
'e7a73ade-390f-4437-a633-3ef167329d34',
'3d0640cf-7a30-4503-9038-f66e01ccfbf4',
'cdcd6320-a03c-4c22-b935-62758ae9d4dc'
)
and activeflag = 1;


