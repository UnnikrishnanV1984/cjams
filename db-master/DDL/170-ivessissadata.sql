ALTER TABLE cjams.ivessissadata ADD doesagencyhasmedicaldocstostateincapabilityofchild int4 NULL;
ALTER TABLE cjams.ivessissadata ADD hasagencyapplytobecomerepresentativepayee int4 NULL;
ALTER TABLE cjams.ivessissadata ADD typeofbenefit varchar(3) NULL;
ALTER TABLE cjams.ivessissadata ADD amountofbenefit int4 NULL;
ALTER TABLE cjams.ivessissadata ADD dateofmedicaldetermination timestamp NULL;
ALTER TABLE cjams.ivessissadata ADD dateofapplicationtobecomerepresentativepayee timestamp NULL;
ALTER TABLE cjams.ivessissadata ADD dateofrequesttosuspendthessipaymentandclaimive timestamp NULL;