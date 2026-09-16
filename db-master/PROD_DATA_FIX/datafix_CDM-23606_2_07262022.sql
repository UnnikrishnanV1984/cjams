-- CDM-23606 - Payment is incorrect
/*
-- Issue Description: 
	The new guardian parent (Vickie Pawley) does not received any payment from June 2022.

-- Case ID: 3235885
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 3622474 (CARTER MICHEAL PAWLEY) - 38ccba82-7342-48ac-bce4-7ff080cc8c9a
-- GAP ID: 3867 - 2015-06-25 To 2030-04-09 - 08e13ab8-5b56-4308-98b0-f5ac50c8ea8a
---------------------------------------------------------------------------------------
-- Delete duplicate active GAP suspensions

-- End Date and make in-active
select gapsuspensionid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspension 
where gapid = '08e13ab8-5b56-4308-98b0-f5ac50c8ea8a'
	and enddate is null ;
	
update gapsuspension
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-23606_1',
	updatedon = now()	
where gapid = '08e13ab8-5b56-4308-98b0-f5ac50c8ea8a'
	and enddate is null ;

-- End Date and make in-active
select gapsuspensionrevisionid, suspensionid, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspensionrevision 
where guardiansubsidyid = '08e13ab8-5b56-4308-98b0-f5ac50c8ea8a'
	and enddate is null ;

update gapsuspensionrevision
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-23606_1',
	updatedon = now()	
where guardiansubsidyid = '08e13ab8-5b56-4308-98b0-f5ac50c8ea8a'
	and enddate is null ;

-- To Trigger Under/Over
select suspensionid, approvaldate, startdate, enddate, activeflag, updatedby, updatedon 
from gapsuspensionrevision 
where guardiansubsidyid = '08e13ab8-5b56-4308-98b0-f5ac50c8ea8a'
	and suspensionid = '78de53dd-7c2c-4fa9-826f-aedb50510b66'
	and activeflag = 1 ;

update gapsuspensionrevision
set approvaldate = now(),
	updatedby = 'CDM-23606_1',
	updatedon = now()
where guardiansubsidyid = '08e13ab8-5b56-4308-98b0-f5ac50c8ea8a'
	and suspensionid = '78de53dd-7c2c-4fa9-826f-aedb50510b66'
	and activeflag = 1 ;
