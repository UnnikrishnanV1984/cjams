---D-24793:-Service Plan stuck on Approval dashboard despite being Approved. 
update routing
set activeflag = 0
, updatedon = Now()
,updatedby = 'admin-D24793'  
where routingid = '3f7bfae8-efc6-4237-8238-3636899150cb'
and  objectid = '24b38b0e-bef6-4a23-ae22-127d79e9657f'
and routingstatustypeid = 15;