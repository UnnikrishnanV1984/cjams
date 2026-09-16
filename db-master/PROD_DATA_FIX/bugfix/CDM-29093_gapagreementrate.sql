/*
   Issue Description: CDM-29093
   Category/ Module  : Gap Agreement rate 
   Root cause: user requested to update the rate
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.gapagreementrate
SET paymentamout=1008.00, updatedby='CDM-29093', updatedon=now()
WHERE gapagreementrateid in ('26e4f8a7-d151-4a69-aaec-a4c9eb96dff3', 'b87ae554-b501-47cd-93c1-3019c19b4dd9') 
and gapagreementid = '0cefa91c-e6b4-4fe4-97c3-9046266366c8';

-- Datafix to trigger Under/Over -- Old ticket update on the same gaprateid CDM-20351
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid in ('26e4f8a7-d151-4a69-aaec-a4c9eb96dff3', 'b87ae554-b501-47cd-93c1-3019c19b4dd9');

update gapratesrevision 
set paymentamt = 1008.00,
	approvaldate = now(),
	updatedby = 'CDM-29093',
	updatedon = now()
where gaprateid in ('26e4f8a7-d151-4a69-aaec-a4c9eb96dff3', 'b87ae554-b501-47cd-93c1-3019c19b4dd9');
