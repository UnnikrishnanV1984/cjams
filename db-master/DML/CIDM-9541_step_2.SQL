update  cjams.routingstatustype set typedescription='Coordinator Assignment Pending', 
updatedby ='CIDM-9541' ,updatedon =now()
WHERE sequencenumber = 902 and activeflag =1;

DELETE FROM cjams.routingstatustype 
WHERE sequencenumber = 908 and activeflag =1;

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, 
expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(908, 'psychotropic_initial_submission', 1, 'Initial Submission/Coordinator Assignment Pending', now(),
NULL, NULL, 'CIDM-9541', NULL, now(), null, NULL);
