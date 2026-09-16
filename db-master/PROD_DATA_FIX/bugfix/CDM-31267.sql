/*
Issue Description: CDM-31267
Root Cause :user wants to be correct dob 
Data fix :Updated dob to 8/18/82 from 8/18/92
Category/ Module: person 
Pull request# N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: N/A
*/

update person set dob='1982-08-18 00:00:00',updatedby='CDM-31267',updatedon=now() where personid='5d637d6f-d9f8-4ac4-8432-77e38ddcef93';
