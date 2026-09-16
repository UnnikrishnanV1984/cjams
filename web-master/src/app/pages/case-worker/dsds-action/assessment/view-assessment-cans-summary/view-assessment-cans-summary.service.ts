import { Injectable } from '@angular/core';
import { CountAttributes } from './ViewAssessmentCansSummary.model';
import _ from 'lodash';

@Injectable()
export class ViewAssessmentCansSummaryService {

  ratings: any[] = ['0','1','2','3'];

  // Status for Service Intensity Need Level
  serviceLevelStatus: any = {
    severe: 'Severe',
    significant: 'Significant',
    mwr: 'Moderate with Risk',
    mwor: 'Moderate without Risk',
    low: 'Low'
  };

  // CHILD BEHAVIORAL / EMOTIONAL HEALTH
  ben_criterion: any[] = ['psychosis_rating','impulse_rating','mood_rating','anxiety_rating','opposition_rating','conduct_rating','substanceabuse_rating','eating_rating','angermang_rating','attchment_rating','adjtrauma_rating'];
  // CHILD RISK BEHAVIORS
  risk_criterion: any[] = ["suicide_rating","selfinjury_rating","reckless_rating","dangertoother_rating","sexaggress_rating","sexreact_rating","runaway_rating","deliquent_rating","fire_rating","intentional_rating","bullying_rating","exploited_rating"];
  // LIFE DOMAIN FUNCTIONING
  ldf_criterion: any[] = ["family_rating","livingsitu_rating","socialpeer_rating","socialadult_rating","medphy_rating","juvenilejustice_rating","enuresis_rating","sleeping_rating","iq_rating","autism_rating","recreation_rating","legal_rating","judgement_rating","sexual_rating","jobfun_rating","schoolatd_rating","schoolacheive_rating","schoolbehave_rating"];
  // CHILD AND ENVIRONMENT STRENGTHS
  useful_strength: any[] = [
    {
      key: 'familyenv_rating',
      value: 'Family Environment'
    },{
      key: 'eduenv_rating',
      value: 'Educational Environment'
    },{
      key: 'religious_rating',
      value: 'Spiritual / Religious'
    },{
      key: 'community_rating',
      value: 'Community Life'
    },{
      key: 'relperformance_rating',
      value: 'Relationship Permanence'
    },{
      key: 'natural_rating',
      value: 'Natural Supports (i.e., unpaid)'
    },{
      key: 'interperson_rating',
      value: 'Interpersonal Skills - Peer'
    },{
      key: 'interpersonnoncare_rating',
      value: 'Interpersonal Skills - Non- caregiver Adult'
    },{
      key: 'optimism_rating',
      value: 'Optimism'
    },{
      key: 'talent_rating',
      value: 'Talent / Interests'
    },{
      key: 'culture_rating',
      value: 'Cultural Identity'
    },{
      key: 'careplanning_rating',
      value: 'Youth Involvement w/ Care Planning'
    },{
      key: 'resiliency_rating',
      value: 'Resiliency (History)'
    },{
      key: 'vocational_rating',
      value: 'Vocational Preferences & Skills'
    },{
      key: 'resourcefulness_rating',
      value: 'Resourcefulness (History)'
    }
  ];
  useful_strength_rating: any = {
    '0': 'cotp',
    '1': 'suitp',
    '2': 'csd',
    '3': 'nscb'
  }
  // TRAUMA EXPERIENCES (OVER LIFETIME)
  trauma_experiences: any[] = [
    {
      key: 'sexsbuse_rating',
      value: 'Sexual Abuse'
    },{
      key: 'phyabuse_rating',
      value: 'Physical Abuse'
    },{
      key: 'emotionalabuse_rating',
      value: 'Emotional Abuse'
    },{
      key: 'neglect_rating',
      value: 'Neglect'
    },{
      key: 'medicaltrauma_rating',
      value: 'Medical Trauma'
    },{
      key: 'familywitness_rating',
      value: 'Witness to Family Violence'
    },{
      key: 'communityvoilance_rating',
      value: 'Community Violence'
    },{
      key: 'schoolvoilance_rating',
      value: 'School Violence'
    },{
      key: 'naturaldisaster_rating',
      value: 'Natural / Man-made Disasters'
    },{
      key: 'waraffected_rating',
      value: 'War Affected'
    },{
      key: 'terroraffected_rating',
      value: 'Terrorism Affected'
    },{
      key: 'criminalactivity_rating',
      value: 'Witness / Victim to Criminal Activity'
    },{
      key: 'disruptions_rating',
      value: 'Disruptions in Caregiving / Attachment Losses'
    }
  ];
  trauma_experiences_rating: any = {
    '1': 'teol'
  };
  // PERMANENCY PLAN 1 and PERMANENCY PLAN 2
  permanency_plan: any[] = [
    {
      key: "supervision_rating",
      value: "Supervision - PP1"
    },
    {
      key: 'involvement_rating',
      value: 'Involvement with Care - PP1'
    },
    {
      key: 'knowledge_rating',
      value: 'Knowledge - PP1'
    },
    {
      key: 'organization_rating',
      value: 'Organization - PP1'
    },
    {
      key: 'resource_rating',
      value: 'Resources - PP1'
    },
    {
      key: 'difficulties_rating',
      value: 'Attachment Difficulties - PP1'
    },
    {
      key: 'assebilitycare_rating',
      value: 'Accessibility to Child Care Services - PP1'
    },
    {
      key: 'stablity_rating',
      value: 'Residential Stability - PP1'
    },
    {
      key: 'familystress_rating',
      value: 'Family Stress - PP1'
    },
    {
      key:'safety_rating',
      value: 'Safety - PP1'
    },
    {
      key: 'phyhealth_rating',
      value: 'Physical Health - PP1'
    },
    {
      key: 'mentalhealth_rating',
      value: 'Mental Health - PP1'
    },
    {
      key: 'substanceuse_rating',
      value: 'Substance Use - PP1'
    },
    {
      key: 'developmental_rating',
      value: 'Developmental - PP1'
    },
    {
      key: 'marital_rating',
      value: 'Marital / Partner Conflict - PP1'
    },
    {
      key: 'traumatic_rating',
      value: 'Post traumatic Reactions - PP1'
    },
    {
      key: 'criminal_rating',
      value: 'Caregiver Criminal Behavior - PP1'
    },
    {
      key: 'supervision_ratingII',
      value: 'Supervision - PP2'
    },
    {
      key: 'involvement_ratingII',
      value: 'Involvement with Care - PP2'
    },
    {
      key: 'knowledge_ratingII',
      value: 'Knowledge - PP2'
    },
    {
      key: 'organization_ratingII',
      value: 'Organization - PP2'
    },
    {
      key: 'resource_ratingII',
      value: 'Resources - PP2'
    },
    {
      key: 'difficulties_ratingII',
      value: 'Attachment Difficulties - PP2'
    },
    {
      value: 'Accessibility to Child Care Services - PP2',
      key: 'assebilitycare_ratingII'
    },
    {
      value: 'Residential Stability - PP2',
      key: 'stablity_ratingII'
    },
    {
      value: 'Family Stress - PP2',
      key: 'familystress_ratingII'
    },
    {
      value: 'Safety - PP2',
      key: 'safety_ratingII'
    },
    {
      value: 'Physical Health - PP2',
      key: 'phyhealth_ratingII'
    },
    {
      value: 'Mental Health - PP2',
      key: 'mentalhealth_ratingII'
    },
    {
      value: 'Substance Use - PP2',
      key: 'substanceuse_ratingII'
    },
    {
      value: 'Developmental - PP2',
      key: 'developmental_ratingII'
    },
    {
      value: 'Marital / Partner Conflict - PP2',
      key: 'marital_ratingII'
    },
    {
      value: 'Post traumatic Reactions - PP2',
      key: 'traumatic_ratingII'
    },
    {
      value: 'Caregiver Criminal Behavior - PP2',
      key: 'criminal_ratingII'
    }
  ];
  permanency_plan_rating: any = {
    // '0': 'pp0',
    // '1': 'pp1',
    '2': 'pp2',
    '3': 'pp3'
  };
  // CURRENT CAREGIVER NEEDS AND STRENGTHS
  current_caregiver_needs_and_strength: any[] = [
    { value: 'Supervision - CCG', key: 'supervision_rating' },
    { value: 'Involvement with Care - CCG', key: 'involvement_rating' },
    { value: 'Knowledge - CCG', key: 'knowledge_rating' },
    { value: 'Organization - CCG', key: 'organization_rating' },
    { value: 'Resources - CCG', key: 'resource_rating' },
    { value: 'Attachment Difficulties - CCG', key: 'difficulties_rating' },
    { value: 'Accessibility to Child Care Services - CCG', key: 'assessablity_rating' },
    { value: 'Residential Stability - CCG', key: 'stability_rating' },
    { value: 'Family Stress - CCG', key: 'familystress_rating' },
    { value: 'Safety - CCG', key: 'safety_rating' },
    { value: 'Physical Health - CCG', key: 'phyhealth_rating' },
    { value: 'Mental Health - CCG', key: 'mentalhealth_rating' },
    { value: 'Substance Use - CCG', key: 'substanceuse_rating' },
    { value: 'Developmental - CCG', key: 'developmental_rating' },
    { value: 'Marital / Partner Conflict - CCG', key: 'marital_rating' },
    { value: 'Post traumatic Reactions - CCG', key: 'posttraumatic_rating' },
    { value: 'Caregiver Criminal Behavior - CCG', key: 'criminalbehav_rating' }
  ];
  current_caregiver_needs_and_strength_rating: any = {
    // '0': 'cg0',
    // '1': 'cg1',
    '2': 'cg2',
    '3': 'cg3'
  };
  // TRAUMA STRESS SYMPTOMS
  trauma_stress: any[] = [
    {
      key: 'traumagrief_rating',
      value: 'Traumatic Grief / Separation'
    },
    {
      key: 'reexperiancing_rating',
      value: 'Re-experiencing'
    },
    {
      key: 'avoidance_rating',
      value: 'Avoidance'
    },
    {
      key: 'numbering_rating',
      value: 'Numbing'
    },
    {
      key: 'dysregulation_rating',
      value: 'Affect Dysregulation'
    },
    {
      value: 'Dissociation',
      key: 'dissociation_rating'
    }, 
  ];
  // CULTURAL FACTORS
  culture_factors: any[] = [
    // cultureFactorForm
    {
      value: 'Language',
      key: 'language_rating'
    },
    {
      value: 'Ritual',
      key: 'ritual_rating'
    },
    {
      value: 'Gender / Sexual Identity',
      key: 'genderidentity_rating'
    },
    {
      value: 'Culture Stress',
      key: 'culturestress_rating'
    }
  ];
  // LIFE DOMAIN FUNCTIONING
  life_domain_functions: any[] = [
    {
      value: 'Family',
      key: 'family_rating'
    },
    {
      value: 'Living Situation',
      key: 'livingsitu_rating'
    },
    {
      value: 'Social Functioning-Peer',
      key: 'socialpeer_rating'
    },
    {
      value: 'Social Functioning-Adult',
      key: 'socialadult_rating'
    },
    {
      value: 'Medical / Physical',
      key: 'medphy_rating'
    },
    {
      value: 'Juvenile Justice',
      key: 'juvenilejustice_rating'
    },
    {
      value: 'Enuresis / Encopresis',
      key: 'enuresis_rating'
    },
    {
      value: 'Sleeping',
      key: 'sleeping_rating'
    },
    {
      value: 'Intellectual (IQ only)',
      key: 'iq_rating'
    },
    {
      value: 'Autism Spectrum / PPD',
      key: 'autism_rating'
    },
    {
      value: 'Recreational',
      key: 'recreation_rating'
    },
    {
      value: 'Legal (DJS/criminal court)',
      key: 'legal_rating'
    },
    {
      value: 'Judgement / Decision Making',
      key: 'judgement_rating'
    },
    {
      value: 'Sexual Development',
      key: 'sexual_rating'
    },
    {
      value: 'Job Functioning',
      key: 'jobfun_rating'
    },
    {
      value: 'School Attendance',
      key: 'schoolatd_rating'
    },
    {
      value: 'School Achievement',
      key: 'schoolacheive_rating'
    },
    {
      value: 'School Behavior',
      key: 'schoolbehave_rating'
    }
  ];
  
