/*
 * CDM-35470 - Subsidy End Date
 * Customer Email ID:lindaj.luallen@maryland.gov
 * Customer Name:Linda J. Luallen
 * Focus Area:Payments
 * the subsidy rate end date on 11/30/2023 need to be updated to 07/31/2023, also 
 * the subsidy rate start date on 12/01/2023 need to be updated to 08/01/2023.
 * Client Name: SHYNIA CHRISTIAN
 * CJAMS PID # 3235623
 * 
 */

select enddate ,* from gapagreementrate where gapagreementrateid  = '5a1b27ee-c938-4aa0-9931-6979151f0c94';
UPDATE cjams.gapagreementrate
SET enddate='2023-07-31 00:00:00.000', updatedby='CDM-35470', updatedon=now() 
WHERE gapagreementrateid='5a1b27ee-c938-4aa0-9931-6979151f0c94'::uuid;

select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
from gapratesrevision 
where gaprateid = '5a1b27ee-c938-4aa0-9931-6979151f0c94' and activeflag = 1 ;

update gapratesrevision 
set rateenddate = '2023-07-31 00:00:00.000',
approvaldate = now(),
updatedon=now(), updatedby='CDM-35470'	
where gaprateid = '5a1b27ee-c938-4aa0-9931-6979151f0c94' and activeflag = 1 ;

select enddate ,* from gapagreementrate where gapagreementrateid  = '8e04d244-b79f-4778-a8e5-6f44e5e19096';
UPDATE cjams.gapagreementrate
SET startdate='2023-08-01 05:00:00.000', updatedby='CDM-35470', updatedon=now() 
WHERE gapagreementrateid='8e04d244-b79f-4778-a8e5-6f44e5e19096'::uuid;

select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
from gapratesrevision 
where gaprateid = '8e04d244-b79f-4778-a8e5-6f44e5e19096' and activeflag = 1 ;

update gapratesrevision 
set ratestartdate = '2023-08-01 05:00:00.000',
approvaldate = now(),
updatedon=now(), updatedby='CDM-35470'	
where gaprateid = '8e04d244-b79f-4778-a8e5-6f44e5e19096' and activeflag = 1 ;
