import { Component, Injector, Input } from '@angular/core';
import { BehaviorSubject } from 'rxjs';
import { CommonHttpService, DataStoreService } from '../../../../../@core/services';
import { ViewAssessmentCansSummaryService } from './view-assessment-cans-summary.service';
import { CaseWorkerUrlConfig } from '../../../case-worker-url.config';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { CommonModule } from '@angular/common';

type RatingValue = '0' | '1' | '2' | '3';

interface CareGiverItem {
  key: string;            // e.g., 'disciplinerating'
  value: RatingValue;     // '0' | '1' | '2' | '3'
  notes: string;          // paired ...notes field
}
interface CareGiverBuckets {
  action: CareGiverItem[];      // value === '2'
  immediate: CareGiverItem[];   // value === '3'
  strength: CareGiverItem[]; // value === '0' (optional)
  trauma: CareGiverItem[];      // value === '1'
}
interface CareGiverSummary {
  caregiverName: string;
  caregiverId: string | null;
  buckets: CareGiverBuckets;
  maxRows: number;
}

interface ChildItem {
  key: string;            // e.g., 'motherrating'
  value: RatingValue;     // '0' | '1' | '2' | '3'
  notes: string;          // paired ...notes field
}
interface ChildBuckets {
  action: ChildItem[];      // value === '2'
  immediate: ChildItem[];   // value === '3'
  strengths: ChildItem[];   // value === '0'
  trauma: ChildItem[];      // value === '1'
}
interface ChildSummary {
  childName: string;
  childId: string | null;
  buckets: ChildBuckets;
  maxRows: number;
  addlInfo?: string;
}

@Component({
  selector: 'view-assessment-cans-f-summary',
  templateUrl: './view-assessment-cans-f-summary.component.html',
  styleUrls: ['./view-assessment-cans-f-summary.component.scss'],
  imports:[CommonModule],
  providers: [ViewAssessmentCansSummaryService],
  standalone: true
})
export class ViewAssessmentCansFSummaryComponent {
  @Input() sinl: any = new BehaviorSubject(null);

  familyYouth: any;
  familyAssessmentYouth: any;
  careGiver: any;
  familyCultureYouth: any;

  // --- Family table display text ---
  assessmentScale: Record<string, string> = {
    'parental_scale': 'Parental-Caregiver collaboration',
    'relation_scale': 'Relations among siblings',
    'extended_scale': 'Extended family relations',
    'family_scale': 'Family conflict',
    'fcommunication_scale': 'Family communication',
    'fappropriateness_scale': 'Family role appropriateness',
    'safety_scale': 'Safety',
    'social_scale': 'Social Resources',
    'financial_resources_scale': 'Financial Resources',
    'residential_stability_scale': 'Residential stability'
  };

  // --- Caregiver table display text ---
  careGivScale: Record<string, string> = {
    'supervisionrating': 'Supervision',
    'involvementrating': 'Involvement with care',
    'emotionalresprating': 'Emotional responsiveness',
    'knowledgerating': 'Knowledge',
    'orgrating': 'Organization',
    'boundariesrating': 'Boundaries',
    'disciplinerating': 'Discipline',
    'posttraumaticrating': 'Post-traumatic Reactions',
    'phyhealthrating': 'Physical Health',
    'mentalhealthrating': 'Mental health',
    'developmentalrating': 'Developmental',
    'substanceuserating': 'Substance use',
    'criminalbehavrating': 'Caregiver Criminal Behavior',
    'youthlivingrating': 'Satisfaction with youth’s living arrangement',
    'youtheducationrating': 'Satisfaction with youth’s educational arrangement',
    'servicearrangerating': 'Satisfaction with service arrangement',
    'famchildneedsrating': 'Knowledge of family-child needs',
    'serviceoptrating': 'Knowledge of service options',
    'responsibilitiesrating': 'Knowledge of rights & responsibilities',
    'listeningrating': 'Ability to listen',
    'communicationrating': 'Ability to communicate',
    'naturesupportrating': 'Natural supports',

    'sexabuserating': 'Sexual Abuse',
    'phyabuserating': 'Physical Abuse',
    'emotionalabuserating': 'Emotional Abuse',
    'neglectrating': 'Neglect',
    'medtraumarating': 'Medical Trauma',
    'familyvoilancerating': 'Witness to Family Violence',
    'communityvoilancerating': 'Community Violence',
    'schoolvoilancerating': 'School Violence',
    'disasterrating': 'Natural/Man-made Disasters',
    'waraffectedrating': 'War-Affected',
    'terroraffectedrating': 'Terrorism-Affected',
    'criminalactivityrating': 'Witness/Victim to Criminal Activity',
    'disruptionrating': 'Disruptions in Caregiving /Attachment Losses',
  };

