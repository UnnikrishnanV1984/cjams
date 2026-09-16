-- CDM-36760 - Contact Notes
/* Issue Description: User Error - Incorrect Contact purpose selected

-- case number: 3241584 

-- Category/ Module: Contact Notes

-- Root cause: User request to change contact purpose from Case Management & Case Monitoring to Monthly Visit for contact id 12545673
-- Fix Provided: Datafix has been provided to update the progressnote record

*/

select progressnotereasontypekey, * from progressnote where progressnoteid = 'f3406ca7-6cb2-48e6-b6a5-e60d55d8d5b9';

update progressnote
	set progressnotereasontypekey = 'MV',
		updatedon = now(),
		updatedby = 'CDM-36760'
	where progressnoteid = 'f3406ca7-6cb2-48e6-b6a5-e60d55d8d5b9'; 