update gapagreement
set gapid = '9bd2b850-fffc-4c97-b5e2-e30c3b40bed3', updatedon = now(), updatedby = 'CDM-3946'
where gapagreementid = '8d12b4cf-b6ea-4c9f-91f2-aa1e184b270d';

update gapannualreview
set gapid = '9bd2b850-fffc-4c97-b5e2-e30c3b40bed3', updatedon = now(), updatedby = 'CDM-3946'
where gapannualreviewid in ('7bea5f37-c510-42c7-80c5-b5a170093dfe','4c21704c-0b9d-4979-a617-795c580579d4','35d1208e-3d65-4f43-9df1-b0fb6781a3af'); 