  familyCultureScale: Record<string, string> = {
    'language_scale': 'Language',
    'cultural_scale': 'Culture',
    'sexual_scale': 'Sexual Identity',
    'ritual_scale': 'Ritual / Traditions'
  }

  traumaItems: Record<string, string> = {
    sexabuserating: 'Sexual Abuse',
    phyabuserating: 'Physical Abuse',
    emotionalabuserating: 'Emotional Abuse',
    neglectrating: 'Neglect',
    medicaltraumarating: 'Medical Trauma',
    medtraumarating: 'Medical Trauma',
    familyvoilancerating: 'Witness to Family Violence',
    communityvoilancerating: 'Community Violence',
    schoolvoilancerating: 'School Violence',
    disasterrating: 'Natural/Man-made Disasters',
    waraffectedrating: 'War-Affected',
    terroraffectedrating: 'Terrorism-Affected',
    criminalactivityrating: 'Witness/Victim to Criminal Activity',
    disruptionrating: 'Disruptions in Caregiving /Attachment Losses',
  }

  // (optional) pretty labels for keys; extend as needed
  childScale: Record<string, string> = {
    motherrating: 'Relationship with biological mother',
    fatherrating: 'Relationship with biological father',
    pricaregiverrating: 'Relationship with primary caregiver',
    adultsrating: 'Relationship with other family adults',
    siblingsrating: 'Relationship with siblings',
    medicalrating: 'Medical/Physical',
    iqrating: 'Intellectual (IQ only)',
    autismrating: 'Autism Spectrum/PDD',
    speechrating: 'Speech Language Delay',
    socialrating: 'Social Functioning',
    schoolatdrating: 'School Attendance',
    schoolachivrating: 'School Achievement',
    schoolbehvrating: 'School Behavior',
    mentalhealthrating: 'Mental Health Needs',
    adjtotraumarating: 'Adjustment to Trauma',

    sexabuserating: 'Sexual Abuse',
    phyabuserating: 'Physical Abuse',
    emotionalabuserating: 'Emotional Abuse',
    neglectrating: 'Neglect',
    medicaltraumarating: 'Medical Trauma',
    familyvoilancerating: 'Witness to Family Violence',
    communityvoilancenotes: 'Community Violence',
    schoolvoilancerating: 'School Violence',
    disasterrating: 'Natural/Man-made Disasters',
    waraffectedrating: 'War-Affected',
    terroraffectedrating: 'Terrorism-Affected',
    criminalactivityrating: 'Witness/Victim to Criminal Activity',
    disruptionrating: 'Disruptions in Caregiving /Attachment Losses',

    SuicideRiskrating: 'Suicide Risk',
    SelfInjuriousBehaviorsrating: 'Self-Injurious Behaviors',
    RecklessBehaviorsrating: 'Reckless Behaviors',
    DangertoOthersrating: 'Danger to Others',
    SexualAggressionrating: 'Sexual Aggression',
    SexuallyReactiveBehaviorsrating: 'Sexually Reactive Behaviors',
    runawayrating: 'Runaway',
    DelinquentBehaviorrating: 'Delinquent Behavior',
    firesettingrating: 'Fire-Setting',
    IntentionalMisbehaviorrating: 'Intentional Misbehavior',
    bullyingrating: 'Bullying',
    Exploitedrating: 'Exploited',

    Psychosisrating: 'Psychosis',
    AttnDeficitImpulseControlrating: 'Attn Deficit / Impulse Control',
    DepressionMoodDisorderrating: 'Depression / Mood Disorder',
    Anxietyrating: 'Anxiety',
    OppositionalBehaviorrating: 'Oppositional Behavior',
    ConductAntisocialBehaviorrating: 'Conduct / Antisocial Behavior',
    SubstanceAbuserating: 'Substance Abuse',
    EatingDisturbancerating: 'Eating Disturbance',
    AngerControlrating: 'Anger Control',
    AttachmentDifficultiesrating: 'Attachment Difficulties',
    riskbehaviour: 'Risk Behaviors',
    communityvoilancerating: 'Community Violence'

  };

