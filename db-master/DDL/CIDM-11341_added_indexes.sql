CREATE INDEX xie10_routing ON routing (
    eventcode,
    tosecurityusersid,
    routingstatustypeid,
    activeflag
)
WHERE
    eventcode = 'PCAUTH';


CREATE INDEX idx_tspa_fast ON tb_service_purchase_authorization (authorization_id, service_log_id)
WHERE
    sprvsr_approval_status_cd = '3047'
    AND ads_approval_status_cd = '3047';


CREATE INDEX xie9_routing ON routing (
    eventcode,
    teamid,
    routingstatustypeid,
    activeflag
)
WHERE
    eventcode = 'PCAUTHR';


CREATE INDEX idx_tsl_fast ON tb_service_log (service_log_id)
WHERE
    delete_sw = 'N'
    AND client_id IS NOT NULL;