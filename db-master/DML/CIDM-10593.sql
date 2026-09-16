/*
 * CIDM-10593 - Psychiatrist and Pharmacist list shows 'null null'
 * Focus Area:Psychotropic Medications - Secondary Review
 * The Psychiatrist and Pharmacist list shows 'null null' for few records.
 */

update  cjams.userprofile set fullname ='Heather Burke',updatedby ='CIDM-10593',updatedon =now()
where securityusersid ='64c02446-0c9f-4110-8e85-53eb0f473773' and activeflag=1 ;

update  cjams.userprofile set fullname ='Sarah Edwards',updatedby ='CIDM-10593',updatedon =now()
where securityusersid ='26fcf860-f88d-47fe-b92e-55c713ea8df9' and activeflag=1;

update  cjams.userprofile set fullname ='Jill Morgan',updatedby ='CIDM-10593',updatedon =now() 
where securityusersid ='becc3cef-f7c8-42d2-8290-9cd975a71893' and activeflag=1;

update  cjams.userprofile set fullname ='Yen Dang',updatedby ='CIDM-10593',updatedon =now()
where securityusersid ='f3de9860-fad0-4c23-bd6e-48c1a738faee' and activeflag=1;
