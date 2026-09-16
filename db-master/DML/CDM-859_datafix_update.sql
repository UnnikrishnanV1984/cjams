update tb_slpa_snapshot
set payment_name = 'Roberta Contee-Murray', director_name = 'Susan Tyzack'
where authorization_id  = 1732818;

update routing
set tosecurityusersid = 'ba6b0879-f713-42ef-99f9-f10b6710c89b', updatedon = now(), updatedby = 'Datafix user as per CDM-859'
where objectid= '1732818' and routingstatustypeid = 42;

update routing
set tosecurityusersid = 'ad6ea6ab-0fe0-4c80-9770-0caaf96962a9', updatedon = now(), updatedby = 'Datafix user as per CDM-859'
where objectid ='1732818' and routingstatustypeid = 44;

update routing
set tosecurityusersid = '5fa4ecd6-9c66-496f-8eff-e32c78192df1', updatedon = now(), updatedby = 'Datafix user as per CDM-859'
where objectid ='1732818' and routingstatustypeid = 43;

