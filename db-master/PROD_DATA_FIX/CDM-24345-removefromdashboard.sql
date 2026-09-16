--CDM-24345
update  routing set activeflag = 0, updatedby='CDM-24345', updatedon= now() 
where objectid = '8901c30c-d184-48d1-a3a5-0770ca4e6a8e' and routingstatustypeid = 15 and tosecurityusersid = 'd9e27467-8d44-4607-a993-287493cdac18';;
