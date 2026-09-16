'use strict';
const LOGGER = require("log4js").getLogger("serviceplan");
const util = require('../utils/utils');
var app = require('../../server/server');
const pdf = require('../models/pdf');
const moment = require('moment');
const dt_format = 'MM/DD/YYYY';
// Formats the UI actually sends for these fields. Parsing with an explicit
// format list avoids moment's deprecated js-Date fallback (and its unreliable,
// locale-dependent results) for non-ISO input like '04/30/2026'.
const dt_in_formats = [dt_format, 'M/D/YYYY', moment.ISO_8601];
const comprehensivefamilyassessment = 'COMPREHENSIVE FAMILY ASSESSMENT';
const comprehensivecaregiverassessment = 'COMPREHENSIVE CAREGIVER ASSESSMENT';
const comprehensivechildassessment = 'COMPREHENSIVE CHILD ASSESSMENT';
const familycultureassessment = 'FAMILY CULTURE ASSESSMENT';
const lifedomainfunctioningsection = 'LIFE DOMAIN FUNCTIONING SECTION';
const childandenvironmentstrengths = 'CHILD AND ENVIRONMENT STRENGTHS';
const childbehaviororemotionalneeds = 'CHILD BEHAVIOR / EMOTIONAL NEEDS';
const childriskbehaviours = 'CHILD RISK BEHAVIOURS';
const culturalfactors = 'CULTURAL FACTORS';
const traumaexperiences = 'TRAUMA EXPERIENCES';
const traumastresssymptoms = 'TRAUMA STRESS SYMPTOMS';
const currentcaregiverneedsandstrengths = 'CURRENT CAREGIVER NEEDS AND STRENGTHS';
const permanencyplan1caregiverneedsandstrengths = 'PERMANENCY PLAN #1 - CAREGIVER NEEDS AND STRENGTHS';

const physicalhealthstr = 'Physical Health';
const caregivercriminalbehavior = 'Caregiver Criminal Behavior';
const sexualabuse = 'Sexual Abuse';
const physicalabuse = 'Physical Abuse';
const emotionalabuse = 'Emotional Abuse';
const medicaltrauma = 'Medical Trauma';
const witnesstofamilyviolence = 'Witness to Family Violence';
const communityviolence = 'Community Violence';
const schoolviolence = 'School Violence';
const naturalormanmadedisasters = 'Natural/Man-made Disasters';
const waraffected = 'War-Affected';
const terrorismaffected = 'Terrorism-Affected';
const witnessorvictimtocriminalactivity = 'Witness/Victim to Criminal Activity';
const disruptionsincaregiving = 'Disruptions in Caregiving';
const intellectualonly = 'Intellectual (IQ only)';
const schoolattendance = 'School Attendance';
const schoolachievement = 'School Achievement';
const schoolbehavior = 'School Behavior';
const adjustmenttotrauma = 'Adjustment to Trauma';
const depressionormooddisorder = 'Depression / Mood Disorder';
const oppositionalbehavior = 'Oppositional Behavior';
const conductorantisocialbehavior = 'Conduct / Antisocial Behavior';
const substanceabuse = 'Substance Abuse';
const eatingdisturbance = 'Eating Disturbance';
const angercontrol = 'Anger Control';
const attachmentdifficulties = 'Attachment Difficulties';
const suiciderisk = 'Suicide Risk';
const selfinjuriousbehaviors = 'Self-Injurious Behaviors';
const recklessbehaviors = 'Reckless Behaviors';
const dangertoothers = 'Danger to Others';
const sexualaggression = 'Sexual Aggression';
const sexuallyreactivebehaviors = 'Sexually Reactive Behaviors';
const delinquentbehavior = 'Delinquent Behavior';
const firesetting = 'Fire-Setting';
const intentionalmisbehavior = 'Intentional Misbehavior';
const genderorsexualidentity = 'Gender/Sexual Identity';
const culturalidentity = 'Cultural Identity';
const involvementwithcare = 'Involvement with Care';
const accessibilitytochildcareservices = 'Accessibility to Child Care Services';
const residentialstability = 'Residential Stability';
const familystress = 'Family Stress';
const mentalhealth = 'Mental Health';
const substanceuse = 'Substance Use';
const maritalorpartnerconflict = 'Marital / Partner Conflict';
const posttraumaticreactions = 'Post traumatic Reactions';

