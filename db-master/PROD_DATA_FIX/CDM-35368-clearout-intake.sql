-- CDM-35368 - Clearout some of intake requests for the specific supervisor
/* Issue Description:Clearing out some of the intake requests for the supervisor provided.

-- Case ID: S20230312055064

-- Category/ Module: Assign-case/

-- Root cause: user wants to clearout some of the intakes
-- Fix Provided:  set activeflag to 0 for specific case numbers for the supervisor provided.
-- Pull request# N/A
*/

update ROUTING R
set 
    activeflag  = 0,
    updatedon = now(),
    updatedby = 'CDM-35368'
from intakeservicerequest ISR
where 
  R.objectid  = ISR.intakenumber
  and
  R.tosecurityusersid = 'ee7a8459-06e3-40b3-9037-3cc0e8130202'
  and 
  R.activeflag = 1
  and
  ISR.servicerequestnumber in (
  '20200191023883',
  '20200163020998',
  '20200161020727',
  '20200132018482',
  '20200126018287',
  '20200125018197',
  '20200125018198',
  '20200125018196',
  '20200113017785',
  '20200105017577',
  '20200104017533',
  '20200100017493',
  '2020070016734',
  '2020069016652',
  '2020056016070'
);

update intakeservicerequest 
set activeflag = 0, updatedby = 'CDM-35368', updatedon = now() 
where activeflag = 1 and servicerequestnumber in (
  '20200191023883',
  '20200163020998',
  '20200161020727',
  '20200132018482',
  '20200126018287',
  '20200125018197',
  '20200125018198',
  '20200125018196',
  '20200113017785',
  '20200105017577',
  '20200104017533',
  '20200100017493',
  '2020070016734',
  '2020069016652',
  '2020056016070'
);