update actor
set ishouseholdmember = 2, updatedby = 'Datafix user as per CDM-1662', updatedon = now()
where personid = '81186ce3-6049-4d1a-a81f-88f9bc45a88e' and activeflag=1 and intakenumber = '3307809';

update intakeservicerequestactor
set householdheadflag =0, isheadofhousehold = false, updatedby = 'Datafix user as per CDM-1662', updatedon = now()
where actorid ='beca5d85-7d13-43b6-92f9-df62ae1d02b3' and activeflag=1;


update personrole
set ishouseholdmember = 2, updatedby = 'Datafix user as per CDM-1662', updatedon = now()
where personid = '81186ce3-6049-4d1a-a81f-88f9bc45a88e' and activeflag=1 and intakenumber = '3307809';

