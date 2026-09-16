/*
   Issue Description: CDM-17692
      Category/ Module  :  gap agreement approvals
   Root cause: gap agrrement approvals
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update gapagreementrate set activeflag = 0, updatedby = 'CDM-17692', updatedon = now() 
		where gapagreementrateid in (
		'b49911fb-435b-486e-a900-e633e6c64736', 
		'e29e0ea3-c26f-411e-9f41-159bb43f6ae8', 
		'c4412bf9-2f23-4bb0-b3b0-d88a10154e62', 
		'3e0ea980-e257-4b69-bf2e-b8d6e244dbfc',
		'87c61458-12d7-42e8-95e9-9220e2b3288f',
		'77e69122-8154-4c09-b7a6-a56e6535a0ee',
		'f06d7f79-e886-4b66-bb20-8547c6fc773c',
		'7d929c06-2092-46eb-bd6d-6d10c3e49a47',
		'4625c9d4-7861-42db-b0d6-74b1da3cc753',
		'6e9fbad8-fd6a-414e-a8a1-94e053ea7091',
		'8c6c2e25-8cae-4712-9ca1-db591247394e',
		'ee200b14-0796-4616-b901-8c8e9f850ea2',
		'8ffc1784-73f9-4e92-b187-0b1b0798b75d',
		'7400faad-3168-463e-9c01-07321e4c9125',
		'95fb17b1-20ad-4e52-a8e6-459653d16bb6',
		'e76032f8-9fb4-457e-b15d-ecb1db332f2c',
		'4f577619-cfaa-4954-8e7c-17f7aa2e212c',
		'0d0df0bf-59b0-434f-9a34-6ae61d60f2c0',
		'04af4d40-ba0a-4cb6-a65b-82a513a0ff8b',
		'f3de57aa-33ac-4bda-82a3-a290934cff5f');