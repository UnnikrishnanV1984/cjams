-- CDM-13381 - CJAMS - Trouble inputting Payment/Billing CJAMS# 3789611 (worker: Anjenette Powell)
/*
-- Issue Description: 
   user is having trouble input payment/bills for the following youth:
   Ventsene Jordan CJam# 3789611, CIS ID# 484025799. 
   I have number of payments to make and the system will not allow me to add any new service log/payments.
   
-- Case ID: 3253406 - anjenette.powell@maryland.gov
-- Client ID: 3789611 (VENTSENE	JORDAN) - daa5ed56-81cc-4d49-b762-f7f2418e31c1
-- Program Assignment: OOH	2015-08-07 to 2020-07-24 - 435cd68d-d1c8-4d2d-a14e-7a33771076d9

-- Category/ Module: Service Log  (Case Management) 
-- Root cause: Data issue; Active Removal/Placement with closed OOH Program Assignment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Active Removal/Placement with closed OOH Program Assignment.
-- Datafix to re-open the OOH Program Assignment
select personid, objectid, programkey, startdate, enddate, activeflag, updatedby, updatedon, * 
	from personprogramarea 
where personprogramid = '435cd68d-d1c8-4d2d-a14e-7a33771076d9'
	and activeflag = 1 ;

update personprogramarea
set enddate = null,
	updatedby = 'CDM-13381',
	updatedon = now()
where personprogramid = '435cd68d-d1c8-4d2d-a14e-7a33771076d9'
	and activeflag = 1 ;
	