
/*
Issue Description: Unable to delete system alerts
Category/Module: Expungement 
Root cause: Dashboard:I am no longer able to delete the system alerts received. I select the "bell," go to "select all" and press delete and receive the message "Enter integer value in amount fields.
Fix provided: Data fix done to soft delete the system notifications for the user.
Data/Code fix ticket#: CJAMS-68121
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Fix
*/
update usernotification 
set activeflag =0, updatedby ='CJAMS-68121',updatedon =now()
where securityusersid ='2749e1a9-7e03-45ec-9127-cbdd9870b55d' and activeflag=1
and insertedon::date between '2026-05-28'::date and '2026-06-03'::date;

update usernotificationmap set activeflag =0,updatedby ='CJAMS-68121',updatedon =now() 
where usernotificationid in(select usernotificationid  from usernotification u where securityusersid ='2749e1a9-7e03-45ec-9127-cbdd9870b55d'
and insertedon::date between '2026-05-28'::date and '2026-06-03'::date and activeflag=0) and activeflag =1;