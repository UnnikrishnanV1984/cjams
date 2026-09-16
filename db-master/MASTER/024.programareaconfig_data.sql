TRUNCATE TABLE programareaconfig;	
INSERT INTO programareaconfig (programkey, subprogramkey, servicerequestsubtypekey,insertedby,updatedby,isdefault)
 VALUES
        ('IHSFP','CS','IHM','admin','admin',1),
		('IHSFP','CTPS','IHM','admin','admin',0),
		('IHSFP','IFC','IHM','admin','admin',0),
		('IHSFP','IFP','IHM','admin','admin',0),
		('IHSFP','SFCC','IHM','admin','admin',0),
		('IHSFP','SFCI','IHM','admin','admin',0),
		('OOH','NA','OHM','admin','admin',1),
		('CPS','IR','CPS-IR','admin','admin',1),
		('CPS','AR','CPS-AR','admin','admin',1);