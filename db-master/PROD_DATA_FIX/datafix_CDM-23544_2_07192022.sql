-- CDM-23544 - Subsidy Payments
/*
-- Issue Description: 
   Private adoption subsidy initiated and subsidy rate entered and approved on 6/30/22 
   but no payments have been created.
   
-- Adoption Case ID: 221040016044
-- Client ID: 200908652  (Avalynn Stevens) 

-- Adoption Case ID: 221040016043
-- Client ID: 200908677  (Coralynn Stevens)

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TBD
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update Start Dates 2022-04-25 00:00:00	2038-12-22 00:00:00
select adoptioncasenumber, alternateid, startdate, enddate, updatedby, updatedon
	from adoptioncase 
where adoptioncasenumber in ( 221040016043, 221040016044 )
	and activeflag = 1 ;

update adoptioncase 
set startdate = '2022-04-25 00:00:00', 
	updatedby = 'CDM-23544_1',
	updatedon = now()
where adoptioncasenumber in ( 221040016043, 221040016044 )
	and activeflag = 1 ;
	
