/*
   Issue Description: CDM-39053 Closing Case Service Logs
   Category/ Module  : CPS case and purchase auth dates 
   Root cause: Unable to pay invoice. 3243421:Hello Support,There seems to be an issue with cjams when paying invoices. I am trying to pay an invoice for my client Amber Brown. It is a daycare invoice for the month of February 2024 and the issue is this: I had put in an invoice (Authorization ID 3050061) that had service dates from 2/25/24 - 3/30/24, which was 5 weeks of daycare. I was told by my finance department that I should only include one month on an invoice because it was easier for tracking purposes. So that authorization was denied. When I tried to put in a new invoice, where the service dates were from 2/5/24 - 3/1/24, I got an error message stating that stated "Please enter the dates correctly as selected dates are overlapping with other existing Service Log."The issue seems to be that because I entered the initial dates of 2/25/24 - 3/30/24, anything that overlaps with that time period will generate that error message, even though that authorization (3050061) has been denied. And I am unable to delete the authorization so there does not seem to be an easy work around.This same issue has come up when paying for a motel for a client. If a client stays at a motel from say 5/1/24 to 5/3/24, but then I want to pay for another 3 days, I cannot put in an invoice from 5/3/24 to 5/6/24 because it will generate the same error message. The system acts as if there is a duplicate bill being generated on 5/3/24, but it is in fact not a duplicate because the motel bills my client based on the nights that they stay, so if my client checks out at 11:00 am on the morning of 5/3/24, but then needs to stay there the night of 5/3/24, the motel will send an invoice for 5/3/24, but cjams will not allow that.It would be better if there was an actual begin time and end time, in addition to the begin date and end date- that would solve the billing problem with the motels. 
   Fix Provided:updated start date and end date
   Data fix has been promoted to enddate the service logs for the case 3303182 and client 3820727
*/

update tb_service_log 
set start_dt='2024-03-04' , 
    estimated_start_dt='2024-03-04' , 
    end_dt='2024-03-29' ,
    estimated_end_dt='2024-03-29', 
    update_ts=now(),
    update_user_id='CDM-39053' 
where service_log_id= '3077500'
and client_id='201238080'
and case_id = 3243421;