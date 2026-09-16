delete from physicianspecialtytype where physicianspecialtytypekey ='DP' and 
description = 'Dental Practice';

INSERT INTO cjams.physicianspecialtytype (physicianspecialtytypekey,description,activeflag,insertedon,effectivedate)
VALUES ('DP','Dental Practice',1,'now()','now()');


-- Actual parameter values may differ, what you see is a default string representation of values
UPDATE cjams.referencevalues
SET description='CNM',value_text='CNM'
WHERE ref_key='CNM' AND referencetypeid=335 AND value_text='CNM (clinical nurse midwife)' AND description='CNM (clinical nurse midwife)' AND teamtypekey='CW' AND activeflag=1 AND displayorder=5 AND insertedby='Admin' AND insertedon='2019-04-26 15:31:53.218' AND updatedby='Admin' AND updatedon='2019-04-26 15:31:53.218' AND parenttypeid IS NULL AND parentkey IS NULL AND mdmcode IS NULL;
UPDATE cjams.referencevalues
SET description='CNS',value_text='CNS'
WHERE ref_key='CNS' AND referencetypeid=335 AND value_text='CNS (clinical nurse specialist)' AND description='CNS (clinical nurse specialist)' AND teamtypekey='CW' AND activeflag=1 AND displayorder=4 AND insertedby='Admin' AND insertedon='2019-04-26 15:31:53.218' AND updatedby='Admin' AND updatedon='2019-04-26 15:31:53.218' AND parenttypeid IS NULL AND parentkey IS NULL AND mdmcode IS NULL;
UPDATE cjams.referencevalues
SET description='PA',value_text='PA'
WHERE ref_key='PA' AND referencetypeid=335 AND value_text='PA (physician assistant)' AND description='PA (physician assistant)' AND teamtypekey='CW' AND activeflag=1 AND displayorder=3 AND insertedby='Admin' AND insertedon='2019-04-26 15:31:53.218' AND updatedby='Admin' AND updatedon='2019-04-26 15:31:53.218' AND parenttypeid IS NULL AND parentkey IS NULL AND mdmcode IS NULL;
UPDATE cjams.referencevalues
SET description='NP',value_text='NP'
WHERE ref_key='NPNP' AND referencetypeid=335 AND value_text='NP (nurse practitioner)' AND description='NP (nurse practitioner)' AND teamtypekey='CW' AND activeflag=1 AND displayorder=2 AND insertedby='Admin' AND insertedon='2019-04-26 15:31:53.218' AND updatedby='Admin' AND updatedon='2019-04-26 15:31:53.218' AND parenttypeid IS NULL AND parentkey IS NULL AND mdmcode IS NULL;