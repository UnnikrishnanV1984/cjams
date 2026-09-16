

/*
Issue Description: SSN Update for Client DIEADRA Elsey CJAMS PID # 204772035 | CIS # 546074733
Category/Module: Person 
Root cause: User requested to carry out data fix to update the SSN# 213-92-2795 for Client DIEADRA Elsey CJAMS PID # 204772035 | CIS # 546074733
Fix provided: Data fix done to update the SSN# 213-92-2795 for Client DIEADRA Elsey CJAMS PID # 204772035 | CIS # 546074733.
Data/Code fix ticket#: CJAMS-67498
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/
update person 
set ssnno  = '213922795', updatedby = 'CJAMS-67498', updatedon = now()
where cjamspid  = '204772035'
and activeflag =1;

insert into personidentifier (personidentifierid, personid, personidentifiertypekey, personidentifiervalue, insertedby, insertedon, activeflag, effectivedate)
values(uuid_generate_v4(), 'fbe6c796-b10a-4b14-85f1-eba80f445e5b', 'SSN', '213922795', 'CJAMS-67498', now(),1 , now());