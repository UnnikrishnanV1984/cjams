update gapagreement set startdate = '2020-11-20 00:00:00', updatedby = 'CDM-10275', updatedon = now() where gapagreementid = 'ce5f4ae5-e0cf-4c28-a569-79e6e8cdc019' and gapid = '62447844-7bb9-497a-ac78-fe4011f67b3a' and activeflag = 1;

update gapagreementrevision set startdate = '2020-11-20 00:00:00', updatedby = 'CDM-10275', updatedon = now() where gapagreementrevisionid = 'd022ad82-1453-46d1-babb-028ca85659d8' 
	and gapagreementid = 'ce5f4ae5-e0cf-4c28-a569-79e6e8cdc019' and gapid = '62447844-7bb9-497a-ac78-fe4011f67b3a' and activeflag = 1;

update gapagreementrate set startdate = '2020-11-20 00:00:00', updatedby = 'CDM-10275', updatedon = now() where gapagreementid = 'ce5f4ae5-e0cf-4c28-a569-79e6e8cdc019' and gapagreementrateid = 'b00e793f-a438-4a10-8209-6e6251cb9133' and activeflag = 1;

update gapannualreview set effectivedate = '2020-11-20 00:00:00', updatedby = 'CDM-10275', updatedon = now() where gapid = '62447844-7bb9-497a-ac78-fe4011f67b3a' and activeflag = 1;

update gapratesrevision set transactiondate = '2020-11-20 00:00:00', ratestartdate = '2020-11-20 00:00:00', approvaldate = now(), updatedby = 'CDM-10275', updatedon = now() where gaprateid = 'b00e793f-a438-4a10-8209-6e6251cb9133' and activeflag = 1;