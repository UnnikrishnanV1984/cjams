-- CDM-35158 - remove referrals
/* Issue Description: User request to delete the following 2 CPS referrals entered in error.

-- Intake Id: I231011693022 and I231011369003

-- Category/ Module: Assessments: other

-- Root cause: User request to delete the following 2 CPS referrals entered in error 
-- Fix Provided: Datafix has been provided to remove 2 CPS referrals
-- Pull request# N/A

*/

select * from Intakedastaging where intakenumber in ('I231011693022','I231011369003') and activeflag=1;

update Intakedastaging 
 set activeflag=0,
 	updatedon = now(), 	
	updatedby = 'CDM-35913'
where intakenumber in ('I231011693022','I231011369003') and activeflag=1;

select * from intakedastatus where intakenumber in ('I231011693022','I231011369003') and activeflag=1;

update intakedastatus 
 set activeflag=0,
 	updatedon = now(), 	
	updatedby = 'CDM-35913'
where intakenumber in ('I231011693022','I231011369003') and activeflag=1;
