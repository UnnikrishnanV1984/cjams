UPDATE routing
SET activeflag = 0, 
	updatedby = 'CDM-14858',
	updatedon = now() 
WHERE routingid in ('a070fb94-45b5-43c9-a284-9022da37137c', 'e936ad3f-f0a7-4f05-96f8-8abb559f285b', '39819016-c6d7-41df-9e6c-74588d175b00', '58d1f0b9-60d0-496d-b349-1b6a85fe012b', '926424f0-5d20-407c-b336-a9fe079c8b80', '54540327-4fa6-4996-a259-fbaad236bfd8', 'd068cfcb-d440-45a8-a592-bf2caeee7b56', '787d20a9-304a-4e36-82c1-d726f869900f', '32fd2ab1-5656-4de3-bebc-7a17a6f5470a');
