-- CDM-25311 - tickets remain on screen
/*
-- Issue Description: 
    four assignments/assessments with the case number '3292827', '3214637' and '221030013948 'are waiting in the pending approval box
    even though they were approved.
    Customer Email ID:lepaul.morceau@maryland.gov
  
-- Resolution: Updated the Flag to zero in the routing table for the servicerequestnumbers ('20200216027059', '20200241031734')

-- Case ID: '3292827', '3214637' and '221030013948' 

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/


-- 3292827 - Case Plan
select * from routing where servicerequestnumber = '3292827' and activeflag = 1 and objectid= 'aa832715-7c0b-4f65-a9a7-7f544c5c1cb8' and routingstatustypeid ='15';

update routing set activeflag =0, updatedby = 'CDM-25311', updatedon = now()
where routingid = '153d3da2-b192-4665-9896-01c1ed7eca7c' and activeflag = 1;

-- 3214637 - Case Plan
select * from routing where servicerequestnumber = '3214637' and activeflag = 1 and objectid= '6fe89a52-3c93-4d73-b875-7a0262d4a095' ;

update routing set activeflag =0, updatedby = 'CDM-25311', updatedon = now()
where routingid in ('1805dab6-6e31-486c-be5b-57e9a449b4f7',
'67c12dbd-adee-4aa2-846b-b83d207d3496',
'0d35f3b8-8d83-4b87-bcec-3c098b530b69',
'96801434-3818-4dfe-a3a0-9da5a07d8aa5') and activeflag = 1;


-- 221030013948 - Case Plan

select * from routing where servicerequestnumber = '221030013948' and activeflag = 1 and objectid= '21967b33-e38d-4ec1-8ecb-948add767232';

update routing set activeflag =0, updatedby = 'CDM-25311', updatedon = now()
where routingid = '4fc9ec20-8677-4c62-84cc-fda2fa5c3113' and activeflag = 1;