-- CDM-37780 - Subsidy Renewal
/*
 -- Issue Description: Subsidy rate has been submitted by Melissa Charnock (melissa.charnock@maryland.gov) on 11/29/2023. 
                       The subsidy rate review is not available in the supervisor pending approval dashboard.
 -- Category/ Module: - GAP Subsidy
 -- Root cause: The subsidy rate review is not available in the supervisor pending approval dashboard as it was sent to different user.
 -- Fix Provided: Data fix has been promoted to updated the correct supervisor id for approval.
 */

select *from routing where objectid='05e7b58a-06d3-4687-b655-6704b83dafba';

update routing
set tosecurityusersid='77a54766-57b2-451b-a1e2-0f6a5d440f39',
	updatedby = 'CDM-37780',
	updatedon = now()
where routingid='87447e4a-7d3c-4287-85b1-7eba3bd30858'
    and objectid='05e7b58a-06d3-4687-b655-6704b83dafba'
	and activeflag  = 1 ;