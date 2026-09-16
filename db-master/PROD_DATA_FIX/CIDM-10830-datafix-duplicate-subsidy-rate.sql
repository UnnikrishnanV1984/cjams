/*
-- Issue Description: 
	3284034:Zara Barrientos 12/1/14 - Case 3284034The last row under the Rate Tab is incorrect, it should show "10/21/25 - 10/20/26", but it's showing duplicated dates from last year "24-25"
-- Category/ Module: GAP (Case Management) 
-- Root cause: System Error, duplicate subsidy rate record has been created.
-- Fix Provided: Datafix has been promoted to remove the duplicated GAP subsidy record.
-- Pull request# N/A
-- Reason why no related code fix: CDM-44533
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select startdate, enddate, paymentamout, activeflag, updatedby, updatedon, *
	from gapagreementrate
where gapagreementid  = '4a74bd63-321d-4e9f-a0ce-d78bc90ba3b7'
	and gapagreementrateid = '400f226c-6323-431c-b6bc-0e40a6838e6f'
	and activeflag = 1 ;
*/

update gapagreementrate
set activeflag = 0,
	updatedby = 'CIDM-10830',
	updatedon = now()
where gapagreementrateid = '400f226c-6323-431c-b6bc-0e40a6838e6f'
	and activeflag = 1 ;

/*
select ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon, *
	from gapratesrevision
where gaprateid = '400f226c-6323-431c-b6bc-0e40a6838e6f'
	and activeflag = 1 ;
*/

update gapratesrevision
set activeflag = 0,
	updatedby = 'CIDM-10830',
	updatedon = now()
where gaprateid = '400f226c-6323-431c-b6bc-0e40a6838e6f'
	and activeflag = 1 ;

/*
select eventcode, routingid, routingstatustypeid, routeddescription, updatedby, updatedon, activeflag
	from routing
where objectid = '400f226c-6323-431c-b6bc-0e40a6838e6f'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/

update routing
set activeflag = 0,
	updatedby = 'CIDM-10830',
	updatedon = now()
where objectid = '400f226c-6323-431c-b6bc-0e40a6838e6f'
	and eventcode = 'GARR'
	and activeflag = 1 ;
