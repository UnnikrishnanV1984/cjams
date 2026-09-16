import { Component, EventEmitter, Injector, Input, OnInit, Output } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { FormArray, FormBuilder, FormGroup } from '@angular/forms';
import { MatDialog } from '@angular/material/dialog';
import { AlertService, CommonHttpService, AuthService, DataStoreService } from '../../../../@core/services';
import { DatePipe } from '@angular/common';
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';
import moment from 'moment';
import _ from 'lodash';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../../../app/pages/case-worker/case-worker-url.config';
interface LooseObject {
  [key: string]: any;
}
@Component({
    selector: 'title-ive-gapeligibility',
    templateUrl: './title-ive-gapeligibility.component.html',
    styleUrls: ['./title-ive-gapeligibility.component.scss'],
    providers: [DatePipe],
    standalone: false
})
export class TitleIveGapeligibilityComponent implements OnInit {
  @Output() submitForReview: EventEmitter<any> = new EventEmitter();
  @Input() gapData: any;
  client_id :string = '';
  servicecase_id = '';
  gapEligibilityData: any;
  formData: any;
  countyname: any;
  siblingGurdianNamedetails :any[]= [];
  removal_id!: string;
  controlSiblingarry :any= [];
  controlarry = [];
  placementinfo = [];
  placementhistory :any[]= [];
  safetyAndAppropriateness = false;
  gapEligibilityForm!: FormGroup;
  @Input() pagesnapshot: any;
  haapprovaldtjson!: DropdownModel[];
  relationShipToRADropdownItems!: DropdownModel[];
  isreadonly: any;
  submitsuccessmsg = 'Submitted successfully!';
  submitfailedmsg = "Submission Failed";
  private fb: FormBuilder;
  private _commonHttpService: CommonHttpService;
  private _alertService: AlertService;
  private activatedRoute: ActivatedRoute;
  private _dataStoreService: DataStoreService;
  public _authService: AuthService;
  private _formBuilder: FormBuilder;
  
  constructor(private injector: Injector, public dialog: MatDialog, private datePipe: DatePipe,) {
    this.fb = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this.activatedRoute = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
  }

  ngOnInit() {
    this.createFormGroup();
    this._dataStoreService.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
    this.gapEligibilityForm.get('dateofhomeapproval')?.valueChanges.subscribe(result => {
      if (result) {
        this.getguardianInfo(result);
      }
    });
    this.getRelationList().subscribe(data => {
      if (data && data.length) {
        this.setRelationList(data);
      }
    if (this.pagesnapshot) {
      this.gapEligibilityForm.patchValue(this.pagesnapshot);
      this.gapEligibilityForm.disable();
    } else {
      this.client_id = this.activatedRoute.snapshot.paramMap.get('clientid') ?? "";
      this.removal_id = this.activatedRoute.snapshot.paramMap.get('removalId')?? "";
      this.searchGapClientId();
    }
    if (this.gapData && this.gapData.minorParentSiblingInfo.length > 0) {
      this.siblingGurdianNamedetails = this.gapData.minorParentSiblingInfo[0].siblingsinfo;
    }
    if (this.gapData && this.gapData.demographicsInfo.length > 0 && this.gapData.demographicsInfo[0].siblinginfo) {
      const siblinginformation = this.gapData.demographicsInfo[0].siblinginfo;
      this.setsiblinginfo(siblinginformation);
    }
    this.gapEligibilityForm.controls.primaryguardianrelationship.valueChanges.subscribe((value) => {
      return this.handleRelationList(value);
    })
    this.gapEligibilityForm.controls.secondguardianrelationship.valueChanges.subscribe((value) => {
      const selectedValue =   this.relationShipToRADropdownItems.find((item) => item.value === value);
      this.gapEligibilityForm.controls.secondguardianrelationshipid.setValue(selectedValue?.additionalProperty?.relationshipid);
      if(selectedValue?.additionalProperty?.relationshipid === 1001){
        this.gapEligibilityForm.controls.secondaryguardianisrelative.setValue("YES");
      } else {
        this.gapEligibilityForm.controls.secondaryguardianisrelative.setValue("NO");
      }
    })
    this._authService.readonlyPage('read_only_access','',
    [this.gapEligibilityForm]);
  });
}

handleRelationList(value:any) {
  const selectedValue = this.relationShipToRADropdownItems.find((item) => item.value === value);
  this.gapEligibilityForm.controls.primaryguardianrelationshipid.setValue(selectedValue?.additionalProperty?.relationshipid);
    if(selectedValue?.additionalProperty?.relationshipid === 1001){
      this.gapEligibilityForm.controls.primaryguardianisrelative.setValue("YES");
    } else {
      this.gapEligibilityForm.controls.primaryguardianisrelative.setValue("NO");
    }
}

getRelationList() {
  return this._commonHttpService.getArrayList(
    {
      where: { activeflag: 1, teamtypekey: this._authService.getAgencyName() },
      method: 'get',
      nolimit: true
    },
    `${CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
      .RelationshipTypesUrl}?filter`
  )
  
}

setRelationList(data:any) {
  if (data && data.length) {
    this.relationShipToRADropdownItems = data.map((res:any) => {
      return new DropdownModel({
        text: res.description,
        additionalProperty: res,
        value: res.relationshiptypekey
      });
    });
  }
}

