update
    permanencyplan
set
    updatedby = 'CDM-9606',
    updatedon = now(),
    permplanquestdata = '{
  "lifebookExpln": "No, this worker has not received the material to give to Anabelle and Rosemarie",
  "isProviderAgree": "1",
  "permToPermExpln": "n/a",
  "courtOrdersExpln": "This worker visits with Anabelle and Rosemarie at least monthly in person. This worker maintains monthly contact with Ms. Phillips, Mr. Coleman, and all other providers to ensure their needs are being met. This worker provides referrals for services when needed. This worker changed the rep-payee toe Mr. Coleman for Rosemarie and Anabelle`s benefits so that the money could be used for their care.",
  "safeAndCareExpln": "This worker visits with Anabelle and Rosemarie at least monthly in person. This worker maintains monthly contact with Ms. Phillips, Mr. Coleman, and all other providers to ensure their needs are being met. This worker provides referrals for services when needed. This worker changed the rep-payee toe Mr. Coleman for Rosemarie and Anabelle`s benefits so that the money could be used for their care.",
  "isInClosedProximity": "0",
  "isProviderAgreeExpln": "Mr. Coleman believe that Anabelle and Rosemarie should be home with their mother as long as she can maintain her sobriety. This worker discussed his ability to keep them longer and custody and guardianship possibilities. Mr. Coleman stated Anabelle and Rosemarie are able to stay with him as long as they need and that he would be in agreement with their case closing custody and guardianship to him if Ms. Phillips is not able to maintain her sobriety and care for them.",
  "assessmentPeriodExpln": "This worker has maintained contact with Ms. Phillips and discussed the recommendations of her substance abuse providers. Ms. Phillips has not signed a release for this worker to contact her prescribing psychiatrist. The department has provided bus passes and cabs for Ms. Phillips to get to and from her substance abuse treatment facilities.",
  "serviceAgreementExpln": "Ms. Phillips has refused to sign a release for this worker to contact her prescribing psychiatrist. Ms. Phillips completed a 30 day inpatient stay for substance abuse at Massie treatment center but has refused to follow through on recommendations to change her Adderall and Xanax to less addictive medications. Ms. Phillips also does not maintain contact with this worker. She does not return phone calls. When transportation to court ordered services are needed Ms. Phillips will reach out to request cabs.",
  "meetingSafetyNeedsExpln": "Mr. Coleman schedules all medical and mental health appointments and ensures all their medical and mental health needs are met. He provides them with a safe living arrangement and provides them appropriate nutrition and medication when needed. Mr. Coleman ensures the receive the appropriate education, go to school with no unexcused absences, and maintain passing grades.",
  "sixMonthsPlacementExpln": "No placement changes since removal. Not placement changes are anticipated within the next 6 months.",
  "isInClosedProximityExpln": "Anabelle and Rosemarie requested to live with Mr. Coleman. Mr. Coleman is Ms. Phillips ex-husband and has been a father figure for the girls by raising them. He lives in Laurel, MD.",
  "serviceAgreementForOtherExpln": "This worker has attempted to have Ms. Phillips, Rosemarie, and Anabelle to visit via video during COVID-19. Ms. Phillips stated she did not know how to and the girls reported they did not want to do video visits. They report texting and sometimes speaking on the phone to maintain contact"
}'
where
    permanencyplanid = '57bcdb28-beae-45cc-8ede-1e218e778e70'
    and activeflag = 1;