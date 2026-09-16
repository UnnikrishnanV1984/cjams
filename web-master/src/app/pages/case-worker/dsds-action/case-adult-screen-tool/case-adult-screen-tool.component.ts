
import {of as observableOf,  Subject, Observable ,  forkJoin } from 'rxjs';

import {pluck, map, share} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AppUser } from '../../../../@core/entities/authDataModel';
import { InvolvedPerson } from '../../../../@core/common/models/involvedperson.data.model';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { SubType, ListAST } from '../../_entities/caseworker.data.model';
import { CountyDetail } from '../as-maltreatment-information/_entities/investigation-finding.data.model';
import { DataStoreService, AuthService, CommonHttpService, AlertService } from '../../../../@core/services';
import { IntakeStoreConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'case-adult-screen-tool',
    templateUrl: './case-adult-screen-tool.component.html',
    styleUrls: ['./case-adult-screen-tool.component.scss'],
    standalone: false
})
export class CaseAdultScreenToolComponent implements OnInit {

  adultScreenFormGroup!: FormGroup;
  userIntakeInfo!: AppUser;
  currentDate!: Date;
  daTypeKey: any;
  store: any;
  invlovedPersons: InvolvedPerson[] = [];
  personNameList: any[] = [];
  formComplete!: boolean;
  caseWorker!: string;
  roleId!: AppUser;
  reviewStatus$ = new Subject<string>();
  responseDropdownList$ = new Observable<DropdownModel[]>();
  subServiceTypes: SubType[] = [];
  @Input()
  reviewStatus!: string;
  subServiceTypes$!: Observable<DropdownModel[]>;
  subServiceDropDownTypes$!: Observable<DropdownModel[]>;
  disableButton!: boolean;
  intakeServId!: string;
  subTypeKey!: string;
  ethinicityDropdownItems$!: Observable<DropdownModel[]>;
  genderDropdownItems$!: Observable<DropdownModel[]>;
  racetypeDropdownItems$!: Observable<DropdownModel[]>;
  maritalDropdownItems$!: Observable<DropdownModel[]>;
  localDssCountys$!: Observable<CountyDetail[]>;
  houseHold : Array<any> = [];
  houseHold$!: Observable<Array<any>>;
  loadAnonymousYesorNo = [
    { 'id': 'Y', 'name': 'Yes' },
    { 'id': 'N', 'name': 'No' }
  ];
  AdultScreenYesOrNo = [
    { 'id': 'Y', 'name': 'Yes' },
    { 'id': 'N', 'name': 'No' },
    { 'id': 'U', 'name': 'Unknown' }
  ];
  adultRisks$!: Observable<DropdownModel[]>;
  supportNetwork$!: Observable<DropdownModel[]>;
  supportNetworkScore= 0;
  environmentalRiskScore= 0;
  healthcareScore= 0;
  transportationScore= 0;
  clutterScore= 0;
  foodScore= 0;
  utilitiesScore= 0;
  supervisionScore= 0;
  eatingSelectScore = 0;
  mobilityScore = 0;
  bathingScore = 0;
  dressingScore = 0;
  toiletingScore = 0;
  mentalRiskScore = 0;
  physicalRiskScore = 0;
  dementiaScore = 0;
  disorderScore = 0;
  substanceAbuseScore = 0;
  moodDisorderScore = 0;
  behavioralScore = 0;
  takingMedicationScore= 0;
  riskScore: any;
  riskLevel!: string;
  allegationDropdownList!: any[];
  riskLevels = [
    { 'id': 'L', 'name': 'Low' },
    { 'id': 'M', 'name': 'Moderate' },
    { 'id': 'H', 'name': 'Value' }
  ];
  physicalAbuse: any;
  selfNeglect: any;
  neglectedByOthers: any;
  exploitation: any;
  sexExploitation: any;
  physicalEnvironment: any;
  intakeRecommendation!: string;
  astData$!: Observable<ListAST[]>;
  astListData : Array<any> = [];
  id: any;


