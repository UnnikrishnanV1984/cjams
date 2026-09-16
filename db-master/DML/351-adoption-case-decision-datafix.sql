update adoptioncase
set statustypekey ='Closed'
where adoptioncaseid in 
	(select ac.adoptioncaseid
	from adoptioncase ac
	join adoptioncasedisposition acd on acd.adoptioncaseid = ac.adoptioncaseid
	join routing r on r.objectid = acd.adoptioncasedispositionid::character varying and r.eventcode='ACDR' and r.routingstatustypeid =16 and r.activeflag =1 and r.remarks='Disposition Approved'
	where ac.statustypekey = 'Open');