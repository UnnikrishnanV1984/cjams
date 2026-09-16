/*
 * CDM-39587 - entered wrong date on subsidy rate
 * Customer Email ID:alice.barkley1@maryland.gov
 * Description - 211030012301:This worker put in the wrong start date under permanency plan and subsidy rate. 
 * The entry was approved but now we are unable to go in and fix it.Either delete the entry or 
 * change start date to 1/19/2024 so this nice lady can start getting her GAP check please. 
 * data fix to update below entered records
 * Subsidy Rate Begin Date - update from 11/19/2024 to 01/19/2024
 * Subsidy Rate Amount - update from $29.16 (per day rate) to $887 (per month rate)
 * 
 */

--select paymentamout, startdate, * from gapagreementrate where gapagreementrateid = '76f80948-bb6c-4cc2-962f-77f63f81df8f';
UPDATE cjams.gapagreementrate
SET paymentamout=887, startdate='2024-01-19 05:00:00.000', updatedby='CDM-39587', updatedon=now() 
WHERE gapagreementrateid='76f80948-bb6c-4cc2-962f-77f63f81df8f'::uuid;

-- select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon 
-- 	from cjams.gapratesrevision
-- where gaprateid = '76f80948-bb6c-4cc2-962f-77f63f81df8f'::uuid and activeflag=1;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-39587',
	updatedon = now()
where gaprateid = '76f80948-bb6c-4cc2-962f-77f63f81df8f'::uuid and activeflag=1;
