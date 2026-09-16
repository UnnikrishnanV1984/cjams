-- MDM Person Data Issue Fix 
/*
1) cjamspid: 200650016 - New MDM ID: MDT-128820712 (Old: MDT-128964097) - CIS Client ID: 403024656 - no changes
2) cjamspid: 200661481 - New MDM ID: MDT-128997768 (Old: MDT-123605204) - CIS Client ID: 415012356 - no changes
3) cjamspid: 200640620 - New MDM ID: MDT-129069029 (Old: MDT-128846550) - CIS Client ID: 401015136 - no changes
4) cjamspid: 200311305 - New MDM ID: MDT-129122826 (Old: MDT-124514514) - CIS Client ID: 433034987 - no changes
5) cjamspid: 200657889 - New MDM ID: MDT-129138614 (Old: MDT-129229647) - CIS Client ID: 408043478 - no changes
6) cjamspid: 200310306 - New MDM ID: MDT-129301027 (Old: MDT-123479204) - CIS Client ID: 412051415 - no changes
7) cjamspid: 200303590 - New MDM ID: MDT-129336515 (Old: MDT-124300789) - CIS Client ID: 429028820 - no changes
8) cjamspid: 200304480 - New MDM ID: MDT-123560243 (Old: MDT-128871195) - CIS Client ID: 401016779 - no changes
9) cjamspid: 200139280 - New MDM ID: MDT-123663824 (Old: MDT-126760511) - CIS Client ID: 479028026 - no changes
10) cjamspid: 200645980 - New MDM ID: MDT-123763873 (Old: MDT-123948517) - CIS Client ID: 422042020 - no changes
11) cjamspid: 200305557 - New MDM ID: MDT-124013470 (Old: MDT-129108260) - CIS Client ID: 406024962 - no changes
12) cjamspid: 200655612 - New MDM ID: MDT-123996655 (Old: MDT-128418149) - CIS Client ID: 15214338 - no changes
13) cjamspid: 200305213 - New MDM ID: MDT-124055092 (Old: MDT-123794690) - CIS Client ID: 418039735 - no changes
14) cjamspid: 200659607 - New MDM ID: MDT-124233962 (Old: MDT-128975286) - CIS Client ID: 403037003 - no changes
15) cjamspid: 200661233 - New MDM ID: MDT-124381267 (Old: MDT-128817814) - CIS Client ID: 400639203 - no changes
16) cjamspid: 200649906 - New MDM ID: MDT-124434999 (Old: MDT-129101209) - CIS Client ID: 405052976 - no changes
17) cjamspid: 200300875 - New MDM ID: MDT-124511514 (Old: MDT-128166837) - CIS Client ID: 15325996 - no changes
18) cjamspid: 200646192 - New MDM ID: MDT-124572735 (Old: MDT-123901730) - CIS Client ID: 421017861 - no changes
19) cjamspid: 200655640 - New MDM ID: MDT-124654272 (Old: MDT-128908737) - CIS Client ID: 401038175 - no changes
20) cjamspid: 200639955 - New MDM ID: MDT-124898707 (Old: MDT-128879517) - CIS Client ID: 401046063 - no changes
21) cjamspid: 200019697 - New MDM ID: MDT-124944133 (Old: MDT-128903353) - CIS Client ID: 401037921 - no changes
22) cjamspid: 200301761 - New MDM ID: MDT-124946360 (Old: MDT-123532802) - CIS Client ID: 414017219 - no changes
23) cjamspid: 200658781 - New MDM ID: MDT-125132078 (Old: MDT-128796704) - CIS Client ID: 400634867 - no changes
24) cjamspid: 200647440 - New MDM ID: MDT-125320524 (Old: MDT-128955573) - CIS Client ID: 403026644 - no changes
25) cjamspid: 200661000 - New MDM ID: MDT-125390959 (Old: MDT-128997444) - CIS Client ID: 403040952 - no changes
*/

-- 1) cjamspid: 200650016
-- New MDM ID: MDT-128820712 (Old: MDT-128964097) 
-- CIS Client ID: 403024656 -  no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = 'f16feee0-910a-4ac3-9c1e-b400a989e4db'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-128820712',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = 'f16feee0-910a-4ac3-9c1e-b400a989e4db'
	and activeflag  = 1 ;

