/*
Issue: 231030161133:YTP is in the system but is not registering under case plan. 
Category/Module: YTP
Root cause: As per system design, the approved YTP record will be pulled to the case plan if the YTP date is in the range of the case plan Date range.
In this case, the case plan date range is 01/23/2025 - 07/22/2025 and the latest YTP start date is 07/22/2025 so the system will pulling the YTP record that was created on 02/06/2025.
Data fix needed to update the creation date to '07/20/25' for below YTP
Fix provided: Data fix needed to update the creation date to '07/20/25' for below YTP
Data/Code fix ticket#: CJAMS-61329
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix:This is as per system design and Data fix should resolve it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update youthtransitionplan
set insertedon = '2025-07-20',
    updatedon = now(),
    updatedby = 'CJAMS-61329'
where youthtransitionplanid = 'cc618877-e553-4c38-9124-475d92e466c6'; 