  // CHILD RISK BEHAVIORS and CHILD BEHAVIORAL / EMOTIONAL HEALTH
  child_risk_behaviors: any[] = [
    {
      value: 'Suicide Risk',
      key: 'suicide_rating'
    },
    {
      value: 'Self-Injurious Behaviors',
      key: 'selfinjury_rating'
    },
    {
      value: 'Reckless Behaviors',
      key: 'reckless_rating'
    },
    {
      value: 'Danger to Others',
      key: 'dangertoother_rating'
    },
    {
      value: 'Sexual Aggression',
      key: 'sexaggress_rating'
    },
    {
      value: 'Sexually Reactive Behaviors',
      key: 'sexreact_rating'
    },
    {
      value: 'Runaway',
      key: 'runaway_rating'
    },
    {
      value: 'Delinquent Behavior',
      key: 'deliquent_rating'
    },
    {
      value: 'Fire-Setting',
      key: 'fire_rating'
    },
    {
      value: 'Intentional Misbehavior',
      key: 'intentional_rating'
    },
    {
      value: 'Bullying',
      key: 'bullying_rating'
    },
    {
      value: 'Exploited',
      key: 'exploited_rating'
    }, 
    {value: 'Psychosis',key: 'psychosis_rating'},
    {value: 'Attention Deficit / Impulse Control',key: 'impulse_rating'},
    {value: 'Depression / Mood Disorder',key: 'mood_rating'},
    {value: 'Anxiety',key: 'anxiety_rating'},
    {value: 'Oppositional Behavior',key: 'opposition_rating'},
    {value: 'Conduct / Antisocial Behavior',key: 'conduct_rating'},
    {value: 'Substance Abuse',key: 'substanceabuse_rating'},
    {value: 'Eating Disturbance',key: 'eating_rating'},
    {value: 'Anger Control',key: 'angermang_rating'},
    {value: 'Attachment Difficulties',key: 'attchment_rating'},
    {value: 'Adjustment to Trauma',key: 'adjtrauma_rating'}
  ];

