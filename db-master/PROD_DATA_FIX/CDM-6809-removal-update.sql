--The following needs to be updated through a data fix.

--Case#3122010: Child removal end date needs to updated for 'Miracle Washington' as 07/23/2020.
--Parental custody record under Court>> Legal custody needs to be deleted.

UPDATE legalcustody SET activeflag = 0, updatedby = 'CDM-6809', updatedon = now() WHERE legalcustodyid = 'a05385e2-ce29-48dd-9719-4c0d56d3082f';
UPDATE intakeservreqchildremoval SET exitdate = '2020-07-23 00:00:00', updatedby = 'CDM-6809', updatedon = now() WHERE removalid = 199087 and exitdate is null ;

--Case#3289172: Child removal end date needs to be updated as 07/17/2020.
--Parental custody record under legal custody needs to be deleted.
UPDATE legalcustody SET activeflag = 0, updatedby = 'CDM-6809', updatedon = now() WHERE legalcustodyid = '81600de3-7a4a-4610-b87e-909215aac733';
UPDATE intakeservreqchildremoval SET exitdate = '2020-07-17 00:00:00', updatedby = 'CDM-6809', updatedon = now() WHERE removalid = 197673 and exitdate is null ;


--Case#3307397: Child removal end date to be updated as 08/21/2020.
--Legal custody record "Custody and Guardianship to Relative" needs to be deleted under Court.

UPDATE legalcustody SET activeflag = 0, updatedby = 'CDM-6809', updatedon = now() WHERE legalcustodyid = '4677b131-3baa-4819-80d8-dde18e6e61d4';
UPDATE intakeservreqchildremoval SET exitdate = '2020-08-21 00:00:00', updatedby = 'CDM-6809', updatedon = now() WHERE removalid = 199696 and exitdate is null ;

--Case#3289066: Child removal for both the children needs to be updated as 07/12/2020.
--For both the children, the "Custody to Mother" legl custody record under court needs to be deleted.
UPDATE legalcustody SET activeflag = 0, updatedby = 'CDM-6809', updatedon = now() WHERE 
legalcustodyid IN('3f817a28-0c4b-4d41-a3f3-ba4de5ba70d2', '206a4b5e-97a6-40d2-97f8-9b9369af19bb');
UPDATE intakeservreqchildremoval SET exitdate = '2020-07-12 00:00:00', updatedby = 'CDM-6809', updatedon = now() WHERE removalid in (191354, 191355) and exitdate is null;

--Case#3228285:*The child(Mckenzie Stanback) removal end date needs to be updated as 09/24/2020 and Living arrangement needs to be end dated on 09/24/2020.
UPDATE intakeservreqchildremoval SET removalexitreason = 'REUNIF', exitdate = '2020-09-24 09:00:00', updatedon = now(), 
updatedby = 'CDM-6809' WHERE removalid in (197406, 162830) AND activeflag = 1 and exitdate is null ;

--Case#3293414: Child removal end date needs to be updated as '08/17/2020'.
UPDATE intakeservreqchildremoval SET removalexitreason = 'REUNIF', exitdate = '2020-08-17 09:00:00', updatedon = now(), 
updatedby = 'CDM-6809' WHERE removalid in (193441) AND activeflag = 1 and exitdate is null ;

--Case#3230227: * Child removal end date needs to be updated as '08/17/2020'.
UPDATE intakeservreqchildremoval SET removalexitreason = 'REUNIF', exitdate = '2020-08-17 09:00:00', updatedon = now(), 
updatedby = 'CDM-6809' WHERE removalid in (173451) AND activeflag = 1 and exitdate is null ;

--Case#3230646: Child removal end date needs to be updated as '09/10/2020'.
UPDATE intakeservreqchildremoval SET removalexitreason = 'REUNIF', exitdate = '2020-09-10 09:00:00', updatedon = now(), 
updatedby = 'CDM-6809' WHERE removalid in (183561) AND activeflag = 1 and exitdate is null ;

--Placement: Th runaway record needs to be end dated on '09/10/2020'.
UPDATE placement SET enddatetime = '2020-09-10', updatedon = now(), 
updatedby = 'CDM-6809' WHERE placementid = 'dcc1270d-9334-4492-b6d2-134b5bd46a1f' and enddatetime is null;

--Provider placement with "Pressley Ridge - Second Generations ILP - Towson" needs to be end dated on 06/21/2020.
--Provider placement with "KidsPeace CPA - Columbia" needs to be end dated on 10/23/2020.