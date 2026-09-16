/*
Issue: CJAMS-62513 Need to add DOD
Category/Module: Person Profile
Root cause: :CPS IR # 231020902441 is created on 08/21/2023 and closed on 09/29/2023.
             Need SSA/Product Owner's approval to add the child DOD as requested.
             Client ID: 201643493 (Jayden Civel)
             Date of Death (DOD): 08/23/2023
Fix provided: Data fix to update Date of Death
Data/Code fix ticket#: CJAMS-62513
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:Case is closed and data fix should resolve it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update person
set dateofdeath = '2023-08-23 00:00:00',
    updatedby = 'CJAMS-62513',
    updatedon = now()
where personid = 'd529301d-c52c-4228-b6b9-7bcbc6e18c19'
and activeflag = 1;