  trauma_stress_rating: any = {
    '2': 'tss2',
    '3': 'tss3'
  };
  // EMERGING ADULT DOMAIN
  emergin_adult: any[] = [
    {value: 'Literacy/Reading Comprehension', key: 'literacyiv_rating'},
    {value: 'Service Learning Requirements', key: 'servlearningiv_rating'},
    {value: 'Educational Attainment', key: 'attainmentiv_rating'},
    {value: 'Access to Financial Aid/Education and Training Voucher(ETV)', key: 'etviv_rating'},
    {value: 'Post-Secondary Education', key: 'posteduiv_rating'},
    {value: 'Employment Optimism', key: 'optimismiv_rating'},
    {value: 'Volunteer /Internship Experience', key: 'internshipiv_rating'},
    {value: 'Work Experience', key: 'workexpiv_rating'},
    {value: 'Training/Certification', key: 'trainingiv_rating'},
    {value: 'Knowledge of Health/Mental Health Needs', key: 'healthneedsv_rating'},
    {value: 'Treatment Complexity', key: 'treatcomplexv_rating'},
    {value: 'Medication Adherence', key: 'medicationv_rating'},
    {value: 'Access to Adult Services', key: 'adultservicev_rating'},
    {value: 'Civic Engagement', key: 'civicengv_rating'},
    {value: 'Self Care', key: 'selfcarevi_rating'},
    {value: 'Placement Stability', key: 'stabilityvi_rating'},
    {value: 'Independent Living Skills', key: 'livingskillsvi_rating'},
    {value: 'Consumer Functioning', key: 'consumervii_rating'},
    {value: 'Budgeting', key: 'budgetingvii_rating'},
    {value: 'Vital Records', key: 'vitalvii_rating'},
    {value: 'Resource Identification', key: 'resourceidentivii_rating'},
    {value: 'Social Support/Peer Connections', key: 'socialpeerviii_rating'},
    {value: 'Intimate Relationships', key: 'intimateviii_rating'},
    {value: 'Relationship Permanence', key: 'permenanceviii_rating'}
  ]
  emergin_adult_rating: any = {
    '2': 'ead2',
    '3': 'ead3'
  };

