-- CIDM-10970 - NCANDS Fatality related data fix updates
/*
-- Issue Description: 
		All the Fatality related records for NCANDS are captured in the report. 
		Ex.case#251023075114, PID 204161833 Nola Dinkins
	
-- Category/ Module: CPS Case (Investigation Management) 
-- Root cause: Data integrity issue, CPS cases with missing case assignment data in the cjams.routing table. 
-- Fix Provided: Datafix has been promoted to add the missing cjams.routing data for the cases belogs to NCANDS Period Oct 24 to Spet 25.
-- Regression Impacts: N/A
-- Is Code fix Required?: N/A
-- Code fix ticket#: (If Yes)
-- Reason why no related code fix: TBD
*/	

-- NCANDS Fatality Missing Case fix 
-- Mass Data cleanup for CPS cases with missing cjams.routing record

INSERT INTO cjams.routing
(
	routingid, 
	eventcode, 
	fromsecurityusersid, 
	tosecurityusersid, 
	teamid, 
	fromroleid, 
	toroleid, 
	objectid, 
	routingstatustypeid, 
	activeflag, 
	insertedby, 
	insertedon, 
	updatedby, 
	updatedon, 
	isreviewrequest, 
	servicerequestnumber 
)
select cjams.gen_random_uuid(), 
	'INVT',
	ca_main.fromworkeridno,
	ca_main.toworkeridno,
	ca_main.fromteamid,
	'CWSP',
	'CWCW',
	ca_main.objectid,
	'4',
	1, 
	'CIDM-10970', 
	now(), 
	'CIDM-10970',
	now(), 
	false, 
	(select isr.servicerequestnumber
		from intakeservicerequest isr
	where isr.intakeserviceid = ca_main.objectid 
	)
from caseassignment ca_main
where ca_main.activeflag = 1
	and ca_main.caseassignmentid
	in (
	select caseassignmentid
	from (
		select ca.caseassignmentid,
			ca.objectid,
			ca.insertedon,
			RANK() OVER(PARTITION BY ca.objectid
							ORDER BY ca.insertedon) as caseassignment_rnk 
		from caseassignment ca
		where ca.activeflag = 1
			and ca.objectid
			in (
				select distinct isr.intakeserviceid
				from intakeservicerequest isr 
						join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid  
							and isra.activeflag = 1 
							and ( isra.rchouseholdflag = 1 or isra.intakeservicerequestpersontypekey = 'AV')
						join person p on p.personid = isra.personid 
							and p.activeflag = 1 
						join investigation inve on inve.intakeserviceid = isr.intakeserviceid
						join (select *				
							from intakeservicerequestdispositioncode 
						  where activeflag = 1
								-- Recommend for closure & Completed
								-- and sd.servicerequesttypeconfigiddispostionid = 'd90db0d3-f665-49db-b3ad-0edb468bc02d' -- Recommend for closure
								and ( intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8' -- Completed
									  or	
									  intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a' -- Closed
									) 
						  )	sd on sd.intakeserviceid = isr.intakeserviceid 					
						join investigationmaltreatment invm on invm.investigationid = inve.investigationid
							and invm.activeflag=1
					where isr.actiontype IN ('IR','AR') -- = 'IR'
						and isr.activeflag = 1 
						and (case when isr.actiontype = 'AR' then
								date_part('year',age(isr.reportedtime::date, p.dob)) <= 18
							 else
								true
							end)	
						and isra.intakeservicerequestpersontypekey in ('BIOCHILD','OTHERCHILD','AV', 'CHILD')  	
						and sd.statusdate BETWEEN '2024-10-01'::date AND '2025-09-30'::date		
					-- Reported missing case 
					-- and servicerequestnumber = '251023075114'
					and( select count(*)
							from routing ru
						where ru.objectid = isr.intakeserviceid::character varying 
							and ru.eventcode='INVT'
							and ru.tosecurityusersid <> '00000000-0000-0000-0000-000000000000'
							and ru.tosecurityusersid IS NOT null
						) = 0	
				)
		-- order by ca.objectid,
		-- 	ca.insertedon
		) a 
		where caseassignment_rnk = 1
	) ;			