  riskBehaviourCategory: any = {
    SuicideRiskrating: 'Suicide Risk',
    SelfInjuriousBehaviorsrating: 'Self-Injurious Behaviors',
    RecklessBehaviorsrating: 'Reckless Behaviors',
    DangertoOthersrating: 'Danger to Others',
    SexualAggressionrating: 'Sexual Aggression',
    SexuallyReactiveBehaviorsrating: 'Sexually Reactive Behaviors',
    runawayrating: 'Runaway',
    DelinquentBehaviorrating: 'Delinquent Behavior',
    firesettingrating: 'Fire-Setting',
    IntentionalMisbehaviorrating: 'Intentional Misbehavior',
    bullyingrating: 'Bullying',
    Exploitedrating: 'Exploited',
  };

  mentalHealthCategory: any = {
    Psychosisrating: 'Psychosis',
    AttnDeficitImpulseControlrating: 'Attn Deficit / Impulse Control',
    DepressionMoodDisorderrating: 'Depression / Mood Disorder',
    Anxietyrating: 'Anxiety',
    OppositionalBehaviorrating: 'Oppositional Behavior',
    ConductAntisocialBehaviorrating: 'Conduct / Antisocial Behavior',
    SubstanceAbuserating: 'Substance Abuse',
    EatingDisturbancerating: 'Eating Disturbance',
    AngerControlrating: 'Anger Control',
    AttachmentDifficultiesrating: 'Attachment Difficulties'
  }

  // Map family *_scale keys -> payload groups
  // Adjust/extend as needed if more scales are present
  private groupMap: Record<string, 'cotp' | 'suitp' | 'csd' | 'nscb' | 'tss' | 'ead' | 'pp' | 'teol'> = {
    parental_scale: 'cotp',
    relation_scale: 'cotp',
    extended_scale: 'cotp',

    fcommunication_scale: 'suitp',
    fappropriateness_scale: 'suitp',
    safety_scale: 'suitp',

    social_scale: 'csd',
    family_scale: 'csd', // place Family Conflict under csd by default
    // If you have other groups (tss/ead/pp/teol), map them here as they appear.
  };

  // --- working arrays feeding HTML + payload ---
  child: any[] = [];
  childSummary: ChildSummary[] = [];
  careGiverSummary: CareGiverSummary[] = [];
  scalesWith2_3: any[] = [];           // [{ key, value: '2'|'3', group, label, description, strength }]
  cultureScalesWith2_3: any[] = [];    // [{ key, value: '2'|'3', group, label, comments, strength }]

  additionalAcculturationInfo: string = '';
  printButtonEnable = true;
  printPdfTableInfo:any = {};
  // getters for family table
  get actionNeeded_scalesArray() { return this.scalesWith2_3.filter(i => i.value === '2'); }
  get immediateNeeded_scalesArray() { return this.scalesWith2_3.filter(i => i.value === '3'); }
  get strengths_scalesArray() { return this.scalesWith2_3.filter(i => i.value === true); }
  get maxRows_scalesArray() {
    return Math.max(
      this.actionNeeded_scalesArray.length,
      this.immediateNeeded_scalesArray.length,
      this.strengths_scalesArray.length,
      1
    );
  }

  // getters for culture table
  get actionNeeded_culture() { return this.cultureScalesWith2_3.filter(i => i.value === '2'); }
  get immediateNeeded_culture() { return this.cultureScalesWith2_3.filter(i => i.value === '3'); }
  get strengths_culture() { return this.cultureScalesWith2_3.filter(i => i.strength); }
  get maxRows_culture() {
    return Math.max(
      this.actionNeeded_culture.length,
      this.immediateNeeded_culture.length,
      this.strengths_culture.length,
      1
    );
  }
  private readonly _dataStoreService: DataStoreService;
  public candidatestraditional: any[] = [];
  constructor(
    private _commonService: CommonHttpService, private readonly injector: Injector
  ) {
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
  }

  // When summary tab is clicked, recalc data
  ngOnChanges(): void {
    this.setSummaryData(this.sinl);
    this.getServicePlans();
  }

  setSummaryData(summaryData: any) {
    const headType = { "2": "Action_Needed", "3": "Immediate_Intensive_Action_Needed" };
    this.printPdfTableInfo = {};
    this.initializeSummaryData(summaryData);

    this.setFamilyAssessment();
    this.setCareGiver();
    this.setFamilyCulture();
    this.setChild();


    this.processScalesWith23(headType);
    this.addImminentRiskInfo();
    this.addCareGiverSummary();
    this.addChildSummary();
    this.addFamilyCultureSummary(headType);
  }

