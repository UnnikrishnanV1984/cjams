-- CDM-13108
update serviceplan set serviceplancandidacy = '{"candidates": [{"id": "2065622", "name": "ANTHONY MOORE", "candidacy": "0"}]}', updatedby = 'CDM-13108',updatedon = now() 
where objectid = '67ba0cbb-fb90-4963-b969-f8bbfc7953ca' and activeflag = 1 and serviceplancandidacy is null;

-- CDM-13093
update serviceplan set serviceplancandidacy = '{"candidates": [{"id": "4454727", "name": "ZOEY CAREATHERS", "candidacy": "1"}]}',
updatedby = 'CDM-13093',updatedon = now() 
where serviceplanid = 'aad1e01e-3c3a-4417-9f4e-64b54fb88aa5' and activeflag = 1;