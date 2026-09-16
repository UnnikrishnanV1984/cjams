/*
Issue Description: Data cleanup in CJAMS to accurately identify Safe Haven (SH) clients. This cleanup specifically applies to clients with a date of birth between 2020 and 2025.
Category/Module: Data Clean up
Root cause: Data clean up, CJAMS is capturing the clients Safe Haven Baby flag in the person table and in the personrole table as well. The current code has flaws if the Safe Haven Baby check box is unchecked CJAMS is updating the personrole table only (not updating the person table).
Fix provided: 
Data/Code fix ticket#: CIDM-10580
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

/*
select safehavenbabyflag,updatedby,updatedon,cjamspid,* from person 
where cjamspid in (202697723, 204114622, 204114369, 200026681, 201896968, 200178438, 200980717, 200175498, 201209788, 203542594, 203977839, 204005025, 203985410, 203985408, 204015015, 202812379, 200865472, 200855233, 200641061, 200900514, 203723840, 203971276, 204052916)
and activeflag = 1 and safehavenbabyflag =1;

select safehavenbabyflag,updatedby,updatedon,cjamspid,* from person 
where cjamspid in ( 202531374, 200981808, 203008923, 202797387, 204141750, 204149160, 204148973, 200176948, 200178435, 200947430, 200970467, 200974641, 201186076, 204054058, 204124079, 200973323, 204134778, 204153897, 200306525, 200893474, 200639050, 202598503, 201274735, 201228729, 202245926, 202794299, 202794067)
and activeflag = 1 and safehavenbabyflag =1;
*/

/*0---> 1
 *8 records
202697723
200865472
200855233
200641061
200900514
203723840
203971276
204052916
*/

update person
set safehavenbabyflag = 1,
	updatedby= 'CIDM-10716',
	updatedon = now()
where cjamspid in (202697723, 204114622, 204114369, 200026681, 201896968, 200178438, 200980717, 200175498, 201209788, 203542594, 203977839, 204005025, 203985410, 203985408, 204015015, 202812379, 200865472, 200855233, 200641061, 200900514, 203723840, 203971276, 204052916)
and activeflag = 1 and safehavenbabyflag =0;

/* 1--->0
 * 14 records
200176948
200178435
200947430
200970467
200974641
200981808
201186076
202531374
202797387
203008923
204054058
204141750
204148973
204149160*/

update person
set safehavenbabyflag = 0,
	updatedby= 'CIDM-10716',
	updatedon = now()
where cjamspid in ( 202531374, 200981808, 203008923, 202797387, 204141750, 204149160, 204148973, 200176948, 200178435, 200947430, 200970467, 200974641, 201186076, 204054058, 204124079, 200973323, 204134778, 204153897, 200306525, 200893474, 200639050, 202598503, 201274735, 201228729, 202245926, 202794299, 202794067)
and activeflag = 1 and safehavenbabyflag =1;	