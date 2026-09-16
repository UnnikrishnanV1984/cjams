

/*
   Issue Description: CDM-25095
   Category/ Module  : intakesdm 
   Root cause: user requested change case type
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm, noImmediateList}','[
    {
    
      "isnoimmed_risk_harm": false,
      "isnoimmed_sexualabuse": false,
      "isnoimmed_mentalinjury": false,
      "isnoimmed_physicalabuse": false,
      "isnoimmed_neglectresponse": true,
      "isnoimmed_substantial_risk": false
    
    }
    ]')
,updatedby = 'CDM-25095'
,updatedon = now()
where intakenumber = 'I221010310362' AND activeflag=1;


UPDATE cjams.intakedastaging
SET jsondata = jsonb_set(jsondata, '{sdm, noImmediateList}','[
    {
    
      "isnoimmed_risk_harm": false,
      "isnoimmed_sexualabuse": false,
      "isnoimmed_mentalinjury": false,
      "isnoimmed_physicalabuse": false,
      "isnoimmed_neglectresponse": true,
      "isnoimmed_substantial_risk": false
    
    }
    ]')
,updatedby = 'CDM-25095'
,updatedon = now()
where intakenumber = 'I221010310362' AND activeflag=1;


update intakesnapshot 
set jsondata = replace (jsondata::text,  '"immediate": ""', '"immediate": "No Immediate"' )::jsonb,
   updatedby = 'CDM-25095', 
     updatedon = now()
where intakenumber = 'I221010310362' AND activeflag=1;


update intakedastaging 
set jsondata = replace (jsondata::text,  '"immediate": ""', '"immediate": "No Immediate"' )::jsonb,
   updatedby = 'CDM-25095', 
     updatedon = now()
where intakenumber = 'I221010310362' AND activeflag=1;




update cjams.intakeservicerequestsdm set isar = true,isnoimmed_neglectresponse = true, updatedby ='CDM-25095', updatedon = now()

where intakeservicerequestsdmid ='5efb971e-b6cc-4e5e-ae63-30de624f986e';




UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isimmed_seriousinjury}','null')
where intakenumber = 'I221010310362'  AND activeflag=1;


UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isnoimmed_sexualabuse}','false')
where intakenumber = 'I221010310362'  AND activeflag=1;


UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isimmed_childfaatility}','null')
where intakenumber = 'I221010310362'  AND activeflag=1;


UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isimmed_childleftalone}','null')
where intakenumber = 'I221010310362'  AND activeflag=1;


UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isnoimmed_mentalinjury}','false')
where intakenumber = 'I221010310362'  AND activeflag=1;

UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isnoimmed_physicalabuse}','false')
where intakenumber = 'I221010310362'  AND activeflag=1;

UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isneggn_signsordiagnosis}','false')
where intakenumber = 'I221010310362'  AND activeflag=1;

UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isnoimmed_neglectresponse}','true')
where intakenumber = 'I221010310362'  AND activeflag=1;

UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,isnoimmed_substantial_risk}','false')
where intakenumber = 'I221010310362'  AND activeflag=1;


UPDATE cjams.intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm,ismenng_psycologicalability}','false')
where intakenumber = 'I221010310362'  AND activeflag=1;
