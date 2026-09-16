/*
Issue Description: CJAMS-63712 Deleting Case Notes or Adding Addendums in CJAMS After Time Limit.Requested to correct the following on the contact notes for the case 251030574132
Category/Module: Contacts: Notes
Root cause: Data fix needed to correct the contact notes that have already been approved with the following changes.
            Please proceed with the data fix once SSA/PO approves it

1) Contact ID: 15432267, 15432259, 15432252, 15432245, 15432230, 15432222

These contact notes need to be deleted

2) Contact ID: 15455699 - Need to delete the existing notes and need to user requested contact note information

3) Contact ID: 15456595

   1. Need to delete the existing notes and need to user requested contact note information
   2. Eric Simpson Role : Adoptive Parent - This person needs to be removed from the Person Contacted field


4) Contact ID: 15456606 - Need to delete the existing notes and need to user requested contact note information



5) Contact ID: 15455662 - Need to delete the existing notes and need to user requested contact note information

Adding PR to be executed in 17.0.0 branch.

Fix provided: Data fix todata fix to delete and edit the exisiting contact notes as requested by the user.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

--Delete  Contact ID: 15432267, 15432259, 15432252, 15432245, 15432230, 15432222

update progressnote 
set activeflag = 0, 
    updatedon = now(), 
    updatedby = 'CJAMS-63712'
where progressnoteid in ('b6607ac4-c796-4bcd-92b2-1b6017d06c9c','5d5b31b8-3214-47d4-90cf-d87dc144b68b','66e41ab5-47bb-4e85-b1c8-0b0afc99fdeb','ae459517-f44e-4522-b82d-aea278005d18','d19988ce-f20a-4651-b4e2-a547ce0b0f19','5fa0da46-18d7-4def-aeab-29e93112ecc6')
and activeflag =1;

update progressnotedetail 
set activeflag = 0, 
    updatedby = 'CJAMS-63712' , 
    updatedon = now()
WHERE progressnoteid in ('b6607ac4-c796-4bcd-92b2-1b6017d06c9c','5d5b31b8-3214-47d4-90cf-d87dc144b68b','66e41ab5-47bb-4e85-b1c8-0b0afc99fdeb','ae459517-f44e-4522-b82d-aea278005d18','d19988ce-f20a-4651-b4e2-a547ce0b0f19','5fa0da46-18d7-4def-aeab-29e93112ecc6')
and activeflag=1;

update contactparticipant
SET activeflag = 0, 
    updatedby = 'CJAMS-63712' , 
    updatedon = now()
WHERE progressnoteid in ('b6607ac4-c796-4bcd-92b2-1b6017d06c9c','5d5b31b8-3214-47d4-90cf-d87dc144b68b','66e41ab5-47bb-4e85-b1c8-0b0afc99fdeb','ae459517-f44e-4522-b82d-aea278005d18','d19988ce-f20a-4651-b4e2-a547ce0b0f19','5fa0da46-18d7-4def-aeab-29e93112ecc6')
and activeflag = 1;

update progressnote_audit_detail
set activeflag = 0,
	updatedby = 'CJAMS-63712',
	updatedon = now()
where progressnoteid in ('b6607ac4-c796-4bcd-92b2-1b6017d06c9c','5d5b31b8-3214-47d4-90cf-d87dc144b68b','66e41ab5-47bb-4e85-b1c8-0b0afc99fdeb','ae459517-f44e-4522-b82d-aea278005d18','d19988ce-f20a-4651-b4e2-a547ce0b0f19','5fa0da46-18d7-4def-aeab-29e93112ecc6')
and activeflag = 1 ;
	

--Contact ID: 15455699

update progressnotedetail 
set description = '<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Summary of Contact and Presentation</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>This worker met with Angel Durham at Bowie High School in the Student Navigator''s office with Ms. Chantal Hunter present. Angel was seen wearing a black hoodie with it covering her head, camouflage pants, and shoes. Angel appeared to be very sleepy as she was seen sleeping in the office and the worker and her friend had to keep waking her up to participate in the interview. Also in the office was Angel''s close friend, Peyton. The worker requested to speak with Angel privately; however, Angel stated that if Peyton could not remain in the room, she would not participate in the interview. Due to this, the worker continued the conversation with both individuals present. </span>
  </span>
</p>

<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Reported Sexual Abuse Incidents</span>
    </span>
  </strong>
</p>
<ol>
  <li>
    <p>
      <span style="color:rgb(23, 43, 77);">
        <span style="background-color:rgb(255, 255, 255);">Angel reported that approximately three weeks ago, she was touched inappropriately by her stepbrother while at home. She stated that she was in her room watching TV when he tried to hop in her bed but she told him he couldn''t get in her bed. She reported that shortly after they started fighting because he wanted to be in her bed. Once they were done fighting she went back to bed after he left.</span>
      </span>
    </p>
  </li>
  <li>
    <p>
      <span style="color:rgb(23, 43, 77);">
        <span style="background-color:rgb(255, 255, 255);">The second incident occurred when she was watching tv in her room and fell asleep. She reports that she woke up to malachi touching the inner parts of her thigh. She states that once he realized she was awake he got up from her bed and left.</span>
      </span>
    </p>
  </li>
  <li>
    <p>
      <span style="color:rgb(23, 43, 77);">
        <span style="background-color:rgb(255, 255, 255);">The third incident was when they were at the movies with the entire family. She reports that she was sitting on the upper level of the theatre and malachi was sitting at the lower part. Shortly after he came to where she was sitting and when she asked him why he was there he reportedly said their parents told him to come up to where she was. She reports that he then sat at the seat that was next to her and asked her to sit on his lap when she denied he then began to touch her thigh. She reports that this happened on September 20, 2025.</span>
      </span>
    </p>
  </li>
</ol>
<p>
<strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Disclosure of Incidents and Initial Response</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>When the worker asked Angel if she ever told anyone about this she stated no, when asked why she just shrugged her shoulders. </span>
  </span>
</p>
<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Leaving Home and Law Enforcement Involvement</span>
    </span>
  </strong>
</p>
<p>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">Angel reports that she left home the following Wednesday which would be September 24, 2025. When asked why she left home she reports that it was because she didn''t feel comfortable living with her brother Malachi. When asked who was she staying with, Angel reported that she was staying with people that previously graduated from Bowie High school. When asked who own the home that she is staying in, Angel stated that it was the person''s mother. Angel reports that she was found by The Bowie Police Department by the library and transported her to the station to await for her parents to pick her up being that she was listed as a missing person. Her adoptive parents then took her to Children''s Hospital from the station. Angel reports that when they found out about what she said Malachi was doing to her their response was she was lying and how could she do this after all that they have done for her. Angel reports that once she was discharged her mom picked her up from the hospital and they went to Petco. While at petco Angel stated that she ran away again because she didn''t want to return back home due to her brother Malachi being there. Angel reports that besides the allegation she made against her brother nothing else has been happening at home.</span>
  </span>
</p>
<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Kinship Questions and Supports</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>The worker asked Angel the three kinship questions: </span>
  </span>
</p>
<ul>
  <li>
    <p>
      <span style="color:rgb(23, 43, 77);">
        <span style="background-color:rgb(255, 255, 255);">In the event your mom/dad can''t pick you up from school, who else might be able to? Angel responded that her neighbor picked her up from school once but its usually her parents that pick her up.</span>
      </span>
    </p>
  </li>
  <li>
    <p>
      <span style="color:rgb(23, 43, 77);">
        <span style="background-color:rgb(255, 255, 255);">In addition to sleeping at home, is there someone else''s house that you visit regularly or stay the night at? Angel responded she has never spent a night at someone''s house or visited regularly.</span>
      </span>
    </p>
  </li>
  <li>
    <p>
      <span style="color:rgb(23, 43, 77);">
        <span style="background-color:rgb(255, 255, 255);">If something were to happen (similar to the incident that prompted Agency involvement), who do you feel comfortable talking to about it? Angel responded Ms. Elliot who is the parent engagement assistant and her friend Peyton.</span>
      </span>
    </p>
  </li>
  <li>
    <p>
      <span style="color:rgb(23, 43, 77);">
        <span style="background-color:rgb(255, 255, 255);">Who do you spend holidays with? Angel responded with her family who consist of Mr and Mrs Simpson, her biological sister Kwen, her stepbrother Malachi, and her stepsister Nyla.</span>
      </span>
    </p>
  </li>
</ul>
<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Current Placement Preferences</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>Angel stated that at this very moment she would like to live with her friend Peyton and their family. When the worker explained to Angel that they could not give the go ahead for her to stay with Peyton temporarily, Angel became upset. The worker explained to Angel that it''s up to her parents'' decision and they would have to speak with Peyton''s family to arrange that. </span>
  </span>
</p>
<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">School Incidents and Suspension</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>Angel reported that on Monday October 6, 2025, she got into a fight with a friend due to them "getting crazy" with their mouth as a result she was suspended. On Tuesday, she went to school but left early at the end of third period and didn''t want to return home. On Wednesday, she returned to school despite the fact of her being suspended. </span>
  </span>
</p>
<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Perception of Home Environment</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>The worker posed a hypothetical question to Angel and asked her if her brother Malachi was no longer in the home would she then return to which Angel stated no. When asked why she described the home environment as toxic, reporting that her mother is verbally abusive. When the worker asked what are some of the things her mother would say to her Angel couldn''t say much besides the fact that her mother often curses a lot and she describes her adoptive father as a drunk. Angel stated that although she and her family go out on vacations and do fun stuff together she doesn''t want to go back to their home. Angel stated she was suspended on Monday but was allowed to return to school today. She stated she will serve a three-day suspension and return the following Monday.Angel denied being physically abused at home. </span>
  </span>
</p>
<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Family History and Prior Services</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>The worker asked Angel about her biological parents. Angel reports that she used to live with her father in Kansas but his parental rights were terminated due to him being physically abusive to her and her siblings. She reports that her mother''s parental rights were also terminated. When the worker asked Angel about the history of sex abuse Angel denied any history of sex abuse from either her father or the foster homes she was in previously placed in. Angel reports that she was in therapy but stopped some time ago. She reports that she has been living in Maryland for about 3 years. </span>
  </span>
</p>
<p>
  <strong>
    <span style="color:rgb(23, 43, 77);">
      <span style="background-color:rgb(255, 255, 255);">Substance Use and Recent Elopement</span>
    </span>
  </strong>
  <span style="color:rgb(23, 43, 77);">
    <span style="background-color:rgb(255, 255, 255);">
      <br>Angel denies using any other substances besides weed. When Angel found out that she does not have permission from her parents to go to Peyton''s home, Angel left the school building without any word or where she will be going. </span>
  </span>
</p>
',
    updatedby ='CJAMS-63712',
    updatedon =now() 
    where progressnoteid  ='4a9b19d9-f59a-43fa-9b9c-1fa1d30aa475' 
    and activeflag =1;


--Contact ID: 15456595
   
update progressnotedetail 
set description = '<p><span style="color:rgb(62, 65, 69);"><span style="background-color:rgb(255, 255, 255);">Date: October 8, 2025<br>Contact Type: In-Person Interview<br>Location: Bowie High School (Private Room)<br></span></span></p>
<p><strong><span style="color:rgb(23, 43, 77);"><span style="background-color:rgb(255, 255, 255);">Summary:</span></span></strong></p>
<p><span style="color:rgb(23, 43, 77);"><span style="background-color:rgb(255, 255, 255);">This worker met privately with Malachi Simpson, who is in the 10th grade. Malachi appeared to be healthy, well groomed and developmentally on target for his age. Malachi reported that nothing unusual has been occurring at home, he has a good time at home, and that he feels safe at home. He stated that Angel is his stepsister and that they have a great relationship.</span></span></p>
<p><span style="color:rgb(23, 43, 77);"><span style="background-color:rgb(255, 255, 255);">&nbsp;</span></span></p>
<p><span style="color:rgb(23, 43, 77);"><span style="background-color:rgb(255, 255, 255);">When the worker asked Malachi if he knew about the allegations that Angel made against him he stated yes, the worker then asked him to explain from his point of view what occurred. Malachi reports that Angel has said he has touched her inappropriately to which he denies. He acknowledged that Angel claimed he entered her room and lay in her bed but denied that the allegations are true. He stated that Angel is lying and that "those things didn''t happen" he believes angel may be saying those things so that she won''t come back home.&nbsp; He reported that they did go to the movies but said that nothing inappropriate ever occurred.</span></span></p>
<p><span style="color:rgb(23, 43, 77);"><span style="background-color:rgb(255, 255, 255);">&nbsp;</span></span></p>
<p><span style="color:rgb(23, 43, 77);"><span style="background-color:rgb(255, 255, 255);">Malachi stated that he was unaware of any allegations until recently. He reports that in the past Angel has never disclosed anything concerning to him. He denies the claim that he and Angel share the same friend group but he is aware of the people that she hangs out with.&nbsp;</span></span></p>
<p><span style="color:rgb(23, 43, 77);"><span style="background-color:rgb(255, 255, 255);">When asked how he is disciplined at home, Maclachi reports that his parents take away his devices. When asked about his relationship with his parents he reports that he has a great relationship with his parents. He stated that his parents treat all the children in the household equally. In all Malachi reported that he has a good relationship with his parents, feels safe in the home, and denied any inappropriate contact with Angel. The worker thanked Malachi for his cooperation and concluded</p>',
    updatedby ='CJAMS-63712',
    updatedon =now() 
    where progressnoteid  ='8b63b91b-af9d-4234-a4b4-237dc87cd231' and activeflag=1;


--- Contact ID: 15456606

update progressnotedetail  
set description = '<p>
   <span style="color: rgb(62, 65, 69)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Date: October 8, 2025<br />Contact Type: Home Visit / In-Person
         Interview<br />Location: Simpson Residence<br /><br /></span></span
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Summary:<br />This worker met with Mr. and Mrs. Simpson at their
         residence to discuss the ongoing concerns involving their adopted
         daughter, Angel Durham. Mrs. Simpson reports that their household is a
         blended family dynamic. She reports that she adopted Angel and her
         sister Kwen, husband has his biological son, Malachi that resides with
         them, and Mrs. Simpson has her own biological daughter Nyla who lives
         with them as well.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Presenting incident and runaway behavior</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Mrs. Simpson reported that Angel was happy before leaving the
         home on Tuesday. In fact on Tuesday Mrs. Simpson reported that as Angel
         was preparing to leave for school in the morning she asked Mrs. Simpson
         for a snack and gave her a hug and a kiss and told her that she loved
         her to which Mrs. Simpson responded back to. She states that shortly
         after Angel changed and she is unsure why. She reports that October 1,
         2025 is the first time Angel ran away and she ran away again the
         following Wednesday. Mrs. Simpson reports that prior Angel did have a
         history of going to school late by going to the nearby Chick-fil-A or
         Bowie Town Center. Mrs. Simpson reports that Angel and a group of
         friends would be transported to and from these locations by a guy named
         Jake who was a former student at Bowie High School.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >House rules, discipline, and school concerns</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Mrs. Simpson reports that Angel told her that she will not be
         coming home because of the fact that they took away her phone. Mrs.
         Simpson reports that they took away Angel''s phone because she was
         failing in all of her classes and they limit the children''s screen
         time. Mrs. Simpson reports that she has tried to engage Angel in
         extracurricular activities such as cross country but instead of her
         attending the practices after school she would use that opportunity to
         hang out and go to boys home. She reported that Angel was involved in
         dance but was removed from the class after becoming disrespectful
         towards the teacher. The teacher reportedly requested that Angel be
         removed from class. Angel was also requested to be removed from art
         class by her teacher due to the same behavior of being disrespectful.
         Last year Angel was caught in the annex building of her high school
         doing inappropriate acts on a boy. Mrs. Simpson stated that Angel has
         problems with authority and wants to do things her own way. Mrs.
         Simpson reports that these behaviors occurred in 9th grade but have
         progressively gotten worse. Mrs. Simpson reports that Angel has gotten
         into a habit of running away when she knows she is about to get in
         trouble. Mrs. Simpson reports that she does not physically punish any
         of the children and her mode of punishment is to take away their
         electronic devices, limit screen time, and take away special
         privileges.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Protective activities and family lifestyle</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Mrs. Simpson reports that she tries to engage all the children
         in extracurricular activities to keep them busy and out of trouble. She
         reports that Angel was also involved in the Bowie explorer program and
         is trying to get into the Jack and Jill organization to keep them
         further involved. In addition to the extracurricular activities, Mrs.
         Simpson reports that they regularly take family vacations to places
         such as New York, Turks and Caicos, Jamaica etc. Reportedly Angel told
         the hospital staff at Children''s Hospital that that kind of lifestyle
         is not for her and she wants to live like Sexxy Redd.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >History of care and mental health</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Mrs. Simpson reports that she has had Angel and her sister Kwen
         since they were about 3-4 years old but legally adopted them some years
         after. Mrs. Simpson reports that Angel was previously placed in a
         mental health facility at the age of eight. Mrs. Simpson states that
         despite the girls troubled background she still didn''t want to see them
         in the system and hence the reason why she adopted them and has tried
         to give them a great lifestyle to which she believes Angel doesn''t
         appreciate. Mrs. Simpson states that every two weeks she would take the
         girls to get their hair done and Angel would take out her hair after a
         couple days after hundred of dollars were spent.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Concerning behaviors and safety measures in the home</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />She described Angel''s lifestyle as troublesome, noting that the
         family has experienced a great deal of stress as a result. Mrs Simpson
         reports that as she was looking through Angel''s phone she noticed that
         Angel told some boy that she was involved with about her fathers income
         and life insurance policy to which the boy responded that they are
         going to be rich. In addition Angel reportedly told them that for
         Halloween she wants to be Jeffery Dahmer and when they asked her does
         she know who that is she stated yes, the man that killed and ate
         people. Lastly Angel also was mentioning mixing cleaning products such
         as bleach and Fabuloso which concerned Mrs. Simpson because the mixture
         can cause a toxic fume and potentially kill the family. Mrs. Simpson
         reports that everyone in the home sleeps with their door shut and they
         have installed cameras for their safety.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Family stressors and lack of support</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Mrs. Simpson reports that on top of Angel''s behavior they are
         dealing with stress of their own. Mr. Simpson''s eldest son passed away
         about two years and ago and Mr. Simpson suffered a mild stroke shortly
         after. In addition, Mrs. Simpson is dealing with health issues of her
         own and to add up to Angel''s behavior it''s just too much for her to
         handle but she doesn''t want to give up on her. Mrs. Simpson reports
         that do not have any family support and describes Angels'' biological
         parents and their siblings as unstable.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Allegations against Malachi and family relationships</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Regarding the allegations Angel has made against Malachi, she
         reports that she doesn''t believe it one bit based on the fact that
         Angel is very vocal about things and has no issues on saying what''s on
         her mind. Mrs. Simpson also described Angel and Malachi relationship as
         "they are like buddies, two peas in a pod" she reports that Angel would
         confide in Malachi about things that she wouldn''t confide in her older
         sister about. Mrs. Simpson reports that there was a time where Malachi
         went to Egypt for the summer and Angel kept saying how much she missed
         him and was always keeping in contact with him. Mrs. Simpson believes
         the real reason why Angel is acting like this is because she does not
         respond well to structure or discipline.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Recent transport to hospital and threatening statements</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Mrs. Simpson recalled as they were transporting Angel to
         Children''s Hospital, Mrs. Simpson was driving and her husband was in
         the back seat in case Angel attempted to harm Mrs. Simpson or jump out
         the car. While driving Angel told her parents "I got something for you.
         You think I''m playing?" and just being disrespectful.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Biological family history</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />Mrs. Simpson shared that Angel once told the family that her
         biological mother tried to drown her and her sisters and that the
         biological side of the family has a history of instability.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Current plan and discussion of resources</span
         ></span
      ></strong
   ><span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         ><br />The Simpsons stated that they continue to want Angel safe and
         are trying to access additional support. Mrs. Simpson noted that she
         worries about Angel''s mental health and impulsive behavior. The worker
         informed the family that most of the resources that the Department
         provides only works if the child is home or is placed with the
         department and has plans of reunification. If Angel is not home then
         the resources wont be of benefit being that the resources placed would
         need to work directly with Angel and her parents. The worker informed
         the family that if Angel continues to run away all they can do at this
         point is to file a missing person report. Mrs. Simpson agreed and
         stated that she would do so and also place a report regarding Angel
         being trafficked being that she''s with an older adult male in his home.
         Mrs. Simpson reports that they do not have anyone in mind that can care
         for Angel temporarily and denied the fact that her neighbors could be
         of assistance. Mrs. Simpson reports that the people in her neighborhood
         are government officials and retired military people and with Angel''s
         behavior she would hate for them to be falsely accused of something
         while caring for Angel.</p>',
    updatedby ='CJAMS-63712',
    updatedon =now() 
    where progressnoteid  ='a8a8db1b-a019-4680-b25a-baf3fd4796c2' 
    and activeflag =1;



---Contact ID: 15455662   

 update progressnotedetail
set description = '<p>
   <span style="color: rgb(62, 65, 69)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Date: October 8, 2025<br />Contact Type: Phone Contact<br /><br /></span></span
   ><strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Worker Contact</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Worker spoke by phone with Mrs. Athena Simpson, the adoptive mother of
         Angel Durham, to obtain additional information regarding the current
         situation.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Family Background</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >She further explained that she is Angel''s paternal great aunt and that
         there is no known history of sexual abuse regarding Angel. Angel''s
         biological father, who is Mrs. Simpson''s nephew, had his parental
         rights terminated for abuse and Angel''s biological mother was recently
         arrested for murder. Mrs. Simpson described the father''s side of the
         family as unstable, and that Angel''s biological mother has seven
         sisters, none of whom were able to adopt her. Mrs. Simpson went on to
         add that they have recently moved from Georgia to Maryland in 2023 and
         they do not have any family here.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >History and Prior Concerns</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Mrs. Simpson reported that Angel has been posting inappropriate
         content on TikTok and Instagram and that she has been diagnosed with
         Multiple Personality Disorder and Bipolar Disorder in the past. Mrs.
         Simpson reported that Angel is prescribed birth control pills and that
         in ninth grade she was found engaging in sexual activity behind a
         stairwell at school. Mrs. Simpson stated that she suggested to the
         principal that Angel be referred to Twin Oaks, an alternative
         school.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Relationship with Stepfamily</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Mrs. Simpson stated that Angel and her stepbrother, Malachi, were
         previously close and shared the same friend group. She expressed
         confusion about why Angel would make such an allegation against him.
         Mrs. Simpson stated that when she and her husband spoke to Malachi
         regarding the allegation he became emotional and cried, asking, "Why
         would she do this to me?"</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Initial Runaway and Police Involvement</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Mrs. Simpson reported that Angel ran away last week on Tuesday and was
         being held in police custody because she was giving police a hard time.
         Mrs. Simpson stated that when Angel was picked up by the Bowie Police
         Department, she told officers that she was upset with her parents for
         taking her phone and said they "had no right to do so." Angel
         reportedly told her parents that she would make sure she was not
         returning home. Mrs. Simpson described this as new behavior and
         explained that they took her phone after learning she had been leaving
         school during the morning and afternoon without permission. From the
         Bowie police station Mrs. Simpson and her husband took Angel to
         Children''s Hospital to get evaluated because they report that her
         behavior was very unusual.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Children''s Hospital Allegations</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >While at Children''s Hospital Mrs. Simpson reported that Angel was not
         admitted into the psych unit because Angel denied being suicidal or
         having thoughts of harming herself. Mrs. Simpson reported that it was
         at Children''s Hospital that Angel disclosed to a social worker there
         that the reason why she doesn''t want to go home is because her brother,
         Malachi, was touching her inappropriately. Mrs. Simpson reported that
         she did not believe Angel because while at the police station Angel
         never disclosed such and Angel is very outspoken and vocal; if anyone
         did something to her that she didn''t like they would have heard about
         it. Mrs. Simpson reported that when she was told this, she was very
         hurt because the allegations are very serious. Additionally, according
         to Mrs. Simpson, the social worker reported that they did not find the
         sexual assault allegations to be strong enough to substantiate.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Desire to Live with Boyfriend and Second Runaway</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Mrs. Simpson reported that Angel stated that she did not want to
         return home but expressed a desire to return to her 21-year-old
         boyfriend "DJ" who lives with his mother in Bowie. Mrs. Simpson told
         Angel and the staff at Children''s Hospital absolutely not because she
         doesn''t know the person and Angel is too young to be with an adult male
         in a romantic relationship. Mrs. Simpson stated that she picked Angel
         up on Friday from Children''s Hospital and while they were at Petco
         shopping Angel ran away from there. When Angel ran away once again Mrs.
         Simpson filed for another missing persons report.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >School Incident and Subsequent Concerns</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Mrs. Simpson stated that the following Monday Angel got into a fight
         with a young lady she goes to school with near school grounds and as a
         result she was suspended. Mrs. Simpson reports that she saw a video of
         the fight and it appeared as though Angel was under the influence of a
         substance. On Tuesday, Angel attended school but appeared to be high.
         Mrs. Simpson reported that she found text messages and videos of Angel
         engaging in sexual activity.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Caregiver''s Current Concerns</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >Mrs. Simpson stated that Angel''s behavior and the false allegations
         she is making are serious and could negatively affect the entire
         household. She stated that Angel has made it clear she does not want to
         return home and that she feels her "back is against the wall." Mrs.
         Simpson said her main concern is keeping Angel safe and off the
         streets. She went to the local courthouse to find out what services
         they offer for delinquent children and she was told by officials that
         there was little they could do and that she should pray regarding
         Angel''s situation, to which Ms. Simpson was baffled.</span
      ></span
   >
</p>
<p>
   <strong
      ><span style="color: rgb(23, 43, 77)"
         ><span style="background-color: rgb(255, 255, 255)"
            >Planned Worker Action</span
         ></span
      ></strong
   >
</p>
<p>
   <span style="color: rgb(23, 43, 77)"
      ><span style="background-color: rgb(255, 255, 255)"
         >The worker informed Mrs. Simpson that they would be going to Bowie
         High School to interview the children regarding the situation, to which
         she agreed.</span
      ></span
   >
</p>',
    updatedby ='CJAMS-63712',
    updatedon =now() 
    where progressnoteid  ='b09121db-682f-4da1-9998-31ca79cee5cc' 
    and activeflag =1;


--2. Eric Simpson Role : Adoptive Parent - This person needs to be removed from the Person Contacted field (Contact ID: 15456595)

update contactparticipant
set activeflag = 0,
  	  updatedby = 'CJAMS-63712',
  	  updatedon = now()
where progressnoteid='8b63b91b-af9d-4234-a4b4-237dc87cd231'
and  intakeservicerequestactorid = 'd1c4241f-a9f0-4dc4-97f9-b432a1306c97'
and activeflag =1;