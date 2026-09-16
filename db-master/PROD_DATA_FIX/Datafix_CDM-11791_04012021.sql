-- CDM-11791 - Placement
/*
Correction of the fix to move the RCC placement from the old contract program to new contract program 
for below 2 cases 
Somerset County Case ID: 3207754
Baltimore City Case ID: 3169787 

Datafix to correct the Requested By (Family Worker)& Approved By (Supervisor) Names
*/

-- Case ID: 3207754
-- Placement IDs: 
-- 1561767	2021-03-01 to 2021-03-29 - b23dc148-d47b-422b-9705-98acefac228d
-- 1556411	2020-07-27 to 2021-03-01 - 295bba6e-9a68-4acf-8532-76a982f04820

-- Old values 
-- ab68028d-401d-4768-94e4-6ebf08f222b6	(Marceline Brooks)
-- 72ea08ae-678a-423d-ae3a-44921d219c5e	(Lisa Pittman)
-- 8d32f1f6-5401-4c69-bc40-1688e3a830cd

-- New values
-- 00c2bb99-10cc-4f68-98f1-915bf0cb354d	(Tineka Harmon)
-- 7ca5718d-cc3f-4884-934c-6769a4d00eed (Lori Engle) - (Act sup cd1515d2-a8db-46b1-9eb3-300d8e92e8d5	
-- fe8d081b-96de-4850-bbb8-888d00638fbc

select approvalstatustypkey, requestedby, approvedby, approvaldate, updatedon, updatedon 
    from cjams.placementrevision p 
where placementid in ('b23dc148-d47b-422b-9705-98acefac228d', '295bba6e-9a68-4acf-8532-76a982f04820')
    and insertedon::date = '2021-03-29'::date ;
	
update cjams.placementrevision
set requestedby = '00c2bb99-10cc-4f68-98f1-915bf0cb354d', 
	approvedby = '7ca5718d-cc3f-4884-934c-6769a4d00eed',
	updatedby = 'CDM-11791',
	updatedon = now()
where placementid in ('b23dc148-d47b-422b-9705-98acefac228d', '295bba6e-9a68-4acf-8532-76a982f04820')
    and insertedon::date = '2021-03-29'::date ;


-- Baltimore City Case # 3169787 & Client ID: 2252610
-- Placement IDs:
-- 1561988	2021-03-01 to active - ce01cf49-2158-488e-8e06-71a8aed49dcb
-- 340175	2020-04-02 to 2021-03-01 - c427eac2-7370-47b8-a0eb-d44407d3b704

-- Old values 
-- 539c9e75-4f92-45e3-818e-775a3e8d88a7	(Latoria Murphy)
-- 95558df3-ac2c-47ad-93e4-c30889c8c8c9	(Erica Fowlkes)
-- 1845ecff-4d1d-4c57-9f76-013b698bc3c6

-- New values
-- daae5686-a3c4-4203-a3ae-1f612d6253fb	(Shirley Arnold)
-- 8b49524f-5a88-45ff-84ed-e15ca46f1a8a	(Fadea Husain)
-- 51fe61c6-e77a-4877-9f52-2ab7da45c4d0

select approvalstatustypkey, requestedby, approvedby, approvaldate, updatedon, updatedon 
    from cjams.placementrevision p 
where placementid in ('ce01cf49-2158-488e-8e06-71a8aed49dcb', 'c427eac2-7370-47b8-a0eb-d44407d3b704')
    and insertedon::date = '2021-03-29'::date ;
	
	
update cjams.placementrevision
set requestedby = 'daae5686-a3c4-4203-a3ae-1f612d6253fb', 
	approvedby = '8b49524f-5a88-45ff-84ed-e15ca46f1a8a',
	updatedby = 'CDM-11791',
	updatedon = now()
where placementid in ('ce01cf49-2158-488e-8e06-71a8aed49dcb', 'c427eac2-7370-47b8-a0eb-d44407d3b704')
    and insertedon::date = '2021-03-29'::date ;
	