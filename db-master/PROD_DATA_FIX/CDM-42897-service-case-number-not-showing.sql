/*
   Data fix ticket#: CDM-42904
   Issue Description: 
   Category/ Module: Title IV-E 
   Root cause: There is no case number and service case id saved in database due to that case number is not showing in UI screen.
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
*/

update gapeligibilityinfo set casenumber='3231587',servicecaseid='5d03301a-7ff8-4b9d-b184-a4702e9f573e',updatedby='CDM-42897',updatedon = now() 
where client_id = '3597446' and activeflag =1;