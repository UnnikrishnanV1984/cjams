/*
   Issue Description: CIDM-4450
   Category/ Module  : User Profile 
   Root cause: audit column not updated in cjams
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'eee7dad0-6ec3-4c99-924f-9cba55f99297') 
where documentpropertiesid =  'eee7dad0-6ec3-4c99-924f-9cba55f99297';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'd9f33469-a45f-4402-8809-8a2cdfd1948c') 
where documentpropertiesid =  'd9f33469-a45f-4402-8809-8a2cdfd1948c';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'a6d7e767-c0dd-47d8-a969-0ac64b0f5665') 
where documentpropertiesid =  'a6d7e767-c0dd-47d8-a969-0ac64b0f5665';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '6b50f5ec-a304-4428-b6f4-7f5b89412344') 
where documentpropertiesid =  '6b50f5ec-a304-4428-b6f4-7f5b89412344';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '3de62717-51cc-4488-b8f0-ea7862426d1a') 
where documentpropertiesid =  '3de62717-51cc-4488-b8f0-ea7862426d1a';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '01f28548-f159-472c-b07d-b3d09330c238') 
where documentpropertiesid =  '01f28548-f159-472c-b07d-b3d09330c238';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '91cd3c16-5f2d-43b9-aff3-4c3539519dac') 
where documentpropertiesid =  '91cd3c16-5f2d-43b9-aff3-4c3539519dac';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '5c93a037-6cfe-41a2-8e0c-2a29242f1934') 
where documentpropertiesid =  '5c93a037-6cfe-41a2-8e0c-2a29242f1934';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'ac46e6b6-e53c-4082-a391-69874e6fdfbc') 
where documentpropertiesid =  'ac46e6b6-e53c-4082-a391-69874e6fdfbc';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '036e7a66-7eaf-4091-a884-27566fc6a429') 
where documentpropertiesid =  '036e7a66-7eaf-4091-a884-27566fc6a429';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '41feed92-01be-4a7e-a4bd-5d12eb77285f') 
where documentpropertiesid =  '41feed92-01be-4a7e-a4bd-5d12eb77285f';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '7e3dcb29-c28b-4af1-8d5e-5e362e658296') 
where documentpropertiesid =  '7e3dcb29-c28b-4af1-8d5e-5e362e658296';


update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '170d6f3c-26c6-4510-a6b4-8498f2cb1e81') 
where documentpropertiesid =  '170d6f3c-26c6-4510-a6b4-8498f2cb1e81';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '861b9d45-7783-4378-93e5-8690e10985d7') 
where documentpropertiesid =  '861b9d45-7783-4378-93e5-8690e10985d7';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '5b1cc971-a208-454a-9e40-d034d24f46c8') 
where documentpropertiesid =  '5b1cc971-a208-454a-9e40-d034d24f46c8';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'cadcdbbb-5f58-4a58-969f-dfa4d5f5ae0b') 
where documentpropertiesid =  'cadcdbbb-5f58-4a58-969f-dfa4d5f5ae0b';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '2d79bb11-0deb-4233-afe8-48f9f2593402') 
where documentpropertiesid =  '2d79bb11-0deb-4233-afe8-48f9f2593402';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '84abff97-4451-456a-8eb5-dc24eda5aff7') 
where documentpropertiesid =  '84abff97-4451-456a-8eb5-dc24eda5aff7';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '633d9e05-6a97-404a-94ac-b330584563ec') 
where documentpropertiesid =  '633d9e05-6a97-404a-94ac-b330584563ec';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'a73517c9-1642-4712-a3a8-88b42a3b2d8c') 
where documentpropertiesid =  'a73517c9-1642-4712-a3a8-88b42a3b2d8c';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '15a8af78-db42-4a16-bc1c-378102414911') 
where documentpropertiesid =  '15a8af78-db42-4a16-bc1c-378102414911';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '75d25e44-b9d2-4b51-a086-a803037a4578') 
where documentpropertiesid =  '75d25e44-b9d2-4b51-a086-a803037a4578';


update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'cef366fe-23c2-4562-99b6-52dc847ba815') 
where documentpropertiesid =  'cef366fe-23c2-4562-99b6-52dc847ba815';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'bb8991c1-2f4c-4c8a-b160-3d49807c3565') 
where documentpropertiesid =  'bb8991c1-2f4c-4c8a-b160-3d49807c3565';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '38afa392-f9f7-430a-a18c-56f6ee9f64ac') 
where documentpropertiesid =  '38afa392-f9f7-430a-a18c-56f6ee9f64ac';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'ad2094c5-fef0-4d41-bd5b-87fcf75d3669') 
where documentpropertiesid =  'ad2094c5-fef0-4d41-bd5b-87fcf75d3669';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'ff046764-f80a-482a-afbf-590340bfe31b') 
where documentpropertiesid =  'ff046764-f80a-482a-afbf-590340bfe31b';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '46a7ce30-c8f0-4416-a0eb-7d9fae8f8aa4') 
where documentpropertiesid =  '46a7ce30-c8f0-4416-a0eb-7d9fae8f8aa4';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'dcf57389-a3be-482a-952a-66e6c6206ad3') 
where documentpropertiesid =  'dcf57389-a3be-482a-952a-66e6c6206ad3';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'a5969a95-1b9c-4c19-a3ea-7ef59a545633') 
where documentpropertiesid =  'a5969a95-1b9c-4c19-a3ea-7ef59a545633';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '13fbcb9b-a2f5-4917-850b-559bdf769438') 
where documentpropertiesid =  '13fbcb9b-a2f5-4917-850b-559bdf769438';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '51e19a52-35f8-4938-ae18-7e1597d05bdd') 
where documentpropertiesid =  '51e19a52-35f8-4938-ae18-7e1597d05bdd';


update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '48a6de7c-3ee7-4227-9cdb-070aff35e691') 
where documentpropertiesid =  '48a6de7c-3ee7-4227-9cdb-070aff35e691';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '87bb6e11-a3b4-4b36-b692-fce2376d32cc') 
where documentpropertiesid =  '87bb6e11-a3b4-4b36-b692-fce2376d32cc';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '9d984d6a-166b-43de-983e-faa5afcaf6f3') 
where documentpropertiesid =  '9d984d6a-166b-43de-983e-faa5afcaf6f3';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '9aca02d0-e03d-42d1-8253-d9b185e0b785') 
where documentpropertiesid =  '9aca02d0-e03d-42d1-8253-d9b185e0b785';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '28e46565-6407-4ddb-be59-b6479cb9f77f') 
where documentpropertiesid =  '28e46565-6407-4ddb-be59-b6479cb9f77f';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '5a98d00b-f5aa-4a98-bcfe-7dd110fdf0ff') 
where documentpropertiesid =  '5a98d00b-f5aa-4a98-bcfe-7dd110fdf0ff';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '5b79066d-ac6d-492f-aad5-536a2c12e48b') 
where documentpropertiesid =  '5b79066d-ac6d-492f-aad5-536a2c12e48b';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '7ea2aa42-3870-429d-8488-6efb62510e16') 
where documentpropertiesid =  '7ea2aa42-3870-429d-8488-6efb62510e16';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '8f400c29-f916-4222-8068-09dfcf0b08ba') 
where documentpropertiesid =  '8f400c29-f916-4222-8068-09dfcf0b08ba';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '4d2ed496-61a0-419c-86b3-c3098723da18') 
where documentpropertiesid =  '4d2ed496-61a0-419c-86b3-c3098723da18';


update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '73525ec5-c552-4333-855a-332eec7642cf') 
where documentpropertiesid =  '73525ec5-c552-4333-855a-332eec7642cf';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'c91678d5-09ae-4822-b617-589516e647de') 
where documentpropertiesid =  'c91678d5-09ae-4822-b617-589516e647de';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'c91678d5-09ae-4822-b617-589516e647de') 
where documentpropertiesid =  'c91678d5-09ae-4822-b617-589516e647de';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'd2ae88e4-8999-40c1-8790-1abd7fb1ed3e') 
where documentpropertiesid =  'd2ae88e4-8999-40c1-8790-1abd7fb1ed3e';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '2f77ddf2-a67a-40bf-abd8-9bbe90275b1e') 
where documentpropertiesid =  '2f77ddf2-a67a-40bf-abd8-9bbe90275b1e';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '3d520292-8492-4f25-847d-e7b0abb7dd7b') 
where documentpropertiesid =  '3d520292-8492-4f25-847d-e7b0abb7dd7b';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'ee0a586d-27ce-4c17-b79b-f7053da2236a') 
where documentpropertiesid =  'ee0a586d-27ce-4c17-b79b-f7053da2236a';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '38c99635-00f8-4869-bf9c-8e567c4ff67c') 
where documentpropertiesid =  '38c99635-00f8-4869-bf9c-8e567c4ff67c';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '66efaa51-d75e-43c2-9265-ce5c0e704acd') 
where documentpropertiesid =  '66efaa51-d75e-43c2-9265-ce5c0e704acd';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'f5519970-6c6a-44f4-8652-b1785103dd39') 
where documentpropertiesid =  'f5519970-6c6a-44f4-8652-b1785103dd39';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'a3a9cf20-f19f-41ef-9582-99206599171e') 
where documentpropertiesid =  'a3a9cf20-f19f-41ef-9582-99206599171e';



update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'adf82e68-013e-484c-9099-19f2fe1eb357') 
where documentpropertiesid =  'adf82e68-013e-484c-9099-19f2fe1eb357';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '1a3430b8-83f1-48b0-8d77-0987afa0d41a') 
where documentpropertiesid =  '1a3430b8-83f1-48b0-8d77-0987afa0d41a';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '4cb1795d-3c92-4777-8654-30c468363dec') 
where documentpropertiesid =  '4cb1795d-3c92-4777-8654-30c468363dec';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'ece89140-0ce0-4e89-b41a-5914be804e58') 
where documentpropertiesid =  'ece89140-0ce0-4e89-b41a-5914be804e58';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '1a0d5b17-3bcc-4a79-a5aa-8090d8d6438a') 
where documentpropertiesid =  '1a0d5b17-3bcc-4a79-a5aa-8090d8d6438a';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'e9973881-60b9-4aea-b992-070c21a3701a') 
where documentpropertiesid =  'e9973881-60b9-4aea-b992-070c21a3701a';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'ece5eaf9-750e-4f48-ac81-a567d8ad42ee') 
where documentpropertiesid =  'ece5eaf9-750e-4f48-ac81-a567d8ad42ee';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'ea59dd32-d8a9-41ed-8b98-1f805047091a') 
where documentpropertiesid =  'ea59dd32-d8a9-41ed-8b98-1f805047091a';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'b0774aa7-a1cb-4c03-ad71-74c77b99742f') 
where documentpropertiesid =  'b0774aa7-a1cb-4c03-ad71-74c77b99742f';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '5635e3cf-ccb8-4ba6-9e33-3decb086defe') 
where documentpropertiesid =  '5635e3cf-ccb8-4ba6-9e33-3decb086defe';


update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '61041dda-fa39-456a-8bc1-89d349bc96c4') 
where documentpropertiesid =  '61041dda-fa39-456a-8bc1-89d349bc96c4';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '9d277a3c-7a10-4cd2-bc86-bbb81e464d4d') 
where documentpropertiesid =  '9d277a3c-7a10-4cd2-bc86-bbb81e464d4d';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '0eb4798e-5035-4ee9-9507-0779bdf0d63a') 
where documentpropertiesid =  '0eb4798e-5035-4ee9-9507-0779bdf0d63a';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = '173a44e7-f70a-4e4c-b54c-68948191e114') 
where documentpropertiesid =  '173a44e7-f70a-4e4c-b54c-68948191e114';

update cjams.documentproperties 
set updatedby='CIDM-4450', updatedon=now(), actualdocumentdate = (select documentdate from cjams.documentproperties where documentpropertiesid = 'b0ba45fd-ba87-4bae-a0a4-a245922f3cdc') 
where documentpropertiesid =  'b0ba45fd-ba87-4bae-a0a4-a245922f3cdc';