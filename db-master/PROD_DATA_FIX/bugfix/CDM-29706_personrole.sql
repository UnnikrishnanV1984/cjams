/*
   Issue Description: CDM-29706
   Category/ Module  : Person Profile
   Root cause: Duplicate records in person role
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.personrole
set activeflag = 0, updatedon = now(), updatedby = 'CDM-29706'
where personroleid in ('767fa842-5a87-4bc3-a5b1-4eb754ae0f85','982cfc1c-fc52-4da2-b723-a45170df0057',
'0b307abb-c322-4a44-bed8-82a82eea58d6','82d62def-6174-44da-9de8-0a16f6e644a3','66ce7a03-3af9-4e71-b8df-d792e91d4cbf',
'8ec070bc-7a4a-4e76-bac4-d83956704595','6822675e-0a92-4724-a6a3-9fd8fdb4ec40','51aa207e-d456-42a1-b6a6-5efcb6458477',
'1d6a5ca9-12ac-4c58-a978-e5ed21fed744','a038a943-079a-46f7-830a-0eb7a76a8d4f','d3930ed5-c3f5-4ae0-9332-b70e4e69bbf2',
'cc0aaf4f-c022-46df-abc1-0f1afb48fdf6','3aa25a06-4f32-49a1-89e2-01bebe733d8c','8243c6b4-e9a3-437f-b73e-adecfebf96fe',
'5d605310-72cb-4a26-aa17-d36e73d96367','8c0a4e4f-b8b8-438f-998d-1efe79aa2673');
