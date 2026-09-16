/*
 * CDM-37141 - CPS-ROA
 * Customer Email ID:jessica.roundtree@maryland.gov
 * Focus Area:Decision
 * Description - 241021902205:Case should have been entered as an out of state ROA from Virginia. Case did not load properly and 
 * will not appear on the caseworker's workload. Case will not allow assessments. 
 * 
*/

--select intakenumber, servicecaseid , * from intakeservicerequest where servicerequestnumber = '241021902205';
--select intakeserviceid, insertedby, *  from intakeservicerequest where intakenumber = 'I241012064352';
select * from createservicecase('ce534720-4bca-4df6-acd1-808f5727cff3', null, 1,'fc251376-8745-4381-a750-6a617c748678', 'intake'); -- intakeserviceid, insertedby
