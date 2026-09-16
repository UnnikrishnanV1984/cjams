update tb_provider tb
  set county_cd_tx = tba.jurisdiction
from tb_vendor_applicant tba
where tba.providerid =  tb.provider_id::character varying;
update tb_provider tb
  set county_cd_tx = c.countyid
from county c
where c.statecountycode =  tb.county_cd;
