-- Add New index on tb_provider_services

drop INDEX if exists routing_routingstatustypeid_idx;
create index if not exists Xie1_tb_provider_services on tb_provider_services(provider_service_id);

