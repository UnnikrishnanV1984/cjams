--CDM-7848 - 2020025803017 court hearing client update

UPDATE hearingclients SET personid = 'c8b8d493-7754-42b8-9e53-8057d5eb36fc', updatedon = now() 
WHERE hearingclientid IN ('36fb308a-8e0e-42d5-913a-f0659c688d0c', 'ea5493ce-de63-4aeb-b4b7-c80667dfd0e4') 
AND personid = '67b0b567-9d15-4dd9-b20c-3f2bc2f7dc25' AND activeflag = 1 ;
    
--7849 - not displayed on case complete tab
UPDATE intakeservicerequest SET isrouted = true,  updatedon = now(), updatedby = 'CDM-7849' 
WHERE servicerequestnumber = 20200259035207 and activeflag = 1;


UPDATE personidentifier SET personidentifiervalue = 'MDT-126899704', updatedon = now() 
WHERE personidentifiervalue = 'MDT-135448721' AND activeflag = 1;

--CDM-6644
--update cis client id 
UPDATE person SET cisclientid = 479059776, updatedon = now() WHERE cjamspid = 4089670 AND cisclientid = 490034832;

UPDATE personidentifier SET personidentifiervalue = 'MDT-127344734', updatedon = now() 
WHERE personidentifiervalue = 'MDT-135081781' AND activeflag = 1;

UPDATE intakeservicerequestactor set personid = 'd728c647-fcb1-4366-b8a9-def08184e979', updatedon = now(), updatedby = 'CDM-6644'
WHERE intakenumber = 'I202000473544' AND personid = '1d5e22e3-4958-42f9-a69b-55258b730f94' ;

UPDATE actor SET personid = 'd728c647-fcb1-4366-b8a9-def08184e979', updatedon = now(), updatedby = 'CDM-6644'
WHERE actorid = 'b1e580a5-ab9e-41fa-b78d-6ea096ca8e04' AND personid = '1d5e22e3-4958-42f9-a69b-55258b730f94' ;

UPDATE personrole SET personid = 'd728c647-fcb1-4366-b8a9-def08184e979', updatedon = now(), updatedby = 'CDM-6644'
WHERE  intakenumber = 'I202000473544' AND personid = '1d5e22e3-4958-42f9-a69b-55258b730f94' ;

UPDATE person SET activeflag = 0, updatedon = now(), updatedby = 'CDM-6644' WHERE personid = '1d5e22e3-4958-42f9-a69b-55258b730f94' and activeflag = 1 ;