  constructor(private _dataStoreService: DataStoreService,
    private _commonHttpService: CommonHttpService,
    private formBuilder: FormBuilder, 
    private _authService: AuthService, 
    private _alertService: AlertService,
    ) {
      this.store = this._dataStoreService.getCurrentStore();
      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
  }

  ngOnInit() {
    this.buildFormGroup();
    const purposeSelected = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
    if (purposeSelected) {
      this.daTypeKey = purposeSelected.value;
    }
    this.invlovedPersons = this._dataStoreService.getData(IntakeStoreConstants.addedPersons);
    const astData = this.store[IntakeStoreConstants.adultScreenTool];
    this.disableButton = (astData && astData.isComplete) ? true : false;
    if (astData && astData.isComplete) {
      this.adultScreenFormGroup.disable();
    }
    this.clientLoadDropDown();
    this.loadlocalDssCountys();
    this.loadRiskMeasure();
    this.loadSupportNetwork();
    this.riskScoreUpdate();
    this.loadASTData();

  }


  buildFormGroup() {
    this.adultScreenFormGroup = this.formBuilder.group({
      // DefaultTop
      astdate: '',
      caseworker: [''],
      countyid: [''],
      // REFERRAL SOURCE
      referralname: [''],
      referraladdress1: [''],
      referraladdress2: [''],
      referralphone: [''],
      referralremainanonymous: [''],
      referralrelationship: [''],
      // CLIENT INFORMATION
      clientinfoname: [''],
      clientinfodob: [''],
      clientinfoage: [''],
      gendertypekey: [''],
      clientinfoaddress1: [''],
      clientinfoaddress2: [''],
      clientinfophone: [''],
      maritalstatuskey: [''],
      monthlyincome: [''],
      monthlyincomesource: [''],
      totalassets: [''],
      totalassetssource: [''],
      racetypekey: [''],
      ethnicitytypekey: [''],
      additionalinfo: [''],
      // OTHERS IN HOUSEHOLD/INTERESTED OTHERS
      othersName: [''],
      othersRelationship: [''],
      othersPhone: [''],
      // Risk/Safety Factors for Investigator
      riskaggrpets: [''],
      riskfireharms: [''],
      riskcdsabuse: [''],
      riskdomviolence: [''],
      riskhomehazards: [''],
      riskpsychiatric: [''],
      riskmedical: [''],
      riskother: [''],
      riskcomments: [''],
      // DETAILS OF REFERRAL (NARRATIVE)
      detailsofreferralcomments: [''],
      // Maltreatment Type
      allegedVictim: [[], Validators.required],
      allegedMaltreator: [[], Validators.required],
      phyAbuseSelect: [''],
      selfNeglectSelect: [''],
      neglectedByOthersSelect: [''],
      exploitationSelect: [''],
      sexExploitationSelect: [''],
      physicalEnvironmentSelect: [''],
      subServiceType: [''],
      locationOfMalTreatment: [''],
      responseDetail: [''],
      // ENVIRONMENTAL/EXTERNAL RISKS
      healthcarekey: [''],
      cluttertypekey: [''],
      housingtypekey: [''],
      transportationkey: [''],
      foodtypekey: [''],
      supervisiontypekey: [''],
      individualvulnerable: [''],
      // PHYSICAL/FUNCTIONAL RISKS
      eatingfeedingkey: [''],
      walkingkey: [''],
      dressingkey: [''],
      takingmedicationkey: [''],
      bathingkey: [''],
      toiletkey: [''],
      physicalrisksnotes: [''],
      // MENTAL/EMOTIONAL CHALLENGES
      dementiakey: [''],
      substanceabusekey: [''],
      behavioralissueskey: [''],
      thoughtdisorderskey: [''],
      mooddisorderskey: [''],
      mentalchallengesnotes: [''],
      // STABILITY OF SUPPORT/CAREGIVING NETWORK
      supportnetworkkey: [''],
      supportnetworknotes: [''],
      riskscore: [''],
      risklevel: [''],
      intakerecommendation: [''],
    });
    this.userIntakeInfo = this._authService.getCurrentUser();
    if (this.userIntakeInfo.user.userprofile.displayname) {
      this.caseWorker = this.userIntakeInfo.user.userprofile.displayname;
      this.updateAdultScreen();
    }
    this.updateAdultScreen();
  }

