/*
  Issue Description:CDM-42838
Category/ Module:Application
Root cause: User requested to remove case from SEN flag,  unselect the substance exposed newborn in SDM and make sure the changes are reflected in the case level.
Also add the following in the Narrative field.
Pull request# for code fix:
Reason why no related code fix:
Status of the code fix if already submitted and expected prod fix date:
   Backup before update/ delete: 
*/

update person
set substanceexposednewbornflag = NULL, 
	substanceexposednewbornsourcetypekey = NULL, 
	substanceexposednewbornsourceid = NULL,
	substanceexposednewborntimetamp = NULL,
	substanceclasses = NULL, 
	senstatusflag = NULL, 
	updatedby = 'CDM-42838', 
	updatedon = now()
where cjamspid = 204030445
	and activeflag = 1;

	


 UPDATE intakedastaging 
SET updatedby = 'CDM-42838', updatedon = now(),
jsondata = REPLACE (jsondata :: TEXT, ' "isnegrh_exposednewborn": true', '  "isnegrh_exposednewborn": false' )::jsonb
WHERE intakenumber = 'I241013179970' AND activeflag = 1;

UPDATE intakesnapshot  
SET updatedby = 'CDM-42838', updatedon = now(),
jsondata = REPLACE (jsondata :: TEXT, ' "isnegrh_exposednewborn": true', '  "isnegrh_exposednewborn": false' )::jsonb
WHERE intakenumber = 'I241013179970' AND activeflag = 1;

update intakedastaging
set jsondata = 
	jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}',
	'"<p>****Reporter asked that the assigned worker go to the nurses station to check in first. The father has told the mother that if she tells anything to CPS that he will take the children away from her. She also did not want to speak about the domestic violence history in front of the father.****</p><p><br></p><p><br></p><p>Reporter states that Theresa Pallett-Gerlach was born on 11/19/2024 at 38 weeks gestation weighing 6 pounds 9 ounces. Ms. Pallett-Gerlasch tested positive for cannabis and the results of the meconium testing have not been received yet. Theresa is in the special care nursery due to breathing issues. Ms. Pallett-Gerlasch received prenatal care from Capital Women`s Care. Reporter states that both mother and father have been very attentive to Theresa and they report having all the supplies that are needed. They do report food insecurity and that their electric will be turned off on Friday due to non payment.</p><p><br></p><p>Reporter states concerns due to domestic violence in the home. Ms. Pallett-Gerlach was guarded in what she was saying while Mr. Taylor, the father, was present. She did convey that there has been domestic violence in the past, but that he stopped hitting her when she became pregnant. Ms. Pallett-Gerlasch told the reporter that Mr. Taylor spanks Anthony, but reported no injuries. On 8/11/2024 Ms. Pallett-Gerlach and Mr. Taylor were arguing and Mr. Taylor was holding Joseph. When he put Joseph down he started to run away and when Ms. Pallett-Gerlach grabbed for him Joseph fell into the wall and bumped his head causing a welt. Reporter states that the police were called on that occasion.</p><p><br></p><p>Ms. Pallett-Gerlach is the mother of Joseph and Theresa.</p><p>The mother of Anthony is unknown to the reporter, but does live in the same home.</p><p><br></p><p><br></p><p><strong>***Initially screened as a SENS but does not meet criteria without test results for baby or withdrawal symptoms.  Screening as ROH DV.</strong></p><p><strong>**Initially screened as a SENS but does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD).Screening as ROH DV.204030445</strong></p>"')
	),
	updatedby = 'CDM-42838', updatedon = now()
where intakenumber = 'I241013179970' and activeflag = 1;
  

