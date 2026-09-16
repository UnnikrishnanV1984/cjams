-- CDM-22514 Supervisor Approval
/*
-- Issue Description: 
   User request we need to pending approvals from Nikki Snider & Tammie Campher
   
-- Category/ Module:Approval Inbox (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Move Pending apporvals from 
-- Nikki Snider - nikki.snider@maryland.gov - a72ed886-4123-4088-8d2f-6394a37bc67c

-- Angela StClair - to Julia Jensen
-- * Angela StClair - angela.stclair@maryland.gov	- fda44521-a8bb-4f30-9fac-dcd8fa209f15
-- Julia Jensen - julia.jensen@maryland.gov - 80025a81-dad5-4345-80d1-f97bddb1dbbc

-- Rhonda Hall  -to  Alicia Snoots 
-- Rhonda Hall - rhonda.hall@maryland.gov - 33dae786-e862-4511-87b6-28a2d36bd30f
-- Alicia Snoots - alicia.snoots@maryland.gov - 6af7a326-0572-4e9c-9d19-e15e2949c5fe

-- Jessica Martin - to Kathleen Chaney 
-- * Jessica Martin	jessica.martin4@maryland.gov	0938566c-0284-4e13-9e20-5d098cf4a409
-- Kathleen Chaney	kathleen.chaney@maryland.gov	dd3ac302-59b9-4e32-ac55-94a0d551ee4f

-- Carolyn Moss  - to Megan Swindell 
-- Carolyn Moss	carrie.moss@maryland.gov	8bc1ab63-2969-4e65-9dea-937cb2b79bf3
-- Megan Swindell	megan.swindell@maryland.gov	de241831-88ae-4347-b704-345e8bef3fff

-- No pending approval for
-- Tammie Campher - tammie.campher1@maryland.gov - 734d9964-f7b3-43a7-b38e-808c1d851853
*/

-- Angela StClair - to Julia Jensen
-- * Angela StClair - angela.stclair@maryland.gov - fda44521-a8bb-4f30-9fac-dcd8fa209f15
-- Julia Jensen - julia.jensen@maryland.gov - 80025a81-dad5-4345-80d1-f97bddb1dbbc

select routingid, eventcode, fromsecurityusersid, tosecurityusersid, routeddescription, updatedby, updatedon 
	from routing 
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = 'fda44521-a8bb-4f30-9fac-dcd8fa209f15'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
  		
update routing 
set tosecurityusersid = '80025a81-dad5-4345-80d1-f97bddb1dbbc',
	updatedby = 'CDM-22514', 
	updatedon = now()
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = 'fda44521-a8bb-4f30-9fac-dcd8fa209f15'
	and activeflag = 1 
	and routingstatustypeid = 15 ;

-- Rhonda Hall  -to  Alicia Snoots 
-- Rhonda Hall - rhonda.hall@maryland.gov - 33dae786-e862-4511-87b6-28a2d36bd30f
-- Alicia Snoots - alicia.snoots@maryland.gov - 6af7a326-0572-4e9c-9d19-e15e2949c5fe

select routingid, eventcode, fromsecurityusersid, tosecurityusersid, routeddescription, updatedby, updatedon 
	from routing 
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = '33dae786-e862-4511-87b6-28a2d36bd30f'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
  		
update routing 
set tosecurityusersid = '6af7a326-0572-4e9c-9d19-e15e2949c5fe',
	updatedby = 'CDM-22514', 
	updatedon = now()
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = '33dae786-e862-4511-87b6-28a2d36bd30f'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
	
-- Jessica Martin - to Kathleen Chaney 
-- * Jessica Martin	jessica.martin4@maryland.gov	0938566c-0284-4e13-9e20-5d098cf4a409
-- Kathleen Chaney	kathleen.chaney@maryland.gov	dd3ac302-59b9-4e32-ac55-94a0d551ee4f

select routingid, eventcode, fromsecurityusersid, tosecurityusersid, routeddescription, updatedby, updatedon 
	from routing 
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = '0938566c-0284-4e13-9e20-5d098cf4a409'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
  		
update routing 
set tosecurityusersid = 'dd3ac302-59b9-4e32-ac55-94a0d551ee4f',
	updatedby = 'CDM-22514', 
	updatedon = now()
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = '0938566c-0284-4e13-9e20-5d098cf4a409'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
	
-- Carolyn Moss  - to Megan Swindell 
-- Carolyn Moss	carrie.moss@maryland.gov	8bc1ab63-2969-4e65-9dea-937cb2b79bf3
-- Megan Swindell	megan.swindell@maryland.gov	de241831-88ae-4347-b704-345e8bef3fff

select routingid, eventcode, fromsecurityusersid, tosecurityusersid, routeddescription, updatedby, updatedon 
	from routing 
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = '8bc1ab63-2969-4e65-9dea-937cb2b79bf3'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
  		
update routing 
set tosecurityusersid = 'de241831-88ae-4347-b704-345e8bef3fff',
	updatedby = 'CDM-22514', 
	updatedon = now()
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid = '8bc1ab63-2969-4e65-9dea-937cb2b79bf3'
	and activeflag = 1 
	and routingstatustypeid = 15 ;
	
