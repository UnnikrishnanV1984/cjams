
-- Need t0 add and update contact participants as per userrequest 

update cjams.contactparticipant set activeflag =1, updatedby ='CDM-13583', updatedon =now() where progressnoteid ='8c1b67a2-b900-42fa-b698-eae485689ff4';

INSERT INTO cjams.contactparticipant
( progressnoteid, participanttypekey, intakeservicerequestactorid, activeflag, insertedby, updatedby, updatedon, participantid)
VALUES('8c1b67a2-b900-42fa-b698-eae485689ff4'::uuid, 'COLLATERAL', 'abedd5f5-c7b6-4675-b78f-d3619cf81384'::uuid, 1, '6af7a326-0572-4e9c-9d19-e15e2949c5fe', 'CDM-13583',now(),  'abedd5f5-c7b6-4675-b78f-d3619cf81384'::uuid);
