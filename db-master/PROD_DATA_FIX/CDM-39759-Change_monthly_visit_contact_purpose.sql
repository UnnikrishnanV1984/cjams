/* 
-- CDM-39759 - Contact Notes

Issue Description: User Error - Incorrect Contact purpose selected

-- case number: 3240139 

-- Category/ Module: Contact Notes

-- Root cause: User request to change contact purpose from Case Management & Case Monitoring to Monthly Visit for contact id 13260493
-- Fix Provided: Datafix has been provided to update the progressnote record

*/


update progressnote 
set progressnotereasontypekey='MV',updatedby ='CDM-39759',updatedon =now()
where progressnoteid ='6715bbe2-b5b1-4965-b2a7-c253acee3855' and witsid = 13260493 and progressnotereasontypekey='CM' and activeflag = 1;
