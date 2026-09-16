/*
   Issue Description: CDM-38477
   Category/ Module  : Case Reopen
   Root cause: user wants reopen the case .Case is closed in error. Need to do data fix
   Fix Provided: Data fix has been promoted to reopen the CPS-AR case that is in closed state.
*/

update routing 
set routingstatustypeid=2,
    activeflag =1,
    intakerecommendation = 'screenout',
    updatedby = 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7',
    updatedon = now()
where objectid='I241012135657';


update intakedastatus 
set status=2,
    updatedby = 'CDM-38477',
    updatedon = now()
where intakenumber  = 'I241012135657';


update intakeservicerequestdispositioncode
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
    servicerequesttypeconfigiddispostionid = '9a333c30-8043-4732-9f9a-622b8d8038da',
    description = 'Accepted',
    updatedby = 'CDM-38477',
    updatedon = now()
WHERE intakeserviceid = '0e626522-3fe6-4fb6-aa30-5eae89be7592';


update intakeservicerequest
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
    intakeservicerequestclassid = 'b74ded78-12dc-4e6d-94db-7662d6eaf093',
    actiontype = 'AR',
    updatedby = 'CDM-38477',
    updatedon = now()
where intakeserviceid = '0e626522-3fe6-4fb6-aa30-5eae89be7592';


update personprogramarea 
set subprogramkey='AR',
    updatedby = 'e4b5f055-b967-4b2b-9f44-04d76dbcc2d7',
    updatedon = now() 
where personid in ('2d8cad28-7f7e-48e6-9eb0-857528e62e9b','4148cb59-4639-43d4-a398-5070052faf0b','8eb422b7-e18b-4a26-a37c-0ad49ce15fba','a6590957-5710-4418-81c4-67b710fda54f') 
and objectid='0e626522-3fe6-4fb6-aa30-5eae89be7592'

