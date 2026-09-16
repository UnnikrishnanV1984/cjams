/* 

CDM-32371 - Wrong name was put in the narrative section 

I202100229916:The wrong name was add into the REPORTER DETAILS section under the Narrative tab. 
I'm unable to edit the name Oluwatoyin I Bello to Gwendolyn Joyner, nor add her title is Deputy Director. Please assist.

Customer Email ID:darchelle.lanteon1@maryland.gov

*/

--select * from listintakedetails('7958f08e-5056-43d7-a970-cc2972994ab2','intake',1,10, 'I202100229916',false,'receiveddate','desc')

UPDATE cjams.intakeservicerequest
SET reporterfirstname = 'Gwendolyn', reporterlastname = 'Joyner', narrative = '<p>CPS Background clearance requested from&nbsp;Residential Child Care Program Professionals  and for Gwendolyn  Joyner</p>'
WHERE intakenumber = 'I202100229916';

UPDATE cjams.intakedastaging 
SET narrative = '<p>CPS Background clearance requested from&nbsp;Residential Child Care Program Professionals  and for Gwendolyn  Joyner</p>'
WHERE intakenumber = 'I202100229916';

update cjams.intakedastaging 
set jsondata = replace(jsondata ::text , '"Firstname": "Oluwatoyin"', '"Firstname": "Gwendolyn"')::json,
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;

update cjams.intakedastaging 
set jsondata = replace(jsondata ::text , '"Lastname": "Bello"', '"Lastname": "Joyner"')::json, 
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;

update cjams.intakedastaging 
set jsondata = replace(jsondata ::text , '"fullName": " Oluwatoyin  Bello "', '"fullName": " Gwendolyn  Joyner "')::json,
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;

update cjams.intakedastaging 
set jsondata = replace(jsondata ::text , '"Narrative": "<p>CPS Background clearance requested from&nbsp;Residential Child Care Program Professionals  and for Oluwatoyin  Bello</p>"', '"Narrative": "<p>CPS Background clearance requested from&nbsp;Residential Child Care Program Professionals  and for Gwendolyn  Joyner</p>"')::json,
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;

update cjams.intakesnapshot 
set jsondata = replace(jsondata ::text , '"Firstname": "Oluwatoyin"', '"Firstname": "Gwendolyn"')::json,
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;

update cjams.intakesnapshot 
set jsondata = replace(jsondata ::text , '"Lastname": "Bello"', '"Lastname": "Joyner"')::json, 
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;

update cjams.intakesnapshot 
set jsondata = replace(jsondata ::text , '"fullName": " Oluwatoyin  Bello "', '"fullName": " Gwendolyn  Joyner "')::json,
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;

update cjams.intakesnapshot 
set jsondata = replace(jsondata ::text , '"Narrative": "<p>CPS Background clearance requested from&nbsp;Residential Child Care Program Professionals  and for Oluwatoyin  Bello</p>"', '"Narrative": "<p>CPS Background clearance requested from&nbsp;Residential Child Care Program Professionals  and for Gwendolyn  Joyner</p>"')::json,
updatedon = now(), 
updatedby = 'CDM-32371'
where intakenumber = 'I202100229916' and activeflag = 1;