const StrengthAndNeedsList = [
    { key: 'parental_strength', value: 'Parental-Caregiver collaboration', section: comprehensivefamilyassessment },
    { key: 'relation_strength', value: 'Relations among sibling', section: comprehensivefamilyassessment },
    { key: 'extended_strength', value: 'Extended family relations', section: comprehensivefamilyassessment },
    { key: 'family_strength', value: 'Family conflict', section: comprehensivefamilyassessment },
    { key: 'fcommunication_strength', value: 'Family communication', section: comprehensivefamilyassessment },
    { key: 'fappropriateness_strength', value: 'Family role appropriateness', section: comprehensivefamilyassessment },
    { key: 'safety_strength', value: 'Safety', section: comprehensivefamilyassessment },
    { key: 'social_strength', value: 'Social Resources', section: comprehensivefamilyassessment },
    { key: 'financial_resources_strength', value: 'Financial Resources', section: comprehensivecaregiverassessment },
    { key: 'residential_stability_strength', value: residentialstability, section: comprehensivecaregiverassessment },

    { key: 'supervision', value: 'Supervision', section: comprehensivecaregiverassessment },
    { key: 'supervisionrating', value: 'Supervision', section: comprehensivecaregiverassessment },
    { key: 'involvement', value: involvementwithcare, section: comprehensivecaregiverassessment },
    { key: 'involvementrating', value: involvementwithcare, section: comprehensivecaregiverassessment },
    { key: 'emotionalresp', value: 'Emotional responsiveness', section: comprehensivecaregiverassessment },
    { key: 'emotionalresprating', value: 'Emotional responsiveness', section: comprehensivecaregiverassessment },
    { key: 'knowledge', value: 'Knowledge', section: comprehensivecaregiverassessment },
    { key: 'knowledgerating', value: 'Knowledge', section: comprehensivecaregiverassessment },
    { key: 'org', value: 'Organization', section: comprehensivecaregiverassessment },
    { key: 'orgrating', value: 'Organization', section: comprehensivecaregiverassessment },
    { key: 'boundaries', value: 'Boundaries', section: comprehensivecaregiverassessment },
    { key: 'boundariesrating', value: 'Boundaries', section: comprehensivecaregiverassessment },
    { key: 'discipline', value: 'Discipline', section: comprehensivecaregiverassessment },
    { key: 'disciplinerating', value: 'Discipline', section: comprehensivecaregiverassessment },
    //2  //NOSONAR
    { key: 'posttraumaticrating', value: 'Post-traumatic Reactions', section: comprehensivecaregiverassessment },
    { key: 'phyhealthrating', value: physicalhealthstr, section: comprehensivecaregiverassessment },
    { key: 'mentalhealthrating', value: mentalhealth, section: comprehensivecaregiverassessment },
    { key: 'developmentalrating', value: 'Developmental', section: comprehensivecaregiverassessment },
    { key: 'substanceuserating', value: substanceuse, section: comprehensivecaregiverassessment },
    { key: 'criminalbehavrating', value: caregivercriminalbehavior, section: comprehensivecaregiverassessment },
    //3 //NOSONAR
    { key: 'sexabuserating', value: sexualabuse, section: comprehensivecaregiverassessment },
    { key: 'phyabuserating', value: physicalabuse, section: comprehensivecaregiverassessment },
    { key: 'emotionalabuserating', value: emotionalabuse, section: comprehensivecaregiverassessment },
    { key: 'neglectrating', value: 'Neglect', section: comprehensivecaregiverassessment },
    { key: 'medtraumarating', value: medicaltrauma, section: comprehensivecaregiverassessment },
    { key: 'familyvoilancerating', value: witnesstofamilyviolence, section: comprehensivecaregiverassessment },
    { key: 'communityvoilancerating', value: communityviolence, section: comprehensivecaregiverassessment },
    { key: 'schoolvoilancerating', value: schoolviolence, section: comprehensivecaregiverassessment },
    { key: 'disasterrating', value: naturalormanmadedisasters, section: comprehensivecaregiverassessment },
    { key: 'waraffectedrating', value: waraffected, section: comprehensivecaregiverassessment },
    { key: 'terroraffectedrating', value: terrorismaffected, section: comprehensivecaregiverassessment },
    { key: 'criminalactivityrating', value: witnessorvictimtocriminalactivity, section: comprehensivecaregiverassessment },
    { key: 'disruptionrating', value: disruptionsincaregiving, section: comprehensivecaregiverassessment },
    //4 //NOSONAR
    { key: 'famchildneeds', value: 'Knowledge of family-child needs', section: comprehensivecaregiverassessment },
    { key: 'famchildneedsrating', value: 'Knowledge of family-child needs', section: comprehensivecaregiverassessment },
    { key: 'serviceopt', value: 'Knowledge of service options', section: comprehensivecaregiverassessment },
    { key: 'serviceoptrating', value: 'Knowledge of service options', section: comprehensivecaregiverassessment },
    { key: 'responsibilities', value: 'Knowledge of rights & responsibilities', section: comprehensivecaregiverassessment },
    { key: 'responsibilitiesrating', value: 'Knowledge of rights & responsibilities', section: comprehensivecaregiverassessment },
    { key: 'listening', value: 'Ability to listen', section: comprehensivecaregiverassessment },
    { key: 'listeningrating', value: 'Ability to listen', section: comprehensivecaregiverassessment },
    { key: 'communication', value: 'Ability to communicate', section: comprehensivecaregiverassessment },
    { key: 'communicationrating', value: 'Ability to communicate', section: comprehensivecaregiverassessment },
    { key: 'naturesupport', value: 'Natural supports', section: comprehensivecaregiverassessment },
    { key: 'naturesupportrating', value: 'Natural supports', section: comprehensivecaregiverassessment },
    //5
    { key: 'youthliving', value: 'Satisfaction with youth’s living arrangement', section: comprehensivecaregiverassessment },
    { key: 'youthlivingrating', value: 'Satisfaction with youth’s living arrangement', section: comprehensivecaregiverassessment },
    { key: 'youtheducation', value: 'Satisfaction with youth’s educational arrangement', section: comprehensivecaregiverassessment },
    { key: 'youtheducationrating', value: 'Satisfaction with youth’s educational arrangement', section: comprehensivecaregiverassessment },
    { key: 'servicearrange', value: 'Satisfaction with service arrangement', section: comprehensivecaregiverassessment },
    { key: 'servicearrangerating', value: 'Satisfaction with service arrangement', section: comprehensivecaregiverassessment },
    //1
    { key: 'mother', value: 'Relationship with biological mother', section: comprehensivechildassessment },
    { key: 'motherrating', value: 'Relationship with biological mother', section: comprehensivechildassessment },
    { key: 'father', value: 'Relationship with biological father', section: comprehensivechildassessment },
    { key: 'fatherrating', value: 'Relationship with biological father', section: comprehensivechildassessment },
    { key: 'pricaregiver', value: 'Relationship with primary caregiver', section: comprehensivechildassessment },
    { key: 'pricaregiverrating', value: 'Relationship with primary caregiver', section: comprehensivechildassessment },
    { key: 'adults', value: 'Relationship with other family adults', section: comprehensivechildassessment },
    { key: 'adultsrating', value: 'Relationship with other family adults', section: comprehensivechildassessment },
    { key: 'siblings', value: 'Relationship with siblings', section: comprehensivechildassessment },
    { key: 'siblingsrating', value: 'Relationship with siblings', section: comprehensivechildassessment },
    { key: 'medical', value: 'Medical/Physical', section: comprehensivechildassessment },
    { key: 'medicalrating', value: 'Medical/Physical', section: comprehensivechildassessment },
    { key: 'iq', value: intellectualonly, section: comprehensivechildassessment },
    { key: 'iqrating', value: intellectualonly, section: comprehensivechildassessment },
    { key: 'autism', value: 'Autism Spectrum/PDD', section: comprehensivechildassessment },
    { key: 'autismrating', value: 'Autism Spectrum/PDD', section: comprehensivechildassessment },
    { key: 'speech', value: 'Speech Language Delay', section: comprehensivechildassessment },
    { key: 'speechrating', value: 'Speech Language Delay', section: comprehensivechildassessment },
    { key: 'social', value: 'Social Functioning', section: comprehensivechildassessment },
    { key: 'socialrating', value: 'Social Functioning', section: comprehensivechildassessment },
    { key: 'schoolatd', value: schoolattendance, section: comprehensivechildassessment },
    { key: 'schoolatdrating', value: schoolattendance, section: comprehensivechildassessment },
    { key: 'schoolachiv', value: schoolachievement, section: comprehensivechildassessment },
    { key: 'schoolachivrating', value: schoolachievement, section: comprehensivechildassessment },
    { key: 'schoolbehv', value: schoolbehavior, section: comprehensivechildassessment },
    { key: 'schoolbehvrating', value: schoolbehavior, section: comprehensivechildassessment },
    //2
    { key: 'mentalhealthrating', value: 'Mental Health Needs', section: comprehensivechildassessment },
    { key: 'riskbehaviour', value: 'Risk Behaviors', section: comprehensivechildassessment },
    { key: 'adjtotraumarating', value: adjustmenttotrauma, section: comprehensivechildassessment },
    //2b mental health rating above 1 //NOSONAR
    { key: 'Psychosisrating', value: 'Psychosis', section: comprehensivechildassessment },
    { key: 'AttnDeficitImpulseControlrating', value: 'Attn Deficit / Impulse Control', section: comprehensivechildassessment },
    { key: 'DepressionMoodDisorderrating', value: depressionormooddisorder, section: comprehensivechildassessment },
    { key: 'Anxietyrating', value: 'Anxiety', section: comprehensivechildassessment },
    { key: 'OppositionalBehaviorrating', value: oppositionalbehavior, section: comprehensivechildassessment },
    { key: 'ConductAntisocialBehaviorrating', value: conductorantisocialbehavior, section: comprehensivechildassessment },
    { key: 'SubstanceAbuserating', value: substanceabuse, section: comprehensivechildassessment },
    { key: 'EatingDisturbancerating', value: eatingdisturbance, section: comprehensivechildassessment },
    { key: 'AngerControlrating', value: angercontrol, section: comprehensivechildassessment },
    { key: 'AttachmentDifficultiesrating', value: attachmentdifficulties, section: comprehensivechildassessment },
    //2c risk behavior //NOSONAR
    { key: 'SuicideRiskrating', value: suiciderisk, section: comprehensivechildassessment },
    { key: 'SelfInjuriousBehaviorsrating', value: selfinjuriousbehaviors, section: comprehensivechildassessment },
    { key: 'RecklessBehaviorsrating', value: recklessbehaviors, section: comprehensivechildassessment },
    { key: 'DangertoOthersrating', value: dangertoothers, section: comprehensivechildassessment },
    { key: 'SexualAggressionrating', value: sexualaggression, section: comprehensivechildassessment },
    { key: 'SexuallyReactiveBehaviorsrating', value: sexuallyreactivebehaviors, section: comprehensivechildassessment },
    { key: 'runawayrating', value: 'Runaway', section: comprehensivechildassessment },
    { key: 'DelinquentBehaviorrating', value: delinquentbehavior, section: comprehensivechildassessment },
    { key: 'firesettingrating', value: firesetting, section: comprehensivechildassessment },
    { key: 'IntentionalMisbehaviorrating', value: intentionalmisbehavior, section: comprehensivechildassessment },
    { key: 'bullyingrating', value: 'Bullying', section: comprehensivechildassessment },
    { key: 'Exploitedrating', value: 'Exploited', section: comprehensivechildassessment },
    //3
    { key: 'sexabuserating', value: sexualabuse, section: comprehensivechildassessment },
    { key: 'phyabuserating', value: physicalabuse, section: comprehensivechildassessment },
    { key: 'emotionalabuserating', value: emotionalabuse, section: comprehensivechildassessment },
    { key: 'neglectrating', value: 'Neglect', section: comprehensivechildassessment },
    { key: 'medicaltraumarating', value: medicaltrauma, section: comprehensivechildassessment },
    { key: 'familyvoilancerating', value: witnesstofamilyviolence, section: comprehensivechildassessment },
    { key: 'communityvoilancerating', value: communityviolence, section: comprehensivechildassessment },
    { key: 'schoolvoilancerating', value: schoolviolence, section: comprehensivechildassessment },
    { key: 'disasterrating', value: naturalormanmadedisasters, section: comprehensivechildassessment },
    { key: 'waraffectedrating', value: waraffected, section: comprehensivechildassessment },
    { key: 'terroraffectedrating', value: terrorismaffected, section: comprehensivechildassessment },
    { key: 'criminalactivityrating', value: witnessorvictimtocriminalactivity, section: comprehensivechildassessment },
    { key: 'disruptionrating', value: disruptionsincaregiving, section: comprehensivechildassessment },
    //Newly added: //NOSONAR
    //Family Culture Youth Assessment //NOSONAR
    { key: 'ritual_scale', value: 'Ritual', section: familycultureassessment },
    { key: 'ritual_strength', value: 'Ritual', section: familycultureassessment },
    { key: 'sexual_scale', value: genderorsexualidentity, section: familycultureassessment },
    { key: 'sexual_identity_strength', value: genderorsexualidentity, section: familycultureassessment },
    { key: 'cultural_scale', value: culturalidentity, section: familycultureassessment },
    { key: 'cultural_strength', value: culturalidentity, section: familycultureassessment },
    { key: 'language_scale', value: 'Language', section: familycultureassessment },
    { key: 'language_strength', value: 'Language', section: familycultureassessment },
    //Comprehensive family Assessment
    { key: 'parental_scale', value: 'Parental-Caregiver collaboration', section: comprehensivefamilyassessment },
    { key: 'relation_scale', value: 'Relations among siblings', section: comprehensivefamilyassessment },
    { key: 'extended_scale', value: 'Extended family relations', section: comprehensivefamilyassessment },
    { key: 'family_scale', value: 'Family conflict', section: comprehensivefamilyassessment },
    { key: 'fcommunication_scale', value: 'Family communication', section: comprehensivefamilyassessment },
    { key: 'fappropriateness_scale', value: 'Family role appropriateness', section: comprehensivefamilyassessment },
    { key: 'safety_scale', value: 'Safety', section: comprehensivefamilyassessment },
    { key: 'social_scale', value: 'Social Resources', section: comprehensivefamilyassessment },


    //CANS-OUT OF HOME //NOSONAR
    //Tab 1 Fact sheet and life domain //NOSONAR
    { key: 'family_rating', value: 'Family', section: lifedomainfunctioningsection },
    { key: 'livingsitu_rating', value: 'Living Situation', section: lifedomainfunctioningsection },
    { key: 'socialpeer_rating', value: 'Social Functioning-Peer', section: lifedomainfunctioningsection },
    { key: 'socialadult_rating', value: 'Social Functioning-Adult', section: lifedomainfunctioningsection },
    { key: 'medphy_rating', value: 'Medical / Physical', section: lifedomainfunctioningsection },
    { key: 'enuresis_rating', value: 'Enuresis / Encopresis', section: lifedomainfunctioningsection },
    { key: 'sleeping_rating', value: 'Sleeping', section: lifedomainfunctioningsection },
    { key: 'iq_rating', value: intellectualonly, section: lifedomainfunctioningsection },
    { key: 'autism_rating', value: 'Autism Spectrum / PPD', section: lifedomainfunctioningsection },
    { key: 'recreation_rating', value: 'Recreational', section: lifedomainfunctioningsection },
    { key: 'legal_rating', value: 'Legal (DJS/criminal court)', section: lifedomainfunctioningsection },
    { key: 'judgement_rating', value: 'Judgement / Decision Making', section: lifedomainfunctioningsection },
    { key: 'sexual_rating', value: 'Sexual Development', section: lifedomainfunctioningsection },
    
    { key: 'jobfun_rating', value: 'Job Functioning', section: lifedomainfunctioningsection },
    { key: 'schoolatd_rating', value: schoolattendance, section: lifedomainfunctioningsection },
    { key: 'schoolbehave_rating', value: schoolbehavior, section: lifedomainfunctioningsection },
    { key: 'schoolacheive_rating', value: schoolachievement, section: lifedomainfunctioningsection },


    
    { key: 'family_strength', value: 'Family', section: lifedomainfunctioningsection },
    { key: 'livingsitu_strength', value: 'Living Situation', section: lifedomainfunctioningsection },
    { key: 'socialpeer_strength', value: 'Social Functioning-Peer', section: lifedomainfunctioningsection },
    { key: 'socialadult_strength', value: 'Social Functioning-Adult', section: lifedomainfunctioningsection },
    { key: 'medphy_strength', value: 'Medical / Physical', section: lifedomainfunctioningsection },
    { key: 'enuresis_strength', value: 'Enuresis / Encopresis', section: lifedomainfunctioningsection },
    { key: 'sleeping_strength', value: 'Sleeping', section: lifedomainfunctioningsection },
    { key: 'iq_strength', value: intellectualonly, section: lifedomainfunctioningsection },
    { key: 'autism_strength', value: 'Autism Spectrum / PPD', section: lifedomainfunctioningsection },
    { key: 'recreation_strength', value: 'Recreational', section: lifedomainfunctioningsection },
    { key: 'legal_strength', value: 'Legal (DJS/criminal court)', section: lifedomainfunctioningsection },
    { key: 'judgement_strength', value: 'Judgement / Decision Making', section: lifedomainfunctioningsection },
    { key: 'sexual_strength', value: 'Sexual Development', section: lifedomainfunctioningsection },
    
    { key: 'jobfun_strength', value: 'Job Functioning', section: lifedomainfunctioningsection },
    { key: 'schoolatd_strength', value: schoolattendance, section: lifedomainfunctioningsection },
    { key: 'schoolbehave_strength', value: schoolbehavior, section: lifedomainfunctioningsection },
    { key: 'schoolacheive_strength', value: schoolachievement, section: lifedomainfunctioningsection },

    //Tab 2
    
    { key: 'familyenv_rating', value: 'Family Environment', section: childandenvironmentstrengths },
    { key: 'eduenv_rating', value: 'Educational Environment', section: childandenvironmentstrengths },
    { key: 'religious_rating', value: 'Spiritual / Religious', section: childandenvironmentstrengths },
    { key: 'community_rating', value: 'Community Life', section: childandenvironmentstrengths },
    { key: 'relperformance_rating', value: 'Relationship Performance', section: childandenvironmentstrengths },
    { key: 'natural_rating', value: 'Natural Supports (i.e., unpaid)', section: childandenvironmentstrengths },
    { key: 'interperson_rating', value: 'Interpersonal Skills – Peer', section: childandenvironmentstrengths },
    { key: 'interpersonnoncare_rating', value: 'Interpersonal Skills – Non- caregiver Adult', section: childandenvironmentstrengths },
    { key: 'optimism_rating', value: 'Optimism', section: childandenvironmentstrengths },
    { key: 'talent_rating', value: 'Talent / Interests', section: childandenvironmentstrengths },
    { key: 'culture_rating', value: culturalidentity, section: childandenvironmentstrengths },
    { key: 'careplanning_rating', value: 'Youth Involvement w/ Care Planning', section: childandenvironmentstrengths },
    { key: 'resiliency_rating', value: 'Resiliency (History)', section: childandenvironmentstrengths },
    
    { key: 'vocational_rating', value: 'Vocational Preferences & Skills', section: childandenvironmentstrengths },
    { key: 'resourcefulness_rating', value: 'Resourcefulness', section: childandenvironmentstrengths },

    { key: 'psychosis_rating', value: 'Psychosis', section: childbehaviororemotionalneeds },
    { key: 'impulse_rating', value: 'Attention Deficit / Impulse Control', section: childbehaviororemotionalneeds },
    { key: 'mood_rating', value: depressionormooddisorder, section: childbehaviororemotionalneeds },
    { key: 'anxiety_rating', value: 'Anxiety', section: childbehaviororemotionalneeds },
    { key: 'opposition_rating', value: oppositionalbehavior, section: childbehaviororemotionalneeds },
    { key: 'conduct_rating', value: conductorantisocialbehavior, section: childbehaviororemotionalneeds },
    { key: 'substanceabuse_rating', value: substanceabuse, section: childbehaviororemotionalneeds },
    { key: 'eating_rating', value: eatingdisturbance, section: childbehaviororemotionalneeds },
    { key: 'angermang_rating', value: angercontrol, section: childbehaviororemotionalneeds },
    { key: 'attchment_rating', value: attachmentdifficulties, section: childbehaviororemotionalneeds },
    { key: 'adjtrauma_rating', value: adjustmenttotrauma, section: childbehaviororemotionalneeds },



    { key: 'familyenv_strength', value: 'Family Environment', section: childandenvironmentstrengths },
    { key: 'eduenv_strength', value: 'Educational Environment', section: childandenvironmentstrengths },
    { key: 'religious_strength', value: 'Spiritual / Religious', section: childandenvironmentstrengths },
    { key: 'community_strength', value: 'Community Life', section: childandenvironmentstrengths },
    { key: 'relperformance_strength', value: 'Relationship Performance', section: childandenvironmentstrengths },
    { key: 'natural_strength', value: 'Natural Supports (i.e., unpaid)', section: childandenvironmentstrengths },
    { key: 'interperson_strength', value: 'Interpersonal Skills – Peer', section: childandenvironmentstrengths },
    { key: 'interpersonnoncare_strength', value: 'Interpersonal Skills – Non- caregiver Adult', section: childandenvironmentstrengths },
    { key: 'optimism_strength', value: 'Optimism', section: childandenvironmentstrengths },
    { key: 'talent_strength', value: 'Talent / Interests', section: childandenvironmentstrengths },
    { key: 'culture_strength', value: culturalidentity, section: childandenvironmentstrengths },
    { key: 'careplanning_strength', value: 'Youth Involvement w/ Care Planning', section: childandenvironmentstrengths },
    { key: 'resiliency_strength', value: 'Resiliency (History)', section: childandenvironmentstrengths },
    
    { key: 'vocational_strength', value: 'Vocational Preferences & Skills', section: childandenvironmentstrengths },
    { key: 'resourcefulness_strength', value: 'Resourcefulness', section: childandenvironmentstrengths },

    { key: 'psychosis_strength', value: 'Psychosis', section: childbehaviororemotionalneeds },
    { key: 'impulse_strength', value: 'Attention Deficit / Impulse Control', section: childbehaviororemotionalneeds },
    { key: 'mood_strength', value: depressionormooddisorder, section: childbehaviororemotionalneeds },
    { key: 'anxiety_strength', value: 'Anxiety', section: childbehaviororemotionalneeds },
    { key: 'opposition_strength', value: oppositionalbehavior, section: childbehaviororemotionalneeds },
    { key: 'conduct_strength', value: conductorantisocialbehavior, section: childbehaviororemotionalneeds },
    { key: 'substanceabuse_strength', value: substanceabuse, section: childbehaviororemotionalneeds },
    { key: 'eating_strength', value: eatingdisturbance, section: childbehaviororemotionalneeds },
    { key: 'angermang_strength', value: angercontrol, section: childbehaviororemotionalneeds },
    { key: 'attchment_strength', value: attachmentdifficulties, section: childbehaviororemotionalneeds },
    { key: 'adjtrauma_strength', value: adjustmenttotrauma, section: childbehaviororemotionalneeds },

    //child risk
    { key: 'suicide_rating', value: suiciderisk, section: childriskbehaviours },
    { key: 'selfinjury_rating', value: selfinjuriousbehaviors, section: childriskbehaviours },
    { key: 'reckless_rating', value: recklessbehaviors, section: childriskbehaviours },
    { key: 'dangertoother_rating', value: dangertoothers, section: childriskbehaviours },
    { key: 'sexaggress_rating', value: sexualaggression, section: childriskbehaviours },
    { key: 'sexreact_rating', value: sexuallyreactivebehaviors, section: childriskbehaviours },
    { key: 'runaway_rating', value: 'Runaway', section: childriskbehaviours },
    { key: 'deliquent_rating', value: delinquentbehavior, section: childriskbehaviours },
    { key: 'fire_rating', value: firesetting, section: childriskbehaviours },
    { key: 'intentional_rating', value: intentionalmisbehavior, section: childriskbehaviours },
    { key: 'bullying_rating', value: 'Bullying', section: childriskbehaviours },
    { key: 'exploited_rating', value: 'Exploited', section: childriskbehaviours },
    
    { key: 'suicide_strength', value: suiciderisk, section: childriskbehaviours },
    { key: 'selfinjury_strength', value: selfinjuriousbehaviors, section: childriskbehaviours },
    { key: 'reckless_strength', value: recklessbehaviors, section: childriskbehaviours },
    { key: 'dangertoother_strength', value: dangertoothers, section: childriskbehaviours },
    { key: 'sexaggress_strength', value: sexualaggression, section: childriskbehaviours },
    { key: 'sexreact_strength', value: sexuallyreactivebehaviors, section: childriskbehaviours },
    { key: 'runaway_strength', value: 'Runaway', section: childriskbehaviours },
    { key: 'deliquent_strength', value: delinquentbehavior, section: childriskbehaviours },
    { key: 'fire_strength', value: firesetting, section: childriskbehaviours },
    { key: 'intentional_strength', value: intentionalmisbehavior, section: childriskbehaviours },
    { key: 'bullying_strength', value: 'Bullying', section: childriskbehaviours },
    { key: 'exploited_strength', value: 'Exploited', section: childriskbehaviours },


    //Tab 3 Cultural Factors //NOSONAR
    
    { key: 'ritual_rating', value: 'Ritual', section: culturalfactors },
    { key: 'ritual_strength', value: 'Ritual', section: culturalfactors },
    { key: 'genderidentity_rating', value: genderorsexualidentity, section: culturalfactors },
    { key: 'genderidentity_strength', value: genderorsexualidentity, section: culturalfactors },
    { key: 'culturestress_rating', value: culturalidentity, section: culturalfactors },
    { key: 'culturestress_strength', value: culturalidentity, section: culturalfactors },
    { key: 'language_rating', value: 'Language', section: culturalfactors },
    { key: 'language_strength', value: 'Language', section: culturalfactors },

    //Tab 4 Trauma  //NOSONAR
    
    { key: 'sexsbuse_rating', value: sexualabuse, section: traumaexperiences },
    { key: 'phyabuse_rating', value: physicalabuse, section: traumaexperiences },
    { key: 'emotionalabuse_rating', value: emotionalabuse, section: traumaexperiences },
    { key: 'neglect_rating', value: 'Neglect', section: traumaexperiences },
    { key: 'medicaltrauma_rating', value: medicaltrauma, section: traumaexperiences },
    { key: 'familywitness_rating', value: witnesstofamilyviolence, section: traumaexperiences },
    { key: 'communityvoilance_rating', value: communityviolence, section: traumaexperiences },
    { key: 'schoolvoilance_rating', value: schoolviolence, section: traumaexperiences },
    { key: 'naturaldisaster_rating', value: naturalormanmadedisasters, section: traumaexperiences },
    { key: 'waraffected_rating', value: waraffected, section: traumaexperiences },
    { key: 'terroraffected_rating', value: terrorismaffected, section: traumaexperiences },
    { key: 'criminalactivity_rating', value: witnessorvictimtocriminalactivity, section: traumaexperiences },
    { key: 'disruptions_rating', value: disruptionsincaregiving, section: traumaexperiences },

    
    { key: 'sexsbuse_strength', value: sexualabuse, section: traumaexperiences },
    { key: 'phyabuse_strength', value: physicalabuse, section: traumaexperiences },
    { key: 'emotionalabuse_strength', value: emotionalabuse, section: traumaexperiences },
    { key: 'neglect_strength', value: 'Neglect', section: traumaexperiences },
    { key: 'medicaltrauma_strength', value: medicaltrauma, section: traumaexperiences },
    { key: 'familywitness_strength', value: witnesstofamilyviolence, section: traumaexperiences },
    { key: 'communityvoilance_strength', value: communityviolence, section: traumaexperiences },
    { key: 'schoolvoilance_strength', value: schoolviolence, section: traumaexperiences },
    { key: 'naturaldisaster_strength', value: naturalormanmadedisasters, section: traumaexperiences },
    { key: 'waraffected_strength', value: waraffected, section: traumaexperiences },
    { key: 'terroraffected_strength', value: terrorismaffected, section: traumaexperiences },
    { key: 'criminalactivity_strength', value: witnessorvictimtocriminalactivity, section: traumaexperiences },
    { key: 'disruptions_strength', value: disruptionsincaregiving, section: traumaexperiences },

    { key: 'traumagrief_rating', value: 'Traumatic Grief / Separation', section: traumastresssymptoms },
    { key: 'reexperiancing_rating', value: 'Re-experiencing', section: traumastresssymptoms },
    { key: 'avoidance_rating', value: 'Avoidance', section: traumastresssymptoms },
    { key: 'numbering_rating', value: 'Numbering', section: traumastresssymptoms },
    { key: 'dysregulation_rating', value: 'Affect Dysregulation', section: traumastresssymptoms },
    { key: 'dissociation_rating', value: 'Dissociation', section: traumastresssymptoms },


    { key: 'traumagrief_strength', value: 'Traumatic Grief / Separation', section: traumastresssymptoms },
    { key: 'reexperiancing_strength', value: 'Re-experiencing', section: traumastresssymptoms },
    { key: 'avoidance_strength', value: 'Avoidance', section: traumastresssymptoms },
    { key: 'numbering_strength', value: 'Numbering', section: traumastresssymptoms },
    { key: 'dysregulation_strength', value: 'Affect Dysregulation', section: traumastresssymptoms },
    { key: 'dissociation_strength', value: 'Dissociation', section: traumastresssymptoms },

    //Tab 5 Caregiver //NOSONAR

    { key: 'supervision_rating', value: 'Supervision', section: currentcaregiverneedsandstrengths },
    { key: 'involvementcare_rating', value: involvementwithcare, section: currentcaregiverneedsandstrengths },
    { key: 'knowledge_rating', value: 'Knowledge', section: currentcaregiverneedsandstrengths },
    { key: 'organization_rating', value: 'Organization', section: currentcaregiverneedsandstrengths },
    { key: 'resource_rating', value: 'Resources', section: currentcaregiverneedsandstrengths },
    { key: 'difficulties_rating', value: attachmentdifficulties, section: currentcaregiverneedsandstrengths },
    { key: 'assessablity_rating', value: accessibilitytochildcareservices, section: currentcaregiverneedsandstrengths },
    { key: 'stability_rating', value: residentialstability, section: currentcaregiverneedsandstrengths },
    { key: 'familystress_rating', value: familystress, section: currentcaregiverneedsandstrengths },
    { key: 'safety_rating', value: 'Safety', section: currentcaregiverneedsandstrengths },
    { key: 'phyhealth_rating', value: physicalhealthstr, section: currentcaregiverneedsandstrengths },
    { key: 'mentalhealth_rating', value: mentalhealth, section: currentcaregiverneedsandstrengths },
    { key: 'substanceuse_rating', value: substanceuse, section: currentcaregiverneedsandstrengths },
    { key: 'developmental_rating', value: 'Developmental', section: currentcaregiverneedsandstrengths },
    { key: 'marital_rating', value: maritalorpartnerconflict, section: currentcaregiverneedsandstrengths },
    { key: 'posttraumatic_rating', value: posttraumaticreactions, section: currentcaregiverneedsandstrengths },
    { key: 'criminalbehav_rating', value: caregivercriminalbehavior, section: currentcaregiverneedsandstrengths },
 

    { key: 'supervision_strength', value: 'Supervision', section: currentcaregiverneedsandstrengths },
    { key: 'involvementcare_strength', value: involvementwithcare, section: currentcaregiverneedsandstrengths },
    { key: 'knowledge_strength', value: 'Knowledge', section: currentcaregiverneedsandstrengths },
    { key: 'organization_strength', value: 'Organization', section: currentcaregiverneedsandstrengths },
    { key: 'resource_strength', value: 'Resources', section: currentcaregiverneedsandstrengths },
    { key: 'difficulties_strength', value: attachmentdifficulties, section: currentcaregiverneedsandstrengths },
    { key: 'assessablity_strength', value: accessibilitytochildcareservices, section: currentcaregiverneedsandstrengths },
    { key: 'stability_strength', value: residentialstability, section: currentcaregiverneedsandstrengths },
    { key: 'familystress_strength', value: familystress, section: currentcaregiverneedsandstrengths },
    { key: 'safety_strength', value: 'Safety', section: currentcaregiverneedsandstrengths },
    { key: 'phyhealth_strength', value: physicalhealthstr, section: currentcaregiverneedsandstrengths },
    { key: 'mentalhealth_strength', value: mentalhealth, section: currentcaregiverneedsandstrengths },
    { key: 'substanceuse_strength', value: substanceuse, section: currentcaregiverneedsandstrengths },
    { key: 'developmental_strength', value: 'Developmental', section: currentcaregiverneedsandstrengths },
    { key: 'marital_strength', value: maritalorpartnerconflict, section: currentcaregiverneedsandstrengths },
    { key: 'posttraumatic_strength', value: posttraumaticreactions, section: currentcaregiverneedsandstrengths },
    { key: 'criminalbehav_strength', value: caregivercriminalbehavior, section: currentcaregiverneedsandstrengths },
 

    //Tab 6 Permanency Plan //NOSONAR

    { key: 'supervision_rating', value: 'Supervision', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'involvementcare_rating', value: involvementwithcare, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'knowledge_rating', value: 'Knowledge', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'organization_rating', value: 'Organization', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'resource_rating', value: 'Resources', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'difficulties_rating', value: attachmentdifficulties, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'assessablity_rating', value: accessibilitytochildcareservices, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'stability_rating', value: residentialstability, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'familystress_rating', value: familystress, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'safety_rating', value: 'Safety', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'phyhealth_rating', value: physicalhealthstr, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'mentalhealth_rating', value: mentalhealth, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'substanceuse_rating', value: substanceuse, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'developmental_rating', value: 'Developmental', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'marital_rating', value: maritalorpartnerconflict, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'posttraumatic_rating', value: posttraumaticreactions, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'criminalbehav_rating', value: caregivercriminalbehavior, section: permanencyplan1caregiverneedsandstrengths },
 

    { key: 'supervision_strength', value: 'Supervision', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'involvementcare_strength', value: involvementwithcare, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'knowledge_strength', value: 'Knowledge', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'organization_strength', value: 'Organization', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'resource_strength', value: 'Resources', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'difficulties_strength', value: attachmentdifficulties, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'assessablity_strength', value: accessibilitytochildcareservices, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'stability_strength', value: residentialstability, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'familystress_strength', value: familystress, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'safety_strength', value: 'Safety', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'phyhealth_strength', value: physicalhealthstr, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'mentalhealth_strength', value: mentalhealth, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'substanceuse_strength', value: substanceuse, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'developmental_strength', value: 'Developmental', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'marital_strength', value: maritalorpartnerconflict, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'posttraumatic_strength', value: posttraumaticreactions, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'criminalbehav_strength', value: caregivercriminalbehavior, section: permanencyplan1caregiverneedsandstrengths },
 

    { key: 'supervision_ratingII', value: 'Supervision', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'involvementcare_ratingII', value: involvementwithcare, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'knowledge_ratingII', value: 'Knowledge', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'organization_ratingII', value: 'Organization', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'resource_ratingII', value: 'Resources', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'difficulties_ratingII', value: attachmentdifficulties, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'assessablity_ratingII', value: accessibilitytochildcareservices, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'stability_ratingII', value: residentialstability, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'familystress_ratingII', value: familystress, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'safety_ratingII', value: 'Safety', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'phyhealth_ratingII', value: physicalhealthstr, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'mentalhealth_ratingII', value: mentalhealth, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'substanceuse_ratingII', value: substanceuse, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'developmental_ratingII', value: 'Developmental', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'marital_ratingII', value: maritalorpartnerconflict, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'posttraumatic_ratingII', value: posttraumaticreactions, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'criminalbehav_ratingII', value: caregivercriminalbehavior, section: permanencyplan1caregiverneedsandstrengths },
 

    { key: 'supervision_strengthII', value: 'Supervision', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'involvementcare_strengthII', value: involvementwithcare, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'knowledge_strengthII', value: 'Knowledge', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'organization_strengthII', value: 'Organization', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'resource_strengthII', value: 'Resources', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'difficulties_strengthII', value: attachmentdifficulties, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'assessablity_strengthII', value: accessibilitytochildcareservices, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'stability_strengthII', value: residentialstability, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'familystress_strengthII', value: familystress, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'safety_strengthII', value: 'Safety', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'phyhealth_strengthII', value: physicalhealthstr, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'mentalhealth_strengthII', value: mentalhealth, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'substanceuse_strengthII', value: substanceuse, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'developmental_strengthII', value: 'Developmental', section: permanencyplan1caregiverneedsandstrengths },
    { key: 'marital_strengthII', value: maritalorpartnerconflict, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'posttraumatic_strengthII', value: posttraumaticreactions, section: permanencyplan1caregiverneedsandstrengths },
    { key: 'criminalbehav_strengthII', value: caregivercriminalbehavior, section: permanencyplan1caregiverneedsandstrengths }
]

