-- CIDM-11127 - query tuning - 02-17-2026

CREATE INDEX idx_routing_role ON routing (toroleid, fromroleid);
CREATE INDEX idx_routing_team ON routing (teamid);
CREATE INDEX idx_tspa_status ON tb_service_purchase_authorization (ads_approval_status_cd, sprvsr_approval_status_cd);
CREATE INDEX idx_tsl_main ON tb_service_log (service_log_id, delete_sw, client_id);
CREATE INDEX idx_provider_name_lower ON prov.tb_provider (lower(btrim(provider_nm)));