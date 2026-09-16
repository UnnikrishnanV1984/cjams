/*
   Issue Description: CDM-37606 - Removal
   211030011899:Please remove the draft removal from youth.
   Category/ Module  : Child Removal
   Root cause: Against Child Olufemi Christiana, Draft records needs deletion (Child Removal -> Removal History).  Please provide data fix.
   Fix Provided: Data fix has been promoted to remove the draft record for the child Olufemi Christiana.
*/

select approvalstatustypekey,activeflag,*from intakeservreqchildremoval 
where intakeservreqchildremovalid='8663a4be-e6f6-4f1e-90ee-cd1ecaa03e4e'
and activeflag=1;

update intakeservreqchildremoval set 
    activeflag =0, 
    updatedby = 'CDM-37606', 
    updatedon = now() 
where intakeservreqchildremovalid ='8663a4be-e6f6-4f1e-90ee-cd1ecaa03e4e' 
and activeflag =1;