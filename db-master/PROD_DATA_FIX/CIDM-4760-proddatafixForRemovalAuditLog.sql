/*
   Issue Description: CIDM-4670
   Category/ Module  : Prod data fix to update Investigation Findings
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




/*
[
    {
        "displayname": "Removal Type",
        "key": "removaltypekeyref"
    },
    {
        "displayname": "Removal Date",
        "key": "removaldate"
    },
    {
        "displayname": "Removal Time",
        "key": "removaltime"
    },
    {
        "displayname": "Family Structure",
        "key": "familystructuretypekeyref"
    },
    {
        "displayname": "Where is the child going to be placed?",
        "key": "agencytypekeyref"
    },
    {
        "displayname": "Primary Caregiver",
        "key": "primarycaregiveractoridref"
    },
    {
        "displayname": "Address of Primary Caregiver",
        "key": "primarycaregiveradd"
    },
    {
        "displayname": "Address of Secondary Caregiver",
        "key": "seccaregiveradd"
    },
    {
        "displayname": "Child Home Address Same as Primary Caregiver address?",
        "key": "ischildaddressasprimaryaddress"
    },
    {
        "displayname": "Secondary Caregiver",
        "key": "seccaregiveractoridref"
    },
    {
        "displayname": "Primary Caregiver Address Verified",
        "key": "isverifiedcaregiver1add"
    },
    {
        "displayname": "Secondary Caregiver Adddress Verified",
        "key": "isverifiedcaregiver2add"
    },
    {
        "displayname": "Physical address from where child removed",
        "key": "childphysicalremovaladdres"
    },
    {
        "displayname": "Physical Address Verified",
        "key": "ischildphysicalremovaladdressverified"
    },
    {
        "displayname": "Factors at Removal",
        "key": "removalreasonref"
    },
    {
        "displayname": "Narrative",
        "key": "comments"
    },
    {
        "displayname": "Reasonable Efforts made to prevent child Removal",
        "key": "reasonableeffortsref"
    },
    {
        "displayname": "Removal End Reason",
        "key": "removalexitreasonref"
    },
    {
        "displayname": "Removal End Date",
        "key": "exitdate"
    },
    {
        "displayname": "Removal End Time",
        "key": "exittime"
    },
    {
        "displayname": "Child's Home Address at the time of removal",
        "key": "removaladd1"
    },
    {
        "displayname": "Physical address from where child was removed",
        "key": "childphysicalremovaladdress"
    },
	{
        "displayname": "Shelter Authorization completed?",
        "key": "isshelterauthcompleted"
    },
	{
        "displayname": "Completed by",
        "key": "isuploadedmanually"
    },
    {
        "displayname": "Child home Address Verified",
        "key": "isverifiedreporteradd"
    },
    {
        "displayname": "Justification",
        "key": "justification"
    }
]



*/