update intakedastatus
set jsondata = 
	jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}',
	'"<p>****Reporter asked that the assigned worker go to the nurses station to check in first. The father has told the mother that if she tells anything to CPS that he will take the children away from her. She also did not want to speak about the domestic violence history in front of the father.****</p><p><br></p><p><br></p><p>Reporter states that Theresa Pallett-Gerlach was born on 11/19/2024 at 38 weeks gestation weighing 6 pounds 9 ounces. Ms. Pallett-Gerlasch tested positive for cannabis and the results of the meconium testing have not been received yet. Theresa is in the special care nursery due to breathing issues. Ms. Pallett-Gerlasch received prenatal care from Capital Women`s Care. Reporter states that both mother and father have been very attentive to Theresa and they report having all the supplies that are needed. They do report food insecurity and that their electric will be turned off on Friday due to non payment.</p><p><br></p><p>Reporter states concerns due to domestic violence in the home. Ms. Pallett-Gerlach was guarded in what she was saying while Mr. Taylor, the father, was present. She did convey that there has been domestic violence in the past, but that he stopped hitting her when she became pregnant. Ms. Pallett-Gerlasch told the reporter that Mr. Taylor spanks Anthony, but reported no injuries. On 8/11/2024 Ms. Pallett-Gerlach and Mr. Taylor were arguing and Mr. Taylor was holding Joseph. When he put Joseph down he started to run away and when Ms. Pallett-Gerlach grabbed for him Joseph fell into the wall and bumped his head causing a welt. Reporter states that the police were called on that occasion.</p><p><br></p><p>Ms. Pallett-Gerlach is the mother of Joseph and Theresa.</p><p>The mother of Anthony is unknown to the reporter, but does live in the same home.</p><p><br></p><p><br></p><p><strong>***Initially screened as a SENS but does not meet criteria without test results for baby or withdrawal symptoms.  Screening as ROH DV.</strong></p><p><strong>**Initially screened as a SENS but does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD).Screening as ROH DV.204030445</strong></p>"')
	),
	updatedby = 'CDM-42838', updatedon = now()
where intakenumber = 'I241013179970' and activeflag = 1;
 
  

update intakesnapshot
set jsondata = 
	jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}',
	'"<p>****Reporter asked that the assigned worker go to the nurses station to check in first. The father has told the mother that if she tells anything to CPS that he will take the children away from her. She also did not want to speak about the domestic violence history in front of the father.****</p><p><br></p><p><br></p><p>Reporter states that Theresa Pallett-Gerlach was born on 11/19/2024 at 38 weeks gestation weighing 6 pounds 9 ounces. Ms. Pallett-Gerlasch tested positive for cannabis and the results of the meconium testing have not been received yet. Theresa is in the special care nursery due to breathing issues. Ms. Pallett-Gerlasch received prenatal care from Capital Women`s Care. Reporter states that both mother and father have been very attentive to Theresa and they report having all the supplies that are needed. They do report food insecurity and that their electric will be turned off on Friday due to non payment.</p><p><br></p><p>Reporter states concerns due to domestic violence in the home. Ms. Pallett-Gerlach was guarded in what she was saying while Mr. Taylor, the father, was present. She did convey that there has been domestic violence in the past, but that he stopped hitting her when she became pregnant. Ms. Pallett-Gerlasch told the reporter that Mr. Taylor spanks Anthony, but reported no injuries. On 8/11/2024 Ms. Pallett-Gerlach and Mr. Taylor were arguing and Mr. Taylor was holding Joseph. When he put Joseph down he started to run away and when Ms. Pallett-Gerlach grabbed for him Joseph fell into the wall and bumped his head causing a welt. Reporter states that the police were called on that occasion.</p><p><br></p><p>Ms. Pallett-Gerlach is the mother of Joseph and Theresa.</p><p>The mother of Anthony is unknown to the reporter, but does live in the same home.</p><p><br></p><p><br></p><p><strong>***Initially screened as a SENS but does not meet criteria without test results for baby or withdrawal symptoms.  Screening as ROH DV.</strong></p><p><strong>**Initially screened as a SENS but does not meet SEN criteria (no positive tox result, no effects of prenatal substance exposure, or fetal alcohol spectrum disorder/FASD).Screening as ROH DV.204030445</strong></p>"')
	),
	updatedby = 'CDM-42838', updatedon = now()
where intakenumber = 'I241013179970' and activeflag = 1;

update cjams.intakeservicerequestsdm 
set drugexposednewbornflag = 0, updatedby= 'CDM-42838', updatedon=NOW()
where intakeserviceid='b9c9cb49-1501-4068-a21a-b6860245cc73' and activeflag=1;

  



