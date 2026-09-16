/*
   Issue Description: CJAMS-66782
   Category/ Module: Person
   Root cause: House hold members missing for service case 241030291653. These are inactivated as these persons are linked to a expunged CPS case
   Fix Provided : Reactivated the intakeserviceactor records
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/


update actor set activeflag = 1, personid = 'a2671b88-5e8d-4d90-b15f-4ac8c729ca94', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '487900a0-3645-4f89-89bd-e0fb67a39539';
update actor set activeflag = 1, personid = 'c85084d6-8484-475d-a7a9-7b0a3b7e19cb', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '6ce20b5f-3d39-4cc6-a1a6-7135f7257f26';
update actor set activeflag = 1, personid = '64482236-8c04-49cb-a035-9689e71e4a09', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '8f8431c2-c067-4b61-8614-4ea27d93e957';
update actor set activeflag = 1, personid = '618f0d1c-16f2-409d-8f7c-e0cb608ece12', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'ac9dde74-7270-4bfe-82bb-5db8a9a2a6e2';
update actor set activeflag = 1, personid = '10a888da-b9c8-4498-8c39-08bff2cfccde', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'eaa74cef-0002-43d1-8358-4c648baca9e2';
update actor set activeflag = 1, personid = '02939c00-e4e0-4336-b583-8877c2dbc352', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '16f7527e-aaf8-4e81-a8c1-ffa515c27889';
update actor set activeflag = 1, personid = '0cf6612c-41ae-4236-8ee5-a6dd49050f62', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '41cf8fdb-5a8a-4883-955e-51e31b468e68';
update actor set activeflag = 1, personid = '486d0117-6825-44f0-96b6-a52cba78ef1a', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '696f72a1-9f07-4ddc-8b79-4b954ff605c7';
update actor set activeflag = 1, personid = '05c9d69a-814d-44a1-82bd-f8741b54902f', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '9815556f-0508-40fb-9c4a-49bc82da73af';
update actor set activeflag = 1, personid = 'ad446068-d23b-47e7-93a2-bbf7c0749432', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '00270ead-fb06-4a91-a31a-0779d7ab0af3';
update actor set activeflag = 1, personid = '0200eadc-3e31-431f-8aac-6ac725a942ae', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '0697384f-37cd-48b1-b75d-e98376d35b52';
update actor set activeflag = 1, personid = 'b148ebe8-7495-4563-8981-387d4e74c3a7', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '12a29edc-0eac-49f7-9e21-2ce061da554d';
update actor set activeflag = 1, personid = '3ab2ebd2-24e0-47a8-b40e-c410945e7f93', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '1db0ef62-a99b-4a2d-85a4-dc8884e65d3e';
update actor set activeflag = 1, personid = 'fd3fe6da-da23-4baa-a517-98b8a547961c', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '40572b0c-7fae-4812-84f8-5e8aa2d3eba1';
update actor set activeflag = 1, personid = '2331fed9-8009-4def-b203-3af275a6354d', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '4c9c8c35-003e-4252-89e7-566b423281f7';
update actor set activeflag = 1, personid = 'a005b6b5-5c3c-4b4f-997c-d53fa4c1116f', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '7dd11af3-5e89-47eb-a92a-281f8ebde262';
update actor set activeflag = 1, personid = '3e6f671a-e4f1-462b-abc9-15a20dc0b241', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '8ea275ed-f5ed-458f-a851-ae5bc736f065';
update actor set activeflag = 1, personid = '6d81b205-f00c-474e-b7b7-55b2ce26a058', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '993f1238-7fee-4d71-96aa-5b8b44ff150c';
update actor set activeflag = 1, personid = '3e405720-1f59-4056-a553-ed14d8d71fa5', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'b408bb6a-781f-4b65-b285-646d8e45fdd4';
update actor set activeflag = 1, personid = '343d97ac-0afb-4e87-89db-0bc17eae65a1', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'c3c1be71-90eb-48b2-8aeb-f6b316cbec3f';
update actor set activeflag = 1, personid = '074d66bf-4b22-480d-ba88-e169e7c271e6', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'e900c17f-7802-4ab2-b36f-8009eeb64762';
update actor set activeflag = 1, personid = '97245ebb-bb80-4f56-8919-5b084e696722', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'ee101b3c-e306-47b5-ac1f-d973aa323895';
update actor set activeflag = 1, personid = '9070796a-fc76-4903-8938-432b7e02c6e5', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '2b42d520-d2e4-469a-9d06-9419f34c270e';
update actor set activeflag = 1, personid = 'ba367a7c-e3dd-46cb-8332-b0454ae3c6a4', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '308e2127-96cd-4aaa-b4e9-f931a0d6ec8d';
update actor set activeflag = 1, personid = '0b60cfd8-2bf7-460c-9650-8e7434d2412a', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3a635347-d37f-4b78-b7b8-808c3ef6603a';
update actor set activeflag = 1, personid = '0ab41fb7-28ea-4686-8ec8-d460b7b19ed5', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'b1b566c2-55a5-4c06-bf97-77dfa0f4b978';
update actor set activeflag = 1, personid = '03b42b28-d775-484d-a2ae-8d06eec6e79f', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'b439d350-6d2e-4c11-b19c-563904beb4b9';
update actor set activeflag = 1, personid = '75e256eb-3403-4277-87d1-12a978958402', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '00861b1e-9942-4668-88be-97f42fddb03f';
update actor set activeflag = 1, personid = 'a42f2bdb-fc33-4252-973e-521389ea56cf', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3e65d7b3-0f99-482e-8042-dbdbb25f2c2e';
update actor set activeflag = 1, personid = '60e933e3-cedd-483a-904f-b88f0efcdf80', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '754390e1-4e6a-4ce4-8d27-a4c48ba3fd9a';
update actor set activeflag = 1, personid = '13777781-1142-4423-ab3d-ee3b0ad6e51f', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '8629d1bd-8fa1-469d-a084-b172b0d7bea3';
update actor set activeflag = 1, personid = '6787464c-bfa8-4410-9d6d-f7db6f5f268b', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '9570bcc0-7499-49da-8bde-289d8c06ccc7';
update actor set activeflag = 1, personid = '097e122a-5e0e-4fe9-b7d7-832e9d5c4601', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'dfea64ad-d7b2-4a56-bb76-2840c5fb14e9';
update actor set activeflag = 1, personid = 'c82fac5b-aa97-4f27-bb15-d26f6885dd71', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '12235cf0-7737-421d-9384-2338f6e5e884';
update actor set activeflag = 1, personid = 'e8ef1cc1-9e7d-473c-a003-f94052073250', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3377660b-0c38-446a-a682-ca4dd2208d83';
update actor set activeflag = 1, personid = '2bfd0b95-481c-4e6d-abb7-7ba410cbf315', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '4d80e40a-9d5b-42f5-8b40-4b70530f0644';
update actor set activeflag = 1, personid = '547e88c9-aec9-45b1-ab4d-cc03cc5c4cfc', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '5961f5be-5c2e-4158-813a-c84ed781e63e';
update actor set activeflag = 1, personid = '5c4ee150-4384-451c-84a1-6d3911ce94e7', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '6aa933d5-d78e-457f-bfbc-95586275533f';
update actor set activeflag = 1, personid = '7d075fb9-e8eb-42fb-a471-b5755bb71599', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '6cdbc07f-a382-4970-9330-598444322986';
update actor set activeflag = 1, personid = 'ea252fb4-4f01-43f5-bebe-ee5f4b2e3211', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '84ce1796-7a48-4c96-ad2a-59096707411c';
update actor set activeflag = 1, personid = '1288f31d-2361-4b88-9c95-91fa6653b738', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'becdbffb-a8c6-4b99-a8a6-1e1791d0259a';
update actor set activeflag = 1, personid = 'e6e6b8ea-1374-40ad-878e-7c1a73d5d47d', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'c492f1fc-55b3-43ab-9669-80f132d41166';
update actor set activeflag = 1, personid = 'a20a3602-4299-4952-9447-30ba4b4d15a5', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'd135daae-17f2-4f8e-9e05-8e020cb8e6fb';
update actor set activeflag = 1, personid = 'b3189816-6699-4e1c-b4ea-f73f8da405a0', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '29b650f5-73c8-42ef-9d80-83f786b998b4';
update actor set activeflag = 1, personid = '71d2b1ac-41c3-47cd-a971-4e1c198a3bb3', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '6b455d57-16e6-4ccc-818f-41b9ee425ce4';
update actor set activeflag = 1, personid = '65948cb5-9b0c-4ad5-a441-2b4ce5247156', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '7e87a927-a90f-4a85-a10d-2ff6eeb93047';
update actor set activeflag = 1, personid = '48748349-1a2b-48f7-931d-ec1bd6c0a0b4', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '8b47ac65-f9ab-4ad5-aae6-bf162075b0a4';
update actor set activeflag = 1, personid = 'd34d2484-52ec-4625-8564-706ab14b1aac', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'bd321655-bcfe-4b75-b1f1-1b27cd2320d4';
update actor set activeflag = 1, personid = 'c9f10911-ef62-4d7b-bfda-76ae0db6a7ee', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'c213f381-25e5-47e3-b7be-08fdf29727a1';
update actor set activeflag = 1, personid = '30a746c8-53fe-43df-abcf-fdf43f6cd4c2', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'ccd73023-098a-4876-b7ce-8dcc53de33de';
update actor set activeflag = 1, personid = 'f6dd5de8-4e2c-4a84-b2dd-51ab2220a788', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'e40f2781-71ab-4696-9833-83fac5f04b71';
update actor set activeflag = 1, personid = '34630fd4-33a1-4a37-840a-9bf1886419b9', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'e502ce37-3eb4-425d-9b32-939a903a77ae';
update actor set activeflag = 1, personid = '299a7255-3778-4904-8bf9-24eee666250a', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '2bc24c68-6d2a-4384-9215-cb28b4805fa4';
update actor set activeflag = 1, personid = '8e69db5e-7dc1-45f5-8d84-141c1676ea3f', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3f68ba22-077b-41c7-8db0-3e51032bfea1';
update actor set activeflag = 1, personid = 'e2a26e75-3990-4aa1-950f-bba9364b4cbb', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '61572b15-3105-436b-bb73-1982404aaf3a';
update actor set activeflag = 1, personid = '8519f958-b9c9-47f1-baac-9a432d4d51e3', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '6b95f647-061d-4449-9397-9a40042193b4';
update actor set activeflag = 1, personid = '00c0c887-a098-4d91-adef-2e46c379bb8f', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '7371c75e-c97e-4606-9da6-2de916d0bcb1';
update actor set activeflag = 1, personid = 'e14478a9-7ce5-4b28-a543-4ea66e979489', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '9ab27606-b9bc-4393-85ed-ecd3a9473a67';
update actor set activeflag = 1, personid = '1a222c05-d594-4d3c-9f0d-76043b9fd0bc', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '9c9f436a-0fea-4287-88e9-7b1f87959b73';
update actor set activeflag = 1, personid = '2f33f9ba-d474-4d77-9e62-e5699a334f36', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'f5d2e36a-1ca5-4e39-9835-a577a7634800';
update actor set activeflag = 1, personid = '63bcd8f9-69bb-49ef-89a7-594993dbdb70', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '0ad96805-66f0-49d5-8b25-d69378c40842';
update actor set activeflag = 1, personid = '0a4f77fc-29e1-4c95-9fb2-e8b1a03a25f5', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '56485b34-77d6-4922-a56e-683f3c97532a';
update actor set activeflag = 1, personid = 'ec695c95-1283-4663-a8e4-3ec8d2a709c6', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '89de4596-aee8-4354-b377-663fd33b2078';
update actor set activeflag = 1, personid = '8f1468ab-adb1-42e5-91d5-dfe607f6ec09', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'a739e0c4-2be9-4a77-b3e2-0b214b8c1764';
update actor set activeflag = 1, personid = 'a4ef2ac3-7f89-4437-b809-12bd765f4d38', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'ae7da88b-02ba-4a07-8862-c2e0a31f0ce4';
update actor set activeflag = 1, personid = 'c271ca87-852d-42e6-84ba-7ed1266abd5d', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'bc555142-9f19-46d8-992c-c3cacf0153e4';
update actor set activeflag = 1, personid = 'b8f2d086-ad6e-481e-9388-1234934e0298', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'd95441d4-9dfc-47c2-a644-fc0fc9ef251c';
update actor set activeflag = 1, personid = '15576dc9-846f-4083-82a7-06a99c85ab06', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '086bab3f-5352-4744-82dd-375a9c319add';
update actor set activeflag = 1, personid = 'f1696a22-32f8-4cec-a1d2-3a67103ed7e8', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '15aca585-023d-484a-bb6a-474775317cba';
update actor set activeflag = 1, personid = '6d653f2d-137f-445b-bf9c-bbc87fb2197a', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'b877235b-d701-4fbe-a488-a66a70470eee';
update actor set activeflag = 1, personid = 'd75036ca-7e00-4df2-bf31-875a27bf2bee', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3aef9dd6-a7bf-4d76-ba43-3acf447c6c5d';
update actor set activeflag = 1, personid = 'af3cb0cc-3199-4467-8e07-6f4bc9e11e5a', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3f6c84e7-203d-4abc-8e40-4315fdb35b55';
update actor set activeflag = 1, personid = 'a94921f1-d72d-47ea-9fea-9ef92097fe0b', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '4d7d2378-46d9-4110-b880-bea5342bd3d7';
update actor set activeflag = 1, personid = 'd5478a10-bad8-463d-8d4f-cd12458b0f8c', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '6389b90c-7fea-4933-95fc-1e0d14bb7a61';
update actor set activeflag = 1, personid = '18345af6-554f-4969-9843-973051f7686b', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'ec32f85d-bd91-407d-b5ef-7f35426a1df9';
update actor set activeflag = 1, personid = '594526ee-cd75-4970-aa8e-e6e0e9125de9', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'f3704d68-6181-407e-8d44-138835243b76';
update actor set activeflag = 1, personid = 'aec7d410-019e-4108-83ae-f129ade964ef', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '024e0b5e-968d-4223-9057-9d71fad8c980';
update actor set activeflag = 1, personid = '41420750-d346-4dfe-9138-3c5e5a6c5f83', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '400f3d04-8366-4375-b82c-9adf3e29d1da';
update actor set activeflag = 1, personid = 'a6026286-388b-4147-b3fe-376b79ada3cc', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '42b7d1ad-2748-47a7-8841-5a79a814ab15';
update actor set activeflag = 1, personid = 'b333199e-b695-43f3-b070-6d54b747db60', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '524224a3-cc05-496d-883f-f074931814f4';
update actor set activeflag = 1, personid = 'a92bad16-046a-4dc8-98a7-52ef727ffb01', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'b5745e8b-acc9-43c1-8106-28f8fcb61172';
update actor set activeflag = 1, personid = 'bf77767b-a2e6-4bf7-8ea5-fdd1df73455a', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'c25c3624-b01f-4fc2-8332-9d46d704dda8';
update actor set activeflag = 1, personid = 'ffcf1e55-ef1e-4a20-9f3a-034c3aa0f833', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'e696f24f-25a2-4046-9318-4e554bfe18a1';
update actor set activeflag = 1, personid = 'a6758b16-080b-42e6-b00f-fb469e0185ef', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3c9b8ffd-2ea6-4214-af56-71bbf59cd9d1';
update actor set activeflag = 1, personid = '77ebdd47-9c65-46ac-8aef-24d69e55dc69', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '3d6b1ebf-568f-49ae-bfb2-c2196b5085af';
update actor set activeflag = 1, personid = 'cf1e095d-4bb4-4743-8c6f-725ace012c10', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '8c0822bb-eea8-413d-8223-4bc9a6ef29f9';
update actor set activeflag = 1, personid = '26c1030a-f05b-4c17-9bb5-0b372a7d7df2', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'a212d17c-e654-4070-a514-713d7c178ec2';
update actor set activeflag = 1, personid = '53a7e293-21bb-4665-a31f-0ac5ac7165d9', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '16b15758-f74a-40df-8ba5-0cde3623ea0b';
update actor set activeflag = 1, personid = '39d714f0-e596-477e-afb5-bf78a78350a0', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '276744a8-8902-42a1-8b61-43b3e90c58fd';
update actor set activeflag = 1, personid = '3253ae87-3ade-480b-aeeb-fad4d25ab719', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '51e098c2-d41d-42a7-9faf-7e4dce868581';
update actor set activeflag = 1, personid = '93c8d799-812f-4559-b982-075b6a7e0b05', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '5e99b3fd-ae22-473e-90ac-4407cc66aea3';
update actor set activeflag = 1, personid = '038a6b3c-dc59-4a3a-a036-34cc84812e7a', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = '77249add-ec62-4790-890d-c1de50f5a353';
update actor set activeflag = 1, personid = '483af318-331b-4de8-9cfc-8ab3cc5cfe03', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'a4fde773-c266-46d0-ac37-3d3bf1360e1c';
update actor set activeflag = 1, personid = 'e0833ee2-a3dd-43f8-964a-1ef0afd668bc', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'd108e99e-546b-48f3-b570-7b616984762b';
update actor set activeflag = 1, personid = 'e8c0ec2a-c31b-433b-b16b-c5f2ec702693', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'dc0dc22f-c109-463c-bc6e-09909f41535d';
update actor set activeflag = 1, personid = '0c6a34b3-df57-4b3c-ac0d-2743ceffd55c', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'e645dea7-98ce-4a65-ac85-dfd3afdacf43';
update actor set activeflag = 1, personid = 'f73eead3-a9fe-4249-9383-006428412b1c', updatedby = 'CJAMS-66782' , updatedon = now()
where actorid = 'ec21c78a-a4f8-4ef1-9c6d-a59bcf5fc4c7';

update intakeservicerequestactor set activeflag = 1, personid = '00c0c887-a098-4d91-adef-2e46c379bb8f', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'e0ecad0a-3122-43c3-8a79-c11845ba6fb2';
update intakeservicerequestactor set activeflag = 1, personid = '299a7255-3778-4904-8bf9-24eee666250a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'efcd6e42-a91b-4dbd-b7ee-6e499130d6e3';
update intakeservicerequestactor set activeflag = 1, personid = '8e69db5e-7dc1-45f5-8d84-141c1676ea3f', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '6835a7ce-ae14-47b7-81db-a45368dd020d';
update intakeservicerequestactor set activeflag = 1, personid = 'e2a26e75-3990-4aa1-950f-bba9364b4cbb', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'cad02114-fa7d-47b8-bbc7-2fe12084281e';
update intakeservicerequestactor set activeflag = 1, personid = '00c0c887-a098-4d91-adef-2e46c379bb8f', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'b976631e-7f2e-44ea-99ac-2dda47494c5f';
update intakeservicerequestactor set activeflag = 1, personid = '8519f958-b9c9-47f1-baac-9a432d4d51e3', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '9aaf6920-22be-420f-b2da-c29d208e8bf4';
update intakeservicerequestactor set activeflag = 1, personid = 'e14478a9-7ce5-4b28-a543-4ea66e979489', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '20ea039c-71af-43dd-bcb5-317ea46466c3';
update intakeservicerequestactor set activeflag = 1, personid = 'e14478a9-7ce5-4b28-a543-4ea66e979489', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'ec77c1a3-2be2-4934-8a1f-158f535588ef';
update intakeservicerequestactor set activeflag = 1, personid = '1a222c05-d594-4d3c-9f0d-76043b9fd0bc', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '4b73652c-a927-47fe-80eb-e482af1daf17';
update intakeservicerequestactor set activeflag = 1, personid = '2f33f9ba-d474-4d77-9e62-e5699a334f36', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '07072d8a-84dd-4f46-8fed-acc0ebfcb7f9';
update intakeservicerequestactor set activeflag = 1, personid = '2f33f9ba-d474-4d77-9e62-e5699a334f36', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'ad79f0c7-e4d5-4783-8a64-15f08a7ac5b0';
update intakeservicerequestactor set activeflag = 1, personid = '63bcd8f9-69bb-49ef-89a7-594993dbdb70', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '3520b0dc-3a25-4937-be20-abc7d9b184e1';
update intakeservicerequestactor set activeflag = 1, personid = 'a4ef2ac3-7f89-4437-b809-12bd765f4d38', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '691fd32b-f834-4042-9e0f-2f0eb6d98112';
update intakeservicerequestactor set activeflag = 1, personid = 'a4ef2ac3-7f89-4437-b809-12bd765f4d38', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'da9fff08-1588-4b40-9b3b-10749fbdcd77';
update intakeservicerequestactor set activeflag = 1, personid = 'ec695c95-1283-4663-a8e4-3ec8d2a709c6', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '4c31109b-32a9-4e9f-bca4-493f1f297fe0';
update intakeservicerequestactor set activeflag = 1, personid = 'c271ca87-852d-42e6-84ba-7ed1266abd5d', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '9fc6ec44-aa6f-48a1-b240-b53605660219';
update intakeservicerequestactor set activeflag = 1, personid = 'c271ca87-852d-42e6-84ba-7ed1266abd5d', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'c99f47f3-ae91-4dc2-ae7a-e574422a91a4';
update intakeservicerequestactor set activeflag = 1, personid = 'c271ca87-852d-42e6-84ba-7ed1266abd5d', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'ccbdf67d-8e84-4cc0-a20b-fec454ab9aa2';
update intakeservicerequestactor set activeflag = 1, personid = '0a4f77fc-29e1-4c95-9fb2-e8b1a03a25f5', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '3649e5ae-c163-447f-9ab6-bc619accf022';
update intakeservicerequestactor set activeflag = 1, personid = '8f1468ab-adb1-42e5-91d5-dfe607f6ec09', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '7eed0816-9594-4d3e-bd49-1dafa9059c2b';
update intakeservicerequestactor set activeflag = 1, personid = 'b8f2d086-ad6e-481e-9388-1234934e0298', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '07f56e95-c0f6-4c5a-a30c-bddfa9029195';
update intakeservicerequestactor set activeflag = 1, personid = 'b8f2d086-ad6e-481e-9388-1234934e0298', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'b9fd0bd6-ae11-45ae-9fec-db9aa0536968';
update intakeservicerequestactor set activeflag = 1, personid = '15576dc9-846f-4083-82a7-06a99c85ab06', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '00229aed-55fb-4586-8843-22242910cd6f';
update intakeservicerequestactor set activeflag = 1, personid = '15576dc9-846f-4083-82a7-06a99c85ab06', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '454f3b4a-21b2-438f-ab11-5deb61d9d3ef';
update intakeservicerequestactor set activeflag = 1, personid = 'f1696a22-32f8-4cec-a1d2-3a67103ed7e8', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '2ecbc6c9-4382-42d9-8765-8b016b2154b8';
update intakeservicerequestactor set activeflag = 1, personid = 'f1696a22-32f8-4cec-a1d2-3a67103ed7e8', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '7f3432eb-4fc8-40ce-91d9-3584fe1ea631';
update intakeservicerequestactor set activeflag = 1, personid = '6d653f2d-137f-445b-bf9c-bbc87fb2197a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'eb6bc1da-8c20-4793-8ad2-45d8f81dbe68';
update intakeservicerequestactor set activeflag = 1, personid = 'd75036ca-7e00-4df2-bf31-875a27bf2bee', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '077fa6b0-61c1-43fd-ac05-416d0ec16bf7';
update intakeservicerequestactor set activeflag = 1, personid = 'd5478a10-bad8-463d-8d4f-cd12458b0f8c', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'ebfa788d-97eb-45c5-8cae-67b9a939717e';
update intakeservicerequestactor set activeflag = 1, personid = '18345af6-554f-4969-9843-973051f7686b', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '1b5607d0-43e6-43e9-9ff3-192aab56b4b4';
update intakeservicerequestactor set activeflag = 1, personid = '18345af6-554f-4969-9843-973051f7686b', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'ffa7b03a-f82f-4901-828f-dfe32721e0ee';
update intakeservicerequestactor set activeflag = 1, personid = '594526ee-cd75-4970-aa8e-e6e0e9125de9', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'a8e8de1f-3608-435f-a4c4-80b202299160';
update intakeservicerequestactor set activeflag = 1, personid = 'af3cb0cc-3199-4467-8e07-6f4bc9e11e5a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '09bfc89a-01aa-48fc-868d-fd687e65e566';
update intakeservicerequestactor set activeflag = 1, personid = 'af3cb0cc-3199-4467-8e07-6f4bc9e11e5a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '504aba5c-4d3f-4ea3-bbca-bd251b00c4ab';
update intakeservicerequestactor set activeflag = 1, personid = 'af3cb0cc-3199-4467-8e07-6f4bc9e11e5a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'a55c37db-72d7-414e-8191-3435ca9c0351';
update intakeservicerequestactor set activeflag = 1, personid = 'a94921f1-d72d-47ea-9fea-9ef92097fe0b', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'cf87ac97-adf4-47dd-8cac-ded0b3e0475b';
update intakeservicerequestactor set activeflag = 1, personid = 'aec7d410-019e-4108-83ae-f129ade964ef', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '304a7f74-c5af-47b3-a292-a3cce0c5d89a';
update intakeservicerequestactor set activeflag = 1, personid = 'aec7d410-019e-4108-83ae-f129ade964ef', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '7d0e11de-2927-41cd-acb8-d753e4f30a76';
update intakeservicerequestactor set activeflag = 1, personid = '41420750-d346-4dfe-9138-3c5e5a6c5f83', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '46cf2484-08e9-4e22-9d9b-f256c2e07da3';
update intakeservicerequestactor set activeflag = 1, personid = '41420750-d346-4dfe-9138-3c5e5a6c5f83', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '806642a9-13c2-4c99-b655-1bd1283a5add';
update intakeservicerequestactor set activeflag = 1, personid = 'b333199e-b695-43f3-b070-6d54b747db60', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '83262948-ee9b-493d-ba06-a7d288f4951f';
update intakeservicerequestactor set activeflag = 1, personid = 'b333199e-b695-43f3-b070-6d54b747db60', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'a09c64e1-8a95-439a-aced-dd4162b5c772';
update intakeservicerequestactor set activeflag = 1, personid = 'a6026286-388b-4147-b3fe-376b79ada3cc', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'dee4b5f0-3dee-4a76-9ec0-7f5e2eb95899';
update intakeservicerequestactor set activeflag = 1, personid = 'ffcf1e55-ef1e-4a20-9f3a-034c3aa0f833', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '63afdcd5-eaed-4cd0-8089-9a1c3b29918f';
update intakeservicerequestactor set activeflag = 1, personid = 'ffcf1e55-ef1e-4a20-9f3a-034c3aa0f833', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'f4bbfafe-4b64-41f6-b7d3-51d9e5ce4638';
update intakeservicerequestactor set activeflag = 1, personid = 'a92bad16-046a-4dc8-98a7-52ef727ffb01', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '4ba9b787-43b6-4c64-9c30-113639056a53';
update intakeservicerequestactor set activeflag = 1, personid = 'a92bad16-046a-4dc8-98a7-52ef727ffb01', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'feac3dd6-6978-4d53-89eb-9083893e7bbb';
update intakeservicerequestactor set activeflag = 1, personid = 'bf77767b-a2e6-4bf7-8ea5-fdd1df73455a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '32517210-4615-4cd7-89c5-0f611cc8fc1b';
update intakeservicerequestactor set activeflag = 1, personid = 'bf77767b-a2e6-4bf7-8ea5-fdd1df73455a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '364158b5-b8e8-4f86-80a0-84a20c583c80';
update intakeservicerequestactor set activeflag = 1, personid = 'bf77767b-a2e6-4bf7-8ea5-fdd1df73455a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'a0f1f815-9f50-4824-9198-daf5af22e1fe';
update intakeservicerequestactor set activeflag = 1, personid = 'a6758b16-080b-42e6-b00f-fb469e0185ef', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'e4ede758-be46-45d9-8a55-2d18252d1648';
update intakeservicerequestactor set activeflag = 1, personid = 'a6758b16-080b-42e6-b00f-fb469e0185ef', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'e6812735-6ef8-4001-bcf2-4e42c555228b';
update intakeservicerequestactor set activeflag = 1, personid = '26c1030a-f05b-4c17-9bb5-0b372a7d7df2', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '59e77068-c23a-49db-b8fc-922b008cb89e';
update intakeservicerequestactor set activeflag = 1, personid = '26c1030a-f05b-4c17-9bb5-0b372a7d7df2', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'cf8aa4c8-8637-423d-946f-00e81feb7117';
update intakeservicerequestactor set activeflag = 1, personid = 'cf1e095d-4bb4-4743-8c6f-725ace012c10', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '0681c234-93e7-4f86-8bb8-e9d7626fad5a';
update intakeservicerequestactor set activeflag = 1, personid = '77ebdd47-9c65-46ac-8aef-24d69e55dc69', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '3a49bd9d-6b1b-4b2b-b963-f220e245eadc';
update intakeservicerequestactor set activeflag = 1, personid = '77ebdd47-9c65-46ac-8aef-24d69e55dc69', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'f7f71daf-8564-4dc8-a35f-20d427ce5b64';
update intakeservicerequestactor set activeflag = 1, personid = '77ebdd47-9c65-46ac-8aef-24d69e55dc69', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'fc8ac27e-e848-4023-b98e-f635e0a0f51d';
update intakeservicerequestactor set activeflag = 1, personid = '39d714f0-e596-477e-afb5-bf78a78350a0', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '62753c1d-3fcf-429b-9e66-fe0387e90cc1';
update intakeservicerequestactor set activeflag = 1, personid = '93c8d799-812f-4559-b982-075b6a7e0b05', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '84a03642-39b5-4cbe-b808-12bca3939f7f';
update intakeservicerequestactor set activeflag = 1, personid = 'e8c0ec2a-c31b-433b-b16b-c5f2ec702693', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '9de2b52f-f3d5-4c5e-a59d-67b2617b4576';
update intakeservicerequestactor set activeflag = 1, personid = 'f73eead3-a9fe-4249-9383-006428412b1c', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '99599d09-cb0d-4ed8-a740-0dfc938b4361';
update intakeservicerequestactor set activeflag = 1, personid = '0c6a34b3-df57-4b3c-ac0d-2743ceffd55c', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '0ec24f00-4929-436f-8f67-05be439df31c';
update intakeservicerequestactor set activeflag = 1, personid = '0c6a34b3-df57-4b3c-ac0d-2743ceffd55c', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '8ce9631d-3360-4286-abf7-52bf33380512';
update intakeservicerequestactor set activeflag = 1, personid = 'e8c0ec2a-c31b-433b-b16b-c5f2ec702693', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'b16c8d45-8d76-46f6-b0c6-09b647f93e1d';
update intakeservicerequestactor set activeflag = 1, personid = '483af318-331b-4de8-9cfc-8ab3cc5cfe03', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '73ffb693-95a9-4b49-8e6b-36274b294e92';
update intakeservicerequestactor set activeflag = 1, personid = 'e0833ee2-a3dd-43f8-964a-1ef0afd668bc', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '9aca635d-97f0-4326-8b95-80436ce67b25';
update intakeservicerequestactor set activeflag = 1, personid = '53a7e293-21bb-4665-a31f-0ac5ac7165d9', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '0a96e690-def5-44cc-a2c0-772363b1f2d2';
update intakeservicerequestactor set activeflag = 1, personid = 'e0833ee2-a3dd-43f8-964a-1ef0afd668bc', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '093aa26a-bd02-41a7-ac17-4ad2d9a74555';
update intakeservicerequestactor set activeflag = 1, personid = '038a6b3c-dc59-4a3a-a036-34cc84812e7a', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '6e472d42-0fd8-47c4-80d1-e74073e9578b';
update intakeservicerequestactor set activeflag = 1, personid = '3253ae87-3ade-480b-aeeb-fad4d25ab719', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = '9a70fcd9-5ef6-4555-b113-1722ee092290';
update intakeservicerequestactor set activeflag = 1, personid = '3253ae87-3ade-480b-aeeb-fad4d25ab719', updatedby = 'CJAMS-66782' , updatedon = now()
where intakeservicerequestactorid = 'fd489ab7-01f8-455f-99a6-6a8ef09a5d4b';