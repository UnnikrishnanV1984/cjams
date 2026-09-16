/*
   Issue Description: CDM-15024
   Category/ Module  :  reopening case close
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

INSERT INTO cjams.routing
(eventcode, fromsecurityusersid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest)
VALUES('SCDR', '299210ac-c6df-4985-a02b-bdeda0cdad67',
	(select servicecasedispositionid from cjams.servicecasedisposition 
		where servicecaseid ='8cbea4d3-df5b-481b-a3b4-ba5763c10e8a' 
		order by insertedon desc limit 1 ), 
	16, 1, 'CDM-15024', now(), 'CDM-15024', now(), true);