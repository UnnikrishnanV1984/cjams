DO $$
<<block1>>
DECLARE
noteIdToNoteArrays TEXT[] := ARRAY[['381e6b05-1f3d-4603-aca2-fecd3e94ab50',
'<p>CPS investigator Johnson went to the home of Janea Carter. Ms. Carter has a two-year-old daughter named Jaida Chambers. Mr. <b>Joshua Chambers</b> is the biological father of two-year-old Jaida Chambers. This worker spoke and interviewed Joshua Chambers. Mr. Chambers stated that he is the fianc&eacute; of Janea Carter with plans to marry Ms. Carter in the future. Mr. Chambers told this worker that he works security and has several other incomes to care for his family. Mr. Chambers stated that he does have several guns; some of the guns are needed for work, and the other he uses to hunt with. Mr. Chambers showed this worker a license permit to have and carry his guns and permits to register his guns. Mr. Chambers stated that no time has any of the children allowed to play with the guns, nor does he let the children around the guns. Mr. Chamber noted that he only brings his guns out to clean, but the children are asleep when he cleans his guns. Ms. Chambers was able to show this worker the gun holsters for the guns are concealed in and a gun closet with a lock to keep the guns away from the children. Mr. Chambers stated that he is a hunter and outdoors person. Mr. Chambers also has axes in his locked storage with the guns. Mr. Chambers says that he is a stableman and would never put his family in harm''s way. Mr. Chambers denied putting his hands on Ms. Carter and stated that they had heated arguments but never has he laid a hand on Ms. Carter and denied that domestic violence exists between the two. Mr. Chambers noted that Ms. Carter''s daughter Imani Berry does not like him ever since he came into Ms. Carter''s life. Mr. Chambers denied that Immanuel cut his hand on any of his guns and stated the boys have seen him clean the guns from a distance but never has any child in the home touched his guns. Mr. Chambers said he has taken gun safety classes by the State of Maryland and feels he is very well trained and licensed in the State of Maryland to handle his guns and does not pose a threat or danger to his family living in the home with him. Mr. Chambers stated that he is a believer in the second amendment. Mr. Chambers noted that he loves Ms. Carter and plans to marry her. Mr. Chambers denies allegations that their home is dirty.</p>'],
['fe47f3ed-852d-46bd-b8f7-6e2384c03be1',
'<p>CPS investigator Johnson interviewed <b>Janea Carter</b> in her home. Ms. Carter is the biological mother of (6) Samuel, Immanuel, and Imani Berry (12), Samuel Berry''s father. Ms. Carter is the biological mother of Jaida Chambers (2) the biological father is Joshua Chambers. Ms. Carter denied domestic violence allegations between her and Mr. Chambers but stated that she experienced constant domestic violence between her and Mr. Samuel Berry. Ms. Carter said that during the time she was in a relationship with Mr. Berry from 2007-2017, Ms. Carter was abused by Mr. Berry and that her daughter Imani witnessed the abuse of her father, Mr. Berry, every day with only one year that Mr. Berry did not physically abuse Ms. Carter. Imani witnessed Mr. Berry choking Ms. Carter and throwing Ms. Carter on the bed after Mr. Berry abused Ms. Carter. Eventually, Ms. Carter stated that she moved out of the home she shared with Mr. Berry after one year as Mr. Berry was unemployed. Ms. Carter said that Mr. Berry made threats to her while in a relationship with him. Ms. Carter stated that Imani lived with her until 2021. Ms. Carter constantly stayed on Imani to clean her room or clean anything; Imani would become mad and have an attitude. Imani would tell her father about any problems in the home with her, and Mr. Chambers and Mr. Berry would sabotage the whole situation and were angry because Ms. Carter had moved on with a new relationship with Mr. Chambers. Mr. Berry would tell the children that he wanted Ms. Berry to die. Ms. Carter allowed Imani to go and live with Mr. Berry on Imani''s terms as there is no court order agreement or custody agreement with any of the children. Ms. Carter stated that Mr. Berry does not pay child support even though he is supposed to pay child support but has not made a child support payment since 2019, and does not buy the children anything, does not pick the children up from school, including Imani. Imani''s school is closer to Mr. Berry, but Ms. Carter picks Imani up and drops her off at the home of Mr. Berry''s mother''s house. Mr. Berry lives with his mother in his mother''s home. Ms. Carter stated that she has tried to be the peacemaker and allow the boys Samuel and Immanuel to visit with Mr. Berry, but the boy''s never wanting to go and do not like staying overnight with Mr. Berry as the boys would cry when going to visit with Mr. Berry, as Mr. Berry likes to a mask on cut off the lights in the home and scare the boys. Ms. Carter stated that Mr. Berry has been on child support since 2017 but did not start paying support until 2019 and currently has not paid anything. Ms. Carter denies domestic violence issues between her and Mr. Chambers and stated that they have arguments in which Ms. Carter will leave home for a cool down between them, but that Mr. Chambers has not harmed her or her children because Mr. Chambers loves her children, she shares with Mr. Berry just like his own child Jaida. Ms. Carter stated that the children missed many days from school because they could not afford the four hundred dollars it cost for online internet for online schooling and were denied when they applied for assistance through social services, and the boy''s school did not help them either. Ms. Carter stated that it was the same issue when Imani lived with her. Ms. Carter noted that eventually, they could get the money for Comcast to provide for the children to attend school online. Ms. Carter stated that she stayed in contact with the school principal of her boy''s school and Imani school until they could get the money. Ms. Carter said that both Samuel and Immanuel had been sick and missed days out of school; thankfully, they tested negative for Covid but had to stay home from school until they were better. Ms. Carter said that she does not keep her children home for anything and stays in contact with their teachers when they are sick. Ms. Carter denied that she smoked Marijuana and stated that she did smoke Marijuana when she was in a relationship with Mr. Berry as Mr. Berry started her smoking Marijuana. Ms. Carter denied that Mr. Chambers keeps his guns out where the children can access the guns or touch them. Ms. Carter stated that those were false allegations about Mr. Chamber&acirc;&euro;&trade;s guns and that she and Mr. Chambers do not allow the children access to the guns, let alone touch them. Ms. Carter would like to have Imani come back to live with her, but it is okay if Imani wants to live with her paternal grandmother. Ms. Carter would like to have limited communication through email only with Mr. Berry or through Mr. Berry''s mother. Ms. Carter would like to have drop-off and pick-up done between her and Mr. Berry''s mother as Mr. Berry is violent towards Ms. Carter, affecting their children.</p>']];

noteIdToNoteArray TEXT[];

updateOn TIMESTAMP := now();

updateBy TEXT := 'CDM-21108';

noteId UUID;

BEGIN 
FOREACH noteIdToNoteArray SLICE 1 IN ARRAY noteIdToNoteArrays LOOP

noteId := uuid(noteIdToNoteArray[1]);

UPDATE
  progressnote
SET
  description = noteIdToNoteArray[2],
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  progressnoteid = noteId
  AND activeflag = 1;

UPDATE
  progressnotedetail
SET
  description = noteIdToNoteArray[2],
  updatedon = updateOn,
  updatedby = updateBy
WHERE
  progressnoteid = noteId
  AND activeflag = 1;
END LOOP;
END block1 $$;