-- CDM-17450 - Maltreatment allegation issues
/*
-- Issue Description: 
	Showing Sexual Abuse in Maltreatment and Investigation screen. 
	But the SDM don't have a Sexual Abuse.

	CPS-IR			County	
	---------------------------
	211020132688	Baltimore City
	211020128987	Baltimore City
	211020129200	Baltimore City
	211020133254	Baltimore County
	211020129806	Cecil
	211020135035	Cecil
	211020131174	Cecil
	211020118073	Montgomery
	211020140317	Prince George's
	211020134596	Prince George's
	211020135461	Prince George's
	211020129973	Prince George's
	211020138354	Prince George's
	211020132140	Washington
	211020132005	N/A				(CDM-17387)
	211020140074	Queen Anne's	(CDM-17384)

-- Category/ Module: CPS-IR  (Investigation Management) 
-- Root cause: This error occurred due to the wrong datafix was promoted with CDM-14707 
	           for the allegation table. That fix was reverted on 10/04 evening. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- e11fc4b5-1edf-4f17-af54-b536bbf6df31 - Neglect	   (New)
-- 19233c90-707c-482c-93c8-b33738685fc6 - Sexual Abuse (Current)

-- 211020132688
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid = 'a5a641a1-2359-420f-a932-63b5ebd9fb76' 
	and activeflag = 1 ;

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid = 'a5a641a1-2359-420f-a932-63b5ebd9fb76' 
	and activeflag = 1 ;

-- 211020128987
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
	in ( 	'8639da24-6300-4739-8c14-e5fb16027451',
			'c653e701-84c0-4cc8-809d-7f8563cdeccd'
		)	
	and activeflag = 1; 

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
	in ( 	'8639da24-6300-4739-8c14-e5fb16027451',
			'c653e701-84c0-4cc8-809d-7f8563cdeccd'
		)	
	and activeflag = 1; 

-- 211020129200
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
		in (	'710c915b-4de3-40e8-9480-79357aa684e1',
				'9fa20919-f7ae-4f27-b5b5-fb109f8e849b'
			)	
	and activeflag = 1;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
		in (	'710c915b-4de3-40e8-9480-79357aa684e1',
				'9fa20919-f7ae-4f27-b5b5-fb109f8e849b'
			)	
	and activeflag = 1;	

-- 211020133254
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
	in (	'490797f1-7ad7-4924-991b-7cc9755eb3e4',
			'a7678939-c956-43db-be76-99ba1bb32039'
		)
	and activeflag = 1 ;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
	in (	'490797f1-7ad7-4924-991b-7cc9755eb3e4',
			'a7678939-c956-43db-be76-99ba1bb32039'
		)
	and activeflag = 1 ;
	

-- 211020129806
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
		in ( 	'3db0dcea-fd00-4d42-96b1-502680b62379',
				'47f51822-e405-4971-bc20-afa82533f4e4',
				'811b2b47-e804-44c4-a024-93601de21bd9',
				'83dd9fe2-950c-4ebb-85dc-9802f61af2a8',
				'e090c211-a753-4225-9d93-33d366a77416',
				'eb4fb30a-b82b-486a-a89d-6ac95a937850',
				'f2188bb8-9bab-4a41-95d9-ca168eb6e8f2',
				'fcb898d7-63ea-4d34-8b18-2fce53bbc6d8'
			)
	and activeflag = 1 ;

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
		in ( 	'3db0dcea-fd00-4d42-96b1-502680b62379',
				'47f51822-e405-4971-bc20-afa82533f4e4',
				'811b2b47-e804-44c4-a024-93601de21bd9',
				'83dd9fe2-950c-4ebb-85dc-9802f61af2a8',
				'e090c211-a753-4225-9d93-33d366a77416',
				'eb4fb30a-b82b-486a-a89d-6ac95a937850',
				'f2188bb8-9bab-4a41-95d9-ca168eb6e8f2',
				'fcb898d7-63ea-4d34-8b18-2fce53bbc6d8'
			)
	and activeflag = 1 ;

-- 211020135035
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid
		in ( 	'206eb564-4f93-428b-9a2f-9681a66040a2',
				'2157f57b-2055-4aca-b8d0-53f2b4b513dc',
				'90841ed7-a5b4-4fb0-97d8-a3240bfeece3',
				'e54221a6-8e14-4918-8c0d-4a5b44df41d0'
			)
	and activeflag = 1 ;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid
		in ( 	'206eb564-4f93-428b-9a2f-9681a66040a2',
				'2157f57b-2055-4aca-b8d0-53f2b4b513dc',
				'90841ed7-a5b4-4fb0-97d8-a3240bfeece3',
				'e54221a6-8e14-4918-8c0d-4a5b44df41d0'
			)
	and activeflag = 1 ;


-- 211020131174
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
	in ( 	'481d33fc-a703-435f-951e-3e168f6411bd',
			'ac804395-42e6-4c69-b3c4-4d2c88ee8f3e'
		)	
	and activeflag = 1 ; 	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
	in ( 	'481d33fc-a703-435f-951e-3e168f6411bd',
			'ac804395-42e6-4c69-b3c4-4d2c88ee8f3e'
		)	
	and activeflag = 1 ; 	


-- 211020118073
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
	in (	'0253ca6d-1413-4f29-97a7-d292eb7bfb01',
			'a7f5a1a5-5eff-4e56-afce-efc6497931e8'	
		)
	and activeflag = 1 ;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
	in (	'0253ca6d-1413-4f29-97a7-d292eb7bfb01',
			'a7f5a1a5-5eff-4e56-afce-efc6497931e8'	
		)
	and activeflag = 1 ;


-- 211020140317 
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid = '0c0e1564-2f24-44bc-af77-7be3d4619c90' 
	and activeflag = 1 ; 	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid = '0c0e1564-2f24-44bc-af77-7be3d4619c90' 
	and activeflag = 1 ;	


-- 211020134596
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
	in (	'6f18418f-91ae-4400-9f70-0e7961f5098f',
			'a8126ab9-0d98-4128-95a1-50e8744c4796'
		)	
 	and activeflag = 1 ;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
	in (	'6f18418f-91ae-4400-9f70-0e7961f5098f',
			'a8126ab9-0d98-4128-95a1-50e8744c4796'
		)
	and activeflag = 1 ;	



-- 211020135461
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
	in (	'1f7f2583-6659-4336-ba73-fa45c474fe88',
			'44315bc6-1e06-422a-815d-4f8a1ae05dcd',
			'4c75f71d-5865-4fde-8083-0946a7431f8e',
			'a1db2292-8d20-4e48-93d1-2eab990587c1',
			'b1bc1716-4c59-45a9-9117-402f2f60fd36'
		)	
	and activeflag = 1 ;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
	in (	'1f7f2583-6659-4336-ba73-fa45c474fe88',
			'44315bc6-1e06-422a-815d-4f8a1ae05dcd',
			'4c75f71d-5865-4fde-8083-0946a7431f8e',
			'a1db2292-8d20-4e48-93d1-2eab990587c1',
			'b1bc1716-4c59-45a9-9117-402f2f60fd36'
		)	
	and activeflag = 1 ;

-- 211020129973
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid = '5c499eff-c742-45b7-81ca-9bb9b35e3a3e' 
	and activeflag = 1;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid = '5c499eff-c742-45b7-81ca-9bb9b35e3a3e' 
	and activeflag = 1 ;	


-- 211020138354
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid 
	in (	'434d56ed-91e2-479c-be46-c611a215e5bc',
			'500ceb08-7b33-4df7-948e-4f71f74c3c35',
			'c8f347db-43d4-4339-9f13-76a2e8a0351e' 
		)	
	and activeflag = 1 ;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid 
	in (	'500ceb08-7b33-4df7-948e-4f71f74c3c35',
			'c8f347db-43d4-4339-9f13-76a2e8a0351e' 
		)	
	and activeflag = 1 ;

update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid = '434d56ed-91e2-479c-be46-c611a215e5bc'
	and activeflag = 1 ;


-- 211020132140
select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid = 'db5e6c8e-ada8-40bf-bae3-19de386eda37' 
	and activeflag = 1;	

	   
update investigationallegation
set allegationid = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31',
	activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid = 'db5e6c8e-ada8-40bf-bae3-19de386eda37' 
	and activeflag = 1;	


select investigationallegationid, allegationid, "name", updatedby, updatedon, activeflag
   from investigationallegation
where investigationallegationid = '8afb334b-585f-4f33-a551-30f85052b573' 
	and activeflag = 1;	

update investigationallegation
set activeflag = 0,
	updatedby = 'CDM-17450',
	updatedon = now()		
where investigationallegationid = '8afb334b-585f-4f33-a551-30f85052b573' 
	and activeflag = 1;	
