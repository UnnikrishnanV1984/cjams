-- 21
update routing set routingstatustypeid = 1, updatedby = 'CDM-14460' , updatedon = now() where objectid = 'I211010168946';
-- 2
update intakedastatus set status = null, updatedby = 'CDM-14460' , updatedon = now() where intakenumber = 'I211010168946';