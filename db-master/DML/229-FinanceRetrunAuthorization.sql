	  delete from routingstatustype where sequencenumber=850;
	  INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(850, 'Returned', 1, 'Returned', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);