  getguardianInfo(providerapprovalid:any) {
    const data = {
      providerapprovalid: providerapprovalid
    }
    this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.getGuardianInfo).subscribe(
      (response: any) => {
        const guardianinfo = response.data ? response.data[0] : null;
        if (guardianinfo) {
          this.setPrimaryGuardianDataAndHousehold(guardianinfo.primaryguardianinfo, guardianinfo.householdmeminfo);
          this.setSecondaryGuardianDataAndHousehold(guardianinfo.secondaryguardianinfo);
        }
      },
      (error) => {
        return false;
      }
    );
  }
  createFormGroup() {
    this.gapEligibilityForm = this._formBuilder.group({
      childname: [''],
      client_id: [''],
      al_removal_id: [''],
      childjurisdiction: [''],
      dateofbirth: [''],
      gender: [''],
      childguardianname: [''],
      childguardianid: [''],
      dateofhomeapproval: [''],
      dateofcourtorderguardianshipfinalization: [''],
      guardianshipapplicationdate: [''],
      latestfcplacementstartdatewithperpectiveguardian: [''],
      guardianshipagreementsigneddate: [''],
      primaryguardianisrelative: [''],
      primaryguardianrelationshipid: [''],
      primaryguardianrelationship: [''],
      primaryguardiannoofhhmembers: [''],
      secondguardianexists: [''],
      childsecguardianname: [''],
      childsecguardianid: [''],
      secondaryguardianshipagreementsigneddate: [''],
      secondaryguardianisrelative: [''],
      secondguardianrelationshipid: [''],
      secondguardianrelationship: [''],
      secguardlivingwithpriguard: [''],
      secondguardiannoofhhmembers: [''],
      successorguardianexists: [''],
      successorguardianname: [''],
      successorguardianid: [''],
      dateofsuccessionaddendum: [''],
      fosterhomeapprover: [''],
      isreunificationremoved: [''],
      isadoptionremoved: [''],
      iscgprovidesafe: [''],
      isconsultationchildage: [''],
      isguardianattach: [''],
      ischildsecondguardianattach: [''],
      yesindicatetypeofremoval: [''],
      childremovedbyvpa: [''],
      childremovedbycrt: [''],
      nochildisnoteligibleforgap: [''],
      removalvpadate: [''],
      removalcourtorderdate: [''],
      isasiblingofachildgappayments: [''],
      last6monthfiscalpaymentstatus: [''],
      isnotasiblingofachildgappayments: [''],
      primaryGuardian: this.fb.array([]),
      primaryGuardianHouseHold: this.fb.array([]),
      secondaryGuardian: this.fb.array([]),
      secondaryGuardianHouseHold: this.fb.array([]),
      siblinginformationgrid: this.fb.array([]),
      personid: [null],
      casenumber: [null],
      servicecaseid: [null]
    });
  }


  addSibling() {

    const siblingArry = <FormArray>this.gapEligibilityForm.controls.siblinginformationgrid;
    siblingArry.push(this._formBuilder.group({
      siblingInformationGridSiblingName: [''],
      siblingInformationGridSiblingGuardianId: [''],
      siblingInformationGridSiblingGapEligiblityStatus: [''],
      ivesiblinginfoid: [''],
      siblingclientid: [''],
      siblingclientname: [''],
      siblingguardianname: [''],
      activeFlag: [1]
    })
    );
    this.controlSiblingarry.push('1');
  }


  updateSibling() {
    const savedata = this.gapEligibilityForm.controls.siblinginformationgrid.value;
    let siblingGurdian:any[]=[];
    const payload = savedata.map((data: any) => {
       siblingGurdian = this.siblingGurdianNamedetails ? this.siblingGurdianNamedetails.filter((siblingGurdian1:any) => data.siblingclientname == siblingGurdian1?.name) : [];
      var siblingclientid = siblingGurdian && siblingGurdian.length > 0 ? siblingGurdian[0].siblingclientid : [];
      return {
        toclientid: Number(this.gapEligibilityForm.value.client_id),
        siblinggapeligibility: data.siblingInformationGridSiblingGapEligiblityStatus ? data.siblingInformationGridSiblingGapEligiblityStatus : null,
        siblingguardianid: data.siblingguardianname.split('-')[1] ? Number(data.siblingguardianname.split('-')[1]) : null,
        ivesiblinginfoid: data.ivesiblinginfoid ? data.ivesiblinginfoid : null,
        siblingclientid: siblingclientid ? Number(siblingclientid) : null,
        siblingclientname: data.siblingclientname ? data.siblingclientname : null,
        siblingguardianname: data.siblingguardianname.split('-')[0] ? data.siblingguardianname.split('-')[0] : null
      };
    });
    this._commonHttpService.create(payload, Titile4eUrlConfig.EndPoint.updategapsiblingInfo).subscribe(
      (res) => {
        this._alertService.success(this.submitsuccessmsg);
        if(res && res.data) {
        this.setsiblinginfo(res.data);
        }
      },
      (error) => {
        this._alertService.error(this.submitfailedmsg);
      });
  }

  setsiblinginfo(siblinginformation:any) {
    const controlArry = <FormArray>this.gapEligibilityForm.controls.siblinginformationgrid;
    while (controlArry.length > 0) {
      this.controlarry.pop();
      controlArry.removeAt(this.controlarry.length - 1);
    }
    if (siblinginformation && _.isArray(siblinginformation)) {
      siblinginformation.forEach((element, index) => {
        this.siblingchildnamechange(element.siblingclientname, index);
        controlArry.push(this._formBuilder.group({
          siblingInformationGridSiblingName: [element.siblingclientname],
          siblingInformationGridSiblingGuardianId: [element.siblingguardianid],
          siblingInformationGridSiblingGapEligiblityStatus: [element.siblinggapeligibility],
          ivesiblinginfoid: [element.ivesiblinginfoid],
          siblingclientid: [element.siblingclientid],
          siblingclientname: [element.siblingclientname],
          siblingguardianname: [element.siblingguardianname + '-' + element.siblingguardianid],
          activeFlag: [1]
        })
        );
      });
    }

  }

  deleteSibling(index:any, item:any) {
    const data = {
      ivesiblinginfoid: item,
    }
    this._commonHttpService.create(data, Titile4eUrlConfig.EndPoint.deletegapsiblinginfo)
      .subscribe(
        response => {
          if (response) {
            this._alertService.success(this.submitsuccessmsg);
          }
        },
        error => {
          this._alertService.error(this.submitfailedmsg);
        }
      );
    const controlSiblingarry = <FormArray>this.gapEligibilityForm.controls.siblinginformationgrid;
    controlSiblingarry.removeAt(index);
  }

  isnotsiblingofchildchange(event:any) {
    if (event.checked) {
      this.gapEligibilityForm.get('isasiblingofachildgappayments')?.disable();
      this.gapEligibilityForm.value.isasiblingofachildgappayments = '';
    } else {
      this.gapEligibilityForm.get('isasiblingofachildgappayments')?.enable();
    }
  }

  issiblingofchildchange(event:any) {
    if (event.checked) {
      this.gapEligibilityForm.get('isnotasiblingofachildgappayments')?.disable();
      this.gapEligibilityForm.value.isnotasiblingofachildgappayments = '';
    } else {
      this.gapEligibilityForm.get('isnotasiblingofachildgappayments')?.enable();
    }
  }

    typeofVpaRemoval(event:any, value:any) {
        if (event.checked) {
            if (value === 'Yes') {
                this.gapEligibilityForm.get('nochildisnoteligibleforgap')?.disable();
                this.gapEligibilityForm.controls['nochildisnoteligibleforgap'].reset();
            } else if (value === 'No') {
                this.gapEligibilityForm.get('yesindicatetypeofremoval')?.disable();
                this.gapEligibilityForm.controls['yesindicatetypeofremoval'].reset();
            }
        } else {
            this.gapEligibilityForm.get('nochildisnoteligibleforgap')?.enable();
            this.gapEligibilityForm.get('yesindicatetypeofremoval')?.enable();
        }
    }

  siblingchildnamechange(event:any, i:any) {
    let siblingGurdian:any;
    siblingGurdian = this.siblingGurdianNamedetails ? this.siblingGurdianNamedetails.filter((siblingGurdian1:any) => event == siblingGurdian1.name) : null;
    const placementinfocheck:any[] = [];
    if(siblingGurdian && siblingGurdian.length > 0 && siblingGurdian[0].guardianinfo && siblingGurdian[0].guardianinfo.length > 0) {
      siblingGurdian[0]?.guardianinfo?.forEach((obj :any)=> {
        if (obj.guardianonename.indexOf('-') < 0) {
            obj.guardianonename = obj.guardianonename + '-' + obj.guardianoneproviderid;
        }
        placementinfocheck.push(obj);
      })
      this.placementhistory[i] = placementinfocheck;
    }
  }

  isTabSwitched() {
    $('.gap a').on('shown.bs.tab', (event) => {
      var x = $(event.target).text();
      if (x.includes("Eligibility")) {
        this.searchGapClientId();
      }
    });
  }

  mapData() {
    if (this.gapEligibilityData.demographicsInfo && this.gapEligibilityData.demographicsInfo.length > 0) {
      this.gapEligibilityForm.patchValue(this.gapEligibilityData.demographicsInfo[0]);
      if (this.gapEligibilityData.demographicsInfo[0].haapprovaldtjson) {
        this.haapprovaldtjson = this.gapEligibilityData.demographicsInfo[0].haapprovaldtjson.map(
          (res:any) =>
            new DropdownModel({
              text: res.text,
              value: res.value,
              parent_provider_name: res.parent_provider_name ? res.parent_provider_name : res.approval_cd
            })
        );
      }
      this.handleRelationshipCheckFn();
      this.gapEligibilityForm.patchValue({
        secondguardianexists: this.gapEligibilityData.demographicsInfo[0].secondguardianexists === true && this.gapEligibilityData.demographicsInfo[0].childsecguardianname.trim() !== '' && this.gapEligibilityData.demographicsInfo[0].childsecguardianname !== null ? true : false,
        dateofhomeapproval: this.gapEligibilityData.demographicsInfo[0].providerapprovalid ? this.gapEligibilityData.demographicsInfo[0].providerapprovalid.toString() : null
      });
    }
  }
  // Assosiated with mapData method
  private handleRelationshipCheckFn() {
    if (this.gapEligibilityData.demographicsInfo[0].primaryguardianrelationship) {
      const selectedValue = this.relationShipToRADropdownItems.filter((item) => item.text === this.gapEligibilityData.demographicsInfo[0].primaryguardianrelationship);
      if (selectedValue && selectedValue.length) {
        this.gapEligibilityForm.patchValue({
          primaryguardianrelationship: selectedValue[0].value
        });
      }
    }
    if (this.gapEligibilityData.demographicsInfo[0].secondguardianrelationship) {
      const selectedValue = this.relationShipToRADropdownItems.filter((item) => item.text === this.gapEligibilityData.demographicsInfo[0].secondguardianrelationship);
      if (selectedValue && selectedValue.length) {
        this.gapEligibilityForm.patchValue({
          secondguardianrelationship: selectedValue[0].value
        });
      }
    }
  }

  setSecondaryGuardianDataAndHousehold(secondaryguardianinfo:any) {

    this.gapEligibilityForm.patchValue({
      secondguardiannoofhhmembers: 0
    });
    const control = <FormArray>this.gapEligibilityForm.controls.secondaryGuardian;
    while (control.length > 0) {
      control.removeAt(0);
    }
    const control1 = <FormArray>this.gapEligibilityForm.controls.secondaryGuardianHouseHold;
    while (control1.length > 0) {
      control1.removeAt(0);
    }

    if (secondaryguardianinfo && secondaryguardianinfo.length > 0) {
      this.getSecondaryguardianinfo(secondaryguardianinfo);
    }

    if (!this.gapEligibilityForm.value.secondguardianexists) {
      this.secondguardianexistsPatchFn();
    }
  }

  private secondguardianexistsPatchFn() {
    this.gapEligibilityForm.patchValue({
      childsecguardianname: '',
      childsecguardianid: 0,
      secondaryguardianshipagreementsigneddate: '',
      secondaryguardianisrelative: '',
      secondguardianrelationship: '',
      secguardlivingwithpriguard: '',
      secondguardiannoofhhmembers: 0
    });
  }

  private getSecondaryguardianinfo(secondaryguardianinfo: any) {
    secondaryguardianinfo.forEach((element:any, index:number) => {
      if (element.persontype !== 'Co-Applicant') {
        this.nonCoApplicantSecondaryFn(element);
      }

      if (element.persontype === 'Co-Applicant') {
        this.coApplicantSecondaryFn(element);
      }
    });
  }

  private coApplicantSecondaryFn(element: any) {
    const control = <FormArray>this.gapEligibilityForm.controls.secondaryGuardian;
    control.push(this._formBuilder.group({
      secondaryGuardianHhPersonName: element.name,
      secondaryGuardianDob: element.dob ? new Date(moment(element.dob).toDate()) : null,
      secondaryGuardianDateofCriminalHistory: element.federalbackgrounddate ? new Date(moment(element.federalbackgrounddate).toDate()) : null,
      secondaryGuardianDateofstatecriminalhistorybackground: element.statebackgrounddate ? new Date(moment(element.statebackgrounddate).toDate()) : null,
      secondaryGuardianDateofChildAbuse: element.childabusemaltdatacheck ? new Date(moment(element.childabusemaltdatacheck).toDate()) : null,
      secondaryGuardianOutofStateinPast5Yrs: element.oospast5years === 'true' ? true : false,
      secondaryGuardianDateOfChildAbuseOutOfState: element.Dateofchildabuseoss ? new Date(moment(element.Dateofchildabuseoss).toDate()) : null
    })
    );
  }

  private nonCoApplicantSecondaryFn(element: any) {
    const secondaryGuardianHouseHoldArry = <FormArray>this.gapEligibilityForm.controls.secondaryGuardianHouseHold;
    secondaryGuardianHouseHoldArry.push(this._formBuilder.group({
      secondaryGuardianHhPersonName: element.name,
      secondaryGuardianHhDob: element.dob ? new Date(moment(element.dob).toDate()) : null,
      secondaryGuardianHhBackgroundCheck: element.federalbackgrounddate === 'YES' ? true : false,
      secondaryGuardianHhDateofCriminalHistory: element.federalbackgrounddate ? new Date(moment(element.federalbackgrounddate).toDate()) : null,
      secondaryGuardianHhDateofstatecriminalhistorybackground: element.statebackgrounddate ? new Date(moment(element.statebackgrounddate).toDate()) : null,
      secondaryGuardianHhChildabusecheck: element.childabusemaltdatacheck === 'YES' ? true : false,
      secondaryGuardianHhDateofChildAbuse: element.childabusemaltdatacheck ? new Date(moment(element.childabusemaltdatacheck).toDate()) : null,
      secondaryGuardianHhOutofStateinPast5Yrs: element.oospast5years === 'true' ? true : false,
      secondaryGuardianHhChildWelfareAgenciesinPreviousStateContacted: element.secchildabuseandmaltreatmentinformationinthepreviousstates === 'YES' ? true : false,
      secondaryGuardianHhDateOfChildAbuseOutOfState: element.Dateofchildabuseoss ? new Date(moment(element.Dateofchildabuseoss).toDate()) : null
    })
    );

    this.gapEligibilityForm.patchValue({
      secondguardiannoofhhmembers: this.gapEligibilityForm.value.secondaryGuardianHouseHold.length
    });
  }

  setPrimaryGuardianDataAndHousehold(primaryguardianinfo:any, householdmeminfo:any) {
    this.gapEligibilityForm.patchValue({
      primaryguardiannoofhhmembers: 0
    });
    const control = <FormArray>this.gapEligibilityForm.controls.primaryGuardianHouseHold;
    while (control.length > 0) {
      control.removeAt(0);
    }
    const control1 = <FormArray>this.gapEligibilityForm.controls.primaryGuardian;
    while (control1.length > 0) {
      control1.removeAt(0);
    }

    if (primaryguardianinfo && primaryguardianinfo.length > 0) {
      this.getPrimaryguardianinfo(primaryguardianinfo);
    }

    // if (!primaryguardianinfo) {
    //   const control = <FormArray>this.gapEligibilityForm.controls.primaryGuardian;
    //   control.push(this._formBuilder.group({
    //     primaryGuardianPersonName: this.gapEligibilityData.demographicsInfo[0].childguardianname,
    //     primaryGuardianDob: this.gapEligibilityData.demographicsInfo[0].dateofbirth,
    //     primaryGuardianDateofCriminalHistory: '',
    //     primaryGuardianDateofstatecriminalhistorybackground: '',
    //     primaryGuardianDateofChildAbuse: '',
    //     primaryGuardianOutofStateinPast5Yrs: '',
    //     primaryGuardianDateofChildAbuseOutofState: ''
    //   })
    //   );
    // }

    if (householdmeminfo && householdmeminfo.length > 0) {
      this.getHouseholdmeminfoFn(householdmeminfo);
    }

  }

  private getHouseholdmeminfoFn(householdmeminfo: any) {
    householdmeminfo.forEach((element:any, index:any) => {
      if (element.persontype !== 'Applicant') {
        this.nonApplicantHouseholdmeminfoFn(element);
      }
    });
  }

  private nonApplicantHouseholdmeminfoFn(element: any) {
    const primaryGuardianArry = <FormArray>this.gapEligibilityForm.controls.primaryGuardianHouseHold;
    primaryGuardianArry.push(this._formBuilder.group({
      primaryGuardianHhPersonName: element.name,
      primaryGuardianHhDob: element.dob ? new Date(moment(element.dob).toDate()) : null,
      primaryGuardianHhBackgroundCheck: element.federalbackgrounddate === 'YES' ? true : false,
      primaryGuardianHhDateofCriminalHistory: element.federalbackgrounddate ? new Date(moment(element.federalbackgrounddate).toDate()) : null,
      primaryGuardianHhDateofstatecriminalhistorybackground: element.statebackgrounddate ? new Date(moment(element.statebackgrounddate).toDate()) : null,
      primaryGuardianHhChildabusecheck: element.childabusemaltdatacheck === 'YES' ? true : false,
      primaryGuardianHhDateofChildAbuse: element.childabusemaltdatacheck ? new Date(moment(element.childabusemaltdatacheck).toDate()) : null,
      primaryGuardianHhOutofStateinPast5Yrs: element.outofstatewithinpast5years === 'YES' ? true : false,
      primaryGuardianHhChildWelfareAgenciesinPreviousStateContacted: element.childabuseandmaltreatmentinformationinthepreviousstates === 'YES' ? true : false,
      primaryGuardianHhDateofChildAbuseOutofState: element.dateofchildabuseandmaltreatmentdbcheckoos ? new Date(moment(element.dateofchildabuseandmaltreatmentdbcheckoos).toDate()) : null
    })
    );
    this.gapEligibilityForm.patchValue({
      primaryguardiannoofhhmembers: this.gapEligibilityForm.value.primaryGuardianHouseHold.length
    });
  }

  private getPrimaryguardianinfo(primaryguardianinfo: any) {
    primaryguardianinfo.forEach((element:any, index:any) => {
      if (element.persontype !== 'Applicant') {
        this.nonApplicantFn(element);
      }

      if (element.persontype === 'Applicant') {
        this.applicantFn(element);
      }
    });
  }

  private applicantFn(element: any) {
    const control = <FormArray>this.gapEligibilityForm.controls.primaryGuardian;
    control.push(this._formBuilder.group({
      primaryGuardianPersonName: element.name,
      primaryGuardianDob: element.dob ? new Date(moment(element.dob).toDate()) : null,
      primaryGuardianDateofCriminalHistory: element.federalbackgrounddate ? new Date(moment(element.federalbackgrounddate).toDate()) : null,
      primaryGuardianDateofstatecriminalhistorybackground: element.statebackgrounddate ? new Date(moment(element.statebackgrounddate).toDate()) : null,
      primaryGuardianDateofChildAbuse: element.childabusemaltdatacheck ? new Date(moment(element.childabusemaltdatacheck).toDate()) : null,
      primaryGuardianOutofStateinPast5Yrs: element.oospast5years === 'true' ? true : false,
      primaryGuardianDateofChildAbuseOutofState: element.Dateofchildabuseoss ? new Date(moment(element.Dateofchildabuseoss).toDate()) : null
    })
    );
  }

  private nonApplicantFn(element: any) {
    const primaryGuardianArry = <FormArray>this.gapEligibilityForm.controls.primaryGuardianHouseHold;
    primaryGuardianArry.push(this._formBuilder.group({
      primaryGuardianHhPersonName: element.name,
      primaryGuardianHhDob: element.dob ? new Date(moment(element.dob).toDate()) : null,
      primaryGuardianHhBackgroundCheck: element.federalbackgrounddate === 'YES' ? true : false,
      primaryGuardianHhDateofCriminalHistory: element.federalbackgrounddate ? new Date(moment(element.federalbackgrounddate).toDate()) : null,
      primaryGuardianHhDateofstatecriminalhistorybackground: element.statebackgrounddate ? new Date(moment(element.statebackgrounddate).toDate()) : null,
      primaryGuardianHhChildabusecheck: element.childabusemaltdatacheck === 'YES' ? true : false,
      primaryGuardianHhDateofChildAbuse: element.oospast5years === 'true' ? true : false,
      primaryGuardianHhChildWelfareAgenciesinPreviousStateContacted: element.childabuseandmaltreatmentinformationinthepreviousstates === 'YES' ? true : false,
      primaryGuardianHhDateofChildAbuseOutofState: element.Dateofchildabuseoss ? new Date(moment(element.Dateofchildabuseoss).toDate()) : null
    })
    );

    this.gapEligibilityForm.patchValue({
      primaryguardiannoofhhmembers: this.gapEligibilityForm.value.primaryGuardianHouseHold.length
    });
  }

  saveData() {
   let haapprovaldt :any[]=[];
   haapprovaldt = this.haapprovaldtjson ? this.haapprovaldtjson.filter(haapprovaldt1 => this.gapEligibilityForm.value.dateofhomeapproval == haapprovaldt1.value) : [];

    const submissiondata = this.gapEligibilityForm.value;
    const finalsubmission = {
      childname: submissiondata.childname,
      client_id: submissiondata.client_id,
      al_removal_id: submissiondata.al_removal_id,
      childjurisdiction: submissiondata.childjurisdiction,
      dateofbirth: submissiondata.dateofbirth,
      gender: submissiondata.gender,
      childguardianname: submissiondata.childguardianname,
      childguardianid: submissiondata.childguardianid,
      haapprovaldtjson: this.haapprovaldtjson,
      dateofhomeapproval: haapprovaldt?.length > 0 ? haapprovaldt[0]?.text : null,
      dateofcourtorderguardianshipfinalization: submissiondata.dateofcourtorderguardianshipfinalization,
      guardianshipapplicationdate: submissiondata.guardianshipapplicationdate,
      latestfcplacementstartdatewithperpectiveguardian: submissiondata.latestfcplacementstartdatewithperpectiveguardian,
      guardianshipagreementsigneddate: submissiondata.guardianshipagreementsigneddate,
      primaryguardianisrelative: submissiondata.primaryguardianisrelative,
      primaryguardianrelationshipid: submissiondata.primaryguardianrelationshipid,
      primaryguardianrelationship: submissiondata.primaryguardianrelationship,
      primaryguardiannoofhhmembers: submissiondata.primaryguardiannoofhhmembers,
      secondguardianexists: submissiondata.secondguardianexists,
      childsecguardianname: submissiondata.childsecguardianname,
      childsecguardianid: submissiondata.childsecguardianid,
      secondaryguardianshipagreementsigneddate: submissiondata.secondaryguardianshipagreementsigneddate,
      secondaryguardianisrelative: submissiondata.secondaryguardianisrelative,
      secondguardianrelationshipid: submissiondata.secondguardianrelationshipid,
      secondguardianrelationship: submissiondata.secondguardianrelationship,
      secguardlivingwithpriguard: submissiondata.secguardlivingwithpriguard,
      secondguardiannoofhhmembers: submissiondata.secondguardiannoofhhmembers,
      successorguardianexists: submissiondata.successorguardianexists,
      successorguardianname: submissiondata.successorguardianname,
      successorguardianid: submissiondata.successorguardianid,
      dateofsuccessionaddendum: submissiondata.dateofsuccessionaddendum,
      fosterhomeapprover: submissiondata.fosterhomeapprover,
      isreunificationremoved: submissiondata.isreunificationremoved,
      isadoptionremoved: submissiondata.isadoptionremoved,
      iscgprovidesafe: submissiondata.iscgprovidesafe,
      isconsultationchildage: submissiondata.isconsultationchildage,
      isguardianattach: submissiondata.isguardianattach,
      ischildsecondguardianattach: submissiondata.ischildsecondguardianattach,
      yesindicatetypeofremoval: submissiondata.yesindicatetypeofremoval,
      childremovedbyvpa: submissiondata.childremovedbyvpa,
      childremovedbycrt: submissiondata.childremovedbycrt,
      nochildisnoteligibleforgap: submissiondata.nochildisnoteligibleforgap,
      removalvpadate: submissiondata.removalvpadate,
      removalcourtorderdate: submissiondata.removalcourtorderdate,
      isasiblingofachildgappayments: submissiondata.isasiblingofachildgappayments,
      last6monthfiscalpaymentstatus: submissiondata.last6monthfiscalpaymentstatus,
      isnotasiblingofachildgappayments: submissiondata.isnotasiblingofachildgappayments,
      primaryguardian: submissiondata.primaryGuardian,
      primaryguardianhousehold: submissiondata.primaryGuardianHouseHold,
      secondaryguardian: submissiondata.secondaryGuardian,
      secondaryguardianhousehold: submissiondata.secondaryGuardianHouseHold,
      siblinginformationgrid: submissiondata.siblinginformationgrid,
      providerapprovalid: submissiondata.dateofhomeapproval,
      personid: submissiondata.personid,
      casenumber: submissiondata.casenumber,
      servicecaseid: submissiondata.servicecaseid,
      guardian_subsidy_id: this.removal_id
    };

    var request = {
      'clientId': Number(this.client_id),
      ...finalsubmission
    };
    this._commonHttpService.create(request, Titile4eUrlConfig.EndPoint.savegapeligibility).subscribe(
      (res) => {
        this._alertService.success("Gap data saved successfully!");
      },
      (error) => {
        this._alertService.error("Gap data save Failed");
      });

  }

  submissionData() {
    let gender = '';
    if (this.gapEligibilityForm.value.gender === 'M') {
      gender = 'Male';
    } else if (this.gapEligibilityForm.value.gender === 'F') {
      gender = 'Female';
    } else {
      gender = 'Other';
    }

    const haapprovaldt = this.haapprovaldtjson ? this.haapprovaldtjson.filter(haapprovaldt1 => this.gapEligibilityForm.value.dateofhomeapproval == haapprovaldt1.value) : [];

    const submissiondata: LooseObject = this.getSubmissionJsonData(gender, haapprovaldt);

    this._commonHttpService.create(submissiondata, Titile4eUrlConfig.EndPoint.postGapEligibilityNExtension).subscribe(
      (res) => {
        this.submitForReview.emit();
        this._alertService.success(this.submitsuccessmsg);
      },
      (error) => {
        this._alertService.error(this.submitfailedmsg);
      });
  }


  private getSubmissionJsonData(gender: string, haapprovaldt: DropdownModel[]): LooseObject {
    return {
      'cjamsPid': Number(this.gapEligibilityForm.value.client_id),
      'removalid': Number(this.gapEligibilityForm.value.al_removal_id),
      'pagesnapshot': this.gapEligibilityForm.getRawValue(),
      'guardiansubsidyid' :  this.removal_id,
      'initialDetermination': {
        'payload': {
          'name': 'GAP',
          '__metadataRoot': {},
          'Objects': this.getObjectsFn(gender, haapprovaldt)
        }
      }
    };
  }

  private getObjectsFn(gender: string, haapprovaldt: DropdownModel[]) {
    return [
      {
        'reason': {
          '__metadata': {
            '#type': 'Reason',
            '#id': 'Reason_id_1'
          }
        },
        'secondGuardian': this.getSecondGuardian(),
        'GuardianshipApplicationDate': this.dateConversion(this.gapEligibilityForm.value.guardianshipapplicationdate),
        'GuardianshipAgreementSignedDate': this.dateTimeConversion(this.gapEligibilityForm.value.guardianshipagreementsigneddate ? this.gapEligibilityForm.value.guardianshipagreementsigneddate : null),
        'applicantInformation': this.getApplicantInformationFn(),
        'person': this.getPersonFn(gender, haapprovaldt),
        'householdMember': this.primaryHHMemberSubmissionData(),
        'GuardianshipFinalizationDate_FinalizationDateOfCourtOrder': this.dateTimeConversion(this.gapEligibilityForm.value.dateofcourtorderguardianshipfinalization),
        'Isprovisionalapproval': haapprovaldt ? this.returnIsprovisionalApprovalorNot(haapprovaldt) : null,
        'successorGuardian': this.getSuccessorGuardianFn(),
        '__metadata': {
          '#type': 'Application',
          '#id': 'Application_id_1'
        },
        'NumberOfAdditionalHouseholdMembers': Number(this.gapEligibilityForm.value.primaryguardiannoofhhmembers),
        'status': {
          '__metadata': {
            '#type': 'Status',
            '#id': 'Status_id_1'
          }
        }
      }
    ];
  }

  private getSecondGuardian() {
    return {
      ...this.getSecondGuardianObj1Fn(),
      ...this.getSecondGuardianObj2Fn()
    };
  }
  // Associated with getSecondGuardian function
  private getSecondGuardianObj2Fn() {
    return {
      'SG_State_criminal_history_background_check': this.gapEligibilityForm.value.secondguardianexists ? this.getStateCriminalHistoryCheckFn() : null,
      '__metadata': {
        '#type': 'SecondGuardian',
        '#id': 'SecondGuardian_id_1'
      },
      'SG_FBI_Criminal_History_Background_Check': this.gapEligibilityForm.value.secondguardianexists ? this.getFbiCriminalHistoryBackgroundCheckFn() : null,
      'ChildSecondGuardianID': this.gapEligibilityForm.value.secondguardianexists ? this.getChildSecondGuardianIdFn() : null,
      'SG_Out_of_state_within_past_5_years_of_the_application_for_GAP': this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.getOutOfStateGapFn() : null,
      'SG_Date_Of_Child_abuse_and_maltreatment_data_base_check_OutOfState': this.dateConversion(this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' && this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 ? this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateOfChildAbuseOutOfState : null)
    };
  }
  // Associated with getSecondGuardian function
  private getSecondGuardianObj1Fn() {
    return {
      'Child_Second_Guardian_Attachment': this.returnIschildsecondguardianattachFn(),
      'SecondGuardianNumberOfAdditionalHouseholdMembers': this.returnSecondguardiannoofhhmembersFn(),
      'SG_Child_abuse_and_maltreatment_data_base_check': this.gapEligibilityForm.value.secondguardianexists ? this.getChildAbuseMaltreatmentBaseCheckFn() : null,
      'IsRelative': this.gapEligibilityForm.value.secondaryguardianisrelative !== '' ? this.getIsRelativeFn() : null,
      'SecondGuardianRelationshipID': this.gapEligibilityForm.value.secondguardianrelationshipid === '' ? null : this.gapEligibilityForm.value.secondguardianrelationshipid,
      'SG_DateOf_State_criminal_history_background_check': this.returnSecondaryGuardianExistsFn(),
      'SecondaryGuardianshipAgreementSignedDate': this.dateConversion(this.gapEligibilityForm.value.secondaryguardianshipagreementsigneddate !== '' ? this.gapEligibilityForm.value.secondaryguardianshipagreementsigneddate : null),
      'LivingWithPrimaryGuardian': this.gapEligibilityForm.value.secguardlivingwithpriguard !== '' ? this.gapEligibilityForm.value.secguardlivingwithpriguard : null,
      'SG_Date_Of_FBI_Criminal_History_Background_Check': this.dateConversion(this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 ? this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateofCriminalHistory : null),
      'SG_Date_Of_Child_abuse_and_maltreatment_data_base_check': this.dateConversion(this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 ? this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateofChildAbuse : null),
      'SG_Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information': this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.getPreviousStatesContactedFn() : null,
      'secondGuardianHouseholdMembers': this.secondaryHHMemberSubmissionData()
    };
  }
  // Associated with getSecondGuardian function
  private returnSecondaryGuardianExistsFn() {
    return this.dateConversion(this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 ? this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateofstatecriminalhistorybackground : null);
  }
  // Associated with getSecondGuardian function
  private returnSecondguardiannoofhhmembersFn() {
    return this.gapEligibilityForm.value.secondguardiannoofhhmembers !== '' ? this.gapEligibilityForm.value.secondguardiannoofhhmembers : null;
  }
  // Associated with getSecondGuardian function
  private returnIschildsecondguardianattachFn() {
    return this.gapEligibilityForm.value.ischildsecondguardianattach ? this.gapEligibilityForm.value.ischildsecondguardianattach : null;
  }
  // Associated with getSecondGuardian function
  private getChildSecondGuardianIdFn() {
    return this.gapEligibilityForm.value.childguardianid ? this.gapEligibilityForm.value.childguardianid : null;
  }
  // Associated with getSecondGuardian function
  private getOutOfStateGapFn() {
    return this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 && this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianOutofStateinPast5Yrs ? 'YES' : 'NO';
  }
  // Associated with getSecondGuardian function
  private getFbiCriminalHistoryBackgroundCheckFn() {
    return this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 && this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateofCriminalHistory === '' ? 'NO' : 'YES';
  }
  // Associated with getSecondGuardian function
  private getPreviousStatesContactedFn() {
    const data= this.dateConversion(this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 ? this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateOfChildAbuseOutOfState : null);
    return data  ? 'YES' : 'NOT_APPLICABLE';
  }
  // Associated with getSecondGuardian function
  private getChildAbuseMaltreatmentBaseCheckFn() {
    return this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 && this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateofChildAbuse === '' ? 'NO' : 'YES';
  }

  private getApplicantInformationFn() {
    return {
      'RelationshipID': this.gapEligibilityForm.value.primaryguardianrelationshipid === '' ? 0 : this.gapEligibilityForm.value.primaryguardianrelationshipid,
      'Guardian_Commitment_For_Permanent_Child_Care': this.gapEligibilityForm.value.iscgprovidesafe ? this.gapEligibilityForm.value.iscgprovidesafe : null,
      'ClientID': this.gapEligibilityForm.value.client_id,
      'IsRelative': this.gapEligibilityForm.value.primaryguardianisrelative === '' ? null : this.gapEligibilityForm.value.primaryguardianisrelative,
      '__metadata': {
        '#type': 'ApplicantInformation',
        '#id': 'ApplicantInformation_id_1'
      }
    };
  }

  private getSuccessorGuardianFn() {
    return {
      'NameOfSuccessorGuardian': this.gapEligibilityForm.value.successorguardianname,
      'ChildSuccessorGuardianID': this.gapEligibilityForm.value.successorguardianid,
      'DateOfSuccessionAddendum': this.dateConversion(this.gapEligibilityForm.value.dateofsuccessionaddendum),
      '__metadata': {
        '#type': 'SuccessorGuardian',
        '#id': 'SuccessorGuardian_id_1'
      }
    };
  }

  private getPersonFn(gender: string, haapprovaldt: DropdownModel[]) {
    return {
      'DateOfBirth': this.dateConversion(this.gapEligibilityForm.value.dateofbirth),
      'Removal_Court_Order_Date': this.dateConversion(this.gapEligibilityForm.value.removalcourtorderdate),
      'Appropriate_Permanency_For_Child_Option_1_Not_Being_Returned_Home': this.gapEligibilityForm.value.isreunificationremoved ? this.gapEligibilityForm.value.isreunificationremoved : null,
      'CountyOfJurisdiction_LDSS': this.gapEligibilityForm.value.childjurisdiction ? this.gapEligibilityForm.value.childjurisdiction : null,
      'Child_Guardian_Attachment': this.gapEligibilityForm.value.isguardianattach ? this.gapEligibilityForm.value.isguardianattach : null,
      'ChildGuardianID': this.gapEligibilityForm.value.childguardianid ? this.gapEligibilityForm.value.childguardianid : null,
      'Gender': gender ? gender : null,
      'SiblingExists': this.gapEligibilityForm.value.isasiblingofachildgappayments ? 'YES' : 'NO',
      'siblingDetails': this.sibilingSubmissionData(),
      'Name': this.gapEligibilityForm.value.childname ? this.gapEligibilityForm.value.childname : null,
      'Child_Removal_Date': this.dateConversion(this.gapEligibilityForm.value.removalvpadate),
      'licensedFosterHome': this.licensedFosterHomeFn(haapprovaldt),
      '__metadata': {
        '#type': 'Person',
        '#id': 'Person_id_1'
      },
      'Age_Appropriate_Consultation_Taken_Place_With_the_Child': this.gapEligibilityForm.value.isconsultationchildage,
      'SecondGuardianExists': this.gapEligibilityForm.value.secondguardianexists ? 'YES' : 'NO',
      'relationship': [
        {
          '__metadata': {
            '#type': 'Relationship',
            '#id': 'Relationship_id_1'
          }
        }
      ],
      'Appropriate_Permanency_For_Child_Option_2_Not_Being_Adopted': this.gapEligibilityForm.value.isadoptionremoved,
      'SuccessorGuardianExists': this.gapEligibilityForm.value.successorguardianexists ? 'YES' : 'NO'
    };
  }

  private licensedFosterHomeFn(haapprovaldt: DropdownModel[]) {
    return [
      {
        ...this.licensedFosterHomeObj1Fn(haapprovaldt),
        ...this.licensedFosterHomeObj2Fn()
      }
    ];
  }

  private licensedFosterHomeObj2Fn() {
    return {
      'Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.getPrimaryGuardianOutOfState() : null,
      '__metadata': {
        '#type': 'LicensedFosterHome',
        '#id': 'LicensedFosterHome_id_1'
      },
      'FosterHome_Approver': this.gapEligibilityForm.value.fosterhomeapprover,
      'DateOf_FBI_criminal_history_background_check': this.dateConversion(this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 ? this.gapEligibilityForm.value.primaryGuardian[0].primaryGuardianDateofCriminalHistory : null),
      'Child_abuse_and_maltreatment_data_base_check': this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 && this.gapEligibilityForm.value.primaryGuardian[0].primaryGuardianDateofChildAbuse ? 'YES' : 'NO',
      'DateOf_State_criminal_history_background_check': this.dateConversion(this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 ? this.gapEligibilityForm.value.primaryGuardian[0].primaryGuardianDateofstatecriminalhistorybackground : null)
    };
  }

  private licensedFosterHomeObj1Fn(haapprovaldt: DropdownModel[]) {
    return {
      'LastSixMonthFiscalCodeandPaymentStatus': this.gapEligibilityForm.value.last6monthfiscalpaymentstatus,
      'DateOfFullApprovalFP': haapprovaldt ? this.returnHaapprovaldtTrueFn(haapprovaldt) : null,
      'DateOf6thMonthFromFullApproval': haapprovaldt && haapprovaldt.length && haapprovaldt[0].text ? this.return6monthapprovaldtTrueFn(new Date(haapprovaldt[0].text)) : null,
      'Date_Of_Child_abuse_and_maltreatment_data_base_check_OutOfState': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.getPrimaryGuardianOutOfState() : null,
      'LatestFosterCarePlacementStartDateWithPerpectiveGuardian': this.dateConversion(this.gapEligibilityForm.value.latestfcplacementstartdatewithperpectiveguardian),
      'DateOf6thMonthFromLatestFosterCarePlacementStartDate':  this.gapEligibilityForm.value.latestfcplacementstartdatewithperpectiveguardian ? this.return6monthapprovaldtTrueFn(new Date(this.gapEligibilityForm.value.latestfcplacementstartdatewithperpectiveguardian)): null,
      'Date_Of_Child_abuse_and_maltreatment_data_base_check': this.dateConversion(this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 ? this.gapEligibilityForm.value.primaryGuardian[0].primaryGuardianDateofChildAbuse : null),
      'FBI_criminal_history_background_check': this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 && this.gapEligibilityForm.value.primaryGuardian[0].primaryGuardianDateofCriminalHistory ? 'YES' : 'NO',
      'State_criminal_history_background_check': this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 && this.gapEligibilityForm.value.primaryGuardian[0].primaryGuardianDateofstatecriminalhistorybackground ? 'YES' : 'NO',
      'Out_of_state_within_past_5_years_of_the_application_for_GAP': (this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 && this.gapEligibilityForm.value.primaryGuardian[0]?.primaryGuardianOutofStateinPast5Yrs && this.gapEligibilityForm.value.fosterhomeapprover === 'CPA') ? 'YES' : 'NO'
    };
  }

  private returnHaapprovaldtTrueFn(haapprovaldt: DropdownModel[]) {
    return haapprovaldt.length > 0 ? haapprovaldt[0].text : null;
  }

  private return6monthapprovaldtTrueFn(date1: any) {

    const formathaapprovaldate = moment(date1);
    const Dateof6monthsFromHomeApproval = formathaapprovaldate.add(6, 'months').toDate();
    return this.datePipe.transform(Dateof6monthsFromHomeApproval, 'MM/01/yyyy');
  }


private returnIsprovisionalApprovalorNot(haapprovaldt: DropdownModel[]) {
  if (haapprovaldt && haapprovaldt.length && haapprovaldt[0].parent_provider_name && haapprovaldt[0].parent_provider_name.includes('Provisional')) {
    return true;
  } else {
    return false;
  }
}

  private getPrimaryGuardianOutOfState() {
    return this.dateConversion(this.gapEligibilityForm.value.primaryGuardian && this.gapEligibilityForm.value.primaryGuardian.length > 0 ? this.gapEligibilityForm.value.primaryGuardian[0].primaryGuardianDateofChildAbuseOutofState : null);
  }

  private getStateCriminalHistoryCheckFn() {
    return this.gapEligibilityForm.value.secondaryGuardian && this.gapEligibilityForm.value.secondaryGuardian.length > 0 && this.gapEligibilityForm.value.secondaryGuardian[0].secondaryGuardianDateofstatecriminalhistorybackground === '' ? 'NO' : 'YES';
  }

  private getIsRelativeFn() {
    return this.gapEligibilityForm.value.secondaryguardianisrelative === 'YES' ? 'YES' : 'NO';
  }

  searchGapClientId() {
    if (this.gapData) {
      this.gapEligibilityData = this.gapData;
      this.mapData();
    }
  }



  dateConversion(date:any) {
    if (date === undefined || date === null || date === '') {
      return null;
    } else {
      return this.datePipe.transform(date, 'MM/dd/yyyy');
    }
  }

  dateTimeConversion(date:any) {
    if (date === undefined || date === null || date === '') {
      return null;
    } else {
      return this.datePipe.transform(date, "MM/dd/yyyy HH:mm:ss");
    }
  }


  secondaryHHMemberSubmissionData() {
    const secondaryHHMemberList :any[]= [];

    if (this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.secondGuardian && this.gapEligibilityForm.value.secondGuardian.length > 0
      && this.gapEligibilityForm.value.secondguardianexists && this.gapEligibilityForm.value.secguardlivingwithpriguard === 'NO' && this.gapEligibilityForm.value.secondguardiannoofhhmembers > 0) {
      if (this.gapEligibilityForm.value.secondaryGuardianHouseHold) {
        this.gapEligibilityForm.value.secondaryGuardianHouseHold.forEach((element:any, index:any) => {
          this.getSecondaryHhMemberList(secondaryHHMemberList, element, index);
        });
      }
    }
    const tempSecondaryHHMemberList: any[] = [];
    if (secondaryHHMemberList === tempSecondaryHHMemberList) {
      secondaryHHMemberList.push({

      });
      return null;
    }
    return secondaryHHMemberList;
  }

  private getSecondaryHhMemberList(secondaryHHMemberList: any[], element: any, index: any) {
    secondaryHHMemberList.push({
      'SG_DateOfBirthOfHouseholdMember': this.dateConversion(element.secondaryGuardianHhDob),
      'SG_FBI_Criminal_History_Background_Check_HH': element.secondaryGuardianHhDateofCriminalHistory ? 'YES' : 'NO',
      'SG_Date_Of_FBI_Criminal_History_Background_Check_HH': this.dateConversion(element.secondaryGuardianHhDateofCriminalHistory),
      'SG_DateOf_State_criminal_history_background_check_HH': this.dateConversion(element.secondaryGuardianHhDateofstatecriminalhistorybackground),
      'SG_State_criminal_history_background_check_HH': element.secondaryGuardianHhDateofstatecriminalhistorybackground ? 'YES' : 'NO',
      'SG_NameOfHouseholdMember': element.secondaryGuardianHhPersonName,
      //'SG_National_and_state_criminal_history_background_check_HH': element.secondaryGuardianHhDateofCriminalHistory && element.secondaryGuardianHhDateofstatecriminalhistorybackground ? 'YES' : 'NO',
      'SG_Out_of_state_within_past_5_years_of_the_application_for_GAP_HH': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.secondaryGuardianHhOutofStateinPast5Yrs(element) : null,
      '__metadata': {
        '#type': 'SecondGuardianHouseholdMembers',
        '#id': 'SecondGuardianHouseholdMembers_id_' + (index + 1)
      },
      'SG_Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information_HH': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.getSecondaryApplicableChildwelfareAgencies(element) : null,
      'SG_Date_Of_Child_abuse_and_maltreatment_data_base_check_OutOfState_HH': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.dateConversion(element.secondaryGuardianHhDateOfChildAbuseOutOfState) : null,
      //'SG_DateOf_National_and_state_criminal_history_background_check_HH': this.dateConversion(element.secondaryGuardianHhDateofCriminalHistory),
      'SG_Child_abuse_and_maltreatment_data_base_check_HH': element.secondaryGuardianHhDateofChildAbuse ? 'YES' : 'NO',
      'SG_Date_Of_Child_abuse_and_maltreatment_data_base_check_HH': this.dateConversion(element.secondaryGuardianHhDateofChildAbuse)
    });
  }

  private secondaryGuardianHhOutofStateinPast5Yrs(element: any) {
    return element.secondaryGuardianHhOutofStateinPast5Yrs ? 'YES' : 'NO';
  }

  private getSecondaryApplicableChildwelfareAgencies(element: any) {
    return this.dateConversion(element.secondaryGuardianHhDateOfChildAbuseOutOfState);
  }

  primaryHHMemberSubmissionData() {
    const primaryHHMemberList:any[] = [];
    if (this.gapEligibilityForm.value.primaryGuardianHouseHold && this.gapEligibilityForm.value.primaryguardiannoofhhmembers > 0) {
      this.gapEligibilityForm.value.primaryGuardianHouseHold.forEach((element:any, index:number) => {
        primaryHHMemberList.push({
          'Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information_HH': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.getApplicableChildwelfareAgencies(element) : null,
          //'National_and_state_criminal_history_background_check_HH': element.primaryGuardianHhDateofCriminalHistory && element.primaryGuardianHhDateofstatecriminalhistorybackground ? 'YES' : 'NO',
          'Date_Of_Child_abuse_and_Maltreatment_database_Check_HH': this.dateConversion(element.primaryGuardianHhDateofChildAbuse),
          'Date_Of_FBI_Criminal_History_Background_Check_HH': this.dateConversion(element.primaryGuardianHhDateofCriminalHistory),
          'Date_Of_State_Criminal_History_Background_Check_HH': this.dateConversion(element.primaryGuardianHhDateofstatecriminalhistorybackground),
          'Out_of_state_within_past_5_years_of_the_application_for_GAP_HH': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.primaryGuardianHhOutofStateinPast5Yrs(element) : null,
          'Date_Of_Child_abuse_and_Maltreatment_database_Check_OutOfState_HH': this.gapEligibilityForm.value.fosterhomeapprover === 'CPA' ? this.dateConversion(element.primaryGuardianHhDateofChildAbuseOutofState) : null,
          ...this.primaryHHMemberSubmissionObj1Fn(element, index)
        });
      });
    }

    const tempPrimaryHHMemberList: any[] = [];
    if (primaryHHMemberList === tempPrimaryHHMemberList) {
      return null;
    }
    return primaryHHMemberList;
  }

  private primaryHHMemberSubmissionObj1Fn(element: any, index: any): any {
    return {
      'FBI_Criminal_History_Background_Check_HH': element.primaryGuardianHhDateofCriminalHistory ? 'YES' : 'NO',
      'NameOfHouseholdMember': element.primaryGuardianHhPersonName,
      'DateOfBirthOfHouseholdMember': this.dateConversion(element.primaryGuardianHhDob),
      'Child_abuse_and_maltreatment_data_base_check_HH': element.primaryGuardianHhDateofChildAbuse ? 'YES' : 'NO',
      'State_criminal_history_background_check_HH': element.primaryGuardianHhDateofstatecriminalhistorybackground ? 'YES' : 'NO',
      '__metadata': {
        '#type': 'HouseholdMember',
        '#id': 'HouseholdMember_id_' + (index + 1)
      }
    };
  }

  private primaryGuardianHhOutofStateinPast5Yrs(element: any) {
    return element.primaryGuardianHhOutofStateinPast5Yrs ? 'YES' : 'NO';
  }

  private getApplicableChildwelfareAgencies(element: any) {
    return this.dateConversion(element.primaryGuardianHhDateofChildAbuseOutofState) ? 'YES' : 'NOT_APPLICABLE';
  }

  sibilingSubmissionData() {
    const siblingList = [];
    if (this.gapEligibilityForm.value.siblinginformationgrid) {
      this.gapEligibilityForm.value.siblinginformationgrid.forEach((element:any, index:number) => {
        siblingList.push({
          'SiblingGAPEligiblityStatus': element.siblingInformationGridSiblingGapEligiblityStatus === '' ? null : element.siblingInformationGridSiblingGapEligiblityStatus,
          'SiblingName': element.siblingclientname === '' ? null : element.siblingclientname,
          'SiblingGuardianID': element.siblingguardianname.split('-')[1] === '' ? null : element.siblingguardianname.split('-')[1],
          'SiblingGuardianName': element.siblingguardianname.split('-')[0] === '' ? null : element.siblingguardianname.split('-')[0],
          '__metadata': {
            '#type': 'SiblingDetails',
            '#id': 'SiblingDetails_id_' + (index + 1)
          }
        });
      });
    } else {
      siblingList.push({
        'SiblingGAPEligiblityStatus': null,
        'SiblingName': null,
        'SiblingGuardianID': null,
        '__metadata': {
          '#type': 'SiblingDetails',
          '#id': 'SiblingDetails_id_1'
        }
      });
    }
    return siblingList;
  }

  getGapEligibilityFormData(name: string): any[] {
    return Object.values((this.gapEligibilityForm.get(name) as FormGroup).controls);
  }
}
