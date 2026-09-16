/*
   Issue Description: CDM-24593
   Category/ Module  : Intake
   Root cause: Wrong reporter name listed
   Pull request# for data fix: 6218
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
SET  updatedon = now(),updatedby ='CDM-24593',jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{Firstname}', '"Cari"')))
WHERE intakenumber = 'I221010304363' AND activeflag=1;

UPDATE intakesnapshot 
SET updatedon = now(),updatedby ='CDM-24593',jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{Lastname}', '"Bland"')))
WHERE intakenumber = 'I221010304363' AND activeflag=1;