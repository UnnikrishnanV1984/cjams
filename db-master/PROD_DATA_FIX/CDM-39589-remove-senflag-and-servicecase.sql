 /*

   Issue Description: CDM-39589-Sens service case

   Category/ Module  :  Person profile,Intake,ServiceCase

   Root cause:241030336246:This case was screened in with the knowledge that mother tested positive for opiods and the prescription was not verified.
    After screen in reporter called back and stated mother prescription was verified by a provider. which means this case is no longer a SENS.

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
updatedby = 'CDM-39589',
updatedon = now()
 where personid = 'f9edf52e-a17d-4646-a383-cea9f002a09f';

 -- edit narrative
 update intakedastaging
set updatedby = 'CDM-39589',
    updatedon = now(),
    jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(
                    select jsonb(jsondata->>'General')-'Narrative' || jsonb(json_build_object('Narrative', '<p>RS: Sinai Hosptial </p><p><br></p><p>Child: Messiah Farmer; 5/29/24 - SEN : Positive for <a href=\"https://www.google.com/search?sca_esv=627549cd271c49f4&amp;rlz=1C1GCEA_enUS1097US1097&amp;q=Buprenorphine&amp;spell=1&amp;sa=X&amp;ved=2ahUKEwi0gLmD07WGAxWMMlkFHb_TC1QQkeECKAB6BAgJEAE\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255); color: var(--JKqx2);\"><strong><em>Buprenorphine</em></strong></a> </p><p>Sibling: Heaven Farmer: 07/21/2019 </p><p><br></p><p>Mother: Samantha Farmer; 443-743-9131</p><p>Father: Teranell Farmer; 443-977-7081</p><p>Address; 5246 Harvey Lane Ellicott City, MD </p><p><br></p><p>Mother is also positive for Buprenorphine. Stated she has been taking it since 2018 from Ideal Options in Catonsville. </p><p>RS does not have any other concerns for the family. </p><p>They family has everything they need for the baby. </p><p>Mother is due for discharge tomorrow and maybe Saturday or Sunday. </p><p>Baby is not currently showing any symptoms but is held for 4 days to monitor. </p><p><br></p><p>Law enforcement notified in writing 5/30/24. </p><p><br></p><p>UPDATE :  mother does have a prescription for the medication and it appears the hospital did check to ensure there was a prescription (RS did not herself but had the doctors check) which meets the exception for a SEN notification per Family Law Article § 5-704.2</p>') )
                    from intakedastaging i 
                    where intakenumber = 'I241012447858' and activeflag = 1))
                ) from intakedastaging i2
                where intakenumber = 'I241012447858' and activeflag = 1)
where intakenumber = 'I241012447858' and activeflag = 1;

update intakesnapshot
set updatedby = 'CDM-39589',
    updatedon = now(),
    jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'Narrative' || jsonb(json_build_object('Narrative', '<p>RS: Sinai Hosptial </p><p><br></p><p>Child: Messiah Farmer; 5/29/24 - SEN : Positive for <a href=\"https://www.google.com/search?sca_esv=627549cd271c49f4&amp;rlz=1C1GCEA_enUS1097US1097&amp;q=Buprenorphine&amp;spell=1&amp;sa=X&amp;ved=2ahUKEwi0gLmD07WGAxWMMlkFHb_TC1QQkeECKAB6BAgJEAE\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255); color: var(--JKqx2);\"><strong><em>Buprenorphine</em></strong></a> </p><p>Sibling: Heaven Farmer: 07/21/2019 </p><p><br></p><p>Mother: Samantha Farmer; 443-743-9131</p><p>Father: Teranell Farmer; 443-977-7081</p><p>Address; 5246 Harvey Lane Ellicott City, MD </p><p><br></p><p>Mother is also positive for Buprenorphine. Stated she has been taking it since 2018 from Ideal Options in Catonsville. </p><p>RS does not have any other concerns for the family. </p><p>They family has everything they need for the baby. </p><p>Mother is due for discharge tomorrow and maybe Saturday or Sunday. </p><p>Baby is not currently showing any symptoms but is held for 4 days to monitor. </p><p><br></p><p>Law enforcement notified in writing 5/30/24. </p><p><br></p><p>UPDATE :  mother does have a prescription for the medication and it appears the hospital did check to ensure there was a prescription (RS did not herself but had the doctors check) which meets the exception for a SEN notification per Family Law Article § 5-704.2</p>') )
                from intakesnapshot i 
                where intakenumber = 'I241012447858' and activeflag = 1)))
                from intakesnapshot i2
                where intakenumber = 'I241012447858' and activeflag = 1)
where intakenumber = 'I241012447858' and activeflag = 1;


UPDATE intakesnapshot
SET
updatedby = 'CDM-39589', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012447858' AND activeflag=1;

UPDATE intakedastaging
SET status = 'Closed',
updatedby = 'CDM-39589', updatedon = now(), jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"ScreenOUT"'))))
WHERE intakenumber = 'I241012447858' AND activeflag=1;

Update routing set 
updatedby = 'CDM-39589', updatedon = now(), activeflag =0, routingstatustypeid = 8
WHERE objectid = 'I241012447858';

update intakedastatus 
set status = 8, updatedby = 'CDM-39589', updatedon = now()
where intakenumber = 'I241012447858' and activeflag = 1;

update servicecase 
set activeflag = 0, updatedby = 'CDM-39589', updatedon = now()
where servicecaseid = '0c1cc2f6-2e70-49af-a17c-6d099fa40693' and activeflag = 1;

UPDATE personprogramarea
SET activeflag = 0, updatedon = now(), updatedby = 'CDM-39589'
WHERE objectid = '0c1cc2f6-2e70-49af-a17c-6d099fa40693' AND activeflag =1;

update caseassignment
set activeflag = 0, updatedby = 'CDM-39589', updatedon = now() 
where objectid = '0c1cc2f6-2e70-49af-a17c-6d099fa40693' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-39589', updatedon = now() 
where objectid = '0c1cc2f6-2e70-49af-a17c-6d099fa40693' and activeflag = 1;