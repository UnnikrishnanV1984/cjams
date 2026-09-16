-- Step II
-- To call expungementsave 

-- CDM-12327 - Maltreator was identified in error
-- CDM-12335 - Maltreator was identified in error
-- CDM-12336 - Maltreator identified in error

select cjams.expungementsave(
	(select expungementid from expungement where insertedby = 'CDM-12327' and activeflag = 1)::uuid, 
	'CDM-12327'::character varying
) ;


select cjams.expungementsave(
	(select expungementid from expungement where insertedby = 'CDM-12335' and activeflag = 1)::uuid, 
	'CDM-12335'::character varying
) ;

select cjams.expungementsave(
	(select expungementid from expungement where insertedby = 'CDM-12336' and activeflag = 1)::uuid, 
	'CDM-12336'::character varying
) ;