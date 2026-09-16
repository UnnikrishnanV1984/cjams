/*
   Issue Description: CDM-25068
   Category/ Module  : Investigation Findings
   Root cause: User requested to update the Investigation Findings
   
   Reason why no related code fix: Worker needs to update/add the requested data. 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*  Maltreatment Type: Neglect */
select 	investigationallegationid from investigationfinding  
where  	investigationallegationid ='6ea98bd6-01ee-4cbc-a8e3-723dbf927cac'
		and personid ='edc601e3-3791-4244-bbe1-47cac2dd6277' and activeflag = 1;

-- Make Active = 0 for existing active record
update 	investigationfinding
set 	activeflag = 0,
		updatedby = 'CDM-25068',
		updatedon = now()
where  	investigationallegationid = '6ea98bd6-01ee-4cbc-a8e3-723dbf927cac' 
		and personid = 'edc601e3-3791-4244-bbe1-47cac2dd6277' 
		and activeflag = 1;
	
--Insert the new information per user request
insert into  investigationfinding(investigationfindingtypekey, investigationallegationid, personid, activeflag, insertedby, insertedon, updatedby, updatedon, findingcomments, omissiondesc, harmdesc )
values('RO', '6ea98bd6-01ee-4cbc-a8e3-723dbf927cac', 'edc601e3-3791-4244-bbe1-47cac2dd6277', 1, 'CDM-25068', now(), 'CDM-25068', now(), 
'No evidence that maltreatment occurred.', 
'Mr. Sligar', 'No evidence that maltreatment occurred.');

/* Maltreatment Type: Sexual Abuse */
select 	investigationallegationid from investigationfinding   
where  	investigationallegationid ='1ac9bf02-8372-41c6-bacb-db8c9b487c09'
		and personid ='edc601e3-3791-4244-bbe1-47cac2dd6277' and activeflag = 1;

-- Make Active = 0 for existing active record	
update 	investigationfinding
set 	activeflag = 0,
		updatedby = 'CDM-25068',
		updatedon = now()
where 	investigationallegationid = '1ac9bf02-8372-41c6-bacb-db8c9b487c09' 
		and personid = 'edc601e3-3791-4244-bbe1-47cac2dd6277' 
		and activeflag = 1;

--Insert the new information per user request	
insert into  investigationfinding(investigationfindingtypekey, investigationallegationid, personid, activeflag, insertedby, insertedon, updatedby, updatedon, findingcomments, omissiondesc)
values('UD', '1ac9bf02-8372-41c6-bacb-db8c9b487c09', 'edc601e3-3791-4244-bbe1-47cac2dd6277', 1, 'CDM-25068', now(), 'CDM-25068', now(), 
'Agatha initially reported to the staff at Polaris Teen Center her disclosure that her biological father, Edwin Sligar, had raped her. Agatha was interviewed by Los Angeles Police Department, Utah Police Department (Duchesne) and forensically interviewed by Utah Department of Social Services. Agatha consistently reported that her father had sexually abused her around the ages of 4-5 years old when she was living at the home of Mr. Sligar’s current residence in Severna Park, MD, another time at the home of her paternal grandparent’s home in Washington state, and when she was in Korea. Agatha stated that her father penetrated her vagina with his penis on two difference occasions (Maryland and Washington locations). Agatha reported that her father groped her buttocks when he was visiting her in Korea. Agatha described that the time the sexual abuse occurred in Maryland, she was staying with her father when her mother was in Korea going to school. Agatha said that her father laid her on a table in the living room area by the dining room area. She said that Mr. Sligar was standing up, and he put his penis into her vagina. Agatha reported feeling “a lot of pain”. Agatha was not able to provide further details of the abuse and reported that she has been diagnosed with complex PTSD which causes her not to remember a lot of things. Agatha stated that she recalled Madeleine being home during the incident and that she also told Mr. Sligar to “stop”. Agatha disclosed other incidents of physical abuse and an injury (which was corroborated by the medical documents where Agatha was seen by the doctor and a CPS report was made to the Department). Agatha disclosed that her father made her and Madeleine eat his “boogers” and another time where Agatha was held over the toilet into feces. Madeleine Sligar reported Mr. Sligar would make “creepy “comments to her. Madeleine stated when puberty started, Mr. Sligar would comment on her boobs, and he would take her bras, and then show them to people. She reported Mr. Sligar would say "You have a lot of junk of your trunk". Madeleine reported Mr. Sligar made those statements to her when her mom, Ms. Neu was in Korea, and she does not remember much at all. Madeleine stated she does not remember Mr. Sligar touching her inappropriately and does not think he did. She reported she does remember Mr. Sligar grabbed her butt but thinks it may have been playful, but was unsure. Emma Lawrence frequently described Mr. Sligar as being “weird” and not liking him or wanting to be around him. She did not disclose witnessing sexual abuse of Agatha. Elizabeth Lawrence reported that Mr. Sligar was very "weird" to her. Elizabeth stated Mr. Sligar would chase her around the house and hug her even when she told him to stop. Elizabeth reported that Mr. Sligar would message her friends on Instagram and message them "heart emojis" on their pictures. She reported that Mr. Sligar would give her friends hugs when they would come over and would see that her friends would be visibly uncomfortable. Elizabeth reported she had seen Mr. Sligar drag Madeleine by her ears. Elizabeth reported she witnessed Mr. Sligar indirectly throwing stuff at the girls and broke a chair one time and broke a glass. Emma and Elizabeth corroborated that Mr. Sligar would yell at Agatha and Madeleine. Mr. Michael Lawrence reported that his daughters both felt uncomfortable around Mr. Sligar and his daughters told him about the hugs that Mr. Sligar would give them. Mr. Lawrence recalls a time he had to pick up his daughters from the Sligar home because the police were there after Mr. Sligar hit Agatha or Madeleine. The Department can neither rule out nor indicate Mr. Sligar for sexual abuse of Agatha. Mr. Sligar was not made available, nor his attorney, to be able to satisfactorily refute the allegations. In addition, Agatha has no perceived motive to lie about the allegations, and she has been consistent with her disclosures of the sexual and physical abuse, Agatha, has also reported having sexual dreams about her father that she declined to share further details about.', 
'Mr. Edwin Sligar is Agatha''s biological father');
