/*
 Issue: Not opened by supervisor
 Category/Module: assignments
 Root cause: :YTP case is showing as not approved
 Fix provided: DB query to change the routingstatustypeid value to approved in routing table
 Data/Code fix ticket#: CDM-44247
 Regression Impacts: N/A
 Is Code fix Required?: No
 Code fix ticket#: N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
 Backup before update/ delete:Query:
 */
update
    routing
set
    routingstatustypeid = 16,
    updatedby = 'CDM-44247',
    updatedon = NOW()
where
    objectid = 'd48316f6-2e75-402c-b8f2-9b9143023297'
    and routingid = '3f9eacd6-5286-4652-98c8-172c7743ab91'
    and activeflag = 1
    and eventcode = 'YTP';