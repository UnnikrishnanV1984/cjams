-- CDM-16108 - Duplicate Subsidy rate
/*
-- Issue Description: 
    There are two subsidy rate entered into the system. 
	Please delete one so that it does not cause two payments to be sent out. 
	The rate period is 10/1/21-9/30/22.
   
-- Case ID: 3190456
-- Adoption ID: 27269 - 2010-09-03 To 2025-04-16 - 327f7ec7-3e73-4726-a08f-15a8bdc50eae


-- Category/ Module: Adoption Subsidy (Adoption Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete duplicate rate slab
select adoptionrevisionid, startdate, enddate, paymentamout, status, activeflag, updatedby, updatedon 
	from adoptioncaserevision  
where adoptionagreementid = '351e15c7-ea19-490b-9714-ab445698d7d0' 
	and adoptionrevisionid in ( 'f2d57a5d-1a99-42bf-9bba-efdc6f578395', '81051966-275f-4372-85d5-5b58448b2890' )
	and activeflag = 1 ;

update adoptioncaserevision  
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-16108'
where adoptionagreementid = '351e15c7-ea19-490b-9714-ab445698d7d0' 
	and adoptionrevisionid in ( 'f2d57a5d-1a99-42bf-9bba-efdc6f578395', '81051966-275f-4372-85d5-5b58448b2890' )
	and activeflag = 1 ;
	

select startdate, enddate, activeflag, updatedby, updatedon 
	from adoptioncaseagreementrate 
where adoptionagreementid = '351e15c7-ea19-490b-9714-ab445698d7d0'
	and adoptionagreementrateid  = 'ef694830-a72f-4785-a121-1526925b3dc9'
	and activeflag = 1 ;

update adoptioncaseagreementrate  
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-16108'
where adoptionagreementid = '351e15c7-ea19-490b-9714-ab445698d7d0'
	and adoptionagreementrateid = 'ef694830-a72f-4785-a121-1526925b3dc9'
	and activeflag = 1 ;

select routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing r 
where objectid = 'ef694830-a72f-4785-a121-1526925b3dc9'
	and eventcode = 'AARR'
	and activeflag = 1 ;

update routing  
set activeflag = 0, 
	updatedon = now(), 
	updatedby = 'CDM-16108'
where objectid = 'ef694830-a72f-4785-a121-1526925b3dc9'
	and eventcode = 'AARR'
	and activeflag = 1 ;
