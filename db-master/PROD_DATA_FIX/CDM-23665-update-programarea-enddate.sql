/*
-- CDM-23665 -- 

-- Issue Description: 
 User asked to end date the program area as the case has been closed
  
*/

update personprogramarea 
set enddate = '2022-07-12 00:00:00', updatedby = 'CDM-23665', updatedon = now() 
where personprogramid in (
    '8686e68e-5e22-4387-8839-dabfdb58aa0b', 
	'eb23cfed-ffc4-4d67-acec-8046c195b6d2', 
	'17fc1637-0c25-4ec4-bc9c-809ef5cfbaf5', 
	'd89f59a2-1aea-473d-aa05-9e92f70fcf23', 
	'50639b3b-610b-4672-a677-47c005f909d3'
);