  updateAdultScreen() {
    this.currentDate = new Date();
    this.adultScreenFormGroup.patchValue({
      astdate: this.currentDate,
      caseworker: this.caseWorker
    });
  }

  loadASTData() {
    this._commonHttpService.getArrayList({
      where: {servicerequestid: this.id}, method: 'get' },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.AdultScreenTool.listAST).pipe(map(result => {
      return result;
    })).subscribe((item) => {
      item.forEach(response => {
        if (response && response.length) {
          response.getadultscreentool.forEach((element: { householdconfig: any[]; }) => {
            this.setAdultScreenFormGroup(element);
          element.householdconfig.forEach(household => {
            this.houseHold.push({
              name: household.name,
              phone: household.phoneno,
              relationship: household.relationship
            });
            this.houseHold$ = observableOf(this.houseHold);
          });
        });
      }
    });
  });
}

setAdultScreenFormGroup(element: any){
  this.adultScreenFormGroup.patchValue({
    countyid: element.countyid,
    referralname: element.referralname ? element.referralname : '',
    referraladdress1: element.referraladdress1 ? element.referraladdress1 : '',
    referraladdress2: element.referraladdress2 ? element.referraladdress2 : '',
    referralphone: element.referralphone ? element.referralphone : '',
    referralremainanonymous: element.referralremainanonymous,
    referralrelationship: element.referralrelationship,
    // CLIENT INFORMATION
    clientinfoname: element.clientinfoname,
    clientinfodob: element.clientinfodob,
    clientinfoage: element.clientinfoage,
    gendertypekey: element.gendertypekey,
    clientinfoaddress1: element.clientinfoaddress1,
    clientinfoaddress2: element.clientinfoaddress2,
    clientinfophone: element.clientinfophone,
    maritalstatuskey: element.maritalstatuskey,
    monthlyincome: element.monthlyincome,
    monthlyincomesource: element.monthlyincomesource,
    totalassets: element.totalassets,
    totalassetssource: element.totalassetssource,
    racetypekey: element.racetypekey,
    ethnicitytypekey: element.ethnicitytypekey,
    additionalinfo: element.additionalinfo,
    // Risk/Safety Factors for Investigator
    riskaggrpets: element.riskaggrpets,
    riskfireharms: element.riskfireharms,
    riskcdsabuse: element.riskcdsabuse,
    riskdomviolence: element.riskdomviolence,
    riskhomehazards: element.riskhomehazards,
    riskpsychiatric: element.riskpsychiatric,
    riskmedical: element.riskmedical,
    riskother: element.riskother,
    riskcomments: element.riskcomments,
    // DETAILS OF REFERRAL (NARRATIVE)
    detailsofreferralcomments: element.detailsofreferralcomments,
    // Maltreatment Type
    /* allegedVictim: [[], Validators.required],
     allegedMaltreator: [[], Validators.required],
     phyAbuseSelect: ,
     selfNeglectSelect: ,
     neglectedByOthersSelect: ,
     exploitationSelect: ,
     sexExploitationSelect: ,
     physicalEnvironmentSelect: ,
     subServiceType: ,
     locationOfMalTreatment: ,
     responseDetail: , */
    // ENVIRONMENTAL/EXTERNAL RISKS
    healthcarekey: element.healthcarekey,
    cluttertypekey: element.cluttertypekey,
    housingtypekey: element.housingtypekey,
    transportationkey: element.transportationkey,
    foodtypekey: element.foodtypekey,
    supervisiontypekey: element.supervisiontypekey,
    individualvulnerable: element.individualvulnerable,
    // PHYSICAL/FUNCTIONAL RISKS
    eatingfeedingkey: element.eatingfeedingkey,
    walkingkey: element.walkingkey,
    dressingkey: element.dressingkey,
    takingmedicationkey: element.takingmedicationkey,
    bathingkey: element.bathingkey,
    toiletkey: element.toiletkey,
    physicalrisksnotes: element.physicalrisksnotes,
    // MENTAL/EMOTIONAL CHALLENGES
    dementiakey: element.dementiakey,
    substanceabusekey: element.substanceabusekey,
    behavioralissueskey: element.behavioralissueskey,
    thoughtdisorderskey: element.thoughtdisorderskey,
    mooddisorderskey: element.mooddisorderskey,
    mentalchallengesnotes: element.mentalchallengesnotes,
    // STABILITY OF SUPPORT/CAREGIVING NETWORK
    supportnetworkkey: element.supportnetworkkey,
    supportnetworknotes: element.supportnetworknotes,
    riskscore: element.riskscore,
    risklevel: element.risklevel,
    intakerecommendation: element.intakerecommendation
  });
}

