update routing set tosecurityusersid='e5f2d788-5de8-4fa0-86f6-564ab972a7a5', updatedon=now(), updatedby='CDM-1580' where objectid=1734803 and routingstatustypeid=43;

update tb_slpa_snapshot set payment_name='Barbara Kutchman',update_ts=now(), update_user_id='CDM-1580' where authorization_id=1734803;