-- 2) cjamspid: 200661481
-- New MDM ID: MDT-128997768 (Old: MDT-123605204) 
-- CIS Client ID: - 415012356 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '5a3cf8eb-c36e-4576-8357-a5bff335e698'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-128997768',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '5a3cf8eb-c36e-4576-8357-a5bff335e698'
	and activeflag  = 1 ;

-- 3) cjamspid: 200640620
-- New MDM ID: MDT-129069029 (Old: MDT-128846550) 
-- CIS Client ID: - 401015136  no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '510eb314-2a66-490c-8bb5-608734dae913'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-129069029',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '510eb314-2a66-490c-8bb5-608734dae913'
	and activeflag  = 1 ;

-- 4) cjamspid: 200311305
-- New MDM ID: MDT-129122826 (Old: MDT-124514514) 
-- CIS Client ID: - 433034987 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = 'ba12e22c-ab1e-4542-91ac-9db96e1f626e'	
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-129122826',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = 'ba12e22c-ab1e-4542-91ac-9db96e1f626e'	
	and activeflag  = 1 ;

-- 5) cjamspid: 200657889
-- New MDM ID: MDT-129138614 (Old: MDT-129229647) 
-- CIS Client ID: - 408043478 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '831f56c4-a4f2-42ba-8b81-28f5ec89d0e9'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-129138614',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '831f56c4-a4f2-42ba-8b81-28f5ec89d0e9'
	and activeflag  = 1 ;

-- 6) cjamspid: 200310306
-- New MDM ID: MDT-129301027 (Old: MDT-123479204) 
-- CIS Client ID: - 412051415 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '0a105554-347c-4e93-b068-a954819bf695' 
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-129301027',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '0a105554-347c-4e93-b068-a954819bf695'
	and activeflag  = 1 ;

-- 7) cjamspid: 200303590
-- New MDM ID: MDT-129336515 (Old: MDT-124300789) 
-- CIS Client ID: - 429028820 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '7d4d8a02-fb45-45d4-a3ae-adc18eaf4880'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-129336515',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '7d4d8a02-fb45-45d4-a3ae-adc18eaf4880'
	and activeflag  = 1 ;

-- 8) cjamspid: 200304480
-- New MDM ID: MDT-123560243 (Old: MDT-128871195) 
-- CIS Client ID: - 401016779 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = 'f04de8d7-fa19-44fe-9bcb-9a9d8c06fc4e'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-123560243',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = 'f04de8d7-fa19-44fe-9bcb-9a9d8c06fc4e'
	and activeflag  = 1 ;

-- 9) cjamspid: 200139280
-- New MDM ID: MDT-123663824 (Old: MDT-126760511) 
-- CIS Client ID: - 479028026 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = 'c16f5971-9c25-4dd6-8237-17f077b97ca5'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-123663824',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = 'c16f5971-9c25-4dd6-8237-17f077b97ca5'
	and activeflag  = 1 ;

-- 10) cjamspid: 200645980
-- New MDM ID: MDT-123763873  (Old: MDT-123948517) 
-- CIS Client ID: - 422042020 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '70d42534-484c-4fd2-9983-baeff3dbef36'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-123763873',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '70d42534-484c-4fd2-9983-baeff3dbef36'
	and activeflag  = 1 ;

-- 11) cjamspid: 200305557
-- New MDM ID: MDT-124013470 (Old: MDT-129108260) 
-- CIS Client ID: - 406024962 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '46b1b7e0-853b-4321-97c7-36fca3c6037e'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124013470',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '46b1b7e0-853b-4321-97c7-36fca3c6037e'
	and activeflag  = 1 ;

-- 12) cjamspid: 200655612
-- New MDM ID: MDT-123996655 (Old: MDT-128418149) 
-- CIS Client ID: - 15214338 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '2f0f59dc-9a14-4e42-ab18-c360cf72e62e'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-123996655',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '2f0f59dc-9a14-4e42-ab18-c360cf72e62e'
	and activeflag  = 1 ;

-- 13) cjamspid: 200305213
-- New MDM ID: MDT-124055092 (Old: MDT-123794690) 
-- CIS Client ID: - 418039735 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '8c271aae-06ae-4ae0-991a-4e9eef01ac00'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124055092',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '8c271aae-06ae-4ae0-991a-4e9eef01ac00'
	and activeflag  = 1 ;

-- 14) cjamspid: 200659607
-- New MDM ID: MDT-124233962 (Old: MDT-128975286) 
-- CIS Client ID: - 403037003 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '8f4fd4c0-1596-468c-afaa-ecb53e020222'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124233962',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '8f4fd4c0-1596-468c-afaa-ecb53e020222'
	and activeflag  = 1 ;

