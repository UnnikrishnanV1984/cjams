-- 2
update routing set routingstatustypeid = 1, updatedby = 'CDM-14366' , updatedon = now() where objectid = 'I211010167967';
-- 2
update intakedastatus set status = null, updatedby = 'CDM-14366' , updatedon = now() where intakenumber = 'I211010167967';
