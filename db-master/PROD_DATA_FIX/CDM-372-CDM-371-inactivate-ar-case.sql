-- CDM-372 Inactivate AR Case

UPDATE intakeservicerequest SET intakeservicerequestclassid ='00000000-0000-0000-0000-000000000000', 
actiontype = NULL,
updatedby = 'CDM-372',
updatedon = now()
WHERE servicerequestnumber IN (2020090017230, 2020090017231);

-- CDM-371

UPDATE personprogramarea ppa SET enddate = '2020-01-17 00:00:00', 
updatedon = now(), datatransferflag = 'U', updatedby = 'CDM-371'
FROM person p WHERE ppa.personid = p.personid
AND ppa.programkey = 'CPS' AND ppa.subprogramkey = 'IR' 
AND entityid = 'CW2946498'
AND cjamspid IN (4461293, 4266321, 4266314, 4313356, 4459399); 

--CDM-365 stuck intake
UPDATE routing SET activeflag = 0, updatedon = now() WHERE objectid = 'I202000259940' AND eventcode = 'INTR' AND activeflag = 1 ;
