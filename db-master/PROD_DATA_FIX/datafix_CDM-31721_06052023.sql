-- CDM-31721 - Response Timer not stopping
/*
-- Issue Description: 
   User Error for question "was this person an active member of the household but not included on the referral."
   The timer is now not recognizing timely contacts, and shows that the mandate has not been met.
   
-- CPS-AR: 231020551943 - 6f8ff70a-9dfb-4f8d-a9a3-646ac007571b
-- Clients:
-- 201252978 (Kevin	Russell Bardales) - f165d971-9855-4006-84e8-b65f35b5764a
-- 201251066 (Gunner Billingsley) - e7fd2414-63ef-404e-a7bf-cc5e5eb6e878
-- 201252979 (Trevin Bardales) - a0938af3-2808-4e98-8e68-3646ebeaebdd
-- 201251068 (Jaymyson Billingsley) - 47ce4043-9a21-4e58-a383-12b8258d74d2
-- 201251067 (Anthony Billingsley) - 62520c87-5160-4f61-ae94-ce9a8da29572

-- Category/ Module: Case Management
-- Root cause: User error
-- Fix Provided: Datafix has been promoted to update the answers as Yes for all 5 children in this case.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To update initialresponse as Yes (CDM-31721)
select personroleid, personid, initialresponse, updatedby, updatedon  
	from personrole 
where intakeserviceid = '6f8ff70a-9dfb-4f8d-a9a3-646ac007571b'
	and activeflag  = 1
	and initialresponse = 0 ;

update personrole
set initialresponse = 1,
	updatedby = 'CDM-31721', 
	updatedon = now()
where intakeserviceid = '6f8ff70a-9dfb-4f8d-a9a3-646ac007571b'
	and activeflag  = 1
	and initialresponse = 0 ;
	
-- To Stop the timer
-- Before 
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020551943'
	and activeflag = 1 ;

select * 
from cjams.cpsresponsetimerupdate( '6f8ff70a-9dfb-4f8d-a9a3-646ac007571b'::uuid, 'CDM-31721'::character varying ) ;
		
-- After
select responsetimer, responsetimerdetails, updatedby, updatedon 
	from intakeservicerequest 
where servicerequestnumber = '231020551943'
	and activeflag = 1 ;
		
		