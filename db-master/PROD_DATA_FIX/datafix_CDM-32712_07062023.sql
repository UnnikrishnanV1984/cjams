-- CDM-32712 - Inaccurate maltreator
/*
-- Issue Description: 
	CPS IR case with one of the children is listed as the alleged maltreator

-- CPS-IR: 231020483180 - 3ab194b0-1530-4254-a602-26e89e24d24a
-- Client ID: 4453181 (DEZIRE LITTLEJOHN) -	e218c8b2-188a-4c72-abc4-ebc8e39af84c

-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: User Error (Child was identified as alleged maltreater incorrectly)
-- Fix Provided: Datafix has been promoted to remove the wrong Investigation Finding record where DEZIRE LITTLEJOHN is a maltreater.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To remove the wrong Investigation Finding (CDM-32712)
select activeflag, updatedby, updatedon
	from investigationmaltreatment
where maltreatmentid = '77e0c593-997c-4519-a6a3-10e77030a1eb'
	and activeflag = 1 ;
	
update investigationmaltreatment
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-32712'	
where maltreatmentid = '77e0c593-997c-4519-a6a3-10e77030a1eb'
	and activeflag = 1 ;

select activeflag, updatedby, updatedon 
	from investigationallegation
where investigationallegationid = 'c5b5dc8a-c4c3-4e12-93b1-3d6dc68d6084'
	and activeflag = 1 ;
	
update investigationallegation
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-32712'	
where investigationallegationid = 'c5b5dc8a-c4c3-4e12-93b1-3d6dc68d6084'
	and activeflag = 1 ;

select activeflag, updatedby, updatedon
	from investigationfinding
where investigationallegationid = 'c5b5dc8a-c4c3-4e12-93b1-3d6dc68d6084'
	and activeflag = 1 ;

update investigationfinding
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-32712'	
where investigationallegationid = 'c5b5dc8a-c4c3-4e12-93b1-3d6dc68d6084'
	and activeflag = 1 ;
	
select activeflag, updatedby, updatedon 
	from investigationallegationmaltreators
where investigationallegationid = 'c5b5dc8a-c4c3-4e12-93b1-3d6dc68d6084'
	and activeflag = 1 ;

update investigationallegationmaltreators
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-32712'	
where investigationallegationid = 'c5b5dc8a-c4c3-4e12-93b1-3d6dc68d6084'
	and activeflag = 1 ;
