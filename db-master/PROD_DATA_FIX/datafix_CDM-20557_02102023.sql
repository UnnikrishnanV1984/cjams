/*
   Issue Description: CDM-20557 - manual expungement
   
   CW2955567:User need to complete the manual expungement of removing the alleged maltreator's name from the Investigation Narrative and 
   replace his name with "unnamed". However, nothing is showing in the Investigation Narrative.
   
   Category/ Module  :  INVESTIGATION SUMMARY
*/

/*email : 
donna.duvall@maryland.gov
*/


SELECT	ivd.narrative
FROM 	referralinvestigationdisposition ivd 
WHERE	ivd.parentkeyid in (select ial.investigationallegationmaltreatorsid from investigationallegationmaltreators ial where ial.investigationallegationid = '78c19ac9-5acd-4e19-88e9-6529d23e7939')	
AND 	ivd.narrative IS NOT NULL and investigationdispositionid = 'ca1e9e69-c43c-4ee9-8268-1b2c9aa7ef82'; 

UPDATE referralinvestigationdisposition
SET 
updatedby = 'CDM-20557',
updatedon = now(),
narrative='Jaila has been hosptialized 4 times in the past year.  Her parents either do not show up for family meeting or they show up and trash eachother.  Jaila stated she is miserable.  She seeks attention from boys and drugs just to get attention.  Jaila reports her mother kicked her out of the home after her last Sheppard Pratt admission so she went to live with her father.  Since she has been at her father''s home she admitted to sneaking out of the home to go and see her boyfriend that drove down from Pennsylvania.  She was able to contact him on the computer and they made the arranged date.  She jumped off the back porch when leaving the home because it was the only way she could get out without alerting anyone.  She hurt her back.  She knows it was a dumb decison but she really wanted to see her boyfriend  and smoke weed.  

On 05-29-2020, at the time of her discharge from Sheppard Pratt Hospital Jaila was recommended for a Treatment Foster Care Placement because her parents would not take her back home.

Based on the above information and the admission of both Mona Raver and unnamed that they are unwilling to allow Jaila to return to their care UNSUBSTANTIATED Neglect is the appropriate dispostion.  

As the Dispositon is UNSUBSTANTIATED, Mona Raver and unnamed are the alleged Neglectors. 
'
WHERE investigationdispositionid = 'ca1e9e69-c43c-4ee9-8268-1b2c9aa7ef82';

SELECT	ivd.narrative
FROM 	referralinvestigationdisposition ivd 
WHERE	ivd.parentkeyid in (select ial.investigationallegationmaltreatorsid from investigationallegationmaltreators ial where ial.investigationallegationid = '78c19ac9-5acd-4e19-88e9-6529d23e7939')	
AND 	ivd.narrative IS NOT NULL and investigationdispositionid = 'ff6662ac-133a-4101-9d92-78ecc426e866'; 

UPDATE referralinvestigationdisposition
SET 
updatedby = 'CDM-20557',
updatedon = now(),
narrative='Neglect of JAILA BASIT is "UNSUBSTANTIATED" in accordance with the provisions of Maryland Code Ann., Fam. Law § 5-701(s), (y) and COMAR 07.02.07.13B. It is the professional assessment of this worker that there is insufficient credible evidence to support a finding of either "indicated " or "ruled out" neglect in that:
   1) Failure to provide proper care or leaving a child unattended;
   2) caused by a parent, caretaker, or household or family member;
   3) to a child under the age of 18;
   4) where, the nature, extent, and location of the injury show either or both
      a) harm to a child; or
      b) during the incident, a substantial risk of harm to a child.


On 05-28-2020, Worker contacted Jaila''s mother-Mona Raver.  Ms. Raver reported she would not take Jaila back in her home at this time.  She was not willing to pick Jaila up from the hospital.  She went on to report that Jaila has behavioral concerns and acted out at her home in February 2020.  She described how Jaila became aggressive at home and pulled a knife on her and her spouse Johnathan.  Mona believed Jaila was unpredictable so she took her to Sheppard Pratt for an evaluation.  Mona reported she is fearful of Jaila and her behaviors when she becomes aggressive.  She contacted unnamed and told him Jaila couldn''t come back to her home.  He took Jaila into his home and now she has found out that Jaila has been at his home with some of the same behaviors.  

Mona began to report that the police have been to her home on three occassions because of Jaila.  The first incident was February 2020 when she told Jaila she couldn''t keep her birthday gifts.  Jaila hit on her and slapped Johnathan in the face.  Jaila called the police and told them they hit her but after they arrived and assessed the situation they learned Jaila was the aggressor.  The second contact with the police came when she ran away and the police located her at the home of a peer.  The third encounter came when Jaila had an Ipad and Mona tried to take it back.  Jaila beat her up, told her she hated her, said she wanted her to die as she got a sharp knife and chased her.  Mona reporst she locked herself in the bathroom and Johnathan got the knife from her.  They called unnamed and he agrreed her behaviors were not good.  Jaila went back to Sheppard Pratt and unnamed agreed to take her back to his home.  

Mona reports she wants unnamed to take responsibility of Jaila because she doesn''t act out with him.  Mona also reitterated her need to protect her other children from Jaila''s behaviors.  Mona admitted she and unnamed do not communicate well and they do not share what happens in eachother''s homes.  

On 05-28-2020, this Worker reported to the home of unnamed.  He offered that he will not pick Jaila up from the hospital as he believes she needs to attend a longterm behavioral health care program.  unnamed went on to report the issues with Jaila are between her and her mother.  He offered that her mother (Mona Raver) will not change.  Jaila was in therapy with Katie Storm of True North Counseling in Hanover, Pa.  She was supposed to attend weekly but Mona did not want her to go.  She was recommended for in-home counseling but it nevery happened because Mona didn''t follow-up.  unnamed pointed out that in March 2020, Mona refused to pick up Jaila at her discharge she he went and brought her back to his home.  Jaila remained in his home but she has maintained that she wanted to return to her mother''s care.  Her mother repeatedly told her no she could not come back.  During her stay at his home, Jaila has been caught lying, stealing, saying she wants to die and jumping off the deck to meet her boyfriend.  She also told her sister she wanted to self harm.  After assessing her behaviors unnamed and his spouse Jackie decided Jaila wasn''t going to stop with her threats of self harm.  So they took her back to Sheppard Pratt for an evaluation after talking to her therapist at Safe Harbor. 

Worker reported to Sheppard Pratt Behavioral Health to meet with Jaila Basit.  She seemed sad/depressed but she was talkative and knowledgeable about her family dynamics and why she was hospitalized.  Jaila immediately began to talk about how her parents are done with her because of her behaviors.  She blammed some of her behaviors on her parents not getting along and making her and her sister feel they are between them and have to choose over the other parent to get validated.  She added, her parents hate eachother and curse eachother out.  '
WHERE investigationdispositionid = 'ff6662ac-133a-4101-9d92-78ecc426e866';