-- 15) cjamspid: 200661233
-- New MDM ID: MDT-124381267 (Old: MDT-128817814) 
-- CIS Client ID: - 400639203 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '549a4d30-9b00-446c-9053-4c7acf5ccd11'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124381267',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '549a4d30-9b00-446c-9053-4c7acf5ccd11'
	and activeflag  = 1 ;

-- 16) cjamspid: 200649906
-- New MDM ID: MDT-124434999 (Old: MDT-129101209) 
-- CIS Client ID: - 405052976 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '3d5ffec2-444d-4c62-9149-d7a679c3e668'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124434999',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '3d5ffec2-444d-4c62-9149-d7a679c3e668'
	and activeflag  = 1 ;

-- 17) cjamspid: 200300875
-- New MDM ID: MDT-124511514 (Old: MDT-128166837) 
-- CIS Client ID: - 15325996 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '867e7ef5-40e3-4833-bd15-961fc3ff8e72'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124511514',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '867e7ef5-40e3-4833-bd15-961fc3ff8e72'
	and activeflag  = 1 ;

-- 18) cjamspid: 200646192
-- New MDM ID: MDT-124572735 (Old: MDT-123901730) 
-- CIS Client ID: - 421017861 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '2568ac26-21c7-43df-a48d-0d47dda6f935'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124572735',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '2568ac26-21c7-43df-a48d-0d47dda6f935'
	and activeflag  = 1 ;


-- 19) cjamspid: 200655640
-- New MDM ID: MDT-124654272 (Old: MDT-128908737) 
-- CIS Client ID: - 401038175 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = 'b9725a13-5395-42a2-ac2f-bbbac5323bb2'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124654272',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = 'b9725a13-5395-42a2-ac2f-bbbac5323bb2'
	and activeflag  = 1 ;


-- 20) cjamspid: 200639955
-- New MDM ID: MDT-124898707 (Old: MDT-128879517) 
-- CIS Client ID: - 401046063 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = 'f6337e25-15af-4521-aadf-d212733d6f80'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124898707',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = 'f6337e25-15af-4521-aadf-d212733d6f80'
	and activeflag  = 1 ;

-- 21) cjamspid: 200019697
-- New MDM ID: MDT-124944133 (Old: MDT-128903353) 
-- CIS Client ID: - 401037921 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = 'cc5865e1-aa6a-4a7a-8fc9-05c22e474bc8'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124944133',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = 'cc5865e1-aa6a-4a7a-8fc9-05c22e474bc8'
	and activeflag  = 1 ;

-- 22) cjamspid: 200301761
-- New MDM ID: MDT-124946360 (Old: MDT-123532802) 
-- CIS Client ID: - 414017219 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '67c69ce4-47db-4f64-8613-41b5f6e62c48'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-124946360',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '67c69ce4-47db-4f64-8613-41b5f6e62c48'
	and activeflag  = 1 ;

-- 23) cjamspid: 200658781
-- New MDM ID: MDT-125132078 (Old: MDT-128796704) 
-- CIS Client ID: - 400634867 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '73256480-3e5d-4644-b0bf-8b02990de6cf'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-125132078',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '73256480-3e5d-4644-b0bf-8b02990de6cf'
	and activeflag  = 1 ;


-- 24) cjamspid: 200647440
-- New MDM ID: MDT-125320524 (Old: MDT-128955573)
-- CIS Client ID: - 403026644 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '7925b0bb-e044-4ac3-a16a-8afe3575dbc9'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-125320524',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '7925b0bb-e044-4ac3-a16a-8afe3575dbc9'
	and activeflag  = 1 ;

-- 25) cjamspid: 200661000
-- New MDM ID: MDT-125390959 (Old: MDT-128997444)
-- CIS Client ID: - 403040952 no changes

-- Update MDM ID
select personid, personidentifiertypekey, personidentifiervalue, updatedby, updatedon 
	from personidentifier 
where personidentifierid = '90063e8a-73e6-45e7-8391-c476b554637a'
	and activeflag  = 1 ;

update personidentifier
set personidentifiervalue = 'MDT-125390959',
	updatedby = 'MDM Merge issue', 
	updatedon = now()
where personidentifierid = '90063e8a-73e6-45e7-8391-c476b554637a'
	and activeflag  = 1 ;

