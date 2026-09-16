-- CIDM-6432 - Cases not showing in application but showing in reports
/*
-- Issue Description: 
-- CPS Cases not showing in application but showing in reports
	
Intake I221010243029
CPS-IR 221020188063 (Blank Case) 
CPS-IR 221020188064 (Actual connected CPS case) 

Intake I221010329739
CPS-AR 221020266497   (Blank Case)
CPS-AR 221020266498   (Actual connected CPS case)

Intake I221010345988
CPS-AR 221020282664    (1st Blank Case)
CPS-AR 221020282665    (2nd Blank Case)
CPS-AR 221020282666    (Actual connected CPS case)

Intake I231010370136 * this data was created yesterday on 01/18/2023
CPS-AR 231020306379   (Blank Case)
CPS-AR 231020306380   (Actual connected CPS case)	

-- No fix for this Intake I211010213025 ***
CPS-IR 211020159446
CPS-IR 211020159445
Both cases are available in CJAMS to search and also both the cases are completed by the users 
(One was marked as Ruled-out and one was Unsubstantiated).  

	
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: Vignesh is working on the root cause analysis and code fix.
-- Fix Provided: Datafix has been promoted to delete below 
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

select routingid, eventcode, routingstatustypeid, remarks, activeflag, updatedby, updatedon  
	from routing  
where objectid in ( select intakeserviceid::character varying 
						from intakeservicerequest 
					where servicerequestnumber 
						in ('221020188063', '221020266497', '221020282664', '221020282665', '231020306379')
						and activeflag = 1
				   )
	and activeflag = 1 ;

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CIDM-6432'
where objectid in ( select intakeserviceid::character varying 
						from intakeservicerequest 
					where servicerequestnumber 
						in ('221020188063', '221020266497', '221020282664', '221020282665', '231020306379')
						and activeflag = 1
				   )
	and activeflag = 1 ;
	
select intakenumber, intakeserviceid, servicerequestnumber, activeflag, updatedby, updatedon  
	from intakeservicerequest 
where servicerequestnumber in ('221020188063', '221020266497', '221020282664', '221020282665', '231020306379')
	and activeflag = 1 ;

update intakeservicerequest 
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CIDM-6432'
where servicerequestnumber in ('221020188063', '221020266497', '221020282664', '221020282665', '231020306379')
	and activeflag = 1 ;


-- No date in actor and intakeservicerequestactor tables 
/*
select *
from actor
where intakeserviceid 
in ( select intakeserviceid 
		from intakeservicerequest 
	where servicerequestnumber 
		in ('221020188063', '221020266497', '221020282664', '221020282665', '231020306379')
	and activeflag = 1
   )
and activeflag  = 1

select *
from intakeservicerequestactor i 
where intakeserviceid 
in ( select intakeserviceid 
		from intakeservicerequest 
	where servicerequestnumber 
		in ('221020188063', '221020266497', '221020282664', '221020282665', '231020306379')
	and activeflag = 1
   )
and activeflag  = 1
where objectid = 'I221010332561'
	and activeflag = 1 ;
*/

