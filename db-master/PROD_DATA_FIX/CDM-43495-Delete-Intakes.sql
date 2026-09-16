
/*
   Issue Description: CDM-43495
   Category/ Module  :  Intakes
   Rootcause: The user requested to delete pending intakes.
   Fix: Datafix to delete pending intakes.
   Pull request# for code fix: 
   Reason why no related code fix: user error.
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Update intakedastatus table
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43495'
where intakenumber in ('I241012436310', 'I241012436309', 'I241012148019', 'I221010287912')
  and activeflag = 1;

-- Update intakedastaging table
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43495'
where intakenumber in ('I241012436310', 'I241012436309', 'I241012148019', 'I221010287912')
  and activeflag = 1;

-- Update intakeservicerequestactor table
update intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-43495'
where intakenumber in ('I241012436310', 'I241012436309', 'I241012148019', 'I221010287912')
  and activeflag = 1;