    // This function is used to calculate 3's and 2's of ben,risk,ldf ratings
  countFn=(arr: any[],data: any,val1:string,val2:string) => {
    const count_rating_2 = arr.filter(x => data[x] === val1).length;
    const count_rating_3 = arr.filter(x => data[x] === val2).length;
    return {count_rating_2,count_rating_3}
  }

  
  // This function is used to calculate 0,1,2,3 and get the key name
  displayNameOnselectedOptionFn=(arr: any[],data: any,rating_status: any,initialData: object) => {
    let category: string = '';
      return arr?.reduce((accumulator, item) => {
        category = '';
        if(data){
        if (this.ratings.indexOf(data[item.key]) === 0){
          category = rating_status['0'];
        } else if (this.ratings.indexOf(data[item.key]) === 1){
          category = rating_status['1'];
        } else if (this.ratings.indexOf(data[item.key]) === 2){
          category = rating_status['2'];
        } else if (this.ratings.indexOf(data[item.key]) === 3){
          category = rating_status['3'];
        }
      }
        if (!_.isNil(category) && !accumulator[category]) {
          accumulator[category] = []
        }
        if(category) {
          accumulator[category].push(item.value);
        }
        return accumulator
      }, initialData);
  }
  
  removeDuplicates = (result: any[]) => {
    return result.reduce((accumulator, currentValue) => {
      if (!accumulator.includes(currentValue)) {
        accumulator.push(currentValue);
      }
      return accumulator;
    }, [])
  }
  // Care giver data re-arrangement
  cgFormatter (arr: any[],data: any[],rating_status:object,row2grid3:any) {
    const careGiverResult: any = row2grid3;
    data?.forEach((element,i) => {
      const cgData = this.displayNameOnselectedOptionFn(arr,element,rating_status,{cg2: [],cg3: []});
      careGiverResult.pp2 = this.removeDuplicates([...careGiverResult.pp2,...cgData.cg2]);
      careGiverResult.pp3 = this.removeDuplicates([...careGiverResult.pp3,...cgData.cg3]);
    });

    return careGiverResult;
  }

