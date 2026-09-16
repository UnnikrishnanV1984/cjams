--D-23773 remove gap approval review records
update routing set activeflag=0, updatedon=now() 
where routingid in ('d497da70-d83e-4a55-8b56-b99621fdb6d0', '4b8f4988-84fe-4826-967f-224db8be2485')
and eventcode='GAYR'
