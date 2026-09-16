UPDATE investigationfinding
SET investigationfindingtypekey='UD',
findingcomments = (
 SELECT REPLACE(ivd.findingcomments,'INDICATED','UNSUBSTANTIATED') FROM 	investigationfinding ivd 
WHERE	ivd.investigationfindingid = '3acf585d-895f-4128-bf21-d941ecc3b1c9' )
WHERE investigationfindingid = '3acf585d-895f-4128-bf21-d941ecc3b1c9';
                      
																
																
 UPDATE referralinvestigationdisposition
 SET narrative = (
			 SELECT REPLACE(ivd.narrative,'INDICATED','UNSUBSTANTIATED') FROM 	referralinvestigationdisposition ivd 
			WHERE	ivd.investigationdispositionid = '235c656f-0cea-49fe-afe9-4afc5bc4a20c' )
 WHERE investigationdispositionid='235c656f-0cea-49fe-afe9-4afc5bc4a20c';	