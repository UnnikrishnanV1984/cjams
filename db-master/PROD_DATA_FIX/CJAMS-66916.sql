/* 
    Issue Description: CJAMS-66916
  Category/ Module  : Services: Service Log
  Root cause: As per system design, multiple Purchase Authorization (Flex Fund) can not be created for the same date period under one Service Log if the purchase authorization for the same period has approved,
              In this case, there are two purchase authorizations for the same date period have been added with status as Returned (Auth ID: 3140556) and Approved (Auth ID: 3668086) so the returned authorization can not be resubmitted.
              Data fix is needed to deny the Auth ID: 3140556 as requested.
  Fix provided: Data fix has been done to deny the purchase authorization
  Is code fix required: N 
  Pull request# for code fix: 
  Reason why no related code fix: Working as expected
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/


update routing
set routingstatustypeid= 62,
routeddescription='Denied CJAMS-66916',
remarks='Denied',
updatedby='CJAMS-66916',
updatedon=now()
where  routingid='1066e57c-f375-4264-b34a-69e9b7dfb2c5' and eventcode='PCAUTH';