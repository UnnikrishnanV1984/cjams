/*
   Issue Description: CDM-28570
   Category/ Module  :amir-jeter-sen-flag
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE intakesnapshot 
 set updatedby = 'CDM-28570', updatedon = now(),
 jsondata = jsonb_set(jsondata, '{DAType}', 
            jsonb_set(jsondata->'DAType', '{DATypeDetail}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}', 
            jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I231010374627' AND activeflag=1;

update intakeservicerequest set servicecaseid = null, updatedby = 'CDM-28570', updatedon = now() where intakeserviceid = 'c74e6a1c-a8c1-4e98-a5c5-6d3c642d17f8';

update person set substanceexposednewbornflag = 0, updatedby = 'CDM-28570', updatedon = now() where personid = '074f59ea-60b6-43e1-bfab-d8b1411b1752';

update intakesnapshot 
set jsondata = replace(jsondata::text, '"Narrative": "<p>Asia and Robert Jeter are the parents of baby boy Amir Jeter (DOB: 1/17/2023) and are reported to be residing at 1818 St. George Court, Edgewood, MD 21040. The mother delivered by caesarean birth. The mother tested positive for marijuana and child tested negative at delivery. The reporter revealed that the meconium will test. The gestational stage was 35 weeks and 6 days. Baby Amir weighed 2570 grams, 5 pounds and 10 ounces. The APGAR Scores were 9 and 9. The mother shared with the reporter that she used marijuana for hyperglycemia.</p><p>&nbsp;</p><p>There are no withdrawal symptoms being experienced by the baby. There are no mental health concerns regarding the mother. The mother reports that she has all the necessary baby supplies needed for her newborn. Mother is receiving WIC and Medical Assistance. It is reported there are no mental health concerns regarding father. There are no reported or observed concerns for domestic violence between mother and father. The reporter stated that the mother and father have a strong relationship.</p><p>&nbsp;</p><p>&nbsp;</p><p>The mother and her child are scheduled to be discharged from the hospital on 1/20/2023.</p><p><br></p>",' , '"Narrative": "<p>The reporter called to report that Rayla Jeter born on 03/09/2022 at the Greater Baltimore Medical Center. She weighed 5 pounds and 7 ounces and was born via Caesarean section.</p><p>Both mom and Rayna tested positive for Marijuana. Her APGAR was 9 and 9. The mother had good prenatal care.</p><p>Asia Jeter reports that she smoked marijuana everyday while pregnant for nausea and vomiting. She smoked Marijuana most of her pregnancy, the last time was four days ago. Asia does not have a Marijuana medical care.</p><p><br></p><p>Expected Discharge is 3/12/2022.</p><p><br></p><p>The parents are Asia and Robert Jeter. They have two other children in the home named Robynn and Raina Jeter.</p><p><br></p><p><br></p><p>No further details reported.</p>",')::json,
updatedby = 'CDM-28570', updatedon = now() 
 where intakenumber = 'I231010374627' and activeflag = 1;

update cjams.person
set 
updatedby = 'CDM-28570', updatedon = now(), substanceexposednewbornflag = null, substanceclasses = null, substanceexposednewbornsourceid = null,substanceexposednewbornsourcetypekey = null, substanceexposednewborntimetamp = null, othersubstances = null where personid = '074f59ea-60b6-43e1-bfab-d8b1411b1752';