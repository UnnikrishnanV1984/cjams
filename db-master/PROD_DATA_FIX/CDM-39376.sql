/*
 * CDM-39376 - Overrode Referral Can't Be Changed to ROH
 * Customer Email ID:diana.tyree2@maryland.gov
 * Description - I241012458717:This referral had to be overrode to make Risk of Harm and not Neglect and it won't allow me to 
 * approve for risk of harm saying that it can't be made a risk of harm as it was connected to an investigation. 
 * data fix to approve the override and create a service case for this intake # I241012458717.
 * Supervisor decision should be screen In
 * A new record for screen In should be created in the submission history
 * Service case should be created and attached to the intake
 * 
 */

UPDATE intakedastaging
SET status = 'Accepted',
updatedby = 'CDM-39376', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I241012458717' AND activeflag=1;

UPDATE intakesnapshot
SET 
updatedby = 'CDM-39376', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I241012458717' AND activeflag=1;

update cjams.routing 
set eventcode='INTR', routingstatustypeid=2, insertedon=now(), insertedby='47dc653d-9089-4b47-b40e-0168ef6c2321', updatedby='47dc653d-9089-4b47-b40e-0168ef6c2321', updatedon=now(), intakerecommendation='Scrnin', supervisordecision='scrnin' 
where objectid = 'I241012458717' and activeflag = 1;

select * from createservicecase('de63b52c-3d63-4964-b872-12af7c097dfb', null, 1,'47dc653d-9089-4b47-b40e-0168ef6c2321', 'intake');

--select isnegrh_risk_dv, isscrnoutrecovr_otherspecify, isrecsc_screenout, isrecsc_scrrenin, 
--isnoimmed_risk_harm , * from intakeservicerequestsdm where intakeserviceid = 'de63b52c-3d63-4964-b872-12af7c097dfb';
UPDATE cjams.intakeservicerequestsdm
SET isnegrh_risk_dv=true, isscrnoutrecovr_otherspecify=false, isrecsc_screenout=false, isrecsc_scrrenin=true, isnoimmed_risk_harm=true, updatedby='CDM-39376', updatedon=now() 
WHERE intakeservicerequestsdmid='d971f3a2-7996-43c1-9ec1-f00540f4c8c3'::uuid and intakeserviceid='de63b52c-3d63-4964-b872-12af7c097dfb'::uuid;