  private initializeSummaryData(summaryData: any) {
    this.familyYouth = summaryData?.familyYouth_childArray;
    this.familyAssessmentYouth = summaryData?.familyAssessmentYouth;
    this.careGiver = summaryData?.careGiver;
    this.familyCultureYouth = summaryData?.familyCultureYouth;
    this.child = summaryData?.child;

    this.scalesWith2_3 = [];
    this.cultureScalesWith2_3 = [];
    this.careGiverSummary = [];
    this.childSummary = [];

    this.printPdfTableInfo["Action_Needed"] = [];
    this.printPdfTableInfo["CARE_GIVER_SUMMARY"] = [];
    this.printPdfTableInfo["CHILD_SUMMARY"] = [];
    this.printPdfTableInfo["FAMILY_CULTURE"] = [];
    this.printPdfTableInfo["Immediate_Intensive_Action_Needed"] = [];
    this.printPdfTableInfo["Imminent_Risk_Criteria_Selected"] = [];
    this.printPdfTableInfo["Strength"] = [];
  }

  private processScalesWith23(headType: any) {
    this.scalesWith2_3.forEach(ele => {
      const key = headType[ele.value];
      this.printPdfTableInfo[key] = (this.printPdfTableInfo[key] || []).concat(ele.label);

      if (ele.value === true) {
        this.printPdfTableInfo["Strength"] = (this.printPdfTableInfo["Strength"] || []).concat(ele.label);
      }
    });
  }

  private addImminentRiskInfo() {
    if (this.familyYouth?.length) {
      this.printPdfTableInfo["Imminent_Risk_Criteria_Selected"] = [{ ACTION: this.familyYouth?.map((ele : any) => ele?.childNameText) }];
    }
  }

  private addCandidatestraditional() {
    if (this.candidatestraditional?.length) {
      this.printPdfTableInfo["Candidates_Traditional"] = [{
        ACTION: this.candidatestraditional?.map(ele => ele?.name),
        IMMEDIATE: this.candidatestraditional.map(
          ele => ele?.details?.replace(/\s*\|\s*/g, ', ') // replace | with , and clean spaces
        )
      }];
    }
  }

  private addCareGiverSummary() {
    if (!this.careGiverSummary?.length) return;
    this.printPdfTableInfo["CARE_GIVER_SUMMARY"] = this.careGiverSummary.map(ele => ({
      sectionName: ele.caregiverName,
      ACTION: ele.buckets.action.map(e1 => this.careGivScale[e1.key]),
      IMMEDIATE: ele.buckets.immediate.map(e1 => this.careGivScale[e1.key]),
      TRAUMA: ele.buckets.trauma.map(e1 => this.careGivScale[e1.key]),
      STRENGTH: ele.buckets.strength.map(e1 => this.careGivScale[e1.key])
    }));
  }

  private addChildSummary() {
    if (!this.childSummary?.length) return;
    this.printPdfTableInfo["CHILD_SUMMARY"] = this.childSummary.map(ele => {
      const b = ele.buckets;
      b.strengths = b.strengths || [];
      b.trauma = b.trauma || [];
      return {
        sectionName: ele.childName,
        ACTION: b.action.map(e1 => this.childScale[e1.key] || this.prettyKey(e1.key)),
        IMMEDIATE: b.immediate.map(e1 => this.childScale[e1.key] || this.prettyKey(e1.key)),
        TRAUMA: b.trauma.map(e1 => this.childScale[e1.key] || this.prettyKey(e1.key)),
        STRENGTH: b.strengths.map(e1 => this.childScale[e1.key] || this.prettyKey(e1.key))
      };
    });
  }

  private addFamilyCultureSummary(headType: any) {
    if (!this.cultureScalesWith2_3?.length) return;
    const FAMILY_CULTURE : any = {};
    this.cultureScalesWith2_3.forEach(ele => {
      const key = headType[ele.value];
      FAMILY_CULTURE[key] = (FAMILY_CULTURE[key] || []).concat(ele.label);
      if (ele.strength === true) {
        FAMILY_CULTURE["Strength"] = (FAMILY_CULTURE["Strength"] || []).concat(ele.label);
      }
    });
    this.printPdfTableInfo["FAMILY_CULTURE"] = FAMILY_CULTURE;
  }