  // This function is used to check the conditions according to the ratings calculated to get serviceLevelOutput to display
  ben_risk_ldf_criterion_rating = (ldf_data: CountAttributes,risk_data: CountAttributes,ben_data: CountAttributes,psychosis: number) => {

    // Severe
    if(this.isSevere(ldf_data,risk_data,ben_data,psychosis)) {
      return this.serviceLevelStatus.severe;
    }
    // Significant
    if(this.isSignificant(ldf_data,risk_data,ben_data,psychosis)) {
      return this.serviceLevelStatus.significant;
    }
    
    //Moderate with Risk and Moderate without Risk
    if((ldf_data?.count_rating_3 + ldf_data?.count_rating_2) >= 2) {
      if(risk_data?.count_rating_3 >= 1 || (risk_data?.count_rating_3 + risk_data?.count_rating_2) >= 2) {
        if(ben_data?.count_rating_3 >= 1 || psychosis === 2 || (ben_data?.count_rating_3 + ben_data?.count_rating_2) >= 2) {
          return this.serviceLevelStatus.mwr;
        }
      } else if(risk_data?.count_rating_2 === 1) {
        if(ben_data?.count_rating_3 >= 1 || psychosis === 2 || (ben_data?.count_rating_3 + ben_data?.count_rating_2) >= 2) {
          return this.serviceLevelStatus.mwor;
        }
      } 
    }
  }
  // Assosiated with ben_risk_ldf_criterion_rating method
  isSevere(ldf_data: CountAttributes,risk_data: CountAttributes,ben_data: CountAttributes,psychosis: number) {
    if(ldf_data?.count_rating_3 >= 3 || (ldf_data?.count_rating_3 + ldf_data?.count_rating_2) >= 5) {
      if(risk_data?.count_rating_3 >= 3 || (risk_data?.count_rating_3 + risk_data?.count_rating_2) >= 4) {
        if(ben_data?.count_rating_3 >= 3 || psychosis === 1 || (ben_data?.count_rating_3 + ben_data?.count_rating_2) >= 4) {
          return true;
        }
      }
    }
  }
  // Assosiated with ben_risk_ldf_criterion_rating method
  isSignificant(ldf_data: CountAttributes,risk_data: CountAttributes,ben_data: CountAttributes,psychosis: number) {
    if(ldf_data?.count_rating_3 >= 3 || (ldf_data?.count_rating_3 + ldf_data?.count_rating_2) >= 4) {
      if(risk_data?.count_rating_3 >= 2 || (risk_data?.count_rating_3 + risk_data?.count_rating_2) >= 3) {
        if(ben_data?.count_rating_3 >= 2 || psychosis === 1 || (ben_data?.count_rating_3 + ben_data?.count_rating_2) >= 3) {
          return true;
        }
      }
    }
  }
}