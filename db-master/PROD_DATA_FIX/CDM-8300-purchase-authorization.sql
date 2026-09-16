update userprofile set supervisorid = '95558df3-ac2c-47ad-93e4-c30889c8c8c9', updatedon = now(), updatedby = 'CDM-8300' WHERE securityusersid in 
('cf88e78d-cca1-474a-a886-eb6603828dfc',
'936d2d5a-5f1c-412c-905a-a30d70a3c330',
'7f7a58e2-4847-4642-801a-f0b2a7c37cfa',
'd0d8ef63-c0e3-4e1c-8d3b-f37b486d03c9',
'539c9e75-4f92-45e3-818e-775a3e8d88a7',
'7b2c26d6-96a0-42be-bb7a-ad6e8809598c') AND activeflag=1;