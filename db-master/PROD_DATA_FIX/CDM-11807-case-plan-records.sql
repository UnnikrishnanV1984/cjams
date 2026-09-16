update routing 
	set
	activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-11807'
	where routingid in ('b8c940ad-1f03-46cd-982d-5c0f2363bd81', '9e87f187-7f27-475b-b35e-847a96df6776', 'f0e962ad-7607-4ddc-b1f5-dfd198035ba8');