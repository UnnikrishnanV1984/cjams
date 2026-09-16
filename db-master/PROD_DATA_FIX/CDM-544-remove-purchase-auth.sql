
--CDM -544
UPDATE tb_service_purchase_authorization SET delete_sw = 'Y' WHERE authorization_id = 1732713;

--CDM 548
UPDATE routing SET activeflag = 0 , updatedon = now(), updatedby = 'CDM-548' WHERE routingid = 'c7220b13-edfd-4e12-b2e6-be3e6cddc6e1';

--CDM-488

--UPDATE intakeservicerequest SET intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby ='CDM-488',
--updatedon = now() WHERE intakenumber = 'CW9924938' AND intakeserreqstatustypeid = 'c8dbf10f-843d-4b40-97ca-288d750463da';

--UPDATE intakedastatus SET status = 11, updatedby = 'CDM-488', updatedon = now() WHERE intakenumber = 'CW9924938';

UPDATE IntakeDAStaging SET activeflag = 0 WHERE intakenumber = 'CW9924938' AND activeflag = 1 ;