  /* -------- Family Assessment -------- */
  setFamilyAssessment() {
    if (!this.familyAssessmentYouth) return;

    for (const [key_, value] of Object.entries(this.familyAssessmentYouth)) {
      if (!this.isAssessmentHit(key_, value)) continue;
      this.scalesWith2_3.push(this.buildAssessmentItem(key_, value));
    }
  }

  private isAssessmentHit(key_: string, value: any): boolean {
    const is23Scale = (value === '2' || value === '3') && key_.endsWith('_scale');
    const isStrength = value === true && key_.endsWith('_strength');
    return is23Scale || isStrength;
  }

  private buildAssessmentItem(key_: string, value: any) {
    const descriptionKey = key_.replace('_scale', '_description');
    const strengthKey = key_.replace('_strength', '_scale');

    const isScaleKey = key_.endsWith('_scale');
    const scaleKey = isScaleKey ? key_ : strengthKey;

    const group = (this.groupMap?.[key_] as any) ?? undefined;
    const label = this.assessmentScale?.[scaleKey] ?? key_;

    return {
      key: scaleKey,                                // normalized *_scale key
      value,                                        // '2' | '3' | true
      group,                                        // used by payload collector
      label,                                        // user-facing text
      description: this.familyAssessmentYouth?.[descriptionKey] || '',
      strength: this.familyAssessmentYouth?.[strengthKey] ?? null
    };
  }


  /* -------- Caregiver -------- */
  setCareGiver() {
    if (!Array.isArray(this.careGiver)) return;

    this.careGiverSummary = this.careGiver.map((cg: any) => this.buildCareGiverSummary(cg));
  }

  private buildCareGiverSummary(cg: any): CareGiverSummary {
    const caregiverName = (cg.ccacaregivername || 'Unknown Caregiver').toString().trim();
    const caregiverId = cg.caregiverlist ?? null;

    const buckets = this.collectCareGiverBuckets(cg);
    const maxRows = Math.max(
      buckets.action.length,
      buckets.immediate.length,
      buckets.strength.length,
      buckets.trauma.length,
      1
    );

    return { caregiverName, caregiverId, buckets, maxRows } as CareGiverSummary;
  }

  private collectCareGiverBuckets(cg: any) {
    const trauma: CareGiverItem[] = [];
    const action: CareGiverItem[] = [];
    const immediate: CareGiverItem[] = [];
    const strength: CareGiverItem[] = [];

    for (const [key, value] of Object.entries(cg)) {
      if (this.isRatingKey(key)) {
        this.pushRatingBucket(cg, key, value, { trauma, action, immediate /* strength intentionally excluded for '0' */ });
      } else {
        this.pushBooleanStrength(key, value, strength);
      }
    }

    return { action, immediate, strength, trauma };
  }

  private isRatingKey(key: string): boolean {
    return key.endsWith('rating');
  }

  private pushRatingBucket(
    cg: any,
    key: string,
    value: any,
    sets: { trauma: CareGiverItem[]; action: CareGiverItem[]; immediate: CareGiverItem[] }
  ) {
    const val = String(value) as RatingValue;
    const notesKey = this.resolveNotesKey(cg, key);
    const item: CareGiverItem = { key, value: val, notes: (cg[notesKey] || '').toString() };

    if (val === '1' && this.traumaItems.hasOwnProperty(item?.key)) sets.trauma.push(item);
    else if (val === '2') sets.action.push(item);
    else if (val === '3') sets.immediate.push(item);
    // Note: val === '0' (strength-from-rating) remains excluded to preserve original behavior.
  }

  private pushBooleanStrength(key: string, value: any, strength: CareGiverItem[]) {
    if (value === true && key !== 'formStatus') {
      const key_ = key + 'rating';
      strength.push({ key: key_, value: '0', notes: '' });
    }
  }


  /* -------- Family Culture -------- */
  private truthy(v: any): boolean {
    return v === true || v === 1 || v === '1' || (typeof v === 'string' && v.toLowerCase() === 'true');
  }

