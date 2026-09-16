/*
Issue Description: 231030045112:Service Status decision is not populated on Plan of Safe Care. No services or monitoring required by agency: Recommend for Closure is not selected as was done.
Root cause: User requested to updated 'No services or monitoring required by agency' radio button.
Fix provided: update into safecareplan table
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A
Code fix ticket#: N/A
Reason why no related code fix: User Error.
*/

update safecareplan
set recommendedforclosure = true, updatedon =now()
where safecareplanid = '4d363044-b361-4aa6-9e31-07f87315c362' and activeflag =1;

--update safecareplan_history
--set recommendedforclosure = true, updatedon =now()
--where safecareplanid = 'c3b35beb-2ddb-48c7-b45a-18a057e640f4' and activeflag =1;
