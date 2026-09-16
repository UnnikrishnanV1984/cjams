-- CDM-36505- Break the link issue
/* Issue Description:User not able to submit break the link for #211030010128

-- Category/ Module: Permanency Plan(Break the link)
-- Root cause: User not able to submit break the link for #211030010128
-- Fix Provided: Datafix has been provided to remove duplicate adoptionagreements
-- Pull request# N/A

*/
select * from adoptionagreement where adoptionplanningid='42c75a3f-e0fe-41d2-be90-33f76959af02';

select activeflag,* from adoptionagreement where adoptionagreementid in ('b3fd2a59-2805-480d-9934-c830fa84a25d','8470c0af-1026-42c8-86ac-68b4bf2d65e3');

select * from routing where objectid in ('b3fd2a59-2805-480d-9934-c830fa84a25d','8470c0af-1026-42c8-86ac-68b4bf2d65e3') and eventcode='ASAR' and activeflag=1;

update adoptionagreement
set activeflag=0,
	updatedon = now(), 	
	updatedby = 'CDM-36505'
where adoptionagreementid in ('b3fd2a59-2805-480d-9934-c830fa84a25d','8470c0af-1026-42c8-86ac-68b4bf2d65e3');

update routing
set activeflag=0,
	updatedon = now(), 	
	updatedby = 'CDM-36505'
where objectid in ('b3fd2a59-2805-480d-9934-c830fa84a25d','8470c0af-1026-42c8-86ac-68b4bf2d65e3') and eventcode='ASAR' and activeflag=1;