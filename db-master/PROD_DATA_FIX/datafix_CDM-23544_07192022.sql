-- CDM-23544 - Subsidy Payments
/*
-- Issue Description: 
   Private adoption subsidy initiated and subsidy rate entered and approved on 6/30/22 
   but no payments have been created.
   
-- Case ID: 3261944 
-- Adoption ID: 45066 - 2015-11-19 To 2025-04-20 - c073ba98-a053-4ec0-b100-91485e950790
-- Client ID: 3893585 (LILLY LASHAWN MONROE-PARKER) - 73037579-490d-4ccc-8395-854a368967e1
-- Provider ID: 5055808	(Christel Parker)- Local Department Home

-- Starting 04/21/2022 
-- Provider ID: 5007408	(Kelly White)- Local Department Home

-- Category/ Module: Adoption (Case Management) 
-- Root cause: TDB (Need more analysis to find out who changed the provider on this case?) 
-- Pull request# TBD 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Update alternateid (adoption_id) used for Payment generation tb_adoption
select adoptioncasenumber, alternateid, updatedby, updatedon 
	from adoptioncase 
where adoptioncasenumber in ( 2020014201261, 221040016043, 221040016044 )
	and activeflag = 1 ;

update adoptioncase 
set alternateid = nextval('sequence_adoptionplanning'::regclass), 
	updatedby = 'CDM-23544',
	updatedon = now()
where adoptioncasenumber in ( 2020014201261, 221040016043, 221040016044 )
	and activeflag = 1 ;
	
-- Update alternateid (subsidy_agreement_id) used for Payment generation tb_adoption_subsidy_agreement
select alternateid, adoptioncaseid, updatedby, updatedon
	from adoptioncaseagreement
where activeflag = 1
	and adoptioncaseid 
		in ( 'b3c34789-9e45-446b-a6d1-d82b7faa1ed6', -- 2020014201261 (No Adoption Agreement)
			 'a7e06c31-a1a1-4d7b-860a-edf48b56692b', -- 221040016043
			 '443aa341-c66e-43c4-96be-5901cbacd977' -- 221040016044
			);

update adoptioncaseagreement			
set alternateid	= nextval('sequence_adoptionagreement'::regclass),
	updatedby = 'CDM-23544',
	updatedon = now()
where activeflag = 1
	and adoptioncaseid 
		in ( 'b3c34789-9e45-446b-a6d1-d82b7faa1ed6', -- 2020014201261 (No Adoption Agreement)
			 'a7e06c31-a1a1-4d7b-860a-edf48b56692b', -- 221040016043
			 '443aa341-c66e-43c4-96be-5901cbacd977' -- 221040016044
			);	
	
-- To Trigger Under/Over 
select adoptionagreementid, startdate, enddate, updatedby, updatedon 
	from adoptioncaseagreementrate
where activeflag = 1 
	 and adoptionagreementid 
		in (select adoptionagreementid
				from adoptioncaseagreement
			where adoptioncaseid 
				in ( 'b3c34789-9e45-446b-a6d1-d82b7faa1ed6', -- 2020014201261 (No Adoption Agreement)
					 'a7e06c31-a1a1-4d7b-860a-edf48b56692b', -- 221040016043
					 '443aa341-c66e-43c4-96be-5901cbacd977' -- 221040016044
					)
			) ;		
	
update adoptioncaseagreementrate
set updatedon = now(), 
	updatedby = 'CDM-23544'
where activeflag = 1 
	 and adoptionagreementid 
		in (select adoptionagreementid
				from adoptioncaseagreement
			where adoptioncaseid 
				in ( 'b3c34789-9e45-446b-a6d1-d82b7faa1ed6', -- 2020014201261 (No Adoption Agreement)
					 'a7e06c31-a1a1-4d7b-860a-edf48b56692b', -- 221040016043
					 '443aa341-c66e-43c4-96be-5901cbacd977' -- 221040016044
					)
			) ;
