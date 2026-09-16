/*
Issue Description:211030012818:I am encountering an issue in one of my cases in the services area where there appears to be a glitch on the screen where I am unable to create a service plan version, obtain signatures, or send the service plan for approval with my supervisor. Also, when I am trying to print the service plan it is not the up to date version. I even notice grey boxes popping up on the screen when I try to move my mouse. I also was not able to make a report in the service plan area due to the bug.
Root cause: During an earlier attempt to create this Service Plan, there was an incomplete data save. This left multiple records in Draft status without proper date fields populated. Because of these incomplete Draft records, the system blocked the creation of a new Service Plan version.
Fix provided: DB query to udate serviceplan,snapshothist.
Data/Code fix ticket#:CJAMS-62028
Regression Impacts: N/A
Is Code fix Required?: no
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update serviceplan
set activeflag =0,updatedby ='CJAMS-62028', updatedon =now()
where serviceplanid  ='f3ae1aa1-d201-48a8-a7dc-b2a2f7087a3b' and activeflag =1;


update snapshothist
set activeflag =0,updatedby ='CJAMS-62028', updatedon =now()
where id in ('ad03474a-6507-4c51-8bcd-bec5915ad6e3','6c363120-feae-4bf3-9ed1-5567ca53576d')  and activeflag =1;