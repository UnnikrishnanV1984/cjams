/*

   Issue Description: CDM-39786-Voided placement
   Trying to update child's placement but the system is not allowing user to update because its still picking up the void placement from 2018 they came over from the chessie system.

   Category/ Module  : Placement

   Root cause: Trying to update child's placement but the system is not allowing user to update because its still picking up the void placement from 2018 they came over from the chessie system.

   Fix provided :Datafix to enddate voided placement

   Code fix ticket#:

   Reason why no related code fix: 

   Status of the code fix if already submitted and expected prod fix date: 

   Backup before update/ delete:

*/

update placement set enddatetime ='2023-08-24 08:30:00', updatedon = now(), updatedby = 'CDM-39786' where placementid  ='fb8ebef7-051a-46e7-85dc-0f02b5641290';