  setFamilyCulture() {
    const fc = this.familyCultureYouth;
    if (!fc) return;

    const FIELDS = [
      { scale: 'language_scale', strength: 'language_strength', comments: 'language_comments', label: 'Language', group: 'csd' },
      { scale: 'cultural_scale', strength: 'cultural_strength', comments: 'cultural_comments', label: 'Cultural Identity', group: 'csd' },
      { scale: 'sexual_scale', strength: 'sexual_identity_strength', comments: 'sexual_comments', label: 'Gender/Sexual Identity', group: 'nscb' },
      { scale: 'ritual_scale', strength: 'ritual_strength', comments: 'ritual_comments', label: 'Ritual', group: 'nscb' }
    ] as const;

    FIELDS.forEach(f => {
      const val = String(fc[f.scale] ?? '');
      if (val === '2' || val === '3') {
        this.cultureScalesWith2_3.push({
          key: f.scale,
          label: f.label,
          value: val,
          comments: fc[f.comments] || '',
          strength: this.truthy(fc[f.strength]),
          group: f.group
        });
      } else {
        let val_s = fc[f.strength] ?? false;
        if (val_s === true) {
          this.cultureScalesWith2_3.push({
            key: f.scale,
            label: f.label,
            value: val_s,
            comments: fc[f.comments] || '',
            strength: this.truthy(fc[f.strength]),
            group: f.group
          });
        }
      }
    });

    this.additionalAcculturationInfo = fc?.additional_acculturation_info || '';
  }

  /* -------- Child -------- */
  public prettyKey(k: string): string {
    const base = k.replace(/rating$/, '');
    const spaced = base
      .replace(/_/g, ' ')
      .replace(/([a-z])([A-Z])/g, '$1 $2')
      .trim();
    return spaced.charAt(0).toUpperCase() + spaced.slice(1);
  }

  /** handle the 'SexuallyReactiveBehaviorsrating' vs 'SexuallyReactiveBehaviornotes' mismatch */
  private resolveNotesKey(obj: any, ratingKey: string): string {
    const defaultKey = ratingKey.replace('rating', 'notes');
    if (defaultKey in obj) return defaultKey;
    if (ratingKey.endsWith('Behaviorsrating')) {
      const alt = ratingKey.replace('Behaviorsrating', 'Behaviornotes');
      if (alt in obj) return alt;
    }
    return defaultKey;
  }

  setChild() {
    if (!Array.isArray(this.child)) return;

    this.childSummary = this.child.map(this.buildChildSummary.bind(this));
  }
  isRiskBehaviour(key: string): boolean {
    return key in this.riskBehaviourCategory;
  }
  isMentalHealthCategory(key: string): boolean {
    return key in this.mentalHealthCategory;
  }
  private buildChildSummary(c: any): ChildSummary {
    const childName = (c.childname || 'Child').toString().trim();
    const childId = c.childlist ?? null;
    const buckets: ChildBuckets = { action: [], immediate: [], strengths: [], trauma: [] };

    // Precompute gates
    const riskOn = c.riskbehaviour === '2' || c.riskbehaviour === '3';
    const mentalOn = c.mentalhealthrating === '2' || c.mentalhealthrating === '3';

    // Tiny helpers to keep the loop flat
    const allowedByGate = (key: string): boolean =>
      this.isRiskBehaviour(key) ? riskOn :
        this.isMentalHealthCategory(key) ? mentalOn : true;

    const isBooleanTrue = (key: string, val: unknown): boolean =>
      val === true && key !== 'formStatus';

    const isRatedKey = (key: string, val: unknown): boolean =>
      (key.endsWith('rating') || key.endsWith('behaviour')) && val !== '0';

    const pushItem = (key: string, val: RatingValue) => {
      const notesKey = this.resolveNotesKey(c, key);
      const item: ChildItem = { key, value: val, notes: (c[notesKey] || '').toString() };
      const bucket = this.getBucketFor(val);
      if (val === "1") {
        if (this.traumaItems.hasOwnProperty(item?.key)) { if (bucket) buckets[bucket].push(item); }
      } else { if (bucket) buckets[bucket].push(item); }
    };

    // Single flat pass
    for (const [key, val] of Object.entries(c)) {
      if (isBooleanTrue(key, val)) {
        const b = this.getBucketFor('0' as RatingValue);
        if (b) buckets[b].push({ key: `${key}rating`, value: '0', notes: '' });
        continue;
      }
      if (isRatedKey(key, val) && allowedByGate(key)) {
        pushItem(key, String(val) as RatingValue);
      }
    }

    const maxRows = Math.max(
      1,
      buckets.action.length,
      buckets.immediate.length,
      buckets.strengths.length,
      buckets.trauma.length
    );

    return {
      childName,
      childId,
      buckets,
      maxRows,
      addlInfo: c.addl_child_info || ''
    } as ChildSummary;
  }



