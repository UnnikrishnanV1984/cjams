/*
   Issue Description: CDM-28079
   Category/ Module  : Removal start date disappeared
   Root cause: :Clent aged out in Sepetmeber and we were able to end date the removal but now the start date for the child of 7/27/2018
   Reason why no related code fix:  Data fix

   
*/


update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-28079', updatedon = now() where intakeservreqchildremovalid = '16bcdb65-2160-4798-8e66-833098476cc0';