update audittraillukup set fieldjson = '[
  {
    "displayname": "Removal Type",
    "key": "removaltypekeyref"
  },
  {
    "displayname": "Removal Date",
    "key": "removaldate"
  },
  {
    "displayname": "Removal Time",
    "key": "removaltime"
  },
  {
    "displayname": "Family Structure",
    "key": "familystructuretypekeyref"
  },
  {
    "displayname": "Where is the child going to be placed?",
    "key": "agencytypekeyref"
  },
  {
    "displayname": "Primary Caregiver",
    "key": "primarycaregiveractoridref"
  },
  {
    "displayname": "Address of Primary Caregiver",
    "key": "primarycaregiveradd"
  },
  {
    "displayname": "Address of Secondary Caregiver",
    "key": "seccaregiveradd"
  },
  {
    "displayname": "Child Home Address Same as Primary Caregiver address?",
    "key": "ischildaddressasprimaryaddress"
  },
  {
    "displayname": "Secondary Caregiver",
    "key": "seccaregiveractoridref"
  },
  {
    "displayname": "Primary Caregiver Address Verified",
    "key": "isverifiedcaregiver1add"
  },
  {
    "displayname": "Secondary Caregiver Adddress Verified",
    "key": "isverifiedcaregiver2add"
  },
  {
    "displayname": "Physical address from where child removed",
    "key": "childphysicalremovaladdres"
  },
  {
    "displayname": "Physical Address Verified",
    "key": "ischildphysicalremovaladdressverified"
  },
  {
    "displayname": "Factors at Removal",
    "key": "removalreasonref"
  },
  {
    "displayname": "Narrative",
    "key": "comments"
  },
  {
    "displayname": "Reasonable Efforts made to prevent child Removal",
    "key": "reasonableeffortsref"
  },
  {
    "displayname": "Removal End Reason",
    "key": "removalexitreasonref"
  },
  {
    "displayname": "Removal End Date",
    "key": "exitdate"
  },
  {
    "displayname": "Removal End Time",
    "key": "exittime"
  },
  {
    "displayname": "Childs Home Address at the time of removal",
    "key": "removaladd1"
  },
  {
    "displayname": "Physical address from where child was removed",
    "key": "childphysicalremovaladdress"
  },
  {
    "displayname": "Shelter Authorization completed?",
    "key": "isshelterauthcompleted"
  },
  {
    "displayname": "Completed by",
    "key": "isuploadedmanually"
  },
  {
    "displayname": "Child home Address Verified",
    "key": "isverifiedreporteradd"
  },
  {
    "displayname": "Justification",
    "key": "justification"
  },
  {
    "displayname": "Circumstances at Removal",
    "key": "removalcircumstances",
     "datatype": "json" 
  },
  {
    "displayname": "Abandonment",
    "key": "abandonment"
  },
  {
    "displayname": "Caretakers Alcohol Use",
    "key": "caretakeralcoholuse"
  },
  {
    "displayname": "Caretakers Drug Use",
    "key": "caretakerdruguse"
  },
  {
    "displayname": "Caretakers Significant Impairment-Cognitive",
    "key": "caretakersignificantimpairment"
  },
  {
    "displayname": "Caretakers Significant Impairment-Physical/Emotional",
    "key": "caretakerignificantimpphysical"
  },
  {
    "displayname": "Child Alcohol Use",
    "key": "childalcoholuse"
  },
  {
    "displayname": "Child Behavior Problem",
    "key": "childbehaviorproblem"
  },
  {
    "displayname": "Child Drug Use",
    "key": "childdruguse"
  },
  {
    "displayname": "Child Requested Placement",
    "key": "childrequestedplacement"
  },
  {
    "displayname": "Death of Caretaker",
    "key": "deathofcaretaker"
  },
  {
    "displayname": "Diagnosed Condition",
    "key": "diagnosedcondition"
  },
  {
    "displayname": "Domestic Violence",
    "key": "domesticviolence"
  },
  {
    "displayname": "Failure to Return",
    "key": "failuretoreturn"
  },
  {
    "displayname": "Family Conflict Related to Child",
    "key": "familyconflict"
  },
  {
    "displayname": "Homelessness",
    "key": "homelessness"
  },
   {
    "displayname": "Inadequate Access to Mental Health Services",
    "key": "inadequateaccesstomhs"
  },
  {
    "displayname": "Inadequate Access to Medical Services",
    "key": "inadequateaccesstomedicalservices"
  },
  {
    "displayname": "Inadequate Housing",
    "key": "inadequatehousing"
  },
  {
    "displayname": "Incarceration of Caretaker",
    "key": "incarcerationofcaretaker"
  },
  {
    "displayname": "Medical Neglect",
    "key": "medicalneglect"
  },
  {
    "displayname": "Neglect",
    "key": "neglect"
  },
  {
    "displayname": "Parental Immigration Detainment or Deportation",
    "key": "parentalimmigration"
  },
  {
    "displayname": "Physical Abuse",
    "key": "physicalabuse"
  },
  {
    "displayname": "Prenatal Alcohol Exposure",
    "key": "prenatalalcoholexposure"
  },
  {
    "displayname": "Prenatal Drug Exposure",
    "key": "prenataldrugexposure"
  },
  {
    "displayname": "Psychological or Emotional Abuse",
    "key": "psychologicalemotionalabuse"
  },
  {
    "displayname": "Public Agency Title IV-E Agreement",
    "key": "publicagencytitleive"
  },
  {
    "displayname": "Runaway",
    "key": "prenatalalcoholexposure"
  },
  {
    "displayname": "Sexual Abuse",
    "key": "sexualabuse"
  },
  {
    "displayname": "Sex Trafficking",
    "key": "sextrafficking"
  },
  {
    "displayname": "Tribal Title IV-E Agreement",
    "key": "tribaltitleive"
  },
  {
    "displayname": "Voluntary Relinquishment for Adoption",
    "key": "voluntaryrelinquishment"
  },
  {
    "displayname": "Whereabouts Unknown",
    "key": "whereaboutsunknown"
  }
]', updatedby = 'CDM-4760', updatedon = now()
where audittraillukupid = '5965d53a-a3e5-4e4e-ba6d-a6550e0db863';