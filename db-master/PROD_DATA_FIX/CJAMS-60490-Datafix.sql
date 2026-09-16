/*
    Issue Description:  CJAMS-60490
    Category/ Module:  Contacts / Progress Notes
    Root cause: WITS-interfaced progress notes were linked to the wrong service case.
                80 notes landed on case 3171993 and must be moved to case 251030569082.
    Fix provided: Re-point the affected progressnote rows (identified by witsid) from the
                  source service case to the target service case.
    Is Code fix Required?: NO
    Code fix ticket#: N/A

    CANS OOH - 6

DELAUNTE LATRELL WHITE (Updated dates: 09/15/2025, 05/30/2024, 03/15/2023)
FLORENCE MARIE WHITE (Updated dates: 08/01/2025, 05/30/2024, 03/15/2023)

SAFE-C OHP - 14

DELAUNTE WHITE (Updated dates: 07/07/2025, 06/06/2024, 02/08/2024, 06/30/2023, 06/06/2023, 06/01/2023, 03/31/2023, 12/29/2022, 12/19/2022)
FLORENCE WHITE (Updated dates: 07/07/2025, 06/06/2024, 06/22/2023, 06/09/2023, 12/16/2022)
   
    Source case 3171993      = servicecaseid e246ff09-2942-4312-a88f-3f8b1aa6bc55
    Target case 251030569082 = servicecaseid 2af28137-e13f-421b-b6a1-052cf2bd1868

*/


UPDATE progressnote 
SET entitytypeid = '2af28137-e13f-421b-b6a1-052cf2bd1868', 
    updatedby = 'CJAMS-60490', 
    updatedon = NOW() 
WHERE witsid IN (14563510, 14921415, 14563917, 11484683, 11691538, 11692202, 10452545, 10452505, 12648102, 12664475, 12668499, 12678617, 12686613, 12702635, 12722109, 12246634, 10590848, 13285716, 10672160, 11853401, 11883717, 14495550, 14845047, 10835181, 10879843, 12100475, 10881368, 10890238, 10936273, 11040785, 12250642, 11185494, 14620302, 14500435, 13270514, 13270515, 13464298, 13829014, 13838973, 14383684, 14651283, 14699074, 15052645, 15051770, 15088535, 15133977, 15134247, 15235881, 15182717, 15235886, 15247722) 
  AND entitytypeid = 'e246ff09-2942-4312-a88f-3f8b1aa6bc55' 
  AND activeflag = 1;


update assessment
set servicecaseid = '2af28137-e13f-421b-b6a1-052cf2bd1868',objectid = '2af28137-e13f-421b-b6a1-052cf2bd1868'
where assessmentid in ('98cf5135-2950-4415-8d2a-f078f889a0c8','7c8e95de-052f-4b8f-9441-68eb94c2855d','9451b9f9-bdc0-4c63-9f74-a5bbbe8875dc','b403d7c9-2615-407f-b37a-38c453f08b61','8e7ea337-4e87-4d6e-86b8-1c534d8f5860','418b26f9-6fb0-45dc-8058-42d904432def','f279faa0-6e0d-4b0f-a970-73d69d033742','8adfe0c9-73b2-4899-a8ff-bd8d31dcec67','616335e3-5525-4dc7-8acb-446d6f6e8fc0','f42aae20-f14a-4e2e-be4b-3ba4df45bb9b','435a956c-e095-42ee-87d4-c474f9af2bda','efd1ede5-be99-4421-90b6-06749f0bfd41','7508662c-ea37-4c42-99b9-5518df2f1c2f','c30de467-9073-4c1e-a432-1c95894c00a6') and activeflag = 1;


update assessment
set servicecaseid = '2af28137-e13f-421b-b6a1-052cf2bd1868',objectid = '2af28137-e13f-421b-b6a1-052cf2bd1868'
where assessmentid in ('8e404c56-2d33-41e0-b61f-922e31dca05a','05d5a934-7cbf-4b9a-819f-e82c6160058c','3ba1a1f2-47a1-47f9-b29a-9537469a5e96','c43fb520-915d-4e67-a45f-8df53d444c06','42b8ac53-9380-4259-badb-823ec678b6f8','8e404c56-2d33-41e0-b61f-922e31dca05a','418e8fb2-0eb8-4ab9-b6e3-d19682e681a1') and activeflag = 1;
