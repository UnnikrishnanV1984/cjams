/*
   Issue Description: CDM-23831
   Category/ Module  : Approval Inbox
   Root cause: user wants to remove approvals from pending tab
   Pull request# for code fix: 6466
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing set activeflag = 0, updatedby = 'CDM-23831', updatedon = now()
where routingid in 
('5b3772e9-f131-4a31-b1bf-280e20899f4e',
'90448f4c-171b-410d-8fb4-3de3668da25a',
'eb5ddb70-e4bf-4025-a212-73d140394a51',
'96a2bae0-5bd5-4231-8427-3d809f40f63f',
'49d85996-3d03-48bb-9c49-93a64f8e788b',
'b45682b3-d894-457c-97a5-3d6377ac6074',
'bb494b53-64dc-4a19-bdd5-4fae548d1f54',
'0e352ed5-c911-4deb-ab46-937ddd3b2747',
'102eabcd-0b08-49ea-9bc2-b0a4c2776760',
'8e0e5c3d-6089-4b2d-ba27-baebe9bd2f78');