  /**
   * Local Dss - County - Start
   */

  private loadlocalDssCountys() {
    this.localDssCountys$ = this._commonHttpService.create({
      where: { state: 'MD' }, order: 'countyname asc', nolimit: true },
      CommonUrlConfig.EndPoint.Listing.CountryListUrl).pipe(map(result => {
      return result;
    }));
  }

   /**
    * Local Dss - County - End
    */

  /**
   * Client Information Tab - start
   */

  private clientLoadDropDown() {
    const source = forkJoin([
        this._commonHttpService.getArrayList(
            {
                where: { activeflag: 1 },
                method: 'get',
                nolimit: true
            },
            NewUrlConfig.EndPoint.Intake.EthnicGroupTypeUrl + '?filter'
        ),
        this._commonHttpService.create(
            {
                where: { activeflag: 1 },
                method: 'post',
                nolimit: true
            },
            NewUrlConfig.EndPoint.Intake.GenderTypeUrl + '/genderlist'
        ),
        this._commonHttpService.getArrayList(
            {
                where: { activeflag: 1 },
                method: 'get',
                nolimit: true,
                order: 'typedescription'
            },
            NewUrlConfig.EndPoint.Intake.RaceTypeUrl + '?filter'
        ),
        this._commonHttpService.getArrayList(
            {
                method: 'get',
                nolimit: true,
                order: 'typedescription'
            },
            NewUrlConfig.EndPoint.Intake.MaritalStatusUrl + '?filter'
        )
    ]).pipe(
        map((result: any) => {
            return {
                ethinicities: result[0].map(
                    (res: { typedescription: any; ethnicgrouptypekey: any; }) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.ethnicgrouptypekey
                        })
                ),
                genders: result[1].map(
                    (res: { typedescription: any; gendertypekey: any; }) =>
                        new DropdownModel({
                            text: res.typedescription,
                            value: res.gendertypekey
                        })
                ),
                racetype: result[2].map(
                  (res: { typedescription: any; racetypekey: any; }) =>
                      new DropdownModel({
                          text: res.typedescription,
                          value: res.racetypekey
                      })
              ),
              maritalstatus: result[3].map(
                (res: { typedescription: any; maritalstatustypekey: any; }) =>
                    new DropdownModel({
                        text: res.typedescription,
                        value: res.maritalstatustypekey
                    })
            )


            };
        }),
        share(),);
        this.ethinicityDropdownItems$ = source.pipe(pluck('ethinicities'));
        this.genderDropdownItems$ = source.pipe(pluck('genders'));
        this.racetypeDropdownItems$ = source.pipe(pluck('racetype'));
        this.maritalDropdownItems$ = source.pipe(pluck('maritalstatus'));
      }

   /**
    * Client Information Tab - End
    */
   /**
    * House Hold Tab - Start
    */
   addHouseHold() {
    const name = this.adultScreenFormGroup.get('othersName')?.value;
    const relationship = this.adultScreenFormGroup.get('othersRelationship')?.value;
    const contactnumber = this.adultScreenFormGroup.get('othersPhone')?.value;
    if (name && relationship && contactnumber) {
        this.houseHold.push({
            contacttypeid: '',
            name: name,
            relationship: relationship,
            phone: contactnumber,
            isactive: 1
        });
        this.houseHold$ = observableOf(this.houseHold);
        this.adultScreenFormGroup.get('othersName')?.reset();
        this.adultScreenFormGroup.get('othersRelationship')?.reset();
        this.adultScreenFormGroup.get('othersPhone')?.reset();
    } else {
        this._alertService.warn('Please fill all the details');
    }
  }
  deleteHouseHold(i: number) {
    this.houseHold.splice(i, 1);
    this.houseHold$ = observableOf(this.houseHold);
  }
  /**
  * House Hold Tab - End
  */

  /**
   * Loading remaining tab - drop down - start
   *
   */

  private loadRiskMeasure() {

    const source = this._commonHttpService.getArrayList(
      {
        where: { teamtypekey: 'AS', referencetypeid: 43 },
        method: 'get',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Intake.adultScreenRiskMeasure
    ).pipe(map((result) => {
      return {
        response: result.map(
          (res) =>
            new DropdownModel({
              text: res.value_text,
              value: res.ref_key
            })
        )
      };
    }),share(),);

    this.adultRisks$ = source.pipe(pluck('response'));
  }

  private loadSupportNetwork() {

    const source = this._commonHttpService.getArrayList(
      {
        where: { teamtypekey: 'AS', referencetypeid: 43 },
        method: 'get',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Intake.adultScreenRiskMeasure
    ).pipe(map((result) => {
      return {
        response: result.map(
          (res) =>
            new DropdownModel({
              text: res.description,
              value: res.ref_key
            })
        )
      };
    }),share(),);

    this.supportNetwork$ = source.pipe(pluck('response'));
  }


  onHealthCare(item: any) {
    if (item.value === 'MINORP') {
      this.healthcareScore = 4;

     } else if (item.value === 'MODPRO') {
      this.healthcareScore = 10;

     } else if (item.value === 'NOP') {
      this.healthcareScore = 0;

     } else if (item.value === 'SERPRO') {
      this.healthcareScore = 16;

     } else if (item.value === 'UNKNOWN') {
      this.healthcareScore = 0.5;
     }
     this.onEnvironmentalRisk();
  }

  onTransportation(item: any) {
    if (item.value === 'MINORP') {
      this.transportationScore = 1;

     } else if (item.value === 'MODPRO') {
      this.transportationScore = 3;

     } else if (item.value === 'NOP') {
      this.transportationScore = 0;

     } else if (item.value === 'SERPRO') {
      this.transportationScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.transportationScore = 0.5;
     }
     this.onEnvironmentalRisk();
  }

  onClutter(item: any) {
    if (item.value === 'MINORP') {
      this.clutterScore = 1;

     } else if (item.value === 'MODPRO') {
      this.clutterScore = 3;

     } else if (item.value === 'NOP') {
      this.clutterScore = 0;

     } else if (item.value === 'SERPRO') {
      this.clutterScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.clutterScore = 0.5;
     }
     this.onEnvironmentalRisk();
  }

  onSelectFood(item: any) {
    if (item.value === 'MINORP') {
      this.foodScore = 1;

     } else if (item.value === 'MODPRO') {
      this.foodScore = 3;

     } else if (item.value === 'NOP') {
      this.foodScore = 0;

     } else if (item.value === 'SERPRO') {
      this.foodScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.foodScore = 0.5;
     }
     this.onEnvironmentalRisk();
  }

  onSelectSupervision(item: any) {
    if (item.value === 'MINORP') {
      this.supervisionScore = 1;

     } else if (item.value === 'MODPRO') {
      this.supervisionScore = 3;

     } else if (item.value === 'NOP') {
      this.supervisionScore = 0;

     } else if (item.value === 'SERPRO') {
      this.supervisionScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.supervisionScore = 0.5;
     }
     this.onEnvironmentalRisk();
  }

  onSelectUtilities(item: any) {
    if (item.value === 'MINORP') {
      this.utilitiesScore = 1;

     } else if (item.value === 'MODPRO') {
      this.utilitiesScore = 3;

     } else if (item.value === 'NOP') {
      this.utilitiesScore = 0;

     } else if (item.value === 'SERPRO') {
      this.utilitiesScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.utilitiesScore = 0.5;
     }
     this.onEnvironmentalRisk();
  }

  onEnvironmentalRisk() {
   this.environmentalRiskScore = this.healthcareScore + this.transportationScore + this.clutterScore + this.foodScore + this.utilitiesScore + this.supervisionScore;
   this.riskScoreUpdate();
  }

  onEatingSelect(item: any) {
    if (item.value === 'MINORP') {
      this.eatingSelectScore = 4;

     } else if (item.value === 'MODPRO') {
      this.eatingSelectScore = 10;

     } else if (item.value === 'NOP') {
      this.eatingSelectScore = 0;

     } else if (item.value === 'SERPRO') {
      this.eatingSelectScore = 16;

     } else if (item.value === 'UNKNOWN') {
      this.eatingSelectScore = 0.5;
     }
     this.onPhysicalRisk();
  }

  onTakingMedicationSelect(item: any) {
    if (item.value === 'MINORP') {
      this.takingMedicationScore = 4;

     } else if (item.value === 'MODPRO') {
      this.takingMedicationScore = 12;

     } else if (item.value === 'NOP') {
      this.takingMedicationScore = 0;

     } else if (item.value === 'SERPRO') {
      this.takingMedicationScore = 20;

     } else if (item.value === 'UNKNOWN') {
      this.takingMedicationScore = 0.5;
     }
     this.onPhysicalRisk();
  }

  onMobility(item: any) {
    if (item.value === 'MINORP') {
      this.mobilityScore = 4;

     } else if (item.value === 'MODPRO') {
      this.mobilityScore = 10;

     } else if (item.value === 'NOP') {
      this.mobilityScore = 0;

     } else if (item.value === 'SERPRO') {
      this.mobilityScore = 16;

     } else if (item.value === 'UNKNOWN') {
      this.mobilityScore = 0.5;
     }
     this.onPhysicalRisk();
  }

  onBathingSelect(item: any) {
    if (item.value === 'MINORP') {
      this.bathingScore = 4;

     } else if (item.value === 'MODPRO') {
      this.bathingScore = 12;

     } else if (item.value === 'NOP') {
      this.bathingScore = 0;

     } else if (item.value === 'SERPRO') {
      this.bathingScore = 20;

     } else if (item.value === 'UNKNOWN') {
      this.bathingScore = 0.5;
     }
     this.onPhysicalRisk();
  }

  onDressingSelect(item: any) {
    if (item.value === 'MINORP') {
      this.dressingScore = 4;

     } else if (item.value === 'MODPRO') {
      this.dressingScore = 12;

     } else if (item.value === 'NOP') {
      this.dressingScore = 0;

     } else if (item.value === 'SERPRO') {
      this.dressingScore = 20;

     } else if (item.value === 'UNKNOWN') {
      this.dressingScore = 0.5;
     }
     this.onPhysicalRisk();
  }

  onToileting(item: any) {
    if (item.value === 'MINORP') {
      this.toiletingScore = 4;

     } else if (item.value === 'MODPRO') {
      this.toiletingScore = 12;

     } else if (item.value === 'NOP') {
      this.toiletingScore = 0;

     } else if (item.value === 'SERPRO') {
      this.toiletingScore = 20;

     } else if (item.value === 'UNKNOWN') {
      this.toiletingScore = 0.5;
     }
     this.onPhysicalRisk();
  }

  onPhysicalRisk() {
   this.physicalRiskScore = this.eatingSelectScore + this.takingMedicationScore + this.mobilityScore + this.bathingScore + this.dressingScore + this.toiletingScore;
   this.riskScoreUpdate();
  }

  onDementiaSelect(item: any) {
    if (item.value === 'MINORP') {
      this.dementiaScore = 4;

     } else if (item.value === 'MODPRO') {
      this.dementiaScore = 10;

     } else if (item.value === 'NOP') {
      this.dementiaScore = 0;

     } else if (item.value === 'SERPRO') {
      this.dementiaScore = 16;

     } else if (item.value === 'UNKNOWN') {
      this.dementiaScore = 0.5;
     }
     this.onMentalRisk();
  }

  onDisorders(item: any) {
    if (item.value === 'MINORP') {
      this.disorderScore = 4;

     } else if (item.value === 'MODPRO') {
      this.disorderScore = 10;

     } else if (item.value === 'NOP') {
      this.disorderScore = 0;

     } else if (item.value === 'SERPRO') {
      this.disorderScore = 16;

     } else if (item.value === 'UNKNOWN') {
      this.disorderScore = 0.5;
     }
     this.onMentalRisk();
  }

  onSubstanceAbuse(item: any) {
    if (item.value === 'MINORP') {
      this.substanceAbuseScore = 1;

     } else if (item.value === 'MODPRO') {
      this.substanceAbuseScore = 3;

     } else if (item.value === 'NOP') {
      this.substanceAbuseScore = 0;

     } else if (item.value === 'SERPRO') {
      this.substanceAbuseScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.substanceAbuseScore = 0.5;
     }
     this.onMentalRisk();
  }

  onMoodDisorder(item: any) {
    if (item.value === 'MINORP') {
      this.moodDisorderScore = 1;

     } else if (item.value === 'MODPRO') {
      this.moodDisorderScore = 3;

     } else if (item.value === 'NOP') {
      this.moodDisorderScore = 0;

     } else if (item.value === 'SERPRO') {
      this.moodDisorderScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.moodDisorderScore = 0.5;
     }
     this.onMentalRisk();
  }

  onBehavioral(item: any) {
    if (item.value === 'MINORP') {
      this.behavioralScore = 1;

     } else if (item.value === 'MODPRO') {
      this.behavioralScore = 3;

     } else if (item.value === 'NOP') {
      this.behavioralScore = 0;

     } else if (item.value === 'SERPRO') {
      this.behavioralScore = 8;

     } else if (item.value === 'UNKNOWN') {
      this.behavioralScore = 0.5;
     }
     this.onMentalRisk();
  }

  onMentalRisk() {
   this.mentalRiskScore = this.dementiaScore + this.disorderScore + this.substanceAbuseScore + this.moodDisorderScore + this.behavioralScore;
   this.riskScoreUpdate();
  }



  onSelectSupportNetwork(item: any) {
   if (item.value === 'MINORP') {
     this.supportNetworkScore = 5;

   } else if (item.value === 'MODPRO') {
     this.supportNetworkScore = 15;

   } else if (item.value === 'NOP') {
     this.supportNetworkScore = 0;

   } else if (item.value === 'SERPRO') {
     this.supportNetworkScore = 25;

   } else if (item.value === 'UNKNOWN') {
     this.supportNetworkScore = 3;
   }
   this.riskScoreUpdate();
  }

  riskScoreUpdate() {
    if (!this.disableButton) {
      if (this.adultScreenFormGroup.get('clientinfoname')?.value !== '' && this.adultScreenFormGroup.get('clientinfoname')?.value !== undefined) {
        this.adultScreenFormGroup.patchValue({
          riskscore: this.environmentalRiskScore + this.physicalRiskScore + this.mentalRiskScore + this.supportNetworkScore
        });
        this.riskScore = this.adultScreenFormGroup.get('riskscore')?.value;
        if (this.riskScore <= 49.5) {
          this.riskLevel = 'Low';
        } else if (this.riskScore > 49.5 && this.riskScore <= 99.5) {
          this.riskLevel = 'Moderate';
        } else if (this.riskScore >= 100) {
          this.riskLevel = 'High';
        }
        if (this.riskLevel) {
          this.adultScreenFormGroup.patchValue({
            risklevel: this.riskLevel
          });
        }
        this.setIntakeRecommendation();
      }
    }
  }

  setIntakeRecommendation(){
    if (this.physicalAbuse && this.selfNeglect && this.neglectedByOthers && this.exploitation
      && this.sexExploitation && this.physicalEnvironment) {
      if (this.physicalAbuse === 1 || this.selfNeglect === 1 || this.neglectedByOthers === 1 ||
        this.exploitation === 1 || this.sexExploitation === 1 || this.physicalEnvironment === 1) {
        this.intakeRecommendation = 'POTENTIAL APS INVESTIGATION';
      } else {
        this.intakeRecommendation = 'NO INVESTIGATION WARRANTED';
      }
    } else {
      this.intakeRecommendation = 'You DID NOT Answer All Questions';
    }
    if (this.intakeRecommendation) {
      this.adultScreenFormGroup.patchValue({
        intakerecommendation: this.intakeRecommendation
      });
    }
  }


  /**
   * Loading remaining tab - drop down - end
   *
   */
  onPhysicalAbuse(items: { value: any; }) {
    this.physicalAbuse = items.value;
    this.riskScoreUpdate();
  }
  onSelfNeglect(items: { value: any; }) {
    this.selfNeglect = items.value;
    this.riskScoreUpdate();
  }

  onNeglectByOthers(items: { value: any; }) {
    this.neglectedByOthers = items.value;
    this.riskScoreUpdate();
  }

  onExploitation(items: { value: any; }) {
    this.exploitation = items.value;
    this.riskScoreUpdate();
  }

  onSexExploitation(items: { value: any; }) {
    this.sexExploitation = items.value;
    this.riskScoreUpdate();
  }

  onPhysicalEnvironment(items: { value: any; }) {
    this.physicalEnvironment = items.value;
    this.riskScoreUpdate();
  }

  private loadResponseTime() {

    const source = this._commonHttpService.getArrayList(
      {
        where: { teamtypekey: 'AS', intakeservreqtypeid: this.daTypeKey },
        method: 'get',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Intake.responseTimeLoad
    ).pipe(map((result) => {
      return {
        response: result.map(
          (res) =>
            new DropdownModel({
              text: res.description,
              value: res.intakeservid
            })
        )
      };
    }),share(),);

    this.subServiceTypes$ = source.pipe(pluck('response'));
  }

  loadSelectedSubType(subServiceType: any) {
    this.getResponseTime(subServiceType.value);
  }

  getSelectedSubtype(subTypeID: any): SubType | undefined {
    return this.subServiceTypes.find((subServiceType: any) =>
        subServiceType.servicerequestsubtypeid === subTypeID
    );
  }

  private getResponseTime(intakeServId: any) {
    this._dataStoreService.getCurrentStore();
    const source = this._commonHttpService.getArrayList(
      {
        where: { teamtypekey: 'AS', intakeservreqtypeid: this.daTypeKey, intakeservid: intakeServId },
        method: 'get',
        nolimit: true
      },
      CommonUrlConfig.EndPoint.Intake.responseTimeGet
    ).pipe(map((result) => {
      return {
        response: result.map(
          (res) =>
            new DropdownModel({
              text: res.description,
              value: res.servicerequestsubtypeid
            })
        )
      };
    }),share(),);

    this.subServiceDropDownTypes$ = source.pipe(pluck('response'));
    this.subServiceDropDownTypes$.subscribe(result => {
      result.forEach((res) => {
        this.subTypeKey = res.value;
      });
    });
  }
  saveAdultScreen() {
    const astData = this.adultScreenFormGroup.getRawValue();
    astData.adultscreentoolhouseholdconfig = this.houseHold;
    astData['isComplete'] = this.disableButton;
    astData['subTypeId'] = this.subTypeKey;
    this._dataStoreService.setData(IntakeStoreConstants.adultScreenTool, Object.assign(astData));
  }

  reset() {
    this.adultScreenFormGroup.reset();
  }

  completeScreen() {
    if (this.daTypeKey) {
      this.adultScreenFormGroup.disable();
      this.disableButton = true;
      this.saveAdultScreen();
    } else {
      this._alertService.error(
        'Please select Purpose value on the screen'
      );
    }
  }

  patchForm(modal: any) {
    if (modal) {
      this.adultScreenFormGroup.patchValue(modal);
      this.houseHold$ = observableOf(modal.adultscreentoolhouseholdconfig);
    }
  }
}