-- Move all remaining to Julia Jensen (from Inactive users)
select routingid, eventcode, fromsecurityusersid, tosecurityusersid, routeddescription, updatedby, updatedon 
	from routing 
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid not in
		(	'8bc1ab63-2969-4e65-9dea-937cb2b79bf3',
			'0938566c-0284-4e13-9e20-5d098cf4a409',
			'33dae786-e862-4511-87b6-28a2d36bd30f',
			'fda44521-a8bb-4f30-9fac-dcd8fa209f15'
		)	
	and activeflag = 1 
	and routingstatustypeid = 15 ;
  		
update routing 
set tosecurityusersid = 'de241831-88ae-4347-b704-345e8bef3fff',
	updatedby = 'CDM-22514', 
	updatedon = now()
where tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c'
	and fromsecurityusersid not in
		(	'8bc1ab63-2969-4e65-9dea-937cb2b79bf3',
			'0938566c-0284-4e13-9e20-5d098cf4a409',
			'33dae786-e862-4511-87b6-28a2d36bd30f',
			'fda44521-a8bb-4f30-9fac-dcd8fa209f15'
		)	

	and activeflag = 1 
	and routingstatustypeid = 15 ;
	
/*
To revert if needed
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'f9ee1a50-b172-4913-a82d-c3d8660dc0cb', updatedon = '2020-07-27 09:26:42.876266' where routingid = '81077190-5f2f-4b0e-87df-29f4e2293ea2' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '8bc1ab63-2969-4e65-9dea-937cb2b79bf3', updatedon = '2020-02-13 09:21:22.725651' where routingid = 'f4823c39-c9aa-4cc4-a342-304add053a82' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'faaf72bc-5da7-4caf-9413-7db22babe7af', updatedon = '2020-02-20 09:06:12.870799' where routingid = 'cf45981b-9585-4831-8bcc-edb86d8b3de7' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '33dae786-e862-4511-87b6-28a2d36bd30f', updatedon = '2020-04-21 08:43:34.425133' where routingid = '1bdbf714-a9f1-4b96-8425-08b57c858a52' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'f9ee1a50-b172-4913-a82d-c3d8660dc0cb', updatedon = '2020-02-20 14:30:40.412687' where routingid = 'ba7c0849-c5d9-49da-a06e-6156f6bcc3a8' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'faaf72bc-5da7-4caf-9413-7db22babe7af', updatedon = '2020-02-25 16:26:45.067017' where routingid = '49d6bea9-b19a-4369-9391-747d7706d958' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'f9ee1a50-b172-4913-a82d-c3d8660dc0cb', updatedon = '2020-01-07 10:14:28.402069' where routingid = 'fcb3996c-957f-41e3-8761-3a0a44cd8c90' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'f9ee1a50-b172-4913-a82d-c3d8660dc0cb', updatedon = '2020-01-07 14:41:49.804712' where routingid = '639b5ca1-1753-42a2-8fcc-18e813ed30dc' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '8bc1ab63-2969-4e65-9dea-937cb2b79bf3', updatedon = '2019-11-14 10:28:49.368512' where routingid = '52ebec95-9531-41bf-a246-fc0fe99640c1' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '33dae786-e862-4511-87b6-28a2d36bd30f', updatedon = '2019-11-26 09:20:16.978706' where routingid = '136a0f28-3bb6-4d95-8444-0c85f9a8f9ae' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'f9ee1a50-b172-4913-a82d-c3d8660dc0cb', updatedon = '2019-11-21 16:08:43.309958' where routingid = 'c4b14d4e-8a5b-4632-9f32-14bf1174af08' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'faaf72bc-5da7-4caf-9413-7db22babe7af', updatedon = '2019-11-27 13:59:01.60735' where routingid = '906e685b-325a-4d3b-a1c4-2fc54a27e528' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '8bc1ab63-2969-4e65-9dea-937cb2b79bf3', updatedon = '2020-02-10 12:52:24.454416' where routingid = '33326b83-9017-4aee-bfeb-054edf42019e' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '33dae786-e862-4511-87b6-28a2d36bd30f', updatedon = '2020-03-04 16:13:21.288452' where routingid = '1dbabd33-8f5a-4708-af68-1b73fd6fe0e5' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '14fc44c9-c74d-4753-b2e4-36380b7ce236', updatedon = '2020-03-11 15:00:14.542253' where routingid = '1d5d6e81-4fd6-4ae5-8244-1c427e493d0d' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '33dae786-e862-4511-87b6-28a2d36bd30f', updatedon = '2021-04-05 15:33:57.906038' where routingid = 'd8b134ab-0398-4378-8f15-f126bb169d61' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = '0938566c-0284-4e13-9e20-5d098cf4a409', updatedon = '2021-12-13 12:54:25.584098' where routingid = 'e79cffac-f809-46ff-836c-2c6daf85fe3f' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'fda44521-a8bb-4f30-9fac-dcd8fa209f15', updatedon = '2022-02-02 14:08:18.947499' where routingid = '5aeac2fa-71f2-4d30-94ba-40e9393c7137' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'fda44521-a8bb-4f30-9fac-dcd8fa209f15', updatedon = '2022-05-11 09:53:50.644666' where routingid = 'de8ae935-8b85-4ade-b044-9480d2a96afd' and activeflag = 1 ;
update routing set  tosecurityusersid = 'a72ed886-4123-4088-8d2f-6394a37bc67c', updatedby = 'fda44521-a8bb-4f30-9fac-dcd8fa209f15', updatedon = '2022-05-11 11:43:37.613518' where routingid = '6715b8a7-4dcc-41f8-8d9b-bc3332cbdca8' and activeflag = 1 ;
*/