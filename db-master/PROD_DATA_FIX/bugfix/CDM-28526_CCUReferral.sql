-- CDM-28526 - CCU Referral

-- Provider ID: 5044564 (Celeste Ireland) - Local Department Home

-- Category/ Module: Account Receivables (Finance Management) 
-- Root cause: Active_sw is not updating correctly in the table because fo which balance is shwoing wrongly
-- Fix Provided: Datafix has been promoted to update the active_sw. 
-- Pull request# https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_welfare_api/pull-requests/1701/overview
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

select * from tb_receivable_header where provider_id = 5044564;

select * from tb_receivable_header where receivable_id = 1245250;

select * from tb_receivable_detail 
where receivable_id = 1245250
order by receivable_detail_id desc;

UPDATE cjams.tb_receivable_collection_status
SET active_sw='Y', update_ts=now(), update_user_id='CDM-28526'
WHERE collection_status_id=23923402 and collection_status_cd='775' and receivable_detail_id=1721385;

UPDATE cjams.tb_receivable_collection_status
SET active_sw='N', update_ts=now(), update_user_id='CDM-28526'
WHERE collection_status_id=23919944 and collection_status_cd='780' and receivable_detail_id=1721385;

UPDATE cjams.tb_receivable_collection_status
SET active_sw='Y', update_ts=now(), update_user_id='CDM-28526'
WHERE collection_status_id=23923401 and collection_status_cd='775' and receivable_detail_id=1721386;

UPDATE cjams.tb_receivable_collection_status
SET active_sw='N', update_ts=now(), update_user_id='CDM-28526'
WHERE collection_status_id=23919945 and collection_status_cd='780' and receivable_detail_id=1721386;
