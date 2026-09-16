
	update cjams.routing
	set activeflag = 0 
	where routingid = '6f8e1c65-c7e1-4030-a05b-23b2b556d364';
	

	update cjams.assessment a
	set activeflag = 1
	where assessmentid = '5a05098a-5f7a-4b54-b854-70ef00b19ae6';

