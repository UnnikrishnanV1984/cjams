import { Component, OnInit, EventEmitter, Output, Input, Injector } from '@angular/core';
import { Router } from '@angular/router';
import { FormArray, FormBuilder, FormGroup } from '@angular/forms';
import _ from 'lodash';
import { MatDialog } from '@angular/material/dialog';
declare var $: any;
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';
import {AlertService, CommonHttpService, AuthService, DataStoreService} from '../../../../@core/services';
import { DatePipe } from '@angular/common';
import moment from 'moment';

interface LooseObject {
  [key: string]: any;
}
@Component({
    selector: 'adoption-eligibility',
    templateUrl: './adoption-eligibility.component.html',
    styleUrls: ['./adoption-eligibility.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class AdoptionEligibilityComponent implements OnInit {
  @Output() submitForReview: EventEmitter<any> = new EventEmitter();
  adoptioneligibilityForm: any;
  @Input() eligibilityData: any;
  @Input() adoptionData: any;
  generalRequirement!: FormGroup;
  otherCriteria!: FormGroup;
  adoptionExt!: FormGroup;
  iveStatus!: FormGroup;
  TbdFields!: FormGroup;
  TitleIVeStatus!: FormGroup;
  SpecialNeedsOfChild!: FormGroup;
  ChildStatusInfo!: FormGroup;
  PlacementAndMedicalInfo!: FormGroup;
  AdoptionApplicable: any;
  AdoptionApplicability: any;
  AdoptionApplicableInn: any;
  RedeterminationStatus: any;
  AdoptionNonapplicability: any;
  AdoptionIncomplete: any;
  adoptionAssistance: any;
  adoptionnonApplicable: any;
  RedeteradoptionAssistance: any;
  RedetExtAdoption: any;
  eligibilityOneFormData: any;
  countyname: any;

  @Output() submitRedetermination = new EventEmitter();
  @Output() submitInitialdetermination = new EventEmitter();
  adoptionDetails: any;
  client_id: any;
  removalid: any;
  adoptionMigratedData: any;
  firstGenList = [];
  caseNumber: any;
  clientName: any;
  @Input() pagesnapshot: any;
  isreadonly: any;
  private router: Router;
  private formBuilder: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _alertService: AlertService;
  private _dataStore: DataStoreService;
  public _authService: AuthService;
  constructor(private injector: Injector, public dialog: MatDialog, private datePipe: DatePipe) {
    this.router = this.injector.get<Router>(Router);
    this.formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dataStore = this.injector.get<DataStoreService>(DataStoreService);
    this._authService = this.injector.get<AuthService>(AuthService);
  }

  ChildStatusInfoSubmit() {
    this.ChildStatusInfo.reset();
  }
  PlacementAndMedicalInfoSubmit() {
    this.PlacementAndMedicalInfo.reset();
  }
  SpecialNeedsOfChildSubmit() {
    this.SpecialNeedsOfChild.reset();
  }
  TitleIVeStatusSubmit() {
    this.TitleIVeStatus.reset();
  }
  ngOnInit() {
    this.createFormGroup();
    this._dataStore.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
    if (this.pagesnapshot) {
      this.adoptioneligibilityForm.patchValue(this.pagesnapshot);
      this.adoptioneligibilityForm.disable();
    } else {
      this.client_id = this.router.routerState.snapshot.url.split('/')[4];
      this.removalid = this.router.routerState.snapshot.url.split('/')[5];
      this.getAdoptionEligibilityInfo();
    }
    if (this.removalid == 'null') {
          this.getAdoptionHistoryByPerson();
    }
    this._authService.readonlyPage('read_only_access','',
    [this.adoptioneligibilityForm]);
  }


    getAdoptionHistoryByPerson() {
        // client_id comes from snapshot.url.split('/')[4], so it is the literal
        // string 'null' whenever the navigation that opened this page built the URL
        // from a list row with no client id -- the same reason removalid is compared
        // against the string 'null' above. adoption-history declares clientId as a
        // required number, so strong-remoting rejects '/adoption-history/null' with
        // a 400 before the query runs and the subscribe below never fires.
        if (!this.client_id || isNaN(Number(this.client_id))) {
            return;
        }
        this._commonHttpService.getAll('iveadoption/adoption/adoption-history/' + this.client_id
        ).subscribe(data => {
            this.adoptionMigratedData = data[0];
            this.adoptioneligibilityForm.patchValue({ dateofbirth: data[0].dateofbirth});
            this.adoptioneligibilityForm.patchValue({ nameofchild: data[0].childname});
            this.adoptioneligibilityForm.patchValue({ clientid: data[0].clientid});
            this.adoptioneligibilityForm.patchValue({ provideridofadoptiveparent: data[0].parent1providerid});
            this.adoptioneligibilityForm.patchValue({ countyofjurisdiction: data[0].childjurisdiction});
            this.adoptioneligibilityForm.patchValue({ nameofadoptiveparent1: data[0].parent1providername});
            this.adoptioneligibilityForm.patchValue({ nameofadoptiveparent2: data[0].parent2providername});
            if (data[0].removalage) {
                    if (data[0].removalage === 'M') {
                        this.adoptioneligibilityForm.patchValue({gender: 'Male'});
                    } else if (data[0].removalage === 'F') {
                        this.adoptioneligibilityForm.patchValue({gender: 'Female'});
                    } else if (data[0].removalage === 'O') {
                        this.adoptioneligibilityForm.patchValue({gender: 'Other'});
                    }
                }
        });
    }


  createFormGroup() {
    this.adoptioneligibilityForm = this.formBuilder.group({
      countyofjurisdiction: [''],
      nameofchild: [''],
      childagency: [''],
      casenumber: [''],
      servicecaseid: [''],
      adoptioncasenumber: [''],
      adoptioncaseid: [''],
      adoptionstartdate: [''],
      createdate: [''],
      ivestatus: [''],
      clientid: [''],
      dateofbirth: [''],
      gender: [''],
      bioclientid: [''],
      nameofadoptiveparent1: [''],
      nameofadoptiveparent2: [''],
      provideridofadoptiveparent: [''],
      dateofadoptionfinalization: [null],
      singleparentadoptioncheck: [''],
      adoptionparent1signdate: [null],
      adoptionparent2signdate: [null],
      adoptionldssdate: [null],
      adoptionpetitiondate: [null],
      childmeetallmedicaldisabilityrequirementsforssi: [''],
      child617yearsofage: [''],
      physicalmentalemotionaldisability: [''],
      emotionaldisturbance: [''],
      siblinginformationcheck: [''],
      siblinggroup: this.formBuilder.array([]),
      recognizedhighriskofphysicaldisability: [''],
      raceethnicityofchild: [''],
      raceorethnicitywithoneofthesabove: [''],
      effortstoplacechildweremade: [null],
      dtofdocforeffortstoplacewithoutasubsidy: [null],
      exceptiongrantedinchildsbestinterests: [''],
      dtofdocumentationforexceptiongrantedinchildsbi: [null],
      isreasonforexceptionrecorded: [''],
      unsuccessfulreasonableeffortsstatusrecords: [''],
      tprGrantedtoBothParent: [''],
      dateofTpRofParent1: [null],
      dateofTpRofParent2: [null],
      ifnoReasonfornotgrantingTpRforbothparent: [''],
      canchildreturntohome: [''],
      descriptionofreturnhome: [''],
      isuscitizen: [''],
      isqualifiedalien: [''],
      age: [''],
      isthechildresidinginafosterfamilyhome: [''],
      childspreviouslyadopted: [''],
      childsIvEStatusofpreviousadoption: [''],
      previousAdoptiveParentsTpRterminationDate: [null],
      previousAdoptiveParentsDeathDateIfdead: [''],
      childreceivingssiatremoval: [''],
      startdateofreceivingssi: [null],
      minorparentivefostercarestatus: [''],
      dateoflatestpaymentofminorparentivefostercare: [null],
      minorparentivefostercarestartdate: [null],
      isafdceligibilitymet: [''],
      wasthechildremovedfromspecifiedrelative: [''],
      childdeprivedofparentalsupport: [''],
      isincomeassetsmet: [''],
      childremovaldate: [null],
      removalcourtorderdate: [null],
      voluntaryrelinquishment: [''],
      childapplicableassessmentdt: [null],
      childapplicabilitystatus: [''],
      adoptionassistancestartdate: [null],
      adoptionapplicabilitystartdt: [null],
      adoptionapplicabilityminorparentinfo: this.formBuilder.array([]),
      istheminorparentreceivingivefc: [null],
      isdocumentedphysicalandmentaldisability: [null]
    });
  }

  isTabSwitched() {
    $('.adoption a').on('shown.bs.tab', (event:any) => {
      var x = $(event.target).text();
      if (x.includes("DETAILS")) {
        this.getAdoptionEligibilityInfo();
      }
    });
  }

    saveData() {
        const finalsubmission = this.adoptioneligibilityForm.value;
        var request = {
            'clientId': Number(this.client_id),
            ...finalsubmission
        };
        this._commonHttpService.create(request, Titile4eUrlConfig.EndPoint.saveadoptioneligibility).subscribe(
            (res) => {
                this._alertService.success("Adoption data saved successfully!");
            },
            (error) => {
                this._alertService.error("Adoption data save Failed");
            });

    }

  submissionData() {
    const siblingDetails :any[]= [];
    if (this.adoptioneligibilityForm.value.siblinggroup && this.adoptioneligibilityForm.value.siblinggroup.length > 0) {
      this.siblingDetailsPushFn(siblingDetails);
    } else {
      this.siblingNullDetailsPushFn(siblingDetails);
    }

    let childAdopApplicabilityStatus = null;

    if (this.adoptioneligibilityForm.value.childapplicabilitystatus === 'Adoption Applicable and NonApplicable') {
        childAdopApplicabilityStatus = 'An applicable and non-applicable child';
    } else if (this.adoptioneligibilityForm.value.childapplicabilitystatus === 'Neither Applicable or NonApplicable') {
        childAdopApplicabilityStatus = 'Neither an applicable nor a non-applicable child';
    } else if (this.adoptioneligibilityForm.value.childapplicabilitystatus === 'Applicable') {
          childAdopApplicabilityStatus = 'An applicable child';
    }  else if (this.adoptioneligibilityForm.value.childapplicabilitystatus === 'NonApplicable') {
        childAdopApplicabilityStatus = 'A Non-applicable child';
    }

    const submissiondata: LooseObject = {
      'cjamsPid': Number(this.client_id),
      'removalid': this.removalid,
      'pagesnapshot': this.adoptioneligibilityForm.getRawValue(),
      'initialDetermination': {
        'payload': {
          "name": "Adoption",
          "__metadataRoot": {},
          "Objects": this.initialDeterminationObjects(siblingDetails, childAdopApplicabilityStatus)
        }
      }
    }

    this.postAdoptionApplicabilityApiFn(submissiondata);
  }
  
  private siblingNullDetailsPushFn(siblingDetails: any[]) {
    siblingDetails.push({
      "SiblingAdoptionDecreeDate": null,
      "SiblingApplicableChildAssessmentDate": null,
      "SiblingAdoptionApplicable": null,
      "SiblingAdoptiveProviderID": null,
      "SiblingName": null,
      "__metadata": {
        "#type": "SiblingDetails",
        "#id": "SiblingDetails_id_1"
      }
    });
  }

  private siblingDetailsPushFn(siblingDetails: any[]) {
    this.adoptioneligibilityForm.value.siblinggroup.forEach((element:any, index:any) => {
      siblingDetails.push({
        "SiblingAdoptionDecreeDate": this.dateConversion(element.siblingadoptiondecreedate),
        "SiblingApplicableChildAssessmentDate": this.dateConversion(element.siblingapplicablechildassessmentdate),
        "SiblingAdoptionApplicable": element.siblingadoptionstatus === '' ? null : element.siblingadoptionstatus,
        "SiblingAdoptiveProviderID": element.nameofthesiblingadoptionplacementproviderid ? element.nameofthesiblingadoptionplacementproviderid : null,
        "SiblingName": element.siblingname,
        "__metadata": {
          "#type": "SiblingDetails",
          "#id": "SiblingDetails_id_" + index
        }
      });
    });
  }

  private postAdoptionApplicabilityApiFn(submissiondata: LooseObject) {
    this._commonHttpService.create(submissiondata, Titile4eUrlConfig.EndPoint.postAdoptionApplicability).subscribe(
      (res) => {
        this.submitForReview.emit();
        this._alertService.success("Submitted successfully!");
      },
      (error) => {
        this._alertService.error("Submission Failed");
      });
  }

  private initialDeterminationObjects(siblingDetails: any[], childAdopApplicabilityStatus: any) {
    return [
      {
        "DateAndTimeOfDocumentationForEffortsToPlaceWithoutSubsidy": this.adoptioneligibilityForm.value.effortstoplacechildweremade === 'YES' ? this.dateTimeConversion(this.adoptioneligibilityForm.value.dtofdocforeffortstoplacewithoutasubsidy) : null,
        "AdoptionAssistanceAgreement_FutureNeedsAgreement_Date_AdoptiveParents_2": this.dateTimeConversion(this.adoptioneligibilityForm.value.adoptionparent2signdate),
        "AdoptionAssistanceAgreement_FutureNeedsAgreement_Date_AdoptiveParents_1": this.dateTimeConversion(this.adoptioneligibilityForm.value.adoptionparent1signdate),
        "AdoptionFinalizationDate": this.dateTimeConversion(this.adoptioneligibilityForm.value.dateofadoptionfinalization),
        "ChildApplicableAssessmentDate": this.dateConversion(this.adoptioneligibilityForm.value.childapplicableassessmentdt),
        "AdoptionPetitionFiledDate": this.dateConversion(this.adoptioneligibilityForm.value.adoptionpetitiondate),
        "ExceptionGrantedInChildsBestInterests": this.adoptioneligibilityForm.value.exceptiongrantedinchildsbestinterests,
        "DateAndTimeOfDocumentationForExceptionGrantedInChildsBestInterests": this.dateTimeConversion(this.adoptioneligibilityForm.value.dtofdocumentationforexceptiongrantedinchildsbi),
        "AdoptionAssistanceStartDate": this.dateConversion(this.adoptioneligibilityForm.value.adoptionassistancestartdate),
        "TPRGrantedtoBothParent": this.adoptioneligibilityForm.value.tprGrantedtoBothParent,
        "AnotherReasonForChildNotReturningHome": (this.adoptioneligibilityForm.value.descriptionofreturnhome === undefined || this.adoptioneligibilityForm.value.descriptionofreturnhome === null) ? null : this.AnotherReasonForChildNotReturningHomeFalseCondition(),
        "AdoptionAssistanceAgreement_FutureNeedsAgreement_Date_Agency": this.dateTimeConversion(this.adoptioneligibilityForm.value.adoptionldssdate),
        "IsReasonForExceptionRecorded": this.adoptioneligibilityForm.value.isreasonforexceptionrecorded,
        "QualifiedAlien": this.adoptioneligibilityForm.value.isuscitizen === 'YES' ? 'NO' : this.qualifiedAlienFalseCondition(),
        "ReasonForNotGrantingTPRForParent": this.adoptioneligibilityForm.value.ifnoReasonfornotgrantingTpRforbothparent,
        "USCitizen": this.adoptioneligibilityForm.value.isuscitizen,
        "applicantInformation": {
          "ClientID": this.client_id,
          "__metadata": {
            "#type": "ApplicantInformation",
            "#id": "ApplicantInformation_id_1"
          }
        },
        "person": this.initialDeterminationPersonData(siblingDetails),
        "AdoptionApplicabilityStartDate": this.dateConversion(this.adoptioneligibilityForm.value.adoptionapplicabilitystartdt),
        "DidEffortsToPlaceChildWereMade": this.adoptioneligibilityForm.value.effortstoplacechildweremade,
        "SingleParentAdoptionCheck": this.adoptioneligibilityForm.value.singleparentadoptioncheck ? "YES" : "NO",
        "__metadata": {
          "#type": "Application",
          "#id": "Application_id_1"
        },
        "DateOfTPROfParent_2": this.dateConversion(this.adoptioneligibilityForm.value.dateofTpRofParent2),
        "DateOfTPROfParent_1": this.dateConversion(this.adoptioneligibilityForm.value.dateofTpRofParent1),
        "status": {
          "AdoptionAssistance": null,
          "ChildApplicabilityStatus": childAdopApplicabilityStatus ? childAdopApplicabilityStatus : null,
          "__metadata": {
            "#type": "Status",
            "#id": "Status_id_1"
          }
        }
      }
    ];
  }

  private qualifiedAlienFalseCondition() {
    return this.adoptioneligibilityForm.value.isqualifiedalien === '' ? null : this.adoptioneligibilityForm.value.isqualifiedalien;
  }

  private AnotherReasonForChildNotReturningHomeFalseCondition() {
    return this.adoptioneligibilityForm.value.descriptionofreturnhome === '' ? 'NO' : 'YES';
  }

  private initialDeterminationPersonData(siblingDetails: any[]) {
    return {
      "ChildHasFosterParentEmotionalTies": null,
      "IncomeAndAssetsMetAFDCStandards": this.adoptioneligibilityForm.value.isincomeassetsmet,
      "ChildAdoptionUnsuccessfulEffortsToPlace": this.adoptioneligibilityForm.value.unsuccessfulreasonableeffortsstatusrecords === '' ? null : this.adoptioneligibilityForm.value.unsuccessfulreasonableeffortsstatusrecords,
      "ChildRaceEthnicity": this.adoptioneligibilityForm.value.raceorethnicitywithoneofthesabove,
      "Gender": this.adoptioneligibilityForm.value.gender,
      "parentDetails": this.initialDeterminationparentDetailsData(),
      "ChildHasHighRiskOfDisability": this.adoptioneligibilityForm.value.recognizedhighriskofphysicaldisability ? 'YES' : 'NO',
      "Name": this.adoptioneligibilityForm.value.nameofchild,
      "Child_Removal_Date": this.dateConversion(this.adoptioneligibilityForm.value.childremovaldate),
      "ChildRemovedFromSpecifiedRelative": this.adoptioneligibilityForm.value.wasthechildremovedfromspecifiedrelative,
      "ChildDeprivedOfParentalSupport": this.adoptioneligibilityForm.value.childdeprivedofparentalsupport,
      "ChildCanReturnToHome": this.adoptioneligibilityForm.value.canchildreturntohome === "" ? null : this.adoptioneligibilityForm.value.canchildreturntohome,
      "ChildExpectedAdoptiveProviderID": this.adoptioneligibilityForm.value.provideridofadoptiveparent,
      "ChildHasEmotionalDisturbance": this.adoptioneligibilityForm.value.emotionaldisturbance ? 'YES' : 'NO',
      "ChildCurrentIVEFosterCareEligibilityStatus": null,
      "__metadata": {
        "#type": "Person",
        "#id": "Person_id_1"
      },
      "DateOfBirth": this.dateConversion(this.adoptioneligibilityForm.value.dateofbirth),
      "Removal_Court_Order_Date": this.dateConversion(this.adoptioneligibilityForm.value.removalcourtorderdate),
      "ChildPreviousAdoptiveParentTPRDate": this.dateConversion(this.adoptioneligibilityForm.value.previousAdoptiveParentsTpRterminationDate),
      "ChildMeetsSSIMedicalDisabledEligReqts": this.adoptioneligibilityForm.value.childmeetallmedicaldisabilityrequirementsforssi,
      "VoluntaryRelinquishment": this.adoptioneligibilityForm.value.voluntaryrelinquishment,
      "ChildSSIEligibilityStatusOnOrBeforeDateOfAdoption": this.adoptioneligibilityForm.value.childreceivingssiatremoval,
      "ChildPreviousAdoptiveParentDeathDate": this.dateConversion(this.adoptioneligibilityForm.value.previousAdoptiveParentsDeathDateIfdead),
      "ChildHasPhysicalMentalEmotionalDisability": this.adoptioneligibilityForm.value.physicalmentalemotionaldisability ? 'YES' : 'NO',
      "CountyOfJurisdiction_LDSS": this.adoptioneligibilityForm.value.countyofjurisdiction ? this.adoptioneligibilityForm.value.countyofjurisdiction.trim() : null,
      "siblingDetails": siblingDetails,
      "StartDateOfReceivingSSI": this.dateConversion(this.adoptioneligibilityForm.value.startdateofreceivingssi),
      "ChildPreviousAdoptionIVEStatus": this.adoptioneligibilityForm.value.childsIvEStatusofpreviousadoption === '' ? null : this.adoptioneligibilityForm.value.childsIvEStatusofpreviousadoption,
      "ChildExpectedAdoptionDate": this.dateConversion(this.adoptioneligibilityForm.value.previousAdoptiveParentsTpRterminationDate),
      "ChildPreviouslyAdopted": this.adoptioneligibilityForm.value.childspreviouslyadopted
    };
  }

  private initialDeterminationparentDetailsData() {
    return [{
      "MinorParentRemovalDate": (this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo && this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo.length > 0) ? this.dateConversion(this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo[0].removaldateofminorparent) : null,
      "MinorParentName": (this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo && this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo.length > 0) ? this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo[0].minorparentname : null,
      "MinorParentCurrentPlacementType": (this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo && this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo.length > 0) ? this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo[0].minorparentscurrentplacementtype : null,
      "MinorParentDateOfBirth": (this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo && this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo.length > 0) ? this.dateConversion(this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo[0].birthdateofparent) : null,
      "MinorParentRemovalCourtOrderDate": (this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo && this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo.length > 0) ? this.dateConversion(this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo[0].removalcourtorderdateofminorparent) : null,
      "MinorParentIVEEligibilityForFosterCareStatus": this.adoptioneligibilityForm.value.minorparentivefostercarestatus === '' ? null : this.adoptioneligibilityForm.value.minorparentivefostercarestatus,
      "__metadata": {
        "#type": "ParentDetails",
        "#id": "ParentDetails_id_1"
      },
      "MinorParentIVEEligibilityForFosterCareStartDate": this.dateConversion(this.adoptioneligibilityForm.value.minorparentivefostercarestartdate),
      "DateOfLatestPaymentOfMinorParentIVEEligibilityForFosterCare": this.dateConversion(this.adoptioneligibilityForm.value.dateoflatestpaymentofminorparentivefostercare),
      "MinorParentPhysicalAddress": (this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo && this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo.length > 0) ? this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo[0].physicaladdressofminorparent : null,
      "ChildPhysicalAddress": (this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo && this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo.length > 0) ? this.adoptioneligibilityForm.value.adoptionapplicabilityminorparentinfo[0].physicaladdressofchild : null
    }];
  }

  dateConversion(date:any) {
    if (date === undefined || date === null || date === '') {
      return null;
    } else {
      return moment(date).format('MM/DD/YYYY');
    }
  }

  dateTimeConversion(date:any) {
    if (date === undefined || date === null || date === '') {
      return null;
    } else {
      return moment(date).format('MM/DD/YYYY HH:mm:ss');
    }
  }
  getAdoptionEligibilityInfo() {
    if (this.adoptionData) {
      this.eligibilityOneFormData = this.adoptionData;
      this.adoptionDetails = this.eligibilityOneFormData.adoptionEligibilityInfo[0];
      this.clientName = this.eligibilityOneFormData.adoptionEligibilityInfo[0].childname;
      this.mapData();
    }
  }
  mapData() {
    if (this.eligibilityOneFormData && this.eligibilityOneFormData.adoptionEligibilityInfo && this.eligibilityOneFormData.adoptionEligibilityInfo.length > 0) {
      this.adoptioneligibilityForm.patchValue(this.eligibilityOneFormData.adoptionEligibilityInfo[0]);

      if (this.eligibilityOneFormData.adoptionEligibilityInfo[0].tprdetails == null) {
          this.adoptioneligibilityForm.patchValue({
              tprGrantedtoBothParent: this.eligibilityOneFormData.adoptionEligibilityInfo[0].tprgrantedtobothparent,
              dateofTpRofParent1: this.eligibilityOneFormData.adoptionEligibilityInfo[0].dateoftprofparent1,
              dateofTpRofParent2: this.eligibilityOneFormData.adoptionEligibilityInfo[0].dateoftprofparent2,
          });
      }
      if (this.eligibilityOneFormData.adoptionEligibilityInfo[0].dateoflatestpaymentofminorparent !== null) {
          this.adoptioneligibilityForm.patchValue({
              dateoflatestpaymentofminorparentivefostercare: this.eligibilityOneFormData.adoptionEligibilityInfo[0].dateoflatestpaymentofminorparent,
          });
      }

      if (this.eligibilityOneFormData.adoptionEligibilityInfo[0].tprdetails !== null && this.eligibilityOneFormData.adoptionEligibilityInfo[0].tprdetails.length > 0) {
        const tprdetails = this.eligibilityOneFormData.adoptionEligibilityInfo[0].tprdetails;
        let isgranted = true;

        if (tprdetails && tprdetails.length !== 2) {
          isgranted = false;
        }

        this.tprdetailsIfElseCondition(isgranted, tprdetails);
      }

      this.siblinggroupFn();
      this.minorparentinfoFn();
    }
  }

  private tprdetailsIfElseCondition(isgranted: boolean, tprdetails: any) {
    if (isgranted) {
      this.adoptioneligibilityForm.patchValue({
        tprGrantedtoBothParent: 'YES',
        dateofTpRofParent1: tprdetails[0].tprdecisiondate,
        dateofTpRofParent2: tprdetails[1].tprdecisiondate
      });
    } else {
      this.adoptioneligibilityForm.patchValue({
        tprGrantedtoBothParent: 'NO'
      });
      tprdetails.forEach((tprdetail:any) => {
        if (tprdetail.isgranted === 'NO') {
          this.adoptioneligibilityForm.patchValue({
            ifnoReasonfornotgrantingTpRforbothparent: tprdetail.reason,
            tprGrantedtoBothParent: 'NO',
          });
        }
      });
    }
  }

  private minorparentinfoFn() {
    if (this.eligibilityOneFormData?.adoptionEligibilityInfo[0]?.minorparentinfo?.length === 0) {
      this.eligibilityOneFormData.adoptionEligibilityInfo[0].minorparentinfo = null;
    }

    if (this.eligibilityOneFormData.adoptionEligibilityInfo[0] && _.isArray(this.eligibilityOneFormData.adoptionEligibilityInfo[0].minorparentinfo)) {
      const minorparent = this.eligibilityOneFormData.adoptionEligibilityInfo[0].minorparentinfo;
      this.adoptioneligibilityForm.patchValue(minorparent[0]);
      const adoptionapplicabilityminorparentinfocontrol = <FormArray>this.adoptioneligibilityForm.controls.adoptionapplicabilityminorparentinfo;
      this.minorparentinfoIfConditionFn(minorparent, adoptionapplicabilityminorparentinfocontrol);
    }
  }

  private minorparentinfoIfConditionFn(minorparent: any, adoptionapplicabilityminorparentinfocontrol: FormArray) {
    minorparent.forEach((element:any) => {
      adoptionapplicabilityminorparentinfocontrol.push(this.formBuilder.group({
        minorparentid: [element.minorparentid],
        minorparentname: [element.minorparentname],
        birthdateofparent: [element.birthdateofparent],
        removaltypeofminorparent: [element.removaltypeofminorparent],
        removalcourtorderdateofminorparent: [element.removalcourtorderdateofminorparent],
        removaldateofminorparent: [element.removaldateofminorparent],
        minorparentscurrentplacementtype: [element.minorparentscurrentplacementtype],
        childscurrentplacementtype: [element.childscurrentplacementtype],
        physicaladdressofminorparent: [element.physicaladdressofminorparent],
        physicaladdressofchild: [element.physicaladdressofchild]
      })
      );
    });
  }

  private siblinggroupFn() {
    if (this.eligibilityOneFormData?.adoptionEligibilityInfo[0]?.siblingsinfo?.length === 0) {
      this.eligibilityOneFormData.adoptionEligibilityInfo[0].siblingsinfo = null;
    }
  
    const adoptionapplicabilitysiblinginfocontrol = <FormArray>this.adoptioneligibilityForm.controls.siblinggroup;
    if (this.eligibilityOneFormData.adoptionEligibilityInfo[0] && _.isArray(this.eligibilityOneFormData.adoptionEligibilityInfo[0].eligiblesiblingsinfo)) {
      this.siblinggroupIfConditionFn(adoptionapplicabilitysiblinginfocontrol);
    } else if (this.eligibilityOneFormData.adoptionEligibilityInfo[0] && _.isArray(this.eligibilityOneFormData.adoptionEligibilityInfo[0].siblingsinfo)) {
      this.siblinggroupElseIfConditionFn(adoptionapplicabilitysiblinginfocontrol);
    }
  }

  private siblinggroupElseIfConditionFn(adoptionapplicabilitysiblinginfocontrol: FormArray) {
    this.eligibilityOneFormData.adoptionEligibilityInfo[0].siblingsinfo.forEach((element:any) => {
      adoptionapplicabilitysiblinginfocontrol.push(this.formBuilder.group({
        siblingname: [element.siblingname ? element.siblingname : element.nameofsiblingchild],
        siblingadoptionstatus: [element.siblingadoptionstatus],
        nameofthesiblingadoptionplacementproviderid: [element.adpsiblingname ? element.adpsiblingname : element.nameofthesiblingadoptionplacementproviderid],
        dateofsiblingsadoptiondecree: [element.dateofsiblingsadoptiondecree ? element.dateofsiblingsadoptiondecree : element.dtofsiblingsadoptiondecree],
        dateofsiblingsapplicablechildassessment: [element.dateofsiblingsapplicablechildassessment]
      })
      );
    });
  }

  private siblinggroupIfConditionFn(adoptionapplicabilitysiblinginfocontrol: FormArray) {
    this.eligibilityOneFormData.adoptionEligibilityInfo[0].eligiblesiblingsinfo.forEach((element:any) => {
      adoptionapplicabilitysiblinginfocontrol.push(this.formBuilder.group({
        siblingname: [element.nameofsiblingchild],
        siblingadoptionstatus: [element.siblingadoptionstatus],
        nameofthesiblingadoptionplacementproviderid: [element.siblingproviderid ? element.siblingproviderid : element.adpsiblingname],
        dateofsiblingsadoptiondecree: [element.dateofsiblingsadoptiondecree ? element.dateofsiblingsadoptiondecree : element.dtofsiblingsadoptiondecree],
        dateofsiblingsapplicablechildassessment: [element.dateofsiblingsapplicablechildassessment]
      })
      );
    });
  }
}
