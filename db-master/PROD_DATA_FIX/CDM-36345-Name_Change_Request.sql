/*
-- CDM-36345 - Name Change Request
-- Issue Description: 231040057445:Ms. Hundley submitted paperwork to the Department to have her name changed on the case, however we are unable to change it. Her name is currently Jacqueline Hundley-Lorick, but her name needs to be change to Jacqueline Hundley.
-- Case ID: S2024008056087
-- Category / Module: Persons / Household
-- Root cause: User Error, incorrect name entered. Customer shared the correct name to proceed with data fix.
-- Fix Provided:  updated adoptioncaseactor, adoptioncaseagreement tables with correct name. # S2024008056087
-- Pull Request# N/A
*/

update adoptioncaseactor set personid = '8b77d793-08cc-46ec-b1d0-be1646ed2fe1', updatedby = 'CDM-36345', updatedon = now()
where adoptioncaseactorid = '731b9b2a-075e-4006-92c8-b79630c7c574';

update adoptioncaseactor set personid = 'a92693a1-36ef-476f-92ab-5dff028f8284', updatedby = 'CDM-36345', updatedon = now()
where adoptioncaseactorid = '80741b46-8094-454a-b844-478fb6219748';

update adoptioncaseagreement 
set parent1providername = 'JACQUELINE HUNDLEY', updatedby = 'CDM-36345', updatedon = now()
where adoptionagreementid = '7e8c3933-9251-4d2a-a2b3-69ef7b8c4a5b';