--Removing assessment from inbox case 20200218027544 
update cjams.routing set activeflag = 0, updatedon = now() , updatedby='CDM-7379' where routingid = 'ac4cb68e-87ad-44e0-946b-f6950472931c';