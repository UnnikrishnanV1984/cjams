-- CDM-38594 - Delete IHS Cases
/*
-- Issue Description: 
   Dashboard:I noticed today that there are 15 old cases listed under 
   my Cases "To be Assigned" tab from May 2020 through August 2022.
   All of these cases have been assigned, worked, and closed in Assessment.
   
-- Case ID's : 221020245539, 20200195024315, 20200191023886, 20200191023887, 20200182022874, 20200182022857, 20200176022196, 20200176022197, 20200171021751, 20200161020689, 20200161020688, 20200156020247, 20200154020038, 20200143019201, 20200143019137

-- Category/ Module: Removal (Case Management) 
-- Root cause: User wantst to delete 15 IHS cases against user which are not searchable from the global search.
               All of these cases have been assigned, worked, and closed in Assessment.
-- Fix Provided: Data fix to delete old IHS cases from to be assigned dashboard */

update routing 
set activeflag = 0,
    updatedby = 'CDM-38594',
    updatedon = now()
    where objectid in ('I221010306927','I202000168010','I202000467553','I202000467561','I202000266330','I202000266300','I202000365557','I202000365556','I202000564941','I202000263745','I202000263710','I202000463204','I202000462513','I202000561918','I202000561846') 
    and activeflag =1;
