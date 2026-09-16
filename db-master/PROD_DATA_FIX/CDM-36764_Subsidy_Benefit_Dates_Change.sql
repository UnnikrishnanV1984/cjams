/*
 * CDM-36764 - Incorrect Subsidy Benefit Dates
 * Customer Email ID:selina.avent@maryland.gov
 * Focus Area:Payments
 * the subsidy rate start date on 01/11/2024 need to be updated to 12/28/23.
 * the subsidy rate end date on 01/10/2025 need to be updated to 12/27/24 
 * Case ID # 211030012387
 * 
 */

select startdate, enddate ,* from gapagreementrate where gapagreementrateid  = '4ac269a7-66cc-4dae-87ab-325337e3b628';

UPDATE cjams.gapagreementrate
	SET 	startdate = '2023-12-28 00:00:00.000', 
			enddate='2024-12-27 00:00:00.000', 
			updatedby='CDM-36764', 
			updatedon=now() 
	WHERE gapagreementrateid='4ac269a7-66cc-4dae-87ab-325337e3b628'::uuid;

select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
from gapratesrevision 
where gaprateid = '4ac269a7-66cc-4dae-87ab-325337e3b628' and activeflag = 1 ;

update gapratesrevision 
	set ratestartdate = '2023-12-28 00:00:00.000', 
		rateenddate='2024-12-27 00:00:00.000',
		approvaldate = now(),
		updatedon=now(), updatedby='CDM-36764'	
	where gaprateid = '4ac269a7-66cc-4dae-87ab-325337e3b628' and activeflag = 1 ;

