
/*
Issue: User has no access to CJAMS
Category/Module:
Root cause: Rolemapping and userresource has been deactivated for theresa.kleppinger@maryland.gov instead of kelsie.hardesty@maryland.gov
Fix provided: Data fix has been done to deactivate the rolemapping and userresource for kelsie.hardesty@maryland.gov and reactivate the rolemapping and userresource for theresa.kleppinger@maryland.gov
Data/Code fix ticket#: CJAMS-67115
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data was done in the database to fix the issue. No code change was required.
*/
--Deactivate Kelsie
update rolemapping set activeflag = 0, updatedby = 'CJAMS-67115', updatedon = now() 
where principalid='15033' and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CJAMS-67115', updatedon = now() 
where userid='15033' and activeflag = 1;

--Reactivate Theresa
update rolemapping set activeflag = 1, updatedby = 'CJAMS-67115', updatedon = now() 
where principalid='3999' and id in ('87598160','87610162','87604161','87622164');

update userresource set activeflag = 1, updatedby = 'CJAMS-67115', updatedon = now() 
where userid='3999' and userresourceid in ('ab221686-343c-4c5a-83fe-27ab0f42ca72',
'eeb5e9ef-72a2-4d27-9a40-cc8c2aa64909',
'b81d5259-041d-4e62-a498-9e9bcae0b5bd',
'33a7966f-333a-46d6-b8c5-318d4bba7a31',
'48c99992-87b2-4373-8f5f-e8ff947a7797',
'a6592e49-0170-49aa-a0e2-80af36b3d53e',
'dbd43741-f410-4a0a-808b-fa7dd03368bf',
'25fc400a-4c90-4043-b612-c6533922b90e',
'20f23a77-55e5-483c-a1c2-781ae47f1dee',
'0ca8dc85-2ae5-4b5d-878e-91158f3b7512',
'85c0d82c-e076-4e72-9687-275824702f0f',
'c887fdc6-1f19-4c56-b134-412cf6746dc8',
'9eb26eed-fa93-470a-81b2-7c136346963a',
'd27f71be-d379-41cb-a58b-23f226eea6f7');