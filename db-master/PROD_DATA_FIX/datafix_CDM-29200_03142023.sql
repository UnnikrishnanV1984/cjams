-- CDM-29200 - No GAP payment generated
/*
-- Issue Description: 
	CDM-29200	- GAP payments not started
	3236684:HOH-3236684 - subsidy payments have not started for Jaden Campbell. C&G was granted 09/08/22 and payments are not showing.
	Verified and there is no provider payment generated.
	Client Name: JADEN CAMPBELL
	CJAMS PID # 3637750
	Provider ID: 6005723

	-- Category/ Module: Accounts Payable (Finance Management)
	-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
	-- Fix Provided: Datafix has been promoted to resolve the data discrepancy (update active intakeservicerequestactorid in permanencyplan table)
	-- Pull request# N/A
	-- Reason why no related code fix: N/A
	-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--issue is permanencyplan table is having intakeservicerequestactorid which is activeflag = 0 record
--we need to update the active intakeservicerequestactorid for that child
--we need to update intakeservicerequestactorid  as
--70041386-acd0-48b2-bec7-a77fa5527b63    CHILD

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'b32cd43d-f9e7-4b0c-83db-c2db5d1afe16'
	and activeflag  = 1 ;

select activeflag, actorid, * from intakeservicerequestactor where  actorid = '15d1bc82-f84b-416f-b1e2-05e96f20852d';

update cjams.permanencyplan 
set intakeservicerequestactorid = '70041386-acd0-48b2-bec7-a77fa5527b63',
	updatedby = 'CDM-29200',
	updatedon = now()
where permanencyplanid = 'b32cd43d-f9e7-4b0c-83db-c2db5d1afe16'
	and activeflag  = 1 ;

select gapagreementid, * from gapagreement where gapid = '4ece6679-2041-4c57-a545-fade398b924f';
select gapagreementrateid, * from gapagreementrate where gapagreementid = '9e003ae6-1c13-491f-b1cc-6f170acc5438';

-- gapagreementrateid is gaprateid
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '4888f3ea-1f2f-443a-b94f-a31b98950cce' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-29200',
	updatedon = now()
where gaprateid = '4888f3ea-1f2f-443a-b94f-a31b98950cce' ;