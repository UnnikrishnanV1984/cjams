INSERT INTO cjams.audittraillukup
(audittraillukupid, typekey, fieldjson, activeflag, insertedby, insertedon, updatedby, updatedon)
VALUES('aa71bcd3-1f87-47ff-8e4a-9d38b3680d3e'::uuid, 'safecassessment', '[
  {
    "displayname": "Unable to Locate Child",
    "key": "unabletolocatechild"
  },
  {
    "displayname": "Child Deceased",
    "key": "childdeceased"
  },
  {
    "displayname": "Child Dod",
    "key": "columnsChildDod"
  },
  {
    "displayname": "Responsible Agency Person",
    "key": "dateoflastsafetyplan"
  },
  {
    "displayname": "Date of Assessment Initiated",
    "key": "dateassessmentinitiated"
  },
  {
    "displayname": "Relationship",
    "key": "relationship"
  },
  {
    "displayname": "Agency Cityname",
    "key": "agencycityname"
  },
  {
    "displayname": "Actions Taken",
    "key": "actionsTaken"
  },
  {
    "displayname": "Deceased Child Name",
    "key": "deceasedChildName"
  },
  {
    "displayname": "child list",
    "key": "childdatagrid",
    "data_type": "json_array"
  },
  {
    "displayname": "Legal Guardian Name",
    "key": "caseheadsname"
  },
  {
    "displayname": "CPS/Case ID",
    "key": "cpscaseid"
  },
  {
    "displayname": "Head Of Household",
    "key": "headofhouseholdname"
  },
  {
    "displayname": "Safeccaregivers",
    "key": "safeccaregivers"
  },
  {
    "displayname": "CIS ID",
    "key": "cisid"
  },
  {
    "displayname": "At the initial face to face contact with the alleged victim and contact or attempted contact with the caregiver",
    "key": "cpsftf"
  },
  {
    "displayname": "At the completion/closure of the investigation if the case has been opened longer than 3 months",
    "key": "cpscoi"
  },
  {
    "displayname": "When the Safety Plan is re-evaluated. Date of last Safety Plan:",
    "key": "cpssafetyplan"
  },
  {
    "displayname": "Safety Plan is re-evaluated Date",
    "key": "cpslastsafetyplandt"
  },
  {
    "displayname": "When the case assessor discovers there is a significant change in the composition of the individuals in the home",
    "key": "cpscad"
  },
  {
    "displayname": "When circumstances suggest that the childs safety may be jeopardized",
    "key": "cpscsj"
  },
  {
    "displayname": "Within 7 working days of case acceptance in Services",
    "key": "ihfsevendays"
  },
  {
    "displayname": "Before completing a case reconsideration",
    "key": "ihfbcar"
  },
  {
    "displayname": "At time of trial home visit with caregiver",
    "key": "oohthv"
  },
  {
    "displayname": "Within ten(10) working days of the assignment or transfer of the case to the assessor",
    "key": "oohtta"
  },
  {
    "displayname": "Before completing a case reconsideration",
    "key": "oohbccr"
  },
  {
    "displayname": "Within 7 working days prior to beginning unsupervised visitation",
    "key": "oohbunsv"
  },
  {
    "displayname": "Within 7 working days prior to returning a child home",
    "key": "oohrch"
  },
  {
    "displayname": "When the case assessor discovers there is a significant change in the composition of the individuals in the home",
    "key": "oohscinc"
  },
  {
    "displayname": "When circumstances suggest that the childs safety may be jeopardized",
    "key": "oohcsafety"
  },
  {
    "displayname": "Age 0-5 Years Old",
    "key": "age05"
  },
  {
    "displayname": "Diminished Physical Capacity",
    "key": "dpc"
  },
  {
    "displayname": "Significant Diagnosed Medical Or Mental Disorder",
    "key": "significantdiagnosed"
  },
  {
    "displayname": "Childs Extreme Anxiety Or Fear About The Current Placement Or Home Environment",
    "key": "childsextreme"
  },
  {
    "displayname": "Diminished Mental Capacity",
    "key": "dmc"
  },
  {
    "displayname": "School Age, But Not Attending School",
    "key": "schoolage"
  },
  {
    "displayname": "Associate Details",
    "key": "associatedetails",
    "data_type": "json_array"
  },
  {
    "displayname": "caseworker comments",
    "key": "caseworkercomments"
  },
  {
    "displayname": "Supervisor Comments",
    "key": "supervisorcomments"
  },
  {
    "displayname": "Safety Assessment Approvaldate",
    "key": "safetyassessmentapprovaldate"
  },
  {
    "displayname": "Safety Assessment Completiondate",
    "key": "safetyassessmentcompletiondate"
  },
  {
    "displayname": "Supervisor name",
    "key": "supervisorname"
  },
  {
    "displayname": "1.Caregiver Fails To Protect The Child From Serious Harm Or Threatened Harm By Others. (This May Include Failure To Protect The Child From Physical Abuse, Sexual Abuse, Or Neglect.)",
    "key": "caregiverfailstoprotect"
  },
  {
    "displayname": "1.Comments",
    "key": "caregiverfailstoprotectnote"
  },
  {
    "displayname": "2. Caregiver Made A Plausible Threat To Cause Serious Physical Harm To The Child Or HAS Caused Serious Physical Harm To The Child As Indicated By: Verbal Threat Of Serious Injury OR Serious Injury To The Child OR Threat Of Retaliation Against The Child OR Caregiver Fears He/She Will Harm The Child.",
    "key": "caregivermadeaplausible"
  },
  {
    "displayname": "2.Comments",
    "key": "caregivermadeaplausiblenote"
  },
  {
    "displayname": "3. There Has Been A Current Act Of Maltreatment Since The Last SAFE-C, Where Excessive Discipline Or Physical Force Against The Child, In Which A Weapon Or Object (E.G.. Gun, Knife, Cord, Hanger, Etc...) Was Used To Inflict Or Threaten Harm To The Child.",
    "key": "currentactofmaltreatment"
  },
  {
    "displayname": "3.Comments",
    "key": "currentactofmaltreatmentnote"
  },
  {
    "displayname": "4. Child Sexual Abuse Is Suspected And Circumstances Suggest That The Childs Safety May Be Of Immediate Concem ",
    "key": "childsexualabuse"
  },
  {
    "displayname": "4.Comments",
    "key": "childsexualabusenote"
  },
  {
    "displayname": "5. Caregiver Describes The Child In Predominately Negative Terms Or Acts Towards The Child In Negative Ways That Result In The Child Being A Danger To Self Or Others, Acting Out Aggressively, Or Being Severely Withdrawn And/Or Suicidal",
    "key": "caregiverdescribes"
  },
  {
    "displayname": "5.Comments",
    "key": "caregiverdescribesnote"
  },
  {
    "displayname": "6. Caregivers Suspected Or Observed Substance Abuse/Use Seriously Impairs His/Her Ability To Supervise, Protect Or Care For The Child Or Child Is A Drug Exposed Newborn/Infant And The Caregiver Is Unable Or Unwilling To Cooperate With Treatment For Substance Abuse/Use",
    "key": "caregiverssuspected"
  },
  {
    "displayname": "6.Comments",
    "key": "caregiverssuspectednote"
  },
  {
    "displayname": "7. Caregivers Emotional Instability, Developmental Status, Lack Of Knowledge, Skills Or Motivation To Parent, Cognitive Deficiency Or Behaviors Resulting From Mental Or Physical Illness Or Disability, Seriously Impairs His/Her Current Ability To Supervise, Protect Or Care For The Child",
    "key": "caregiversemotionalinstability"
  },
  {
    "displayname": "7.Comments",
    "key": "caregiversemotionalinstabilitynote"
  },
  {
    "displayname": "8. Caregivers Explanation For An Injury To The Child Is Questionable Or Inconsistent With The Type Of Injury And The Nature Of The Injury Suggests That The Childs Safety May Be Of Immediate Concern",
    "key": "caregiversexplanation"
  },
  {
    "displayname": "8.Comments",
    "key": "caregiversexplanationnote"
  },
  {
    "displayname": "9. Caregivers Justification Or Denial Of His/Her Own Harmful Behavior Or The Harmful Behavior Of Others, Places The Child In Immediate Danger.",
    "key": "caregiversjustification"
  },
  {
    "displayname": "9.Comments",
    "key": "caregiversjustificationnote"
  },
  {
    "displayname": "10. Caregiver Does Not Or Refuses To Provide Supervision To Protect The Child, Based On The Childs Age And Developmental Needs And There Is No Substitute Caregiver To Adequately Plan For The Childs Supervision, And This Places The Child In Immediate Danger",
    "key": "caregiverrefuses"
  },
  {
    "displayname": "10.Comments",
    "key": "caregiverrefusesnote"
  },
  {
    "displayname": "11. Domestic Violence Exists In The Home And Poses An Imminent Danger Of Serious Physical And Or Emotional Harm To The Child. (A Lethality Assessment May Be Needed To Protect Other Persons In The Home.)",
    "key": "domesticviolence"
  },
  {
    "displayname": "11.Comments",
    "key": "domesticviolencenote"
  },
  {
    "displayname": "12.Caregiver Does Not Meet The Childs Current/Imminent Environmental Needs For Food Or Clothing Or Adequate Shelter And There Are No Substitute Caregivers Who Are Capable Of Obtaining Resources To Meet The Needs",
    "key": "childscurrentimminent"
  },
  {
    "displayname": "12.Comments",
    "key": "childscurrentimminentnote"
  },
  {
    "displayname": "13. The Childs Whereabouts Are Unknown, The Family Refuses Access To The Child Or There Is Reason To Believe That The Family Is About To Flee.",
    "key": "childswhereabouts"
  },
  {
    "displayname": "13.Comments",
    "key": "childswhereaboutsnote"
  },
  {
    "displayname": "14. The Child Has Special Needs, Behaviors Or Medical Concerns And The Caregiver Does Not Meet The Childs Needs For Current/Immediate Medical, Dental Or Mental Healthcare",
    "key": "specialneeds"
  },
  {
    "displayname": "14.Comments",
    "key": "specialneedsnote"
  },
  {
    "displayname": "15. The Child Is Extremely Anxious Or Fearful About The Current Home Environment",
    "key": "extremelyanxious"
  },
  {
    "displayname": "15.Comments",
    "key": "extremelyanxiousnote"
  },
  {
    "displayname": "16. The Child Is Unable To Protect Self And Conditions In The Home Indicate Immediate Danger",
    "key": "unabletoprotect"
  },
  {
    "displayname": "16.Comments",
    "key": "unabletoprotectnote"
  },
  {
    "displayname": "17. Previous Services To The Caregiver Regarding Similar Harmful Behaviors Resulted In No Change In The Caregivers Behaviors Towards The Child(Ren).",
    "key": "servicestothecaregiver"
  },
  {
    "displayname": "17.Comments",
    "key": "servicestothecaregivernote"
  },
  {
    "displayname": "18. There Have Been Multiple Reports From The Community Or Since The Last SAFE-C Regarding This Family, Where There Were Previous Concerns About The Safety Of The Child (Ren),",
    "key": "multiplereports"
  },
  {
    "displayname": "18.Comments",
    "key": "multiplereportsnote"
  },
  {
    "displayname": "Date Of Multidisciplinary Team Meeting",
    "key": "dateofmultidisciplinary"
  },
  {
    "displayname": "Child Has The Cognitive, Physical And Emotional Capacity To Participate In Safety Interventions",
    "key": "protectivecapacity1"
  },
  {
    "displayname": "1.Comments",
    "key": "TF1"
  },
  {
    "displayname": "Caregiver is able and willing to participate in creating and carrying out safety interventions to protect the child",
    "key": "protectivecapacity2"
  },
  {
    "displayname": "2.Comments",
    "key": "TF2"
  },
  {
    "displayname": "Caregiver is able and willing to use resources that are necessary to protect child",
    "key": "protectivecapacity3"
  },
  {
    "displayname": "3.Comments",
    "key": "TF3"
  },
  {
    "displayname": "Caregiver has supportive relationships with one or more persons who may be willing to participate in safety planning AND caregiver is willing and able to accept their assistance.",
    "key": "protectivecapacity4"
  },
  {
    "displayname": "4.Comments",
    "key": "TF4"
  },
  {
    "displayname": "Caregiver exhibits self control and puts the childs safety ahead of his/her own needs and for wants.",
    "key": "protectivecapacity5"
  },
  {
    "displayname": "5.Comments",
    "key": "TF5"
  },
  {
    "displayname": "There is evidence of a healthy relationship between caregiver and child",
    "key": "protectivecapacity6"
  },
  {
    "displayname": "6.Comments",
    "key": "TF6"
  },
  {
    "displayname": "Caregiver has demonstrated effective problem solving",
    "key": "protectivecapacity7"
  },
  {
    "displayname": "7.Comments",
    "key": "TF7"
  },
  {
    "displayname": "Relevant community services or resources are immediately available",
    "key": "protectivecapacity8"
  },
  {
    "displayname": "8.Comments",
    "key": "TF8"
  },
  {
    "displayname": "Child Is Safe",
    "key": "safetydecision1"
  },
  {
    "displayname": "Child Is Conditionally Safe (Any Influences 1-16 Is Checked And There Is A Completed Safety Plan That Is Signed By All Parties",
    "key": "safetydecision2"
  },
  {
    "displayname": "Child Is Conditionally Safe (Any Influences 17-18 Is Checked Yes All Actions In A Required Case Staffing Have Been Implemented)",
    "key": "safetydecision3"
  },
  {
    "displayname": "Child Is Unsafe",
    "key": "safetydecision4"
  },
  {
    "displayname": "Any Influences 1-18 was checked Yes and there is NO Safety Plan",
    "key": "childisunsafe1"
  },
  {
    "displayname": "Child currently has an Out of Home Program Assignment and it is not safe for the child to return to this caregiver.",
    "key": "childisunsafe2"
  },
  {
    "displayname": "Caregiver did not agree to a Safety Plan",
    "key": "childisunsafe3"
  },
  {
    "displayname": "Danger cannot be addressed via Safety Plan",
    "key": "childisunsafe4"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 1",
    "key": "dangerinfluence1"
  },
  {
    "displayname": "Action Required 1",
    "key": "actionrequired1"
  },
  {
    "displayname": "Date to be completed 1",
    "key": "datetobecompleted1"
  },
  {
    "displayname": "Responsible Parties 1",
    "key": "responsibleparties1"
  },
  {
    "displayname": "Re-evaluation Date 1",
    "key": "reevaluationdate1"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 2",
    "key": "dangerinfluence2"
  },
  {
    "displayname": "Action Required 2",
    "key": "actionrequired2"
  },
  {
    "displayname": "Date to be completed 2",
    "key": "datetobecompleted2"
  },
  {
    "displayname": "Responsible Parties 2",
    "key": "responsibleparties2"
  },
  {
    "displayname": "Re-evaluation Date 2",
    "key": "reevaluationdate2"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 3",
    "key": "dangerinfluence3"
  },
  {
    "displayname": "Action Required 3",
    "key": "actionrequired3"
  },
  {
    "displayname": "Date to be completed 3",
    "key": "datetobecompleted3"
  },
  {
    "displayname": "Responsible Parties 3",
    "key": "responsibleparties3"
  },
  {
    "displayname": "Re-evaluation Date 3",
    "key": "reevaluationdate3"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 4",
    "key": "dangerinfluence4"
  },
  {
    "displayname": "Action Required 4",
    "key": "actionrequired4"
  },
  {
    "displayname": "Date to be completed 4",
    "key": "datetobecompleted4"
  },
  {
    "displayname": "Responsible Parties 4",
    "key": "responsibleparties4"
  },
  {
    "displayname": "Re-evaluation Date 4",
    "key": "reevaluationdate4"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 5",
    "key": "dangerinfluence5"
  },
  {
    "displayname": "Action Required 5",
    "key": "actionrequired5"
  },
  {
    "displayname": "Date to be completed 5",
    "key": "datetobecompleted5"
  },
  {
    "displayname": "Responsible Parties 5",
    "key": "responsibleparties5"
  },
  {
    "displayname": "Re-evaluation Date 5",
    "key": "reevaluationdate5"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 6",
    "key": "dangerinfluence6"
  },
  {
    "displayname": "Action Required 6",
    "key": "actionrequired6"
  },
  {
    "displayname": "Date to be completed 6",
    "key": "datetobecompleted6"
  },
  {
    "displayname": "Responsible Parties 6",
    "key": "responsibleparties6"
  },
  {
    "displayname": "Re-evaluation Date 6",
    "key": "reevaluationdate6"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 7",
    "key": "dangerinfluence7"
  },
  {
    "displayname": "Action Required 7",
    "key": "actionrequired7"
  },
  {
    "displayname": "Date to be completed 7",
    "key": "datetobecompleted7"
  },
  {
    "displayname": "Responsible Parties 7",
    "key": "responsibleparties7"
  },
  {
    "displayname": "Re-evaluation Date 7",
    "key": "reevaluationdate7"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 8",
    "key": "dangerinfluence8"
  },
  {
    "displayname": "Action Required 8",
    "key": "actionrequired8"
  },
  {
    "displayname": "Date to be completed 8",
    "key": "datetobecompleted8"
  },
  {
    "displayname": "Responsible Parties 8",
    "key": "responsibleparties8"
  },
  {
    "displayname": "Re-evaluation Date 8",
    "key": "reevaluationdate8"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 9",
    "key": "dangerinfluence9"
  },
  {
    "displayname": "Action Required 9",
    "key": "actionrequired9"
  },
  {
    "displayname": "Date to be completed 9",
    "key": "datetobecompleted9"
  },
  {
    "displayname": "Responsible Parties 9",
    "key": "responsibleparties9"
  },
  {
    "displayname": "Re-evaluation Date 9",
    "key": "reevaluationdate9"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 10",
    "key": "dangerinfluence10"
  },
  {
    "displayname": "Action Required 10",
    "key": "actionrequired10"
  },
  {
    "displayname": "Date to be completed 10",
    "key": "datetobecompleted10"
  },
  {
    "displayname": "Responsible Parties 10",
    "key": "responsibleparties10"
  },
  {
    "displayname": "Re-evaluation Date 10",
    "key": "reevaluationdate10"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 11",
    "key": "dangerinfluence11"
  },
  {
    "displayname": "Action Required 11",
    "key": "actionrequired11"
  },
  {
    "displayname": "Date to be completed 11",
    "key": "datetobecompleted11"
  },
  {
    "displayname": "Responsible Parties 11",
    "key": "responsibleparties11"
  },
  {
    "displayname": "Re-evaluation Date 11",
    "key": "reevaluationdate11"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 12",
    "key": "dangerinfluence12"
  },
  {
    "displayname": "Action Required 12",
    "key": "actionrequired12"
  },
  {
    "displayname": "Date to be completed 12",
    "key": "datetobecompleted12"
  },
  {
    "displayname": "Responsible Parties 12",
    "key": "responsibleparties12"
  },
  {
    "displayname": "Re-evaluation Date 12",
    "key": "reevaluationdate12"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 13",
    "key": "dangerinfluence13"
  },
  {
    "displayname": "Action Required 13",
    "key": "actionrequired13"
  },
  {
    "displayname": "Date to be completed 13",
    "key": "datetobecompleted13"
  },
  {
    "displayname": "Responsible Parties 13",
    "key": "responsibleparties13"
  },
  {
    "displayname": "Re-evaluation Date 13",
    "key": "reevaluationdate13"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 14",
    "key": "dangerinfluence14"
  },
  {
    "displayname": "Action Required 14",
    "key": "actionrequired14"
  },
  {
    "displayname": "Date to be completed 14",
    "key": "datetobecompleted14"
  },
  {
    "displayname": "Responsible Parties 14",
    "key": "responsibleparties14"
  },
  {
    "displayname": "Re-evaluation Date 14",
    "key": "reevaluationdate14"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 15",
    "key": "dangerinfluence15"
  },
  {
    "displayname": "Action Required 15",
    "key": "actionrequired15"
  },
  {
    "displayname": "Date to be completed 15",
    "key": "datetobecompleted15"
  },
  {
    "displayname": "Responsible Parties 15",
    "key": "responsibleparties15"
  },
  {
    "displayname": "Re-evaluation Date 15",
    "key": "reevaluationdate15"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 16",
    "key": "dangerinfluence16"
  },
  {
    "displayname": "Action Required 16",
    "key": "actionrequired16"
  },
  {
    "displayname": "Date to be completed 16",
    "key": "datetobecompleted16"
  },
  {
    "displayname": "Responsible Parties 16",
    "key": "responsibleparties16"
  },
  {
    "displayname": "Re-evaluation Date 16",
    "key": "reevaluationdate16"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 17",
    "key": "dangerinfluence17"
  },
  {
    "displayname": "Action Required 17",
    "key": "actionrequired17"
  },
  {
    "displayname": "Date to be completed 17",
    "key": "datetobecompleted17"
  },
  {
    "displayname": "Responsible Parties 17",
    "key": "responsibleparties17"
  },
  {
    "displayname": "Re-evaluation Date 17",
    "key": "reevaluationdate17"
  },
  {
    "displayname": "Specific DANGER INFLUENCE 18",
    "key": "dangerinfluence18"
  },
  {
    "displayname": "Action Required 18",
    "key": "actionrequired18"
  },
  {
    "displayname": "Date to be completed 18",
    "key": "datetobecompleted18"
  },
  {
    "displayname": "Responsible Parties 18",
    "key": "responsibleparties18"
  },
  {
    "displayname": "Re-evaluation Date 18",
    "key": "reevaluationdate18"
  }
]'::json::json, 1, 'ADMIN', now(), 'CIDM-5982', now()) on conflict do nothing;
