/*
   Issue Description: CJAMS-61226
   Category/ Module  : Removing person from case
   Root cause: I251013336354:Cjams will not allow for us to add Laneah Shaw (DOB 12/19/1996) due to her adoption date 02/27/2001). 
   She was created as unknwon name and information.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
select updatedby,updatedon,* from intakedastaging where intakenumber = 'I251013336354' and activeflag=1;
select updatedby,servicerequestnumber,servicecaseid,* from intakeservicerequest where intakenumber = 'I251013336354';
select updatedby,* from servicecase where servicecaseid = '233e3344-31e7-4d03-8b30-0cac555c6e48';
*/

update person 
set preadoptiondate ='2001-02-27', 
	updatedby ='CJAMS-61226', 
	updatedon = now()
where personid ='bf886a6f-33b9-47aa-8c39-e256ab030768' and activeflag =1;

/*
--wrong created
select * from actor where intakeserviceid = '07b93ee5-990a-43f2-ad0d-b52f85f5836a' and activeflag = 1;
0e3305eb-d7b1-4ad8-b8c8-e043886c37ab -- unknown Laneah Shaw 204194534
0f3ca607-ee13-46a9-9053-427b7f32b59b -- actor id
--right
select * from person where cjamspid = '1723892'; -- bf886a6f-33b9-47aa-8c39-e256ab030768
*/

update intakeservicerequestactor 
set updatedby = 'CJAMS-61226',
	updatedon = now(),
	personid = 'bf886a6f-33b9-47aa-8c39-e256ab030768'-- right
where personid = '0e3305eb-d7b1-4ad8-b8c8-e043886c37ab' 
and intakenumber = 'I251013336354'
and activeflag = 1;

update actor 
set updatedby = 'CJAMS-61226',
	updatedon = now(),
	personid = 'bf886a6f-33b9-47aa-8c39-e256ab030768'-- right
where personid = '0e3305eb-d7b1-4ad8-b8c8-e043886c37ab' 
and intakenumber = 'I251013336354'
and activeflag = 1;

update personrole 
set activeflag = 0, updatedby = 'CJAMS-61226', updatedon = now()
where personid = '0e3305eb-d7b1-4ad8-b8c8-e043886c37ab' and activeflag = 1;

update personroletype 
set activeflag = 0, updatedby = 'CJAMS-61226', updatedon = now()
where personroleid in ('6b016357-59b2-4e82-9b55-d500e792cec3',
'ab7e68d5-083c-4bcb-9af7-fc781c1ce14c',
'9f45d267-36bd-4a3e-950c-b70c3acc0bac') and activeflag = 1;

-- update cps report
UPDATE intakedastaging
SET 
  jsondata = jsonb_set(
    jsonb_set(
      jsonb_set(
        jsonb_set(
          jsondata::jsonb, 
          '{General,HeadofHousehold}',  -- Update HeadofHousehold in 'General'
          '"LANEAH HELEN SHAW"'::jsonb
        ),
        '{persons,1,Pid}',  -- Update Pid in the second object of 'persons' array
        '"bf886a6f-33b9-47aa-8c39-e256ab030768"'::jsonb
      ),
      '{persons,1,cjamspid}',  -- Update cjamspid in the second object of 'persons' array
      '"1723892"'::jsonb
    ),
    '{persons,1,fullName}',  -- Update fullName in the second object of 'persons' array
    '"LANEAH HELEN SHAW"'::jsonb
  )::jsonb,  -- Cast to jsonb after all modifications
  updatedby = 'CJAMS-61226',
  updatedon = now()
WHERE intakenumber = 'I251013336354' AND activeflag = 1;

UPDATE intakesnapshot
SET 
  jsondata = jsonb_set(
    jsonb_set(
      jsonb_set(
        jsonb_set(
          jsondata::jsonb, 
          '{General,HeadofHousehold}',  -- Update HeadofHousehold in 'General'
          '"LANEAH HELEN SHAW"'::jsonb
        ),
        '{persondetails,Person,1,Pid}',  -- Update Pid in the first object of 'persons' array inside 'persondetails'
        '"bf886a6f-33b9-47aa-8c39-e256ab030768"'::jsonb
      ),
      '{persondetails,Person,1,cjamspid}',  -- Update cjamspid in the first object of 'persons' array inside 'persondetails'
      '"1723892"'::jsonb
    ),
    '{persondetails,Person,1,fullName}',  -- Update fullName in the first object of 'persons' array inside 'persondetails'
    '"LANEAH HELEN SHAW"'::jsonb
  )::jsonb,  -- Final jsonb_set call to apply all changes
  updatedby = 'CJAMS-61226',
  updatedon = now()
WHERE intakenumber = 'I251013336354' AND activeflag = 1;

--remove from service case
update actor 
set updatedby = 'CJAMS-61226',
	updatedon = now(),
	activeflag = 0
where personid = '0e3305eb-d7b1-4ad8-b8c8-e043886c37ab' and servicecaseid = '233e3344-31e7-4d03-8b30-0cac555c6e48'
and activeflag = 1;

update intakeservicerequestactor 
set updatedby = 'CJAMS-61226',
	updatedon = now(),
	activeflag = 0
where personid = '0e3305eb-d7b1-4ad8-b8c8-e043886c37ab' and servicecaseid = '233e3344-31e7-4d03-8b30-0cac555c6e48'
and activeflag = 1;