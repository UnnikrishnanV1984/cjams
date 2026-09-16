/*
   Issue Description: CDM-15273
   Category/ Module  :  Wrong reorter and narrative
   Root cause: user wants to replace with correct data
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

	
	UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{General}', 
			jsonb_set(jsondata->'General', '{Firstname}', '"Vanessa"'))
WHERE intakenumber = 'I211010175038' AND activeflag=1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{General}', 
			jsonb_set(jsondata->'General', '{Narrative}', '"<p>Reporter expressed concerns about verbal abuse of a child. Reporter stated River and her mother came into the office today and disclosed to them that her father, Nathan, is verbally abusive and has even shoved her and her siblings before. Reporter stated that Nathan yells at River and her siblings and says mean things, especially when she does something wrong. This has allegedly been going on for a couple years and Nathan simply is constantly putting the kids down. Worker suggested getting the siblings into therapy. River is allegedly in therapy with a Christian based counselor and Avyn utilizes Brook Lane.</p>"'))
WHERE intakenumber = 'I211010175038' AND activeflag=1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{Firstname}', '"Vanessa"')))
WHERE intakenumber = 'I211010175038' AND activeflag=1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentlocation}', '"Hagerstown"')))
WHERE intakenumber = 'I211010175038' AND activeflag=1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{organization}', '" Children''s Doctor"')))
WHERE intakenumber = 'I211010175038' AND activeflag=1;

UPDATE intakesnapshot 
SET jsondata = jsonb_set(jsondata, '{narrative}',
				jsonb_set(jsondata->'narrative', '{0}', 
			jsonb_set(jsondata->'narrative'->0, '{incidentdate}', '"2021-07-17 04:00:00"')))
WHERE intakenumber = 'I211010175038' AND activeflag=1;