-- CDM-8542 - Missing Adoption case
/*
-- Issue Description: 
   To create missing placement validation (placement_id = 1559969 )
	  
-- Category/ Module: Placement (Case Management)
-- Root cause: SP was not having logic to process placements with entry date as prior month last day
-- Pull request# Tanmay will check the modified SP sp_placement_validation_datafix
-- Reason why no related code fix: TBD
-- Status of the code fix if already submitted and expected prod fix date: Will be part of the next build
*/

-- Before 
select count(*) from tb_placement_validation where placement_id = 1559969 and delete_sw = 'N' ;

-- SP Call
select al_sqlcode, as_mess 
from cjams.sp_placement_validation_datafix('2021-01-04'::date, '2021-01-04'::date, 'financeDFx');


-- After
select count(*) from tb_placement_validation where placement_id = 1559969 and delete_sw = 'N' ;
