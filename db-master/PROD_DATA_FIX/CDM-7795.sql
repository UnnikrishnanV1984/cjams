--CDM-7795 service plan review request inactivate 

UPDATE routing SET activeflag = 0, updatedon = now() WHERE servicerequestnumber = 3144452 AND activeflag = 1 AND 
routingstatustypeid = 15 AND eventcode = 'SPLAN';

--CDM-7736 - remove/reset child remal

UPDATE intakeservreqchildremoval c SET c.activeflag = 0, updatedon = now() from
servicecase sc WHERE sc.servicecaseid = c.servicecaseid AND sc.servicecasenumber = 2020025803012
AND c.activeflag = 1 AND exitdate IS NOT NULL;
