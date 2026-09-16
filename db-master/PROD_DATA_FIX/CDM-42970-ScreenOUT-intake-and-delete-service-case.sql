 /*

   Issue Description: CDM-42970-Sens service case

   Category/ Module  :  Person profile,Intake,ServiceCase

   Root cause:241030336246:
   Fix provided : Datafix  to remove SEN flag from the child , 
    Screen out intake and Remove the service case

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/

update person 
set senstatusflag = null,
substanceexposednewbornflag = null, 
substanceclasses = null, 
substanceexposednewbornsourceid = null,
substanceexposednewbornsourcetypekey = null, 
substanceexposednewborntimetamp = null, 
othersubstances = null  ,
updatedby = 'CDM-42970',
updatedon = now()
 where personid = '787f3f50-1c4f-4d69-b859-9c87b79b85f6';



 UPDATE intakedastaging
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'false'))
    , updatedby = 'CDM-42970'
    , updatedon = now()
WHERE intakenumber = 'I241013182121' 
      AND activeflag=1;

UPDATE intakedastaging 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
    , updatedby = 'CDM-42970'
    , updatedon = now()
WHERE intakenumber = 'I241013182121' 
      AND activeflag = 1;


	  
     UPDATE intakesnapshot
SET jsondata = jsonb_set(jsondata, '{sdm}', jsonb_set(jsondata->'sdm', '{isnegrh_exposednewborn}', 'false'))
    , updatedby = 'CDM-42970'
    , updatedon = now()
WHERE intakenumber = 'I241013182121' 
      AND activeflag=1;

UPDATE intakesnapshot 
SET jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
    , updatedby = 'CDM-42970'
    , updatedon = now()
WHERE intakenumber = 'I241013182121' 
      AND activeflag = 1;

update intakedastaging
set jsondata = 
	jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}',
	'"<p>On 11/23/24 CWS AH S/W T. Kelly received the following information regarding newborn, Layla Rabinowitz, born 11/22/24</p><p><br></p><p>\"Took call from Crisis Center. Mother tested positive for opiates but the child did not. Crisis Center did not know whether the mother had a C-section or used substances. Crisis Center staff did not get the name of the hospital. The number dialed did not go through after making several attempts. The on call supervisor was notified.\" No DOB or phone number for Mother was listed on the 743. Mother''s complete demographic info obtained via MVA search.</p><p><br></p><p>11/25/24 Screener B. Fitzgibbon called SW on-call cell (ph:240-328-4603) for Adventist HealthCare Shady Grove Medical Center (ph: <span style=\"background-color: rgba(0, 0, 0, 0); color: rgb(0, 0, 0);\">240-826-7384)</span> but call went straight to VM. This writer also attempted to reach the Adventist HealthCare social workers via their desk line but no one answered and there was no option to leave a v/m. Number as written on 743 was not in service.</p><p><br></p><p>12:14 p.m. Spoke with S/W Maria Cole who said child was already discharged. Mother reports that she ate a poppyseed bagel.</p><p><br></p><p>3 y.o. son, Noah, and husband at home. History of work related anxiety, panic attacks with symptoms. Takes Zoloft. Had a therapist and MH improved since then. Mother denied substance or alcohol use. Consumed a lot of poppyseed bagels during pregnancy and was prepared to show a receipt from Dunkin Donuts from the day of delivery. Baby''s urine negative.</p><p><br></p><p>Mother''s PH: 347-268-6982.</p><p><br></p><p>No info listed for Father/husband. Screener identified Father/husband via combo of SDAT and MVA searches.</p><p><br></p><p>Healthy pregnancy, 40 weeks 5 days gestation, APGARS 8 and 9, vaginal delivery with epidural, 9lb 4 oz.</p><p>Unlikely that epidural had anything to do with Mother''s positive tox screen. Baby''s meconium not back yet.</p><p><br></p><p>Pediatrician: Dr. Paul Weiner of Bethesda.</p><p>Mother said she has support from relatives and all necessary supplies for baby.</p><p><br></p><p>SEN paperwork pending.</p><p><br></p><p>Reviewed w/ Screening Supervisor J. Knotts. Will pend report until COB 11/27/24 to see if meconium results come in.</p><p><br></p><p>Mother and baby discharged on November 23, 2024 </p><p><br></p><p>T/C 11/27/2024 J. Knotts, Screening Supervisor, called and spoke to Glenda L., Social Worker, meconium came back positive on 11/26/2024 positive for meth amphetamines, cocaine, benzos, and opiates . Glenda L. glazo@adventisthealthcare.com neg for opiates pos fentanyl mother medicate in labor and delivery</p><p><br></p><p><strong>CJAMS Contact Support Ticket# S20240323062902. SSA program staff on 12/2/2024 approved Screen-Out decision. Initially screened as a SEN but meconium results received and new information from hospital indicate newborn does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD)</strong></p>"')
	),
	updatedby = 'CDM-42970', updatedon = now()
where intakenumber = 'I241013182121' and activeflag = 1;

update intakedastatus
set jsondata = 
	jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}',
	'"<p>On 11/23/24 CWS AH S/W T. Kelly received the following information regarding newborn, Layla Rabinowitz, born 11/22/24</p><p><br></p><p>\"Took call from Crisis Center. Mother tested positive for opiates but the child did not. Crisis Center did not know whether the mother had a C-section or used substances. Crisis Center staff did not get the name of the hospital. The number dialed did not go through after making several attempts. The on call supervisor was notified.\" No DOB or phone number for Mother was listed on the 743. Mother''s complete demographic info obtained via MVA search.</p><p><br></p><p>11/25/24 Screener B. Fitzgibbon called SW on-call cell (ph:240-328-4603) for Adventist HealthCare Shady Grove Medical Center (ph: <span style=\"background-color: rgba(0, 0, 0, 0); color: rgb(0, 0, 0);\">240-826-7384)</span> but call went straight to VM. This writer also attempted to reach the Adventist HealthCare social workers via their desk line but no one answered and there was no option to leave a v/m. Number as written on 743 was not in service.</p><p><br></p><p>12:14 p.m. Spoke with S/W Maria Cole who said child was already discharged. Mother reports that she ate a poppyseed bagel.</p><p><br></p><p>3 y.o. son, Noah, and husband at home. History of work related anxiety, panic attacks with symptoms. Takes Zoloft. Had a therapist and MH improved since then. Mother denied substance or alcohol use. Consumed a lot of poppyseed bagels during pregnancy and was prepared to show a receipt from Dunkin Donuts from the day of delivery. Baby''s urine negative.</p><p><br></p><p>Mother''s PH: 347-268-6982.</p><p><br></p><p>No info listed for Father/husband. Screener identified Father/husband via combo of SDAT and MVA searches.</p><p><br></p><p>Healthy pregnancy, 40 weeks 5 days gestation, APGARS 8 and 9, vaginal delivery with epidural, 9lb 4 oz.</p><p>Unlikely that epidural had anything to do with Mother''s positive tox screen. Baby''s meconium not back yet.</p><p><br></p><p>Pediatrician: Dr. Paul Weiner of Bethesda.</p><p>Mother said she has support from relatives and all necessary supplies for baby.</p><p><br></p><p>SEN paperwork pending.</p><p><br></p><p>Reviewed w/ Screening Supervisor J. Knotts. Will pend report until COB 11/27/24 to see if meconium results come in.</p><p><br></p><p>Mother and baby discharged on November 23, 2024 </p><p><br></p><p>T/C 11/27/2024 J. Knotts, Screening Supervisor, called and spoke to Glenda L., Social Worker, meconium came back positive on 11/26/2024 positive for meth amphetamines, cocaine, benzos, and opiates . Glenda L. glazo@adventisthealthcare.com neg for opiates pos fentanyl mother medicate in labor and delivery</p><p><br></p><p><strong>CJAMS Contact Support Ticket# S20240323062902. SSA program staff on 12/2/2024 approved Screen-Out decision. Initially screened as a SEN but meconium results received and new information from hospital indicate newborn does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD)</strong></p>"')
	),
	updatedby = 'CDM-42970', updatedon = now()
where intakenumber = 'I241013182121' and activeflag = 1;

update intakesnapshot 
set jsondata = 
	jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}',
	'"<p>On 11/23/24 CWS AH S/W T. Kelly received the following information regarding newborn, Layla Rabinowitz, born 11/22/24</p><p><br></p><p>\"Took call from Crisis Center. Mother tested positive for opiates but the child did not. Crisis Center did not know whether the mother had a C-section or used substances. Crisis Center staff did not get the name of the hospital. The number dialed did not go through after making several attempts. The on call supervisor was notified.\" No DOB or phone number for Mother was listed on the 743. Mother''s complete demographic info obtained via MVA search.</p><p><br></p><p>11/25/24 Screener B. Fitzgibbon called SW on-call cell (ph:240-328-4603) for Adventist HealthCare Shady Grove Medical Center (ph: <span style=\"background-color: rgba(0, 0, 0, 0); color: rgb(0, 0, 0);\">240-826-7384)</span> but call went straight to VM. This writer also attempted to reach the Adventist HealthCare social workers via their desk line but no one answered and there was no option to leave a v/m. Number as written on 743 was not in service.</p><p><br></p><p>12:14 p.m. Spoke with S/W Maria Cole who said child was already discharged. Mother reports that she ate a poppyseed bagel.</p><p><br></p><p>3 y.o. son, Noah, and husband at home. History of work related anxiety, panic attacks with symptoms. Takes Zoloft. Had a therapist and MH improved since then. Mother denied substance or alcohol use. Consumed a lot of poppyseed bagels during pregnancy and was prepared to show a receipt from Dunkin Donuts from the day of delivery. Baby''s urine negative.</p><p><br></p><p>Mother''s PH: 347-268-6982.</p><p><br></p><p>No info listed for Father/husband. Screener identified Father/husband via combo of SDAT and MVA searches.</p><p><br></p><p>Healthy pregnancy, 40 weeks 5 days gestation, APGARS 8 and 9, vaginal delivery with epidural, 9lb 4 oz.</p><p>Unlikely that epidural had anything to do with Mother''s positive tox screen. Baby''s meconium not back yet.</p><p><br></p><p>Pediatrician: Dr. Paul Weiner of Bethesda.</p><p>Mother said she has support from relatives and all necessary supplies for baby.</p><p><br></p><p>SEN paperwork pending.</p><p><br></p><p>Reviewed w/ Screening Supervisor J. Knotts. Will pend report until COB 11/27/24 to see if meconium results come in.</p><p><br></p><p>Mother and baby discharged on November 23, 2024 </p><p><br></p><p>T/C 11/27/2024 J. Knotts, Screening Supervisor, called and spoke to Glenda L., Social Worker, meconium came back positive on 11/26/2024 positive for meth amphetamines, cocaine, benzos, and opiates . Glenda L. glazo@adventisthealthcare.com neg for opiates pos fentanyl mother medicate in labor and delivery</p><p><br></p><p><strong>CJAMS Contact Support Ticket# S20240323062902. SSA program staff on 12/2/2024 approved Screen-Out decision. Initially screened as a SEN but meconium results received and new information from hospital indicate newborn does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD)</strong></p>"')
	),
	updatedby = 'CDM-42970', updatedon = now()
where intakenumber = 'I241013182121' and activeflag = 1;

UPDATE intakesnapshot
SET
updatedby = 'CDM-42970', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241013182121' AND activeflag=1;

update routing set supervisordecision ='ScreenOUT',updatedby = 'CDM-42970', updatedon = now()
WHERE objectid  = 'I241013182121' AND activeflag=1;

update servicecase set activeflag =0,updatedby = 'CDM-42970', updatedon = now()
WHERE servicecaseid ='28b83ea1-51c8-420a-8ef5-8d135ef196f3' AND activeflag=1;

update personprogramarea set activeflag =0,updatedby = 'CDM-42970', updatedon = now()
WHERE objectid ='28b83ea1-51c8-420a-8ef5-8d135ef196f3' AND activeflag=1;

update caseassignment set activeflag =0,updatedby = 'CDM-42970', updatedon = now()
WHERE objectid ='28b83ea1-51c8-420a-8ef5-8d135ef196f3' AND activeflag=1;

update routing  set activeflag =0,updatedby = 'CDM-42970', updatedon = now()
WHERE objectid ='28b83ea1-51c8-420a-8ef5-8d135ef196f3' AND activeflag=1;