  private getBucketFor(val: RatingValue): keyof ChildBuckets | undefined {
    // rating → bucket
    const map: Record<RatingValue, keyof ChildBuckets> = {
      '0': 'strengths',
      '1': 'trauma',
      '2': 'action',
      '3': 'immediate'
    };
    return map[val];
  }


  /* ---------------------------------------------
     PRINT / DOWNLOAD
  ----------------------------------------------*/
  downloadCansSummarySection() {
    try {
      this.printButtonEnable = false;
      const request = {
        method: 'post',
        where: {
          documenttemplatekey: ['cansfsummarySheet'],
          payload: this.printPdfTableInfo
        },
        limit: 10,
        order: 'desc',
        page: 1,
        count: -1
      };
      const generateintakedocumentUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Assessment.Generateintakedocument;
      this._commonService
        .download(generateintakedocumentUrl, request)
        .subscribe(
          (res: ArrayBuffer | any) => {
            const blob = new Blob([new Uint8Array(res)]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = 'CANS_Summary_Sheet.pdf';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            this.printButtonEnable = true;
          },
          (error) => {
            console.error('Download failed', error);
            this.printButtonEnable = true;
          }
        );
    } catch (err) {
      console.error('Error generating summary sheet:', err);
      this.printButtonEnable = true;
    }
  }

  getServicePlans() {
    const payload = {
      method: 'get',
      where: {
        caseid: this._dataStoreService.getData('CASEUID')
      }
    };
    this._commonService.getArrayList(payload, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.Listbyallrelation).subscribe(
      response => {
        let servicePlans: any[] = [];
        if (response.length) {
          servicePlans = response;
          const latest = servicePlans.reduce((best, item) => {
            const t = item?.effectivedate ? new Date(item.effectivedate).getTime() : -Infinity;
            const b = best?.effectivedate ? new Date(best.effectivedate).getTime() : -Infinity;
            return t > b ? item : best;
          }, undefined as any);
          this.getHist(latest?.serviceplanid)
        }
      });
  }
  getHist(serviceplanid : any) {
    this._commonService
      .getArrayList(
        new PaginationRequest({
          page: 1,
          limit: 20,
          method: 'get',
          order: 'insertedon desc',
          where: {
            objectid: serviceplanid,
            objecttype: 'SPLAN'
          }
        }),
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.Snapshothist
      ).subscribe(
        response => {
          if (response && Array.isArray(response) && response.length > 0) {
            let items: any[] = [];
            if (response.length) {
              items = response;
              const approvalTime = (x: any) =>
                new Date(x?.approvaldate ?? x?.snapshotdata?.approvaldate ?? 0).getTime();

              const latest = items.reduce((best, it) =>
                approvalTime(it) > approvalTime(best) ? it : best
                , undefined as any);
              this.setServicePlanTable(latest);
            }
          } else {
            this.setServicePlanTable([]);
          }
        });
  }
  setServicePlanTable(Snapshothist: any) {
    this.candidatestraditional = [];
    let candidatestraditional = Snapshothist?.snapshotdata?.serviceplancandidacy?.candidatestraditional.map((ele:any) => ({
      details: ele?.details,
      name: ele?.name
    }));
    if (this.familyYouth?.length) {
      this.familyYouth?.forEach((child:any) => {
        // Check if the childNameText is not already in candidatestraditional
        if (candidatestraditional) {
          const normalizeName = (s: string) =>
            (s ?? '').trim().replace(/\s+/g, ' ').toUpperCase();
          const isExists = candidatestraditional.filter(
            (candidate: any) => normalizeName(candidate.name) === normalizeName(child.childNameText)
          );

          if (isExists.length) {
            // Add missing child to candidatestraditional
            this.candidatestraditional.push({
              name: isExists[0].name,
              details: isExists[0].details ? isExists[0]?.details.replace(/\s*\|\s*/g, ', ') : ""
            });
          } else {
            this.candidatestraditional.push({
              name: child.childNameText,
              details: ""
            });
          }
        } else {
          this.candidatestraditional.push({
            name: child.childNameText,
            details: ""
          });
        }
      });
      this.addCandidatestraditional();
    }
  }
  getCaregiverScaleLabel(key?: string): string {
    return key ? (this.careGivScale?.[key] ?? '') : '';
  }
}