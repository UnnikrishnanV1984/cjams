/*
   Issue Description: CIDM-7999
   Category/ Module  : Prod data fix to update IVE Referrals Data
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 4369611	250750
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '250750' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '250750' and start_dt is null;

-- 4207598	252562
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '252562' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '252562' and start_dt is null;

-- 4313062	252563
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '252563' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '252563' and start_dt is null;

-- 4386445	251018
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '251018' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '251018' and start_dt is null;

-- 3440300	252187
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '252187' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '252187' and start_dt is null;


-- 3888850	253697
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '253697' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '253697' and start_dt is null;

-- 3419504	253228
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '253228' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '253228' and start_dt is null;

-- 200831080	253267
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '253267' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '253267' and start_dt is null;


-- 201341378	280034
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '280034' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '280034' and start_dt is null;

-- 4425656	253229
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '253229' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '253229' and start_dt is null;

-- 2031675	168276
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '168276' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '168276' and start_dt is null;

-- 1504206	252311
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '252311' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '252311' and start_dt is null;

-- 1949405	252312
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '252312' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '252312' and start_dt is null;

-- 201916580	288427
update tb_client_eligibility tce set start_dt = (select removaldate from intakeservreqchildremoval where removalid  = '288427' ), update_ts = now(), update_user_id = 'CIDM-8015'
where tce.removal_id = '288427' and start_dt is null;