module.exports = function(Serviceplan) {
    Serviceplan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplan.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplan.observe('after save', (ctx, next) => util.aftersave(ctx, next, 'SPLAN',      
        (ctx.isNewInstance || ctx.instance) ? ctx.instance.serviceplanid : ctx.where.serviceplanid));
    Serviceplan.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));


    Serviceplan.remoteMethod('getserviceplan', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Serviceplan.getserviceplan = (request) => {
        return app.models.Serviceplan.find({
            where: { serviceplanlogid: request.where.serviceplanid },
            include: [{
                    relation: "repeats",
                    scope: {
                        where: { activeflag: 1 }
                    }
                },
                {
                    relation: "exemptions",
                    scope: {
                        where: { activeflag: 1 }
                    }
                },
                {
                    relation: "occurences",
                    scope: {
                        where: { activeflag: 1 }
                    }
                }
            ]
        }).then(data => {
            return data
        })
    }

    Serviceplan.remoteMethod('add', {
        http: {
            path: '/add',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Serviceplan.add = function(request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const securityuserid = request.securityuserid ? request.securityuserid : suserid;
        request.serviceplanstatustypekey = "PENDING";
        request.insertedon = new Date().toLocaleString();
        request.updatedon = new Date().toLocaleString();
        request.insertedby = securityuserid;
        request.updatedby = securityuserid;
        return app.models.Serviceplanlog.create(request)
            .then(res => {
                LOGGER.debug(res)
                var serviceplanlogid = res.serviceplanlogid;
                if (Array.isArray(request.repeats)) {
                    request.repeats.map(repeat => {
                        app.models.Serviceplanlogrepeat.create({
                            serviceplanlogid: serviceplanlogid,
                            repeatdaytypekey: repeat.repeatdaytypekey,
                            insertedby: securityuserid,
                            updatedby: securityuserid,
                            updatedon: new Date().toLocaleString(),
                            insertedon: new Date().toLocaleString()
                        });
                    });
                }
                if (Array.isArray(request.exemptions)) {
                    request.exemptions.map(exempt => {
                        app.models.Serviceplanlogscheduleexemption.create({
                            serviceplanlogid: serviceplanlogid,
                            exemptiondate: exempt.exemptiondate,
                            insertedby: securityuserid,
                            updatedby: securityuserid,
                            updatedon: new Date().toLocaleString(),
                            insertedon: new Date().toLocaleString()
                        });
                    });
                }
                if (Array.isArray(request.occurences)) {
                    request.occurences.map(occur => {
                        app.models.Serviceplanlogoccurence.create({
                            serviceplanlogid: serviceplanlogid,
                            starttime: occur.starttime,
                            endtime: occur.endtime,
                            insertedby: securityuserid,
                            updatedby: securityuserid,
                            updatedon: new Date().toLocaleString(),
                            insertedon: new Date().toLocaleString()
                        });
                    });
                }
                return res;
            });
    };

    Serviceplan.remoteMethod('getReportServicePlan', {

        http: {
            path: '/getreportserviceplan',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'Object',
            http: {
                source: 'body'
            }
        },
        {
            arg: 'res',
            type: 'object',
            'http': {
                source: 'res'
            }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }

    ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    })

    Serviceplan.getReportServicePlan = (request, res) => {
            return pdf.servicePlanPDF(request, res);
    }

    Serviceplan.remoteMethod('serviceplanlog', {
        accepts: [{
            arg: 'id',
            type: 'string',
            required: true,
            http: { source: 'path' }
        }],
        http: { "verb": "get", "path": "/servicelog/:id" },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Serviceplan.serviceplanlog = (id) => {
        var sql = 'select * from serviceplanlog($1)';
        return util.executeDBQuery(sql, [id])
            .then(data => {
                if (data != null && data.length > 0) {
                    return data[0].servicelog;
                } else {
                    return null;
                }
            })
            .catch(err => util.logError(err));

    };

    Serviceplan.remoteMethod('servicelog', {
        http: {
            path: '/servicelog',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'string',
            root: true
        }
    });


    Serviceplan.getserviceloghistory = (data) => {
        var sql = 'select * from serviceplanlogHistory($1)';
        return util.executeSecondaryNodeDBQuery(sql, [data.where.objectid])
            .then(data2 => {
                if (data2 != null && data2.length > 0) {
                    return data2[0].servicelog;
                } else {
                    return null;
                }
            })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });

    };

    Serviceplan.remoteMethod('getserviceloghistory', {
        http: {
            path: '/getserviceloghistory',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'string',
            root: true
        }
    });





    Serviceplan.servicelog = data => {
        var sql = 'select * from serviceplanlog($1)';
        return util.executeDBQuery(sql, [data.serviceplanid])
            .then(data6 => {
                if ( data6?.length > 0){
                    return data6[0].servicelog;
                }else {
                    return null;
                }

            })
            .catch(err => util.logError(err));
    };
    Serviceplan.remoteMethod(
        'vendorsearch', {
            http: {
                path: '/vendorsearch',
                verb: 'post'
            },
            accepts: [{
                arg: 'data',
                type: 'Object',
                http: { source: 'body' }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );
    Serviceplan.vendorsearch = (request) => {
        var Totalcount = 0;
        const sql = 'Select * from serviceplanvendorsearch($1)';

        return util.executeDBQuery(sql, [JSON.stringify(request.where)])
            .then(data => {
                if (data != null && data.length > 0) {
                    Totalcount = data[0].totalcount;}
                var result;
                result = {
                    'data': data,
                    'count': Totalcount
                };
                return result;
            })
            .catch(err => util.logError(err));
    }

    Serviceplan.remoteMethod('getservicecaseplan', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });
    Serviceplan.getservicecaseplan = (request) => {
        const sql = 'select * from getservicecaseplan($1, $2, $3)';
        const params = [request.where.objectid, request.page, request.limit];

        return util.executeDBQuery(sql, params)
            .then(data => data[0].getservicecaseplan)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Serviceplan.remoteMethod(
        'agencysearch', {
            http: {
                path: '/agencysearch',
                verb: 'post'
            },
            accepts: [{
                arg: 'data',
                type: 'Object',
                http: { source: 'body' }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );
    Serviceplan.agencysearch = (request) => {
        var Totalcount = 0;
        const sql = 'Select * from serviceplanagencysearch($1)';

        return util.executeDBQuery(sql, [JSON.stringify(request.where)])
            .then(serviceplanagencysearchdata => {
                if (serviceplanagencysearchdata != null && serviceplanagencysearchdata.length > 0) {
                    Totalcount = serviceplanagencysearchdata[0].totalcount;}
                var result;
                result = {
                    'data': serviceplanagencysearchdata,
                    'count': Totalcount
                };
                return result;
            })
            .catch(err => util.logError(err));
    }


    Serviceplan.getserviceplandetails = (request) => {
        var intakeserviceid = request.where.intakeserviceid;

        var page = request.page;
        var limit = request.limit;

        var totalcount = 0;

        const sql = 'Select * from getserviceplandetails($1,$2,$3)';

        return util.executeDBQuery(sql, [intakeserviceid, page, limit])
            .then(data => {
                if (data !== null && data.length > 0) {
                    totalcount = data[0].totalcount;}

                var result;
                result = {
                    'data': data,
                    'count': totalcount
                };
                LOGGER.debug(result)
                return result;
            })
            .catch(err => util.logError(err));
    }
    Serviceplan.remoteMethod('getserviceplandetails', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/getserviceplandetails',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Serviceplan.remoteMethod('getAssessment', {
        http: {
            path: '/getAssessment',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Serviceplan.getAssessment = (request) => {

        const sql = `SELECT  a.insertedon,at.external_templateid,at.name,a.submissionid,(a.submissiondata :: json), coalesce(a.ischildsafe,false),a.assessmentstatustypekey,a.intakeservicerequestactorid from assessment a
        JOIN assessmenttemplate at on a.assessmenttemplateid = at.assessmenttemplateid and a.activeflag =1 and at.activeflag = 1
        where a.objectid = $1 and lower(at.name) = lower($2) and lower(a.assessmentstatustypekey)=lower($3)
        order by  a.insertedon desc  limit 1`;

        var result;

        return util.executeDBQuery(sql, [request.where.objectid,request.where.templatename,request.where.status])
            .then(data => {
                result = {
                    'data': data
                };
                return result;
            })
            .catch(err => util.logError(err));
    };


    Serviceplan.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });

    // Returns the value formatted as MM/DD/YYYY, or the original value when it
    // is empty/unparseable so existing validation still sees what was sent.
    function formatplandate(value) {
        if (value === undefined || value === null || value === '') {
            return value;
        }
        const parsed = moment(value instanceof Date ? value : String(value), dt_in_formats, true);
        return parsed.isValid() ? parsed.format(dt_format) : value;
    }

    Serviceplan.addupdate = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const insertedon = new Date().toLocaleString();

        if (request.serviceplanid === undefined || request.serviceplanid == null) {
            request.insertedby = (request && request.securityuserid?request.securityuserid:suserid);
            request.updatedby = (request && request.securityuserid?request.securityuserid:suserid);
            request.insertedon = insertedon;
            request.updatedon = insertedon;
            request.effectivedate = formatplandate(request.effectivedate)
            request.targetenddate = formatplandate(request.targetenddate)
            return Serviceplan.create(request);
        } else {
            request.updatedon = insertedon;
            request.updatedby = (request && request.securityuserid?request.securityuserid:suserid);
            return Serviceplan.updateserviceplan(request,suserid);
        }
    };

    Serviceplan.updateserviceplan = (request,suserid) => {

        return Serviceplan.updateAll({
            serviceplanid: request.serviceplanid

        }, {
            serviceplanid: request.serviceplanid,
            effectivedate: formatplandate(request.effectivedate),
            targetenddate:  formatplandate(request.targetenddate),
            serviceplanname: request.serviceplanname,
            enddate: request.enddate,
            numberofdays: request.numberofdays,
            objectid: request.objectid,
            status: request.status,
            activeflag: request.activeflag,
            updatedby: (request && request.securityuserid?request.securityuserid:suserid),
            involvedpersons: request.involvedpersons,
            updatedon: new Date().toLocaleString()
        }).then(data => {
            return data;
        })
    };

    Serviceplan.listByAllRelation = function(request) {
        return app.models.Servicecase.count({ servicecaseid: request.where.caseid })
            .then(data => {
                var caseidarr = [];
                caseidarr.push(request.where.caseid);
                return Serviceplan.sclistByAllRelation(caseidarr);
            }).catch(err => util.logError(err));
    }

    Serviceplan.sclistByAllRelation = function(caseid) {
        return Serviceplan.find({
            nolimit: true,
            where: { 
                objectid: { inq: caseid } },
            // order: 'insertedon desc',
            order: 'effectivedate desc',
            include: {
                relation: 'splangoal',
                scope: {
                    nolimit:true,
                    fields: ['splangoalid',
                        'goalname',
                        'approvalstatustypekey',
                        'serviceplanid',
                        'activeflag',
                        'autoflag',
                        'status'
                    ],
                    include: [{
                        relation: 'splanobjective',
                        scope: {
                            nolimit:true,
                            order: 'insertedon desc',
                            fields: [
                                'splanobjectiveid',
                                'splangoalid',
                                'objectivename',
                                'needs',
                                'strengths',
                                'approvalstatustypekey',
                                'comments',
                                'activeflag',
                                'autoflag',
                                'status'
                            ],

                            include: [{
                                relation: 'serviceplanaction',
                                scope: {
                                    nolimit:true,
                                    order: 'insertedon asc',
                                    fields: [
                                        'serviceplanactionid',
                                        'splanobjectiveid',
                                        'serviceplanactionname',
                                        'personresponsible',
                                        'startdate',
                                        'enddate',
                                        'status',
                                        'approvalstatustypekey',
                                        'serviceplanoutcome',
                                        'plantype',
                                        'planfor',
                                        'comments',
                                        'goalreason',
                                        'insertedby',
                                        'insertedon',
                                        'updatedby',
                                        'updatedon',
                                        'activeflag',
                                        'autoflag'
                                    ],
                                    include: [{
                                        relation: 'serviceplanpersoninvolved',
                                        scope: {
                                            nolimit:true,
                                            fields: [
                                                'serviceplanpersoninvolvedid',
                                                'serviceplanactionid',
                                                'personinvolved',
                                                'activeflag'
                                            ],
                                            include: [{
                                                relation: 'person',
                                                scope: {
                                                    fields: [
                                                        'prefx',
                                                        'firstname',
                                                        'middlename',
                                                        'lastname',
                                                        'suffix',
                                                        'activeflag'
                                                    ]
                                                }
                                            }]
                                        }
                                    }]
                                }

                            }]
                        }
                    }]
                }
            }
        }).then(resp => {
            if (resp && resp.length > 0) {
                resp.forEach((e) => {
                    e.insertedon = moment(e.insertedon).format('MM/DD/YYYY HH:mm:ss');
                    e.updatedon = moment(e.updatedon).format('MM/DD/YYYY HH:mm:ss');
                });
            }
            return resp;
        }).catch(err => util.logError(err));
    }

    Serviceplan.isrlistByAllRelation = function(caseid) {
        return Serviceplan.find({
            where: { objectid: { inq: caseid } },
            order: 'insertedon desc',
            include: {
                relation: 'serviceplanfocus',
                scope: {
                    nolimit:true,
                    fields: ['serviceplanfocusid',
                        'focusname',
                        'approvalstatustypekey',
                        'serviceplanid',
                        'activeflag'
                    ],
                    include: [{
                            relation: 'serviceplanaction',
                            scope: {
                                nolimit:true,
                                fields: [
                                    'serviceplanactionid',
                                    'serviceplanfocusid',
                                    'serviceplanactionname',
                                    'personresponsible',
                                    'startdate',
                                    'enddate',
                                    'status',
                                    'approvalstatustypekey',
                                    'plantype',
                                    'planfor',
                                    'goalreason',
                                    'insertedby',
                                    'insertedon',
                                    'updatedby',
                                    'updatedon',
                                    'activeflag'
                                ],
                                include: [{
                                        relation: 'serviceplanoutcome',
                                        scope: {
                                            nolimit:true,
                                            fields: [
                                                'serviceplanoutcomeid',
                                                'serviceplanactionid',
                                                'serviceplanoutcomename',
                                                'actualserviceplanoutcomename',
                                                'activeflag'
                                            ]
                                        }
                                    },
                                    {
                                        relation: 'serviceplanpersoninvolved',
                                        scope: {
                                            nolimit:true,
                                            fields: [
                                                'serviceplanpersoninvolvedid',
                                                'serviceplanactionid',
                                                'personinvolved',
                                                'activeflag'
                                            ]
                                        }
                                    }
                                ]
                            }
                        },
                        {
                            relation: 'serviceplanneed',
                            scope: {
                                nolimit:true,
                                fields: [
                                    'serviceplanfocusid',
                                    'serviceplanneedname',
                                    'activeflag'
                                ]
                            }
                        },
                        {
                            relation: 'serviceplanstrength',
                            scope: {
                                nolimit:true,
                                fields: [
                                    'serviceplanfocusid',
                                    'serviceplanstrengthname',
                                    'activeflag'
                                ]
                            }
                        }
                    ]
                }
            }
        }).then(resp => {
            return resp;
        }).catch(err => util.logError(err));
    }
    Serviceplan.servicecaselistByAllRelation = function(caseid) {
        return app.models.Intakeservicerequest.find({
            where: { servicecaseid: caseid },
            fields: ['intakeserviceid']
        }).then(resp => {
            var result = JSON.parse(JSON.stringify(resp));
            const caseidarr = result.map(x => x.intakeserviceid).reduce((a, b) => a.concat(b), []);
            caseidarr.push(caseid);
            return Serviceplan.isrlistByAllRelation(caseidarr);
        }).catch(err => util.logError(err));
    };



    Serviceplan.ebpplandetails = (request,reqctx) => {

        const caseid = request.where.caseid ;

        const caseType = request.where.casetype ;

        var sql = ' select * from ebpservicelogdetails($1, $2) ';

        
        return util.executeSecondaryNodeDBQuery(sql,[caseid, caseType])
            .then(data => data?.[0]?.servicelog ?? [])
            .catch(err=>{
                LOGGER.error('>>>>ERROR:', err);
            });
    }


    Serviceplan.remoteMethod('listByAllRelation', {
        http: {
            path: '/listbyallrelation',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplan.remoteMethod('ebpplandetails', {
        http: {
            path: '/ebpplandetails',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplan.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: { source: 'query' }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Serviceplan.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var serviceplanid = request.where.serviceplanid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from serviceplan where serviceplanid=$1 limit $2 offset $3';

        return util.executeSecondaryNodeDBQuery(sql, [serviceplanid, request.limit, request.skip])
            .then(data => {
                    if (data !== null && data.length > 0) {
                        totalcount = data[0].totalcount;}
                    var result;
                    result = {
                        'data': data,
                        'count': totalcount
                    };
                    return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Serviceplan.saveAssessmentStrengthNeeds = (request,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        const intakeserviceid = request.objectid;
        const assessmenttype = request.templatename;
        var sql = `SELECT  a.insertedon,at.external_templateid,at.name,a.submissionid,(a.submissiondata :: json),coalesce(a.ischildsafe,false),a.assessmentstatustypekey,a.intakeservicerequestactorid from assessment a JOIN assessmenttemplate at 
        on a.assessmenttemplateid = at.assessmenttemplateid and  a.activeflag =1 and at.activeflag = 1 
        where (a.objectid  = $1 or a.servicecaseid  = $1) and lower(at.name)=  lower($2) and lower(a.assessmentstatustypekey)=lower($3)
        order by  a.insertedon desc  limit 1`;
        var needsdata;
        var strengthsdata;

        return util.executeDBQuery(sql, [intakeserviceid,assessmenttype,request.status])
            .then(data => {
                if (data && data.length) {
                    LOGGER.debug('### --> ', data);
                    const assessmentData = data[0].submissiondata;
                    if (assessmenttype === 'cansF') {
                        needsdata = getNeedsData(StrengthAndNeedsList, assessmentData);
                        strengthsdata = getStrengthData(StrengthAndNeedsList, assessmentData);

                        const needsrequest = {}
                        needsrequest['intakeserviceid'] = intakeserviceid;
                        needsrequest['assessmenttype'] = assessmenttype;
                        needsrequest['serviceplanneeds'] = needsdata;
                        app.models.Serviceplanneed.addneeds(needsrequest,suserid);

                        const strengthsrequest = {}
                        strengthsrequest['intakeserviceid'] = intakeserviceid;
                        strengthsrequest['assessmenttype'] = assessmenttype;
                        strengthsrequest['serviceplanstrengths'] = strengthsdata;
                        app.models.Serviceplanstrength.addstrengths(strengthsrequest,suserid);

                    } else {
                        needsdata = getNeedsData2(StrengthAndNeedsList, assessmentData);

                        strengthsdata = getStrengthData2(StrengthAndNeedsList, assessmentData);

                        const needsrequest = {}
                        needsrequest['intakeserviceid'] = intakeserviceid;
                        needsrequest['assessmenttype'] = assessmenttype;
                        needsrequest['serviceplanneeds'] = needsdata;
                        app.models.Serviceplanneed.addneeds(needsrequest,suserid);

                        const strengthsrequest = {}
                        strengthsrequest['intakeserviceid'] = intakeserviceid;
                        strengthsrequest['assessmenttype'] = assessmenttype;
                        strengthsrequest['serviceplanstrengths'] = strengthsdata;
                        app.models.Serviceplanstrength.addstrengths(strengthsrequest,suserid);
                    }
                }

                return strengthsdata;
            })
            .catch(err => util.logError(err));
    };

    function getStrengthData2(StrengthAndNeedsList1, assessmentData){
        return StrengthAndNeedsList1.filter(sn => {
            if (assessmentData.childform[sn.key] === true ||
                assessmentData.traumaform[sn.key] === true ||
                assessmentData.faceLifeForm[sn.key] === true ||
                assessmentData.cultureFactorForm[sn.key] === true ||
                assessmentData.permanencyPlanform[sn.key] === true 
                ) {
                LOGGER.debug("Found strngth", sn);

                return sn;
            }
            //caregiver array
            if (assessmentData.careGiver) {
                let flag = false;
                assessmentData.careGiver.forEach(element => {
                    if (element[sn.key] === true) {
                        flag = true;
                    }
                });
                if (flag) {
                    return sn;
                }
            }
        }).map(x => {
            const strength = {};
            strength['strengthname'] = x.value;
            strength['strengthsection'] = x.section;
            return strength;
        });
    }

    function getStrengthData(StrengthAndNeedsList2, assessmentData){
        return StrengthAndNeedsList2.filter(sn => {
            if (assessmentData.familyAssessmentYouth[sn.key] === true || assessmentData.familyCultureYouth[sn.key] === true) {
                return sn;
            }
            let flag = false;
            flag = checkCaregiverStrengths(assessmentData, sn);
            if (flag) {
                return sn;
            }
            if (assessmentData.child) {
                let flag2 = false;
                assessmentData.child.forEach(element => {
                    if (element[sn.key] === true) {
                        flag2 = true;
                    }
                });
                if (flag2) {
                    return sn;
                }
            }
        }).map(y => {
            const strength = {};
            strength['strengthname'] = y.value;
            strength['strengthsection'] = y.section;
            return strength;
        });
    }

    function checkCaregiverStrengths(assessmentData, sn){
        let flag = false;
        if (assessmentData.careGiver) {
            assessmentData.careGiver.forEach(element3 => {
                if (element3[sn.key] === true) {
                    flag = true;
                }
            });
        }
        return flag;
    }

    function getNeedsData2(StrengthAndNeedsList3, assessmentData){
        return StrengthAndNeedsList3.filter(sn => {
            //all objects
            if (assessmentData.childform[sn.key] === '2' || assessmentData.childform[sn.key] === '3' ||
                assessmentData.traumaform[sn.key] === '2' || assessmentData.traumaform[sn.key] === '3' ||
                assessmentData.faceLifeForm[sn.key] === '2' || assessmentData.faceLifeForm[sn.key] === '3' ||
                assessmentData.cultureFactorForm[sn.key] === '2' || assessmentData.cultureFactorForm[sn.key] === '3' ||
                assessmentData.caregiverstrengthform[sn.key] === '2' || assessmentData.caregiverstrengthform[sn.key] === '3' ||
                assessmentData.permanencyPlanform[sn.key] === '2' || assessmentData.permanencyPlanform[sn.key] === '3') {
                return sn;
            }
            //caregiver array
            if (assessmentData.careGiver) {
                let flag = false;
                assessmentData.careGiver.forEach(element => {
                    if (element[sn.key] === '2' || element[sn.key] === '3') {
                        flag = true;
                    }
                });
                if (flag) {
                    return sn;
                }
            }
        }).map(x => {
            const need = {};
            need['needname'] = x.value;
            need['needvalue'] = assessmentData[x.key];
            need['needsection'] = x.section;
            return need;
        });
    }

    function getNeedsData(StrengthAndNeedsList4, assessmentData){
        return StrengthAndNeedsList4.filter(sn => {
            if (assessmentData.familyAssessmentYouth[sn.key] === '2' || assessmentData.familyAssessmentYouth[sn.key] === '3' ||
                assessmentData.familyCultureYouth[sn.key] === '2' || assessmentData.familyCultureYouth[sn.key] === '3') {
                return sn;
            }
            let flag = false;
            flag = checkCaregiver(assessmentData, sn);
            if (flag) {
                return sn;
            }
            if (assessmentData.child) {
                let flag1 = false;
                assessmentData.child.forEach(element1 => {
                    if (element1[sn.key] === '2' || element1[sn.key] === '3') {
                        flag1 = true;
                    }
                });
                if (flag1) {
                    return sn;
                }
            }
        }).map(z => {
            const need = {};
            need['needname'] = z.value;
            need['needvalue'] = assessmentData[z.key];
            need['needsection'] = z.section;
            return need;
        });
    }

    function checkCaregiver(assessmentData, sn){
        let flag = false;
        if (assessmentData.careGiver) {
            assessmentData.careGiver.forEach(element2 => {
                if (element2[sn.key] === '2' || element2[sn.key] === '3') {
                    flag = true;
                }
            });
        }
        return flag;
    }

    Serviceplan.remoteMethod('saveAssessmentStrengthNeeds', {
        http: {
            path: '/saveAssessmentStrengthNeeds',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Serviceplan.servicePlanRouting = function(request) {
        var userid = request.fromsecurityusersid;
        var applicantId = request.objectid;
        var toUserID = request.tosecurityusersid;
        var eventcode = request.eventcode;
        var serviceNumber = request.serviceNumber;
        var serviceplanid = request.serviceplanid;
        var status = 15;
        var nofitymsg = 'Service plan Submitted for review';
        LOGGER.debug(nofitymsg);
        if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() === "return") {
            status = 17;
            nofitymsg = 'Service plan  Return ';
        } else if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() === "approved") {
            status = 16;
            nofitymsg = 'Service plan  Approved ';
        }
        LOGGER.debug(nofitymsg);

        if (!applicantId) {
            applicantId = '';
        }

        if (!toUserID) {
            toUserID = '';
        }

        if (!eventcode) {
            eventcode = '';
        }

        if (!serviceNumber) {
            serviceNumber = 0;
        }

        if (!serviceplanid) {
            serviceplanid = '';
        }

        var sql = 'select * from publicserviceplanrouting($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)';
        LOGGER.debug(sql);
        LOGGER.debug(applicantId, userid, toUserID, status, eventcode, nofitymsg, serviceNumber, serviceplanid, request.approvalstatustypekey.toLowerCase());
        return util.executeDBQuery(sql, [applicantId, userid, toUserID, status, eventcode, nofitymsg, nofitymsg,
                                   serviceNumber, serviceplanid, request.approvalstatustypekey.toLowerCase()])
            .then(data => ({
                data: data
            }))
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Serviceplan.remoteMethod(
        'servicePlanRouting', {
            http: {
                path: '/serviceplanrouting',
                verb: 'post'
            },
            accepts: {
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body'
                }
            },
            returns: {
                type: 'object',
                root: true
            }
        }
    );

}