/*
Issue Description: Please do a data fix for case # 241030406800 as below;
1. Update the Case start date with 09/17/2024 in the case search
2. Update the Case start date with 09/17/2024 in the caseworker My Service Case dashboard
3. Delete the highlighted program assignment for three of the household members below
Category/Module: Support
Root cause: User requested datafixes on previous support ticket
Fix provided: DB queries to fix previous error values
Data/Code fix ticket#: CDM-42241
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data cleanup
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--1. update case start date in servicecase
update servicecase
set startdate = '2024-09-17 11:17:45', updatedby = 'CDM-42241', updatedon = now()
where servicecaseid = '794bb7b2-58a0-466f-9c16-ccb7b66c0df8' and activeflag = 1;

--2. update case start date in servicecasedisposition
update servicecasedisposition
set statusdate = '2024-09-17 11:17:45', updatedby = 'CDM-42241', updatedon = now()
where servicecasedispositionid = '42b9f3c6-a51a-4156-a075-e93cecafe4f4' and activeflag = 1;

--3. remove highlighted program assignments from personprogramarea
update personprogramarea
set activeflag = 0, updatedby = 'CDM-42241', updatedon = now()
where activeflag = 1 and personprogramid in (
'c9e3187d-5f66-4494-8b17-010d5f0223a6',
'19f375b5-6e82-4319-a229-6b9bacc1fd24',
'34302bfe-39cb-4799-98a8-551d5c7485eb',
'35641f84-bc19-4f28-9321-58ecd8626f53');