/*
Issue Description: On the person profile, the AKA checkbox is selected and the Alias & Maiden Name cards are available without any data.
Category/Module: Error
Root cause: User created the two aliases without data in April 2021
Fix provided: DB query to deactivated empty aliases
Data/Code fix ticket#: CDM-42208
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating alias
update alias 
set activeflag = 0, updatedby = 'CDM-42208', updatedon = now()
where aliasid in ('2ac2443f-6ce2-46d7-9b90-ffd84b19525f', 'e13ba4c6-2b39-4e56-aa6e-3a21088976ac') and activeflag = 1;