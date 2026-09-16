
import { pluck, share, map } from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { forkJoin, Observable } from 'rxjs';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { BirthInfocw, Health } from '../../../involved-persons/_entities/involvedperson.data.model';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, CommonHttpService, CommonDropdownsService, ValidationService, AuthService } from '../../../../../@core/services';
import { PersonHealthService } from '../person-health.service';
import { HealthConstants } from '../health-constants';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonInfoService } from '../../person-info.service';
import moment from 'moment';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'birth-information-cw',
    templateUrl: './birth-information-cw.component.html',
    styleUrls: ['./birth-information-cw.component.scss'],
    standalone: false
})
export class BirthInformationCwComponent implements OnInit {

  birthInfoForm!: FormGroup;
  examTypeList: any[] = [];
  specialityExamTypeList!: any[];
  labTestList: any[] = [];
  editMode!: boolean;
  reportMode!: string;
  modalInt!: number;
  birthInfocw: BirthInfocw[] = [];
  health: Health = {};
  isAgeUnder5: boolean = false;
  constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
  pregnatMothersUseDropdownItems$!: Observable<DropdownModel[]>;
  medicalConditionsDropdownItems$!: Observable<DropdownModel[]>;
  diseasesDropdownItems$!: Observable<DropdownModel[]>;
  prenatalCareDropdownItems$!: Observable<DropdownModel[]>;
  gestationDropdownItems$!: Observable<DropdownModel[]>;
  deliveryTypeDropdownItems$!: Observable<DropdownModel[]>;
  complicationTypeDropdownItems$!: Observable<DropdownModel[]>;
  stateDropdownItems$!: Observable<DropdownModel[]>;
  countyDropDownItems$!: Observable<DropdownModel[]>;
  whenBegunItems$!: Observable<DropdownModel[]>;
  parityItems$!: Observable<DropdownModel[]>;

  address = { address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
  under5yearsInfoForm!: FormGroup;
  uploadedFiles: any[] = [];
  uploadNumber = '123434';
  load: boolean = false;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  isClosed = false;

  private formbulider: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _personInfoService: PersonInfoService;
  private _commonDropdownService: CommonDropdownsService;
  public _authService: AuthService;
  private route: ActivatedRoute;
  retrydoc: any = false;
  birthhealthinfoCheck: any;
  birthhealthinfoid: any;

  constructor(private injector: Injector) {
    this.formbulider = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
     this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.birthhealthinfoid = params['retryid'];
    });
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personhealth');
    this._personInfoService.personInfoListener$.subscribe(response => {
      this.isAgeUnder5 = (this.calculateAge(this._personInfoService.personInfo.personbasicdetails.dob) < 5) ? true : false;
    });

    if (this._personInfoService?.personInfo?.length > 0) {
      this.isAgeUnder5 = (this.calculateAge(this._personInfoService?.personInfo?.personbasicdetails?.dob) < 5) ? true : false;
    }

    this.reportMode = 'add';
    this.loadDropDown();
    this.birthInfoForm = this.formbulider.group({
      mothersusepregnant: '',
      mothersusepregnantspecify: '',
      mentalcondition: '',
      mentalconditionspecify: '',
      diseasescondition: '',
      diseasesconditionspecify: '',
      birthdefects: '',
      comments: '',
    });
    this.under5yearsInfoForm = this.formbulider.group({
      parentcare: '',
      gestation: '',
      deliverytype: '',
      comments: '',
      whenbegun: null,
      parity: null,
      prenatalproblem: null,
      prenatalproblemspecify: null,
      hospitalcomments: '',
      complications: '',
      childbornin: '',
      speciality: '',
      phone: '',
      email: ['', [ValidationService.mailFormat]]
    });
    const list = this._healthService.getHealthInfoWithKey(HealthConstants.LIST_KEY.PERSON_BIRTH);
    if (list && Array.isArray(list) && list.length) {
      this.birthInfocw = list;
    }
    this.loadBirthInfo();
    this.route.queryParams.subscribe(params => {
      const status = params['birthDetails'];
      if (status) {
        const birthDetails = JSON.parse(this._dataStoreService.getData('birthDetails-health-summary'));
        this.view(birthDetails);
      }
    });
  }

  uploadclosed(event: any) {
    if (event) {
      this.documentuploaded.closeupload();
      this.load = true;
    }
  }

  updateLoad() {
    this.load = false;
  }

  loadBirthInfo() {
    this._healthService.getBirthInfo().subscribe(response => {
      if (response && Array.isArray(response) && response.length) {
        const data = response[0].getbirthinfolist;
          this.birthhealthinfoCheckCondition(data);
          if (this.birthhealthinfoCheck && this.birthhealthinfoid) {
              this.edit(this.birthhealthinfoCheck);
              this.birthhealthinfoid = null;
          }
        if (data.personBirth && data.personBirth.length) {
          const personBirth = data.personBirth[data.personBirth.length - 1];
          this.birthInfoForm.patchValue(personBirth);
          this.reportMode = 'edit';
          this.editMode = true;
          this.uploadedFiles = Array.isArray(personBirth.uploadpath) ? personBirth.uploadpath : [];
        }
        if (data.underfive && data.underfive.length) {
          const underfive = data.underfive[data.personBirth.length - 1];
          this.under5yearsInfoForm.patchValue(underfive);
          this.address.address1 = underfive.address1;
          this.address.address2 = underfive.address2;
          this.address.city = underfive.city;
          this.address.state = underfive.state;
          this.address.county = underfive.county;
          this.address.zipcode = underfive.zip5no;
          this.reportMode = 'edit';
          this.editMode = true;
        }

      }
    });
  }


  birthhealthinfoCheckCondition(data: any) {
    if (this.birthhealthinfoid) {
      this.birthhealthinfoCheck = (data?.personBirth as any[]).find(item => item.personfmlymdcl_hstryid === this.birthhealthinfoid);
    }
  }

  resetAddress() {
    this.address = { address1: null, address2: null, city: null, state: null, county: null, zipcode: null };
  }
  resetForm() {
    this.birthInfoForm.reset();
    this.modalInt = -1;
    this.editMode = false;
    this.reportMode = 'add';
    this.birthInfoForm.enable();
  }


  view(modal: any) {
    this.reportMode = 'edit';
    this.patchForm(modal);
    this.editMode = false;
    this.birthInfoForm.disable();
  }

  edit(modal: any, i?: any) {
    this.reportMode = 'edit';
    this.editMode = true;
    this.modalInt = i;
    this.patchForm(modal);
    this.birthInfoForm.enable();
  }

  delete(index: any) {
    this.birthInfocw.splice(index, 1);
    this._alertSevice.success('Deleted Successfully');
    this.resetForm();
  }

  cancel() {
    this.resetForm();
  }

  add() {
    const uploadInfo = {};
    const birthInfo = this.birthInfoForm.getRawValue();
    birthInfo.uploadpath = this.uploadedFiles;
    if (birthInfo.uploadpath) {
      birthInfo.uploadpath.forEach((document: { percentage: any; }) => {
        if (document.percentage) {
          delete document.percentage;
        }
      });
    }
    const under5 = { ...this.under5yearsInfoForm.getRawValue(), ...this.address };
    under5.cityname = this.address.city;
    under5.statetypekey = this.address.state;
    under5.zip5no = this.address.zipcode;

    const data = { 'birth': birthInfo, 'underfive': under5 };
    this._healthService.saveHealth({ 'personBirth': data }).subscribe(_ => {
      this._alertSevice.success('Birth/Neonatal Info Saved Successfully');
      this.reportMode = 'edit';
      this.editMode = true;
      this.loadBirthInfo();
    });

  }

  update() {
    if (this.modalInt !== -1) {
      this.birthInfocw[this.modalInt] = this.birthInfoForm.getRawValue();
      this.patchForm(this.birthInfocw[0]);
    }

    this.reportMode = 'edit';
    this.editMode = true;
    this._alertSevice.success('Birth/Neonatal Info Updated Successfully');
  }
  private patchForm(modal: BirthInfocw) {
    this.birthInfoForm.patchValue(modal);
  }

  private loadDropDown() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '125' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '48' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '71' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      )
    ]).pipe(
      map((result) => {
        return {
          pregnatMothersUseList: this.returnNewDropdown(result[0], 1),
          medicalConditionsList: this.returnNewDropdown(result[1], 1),
          diseasesList: this.returnNewDropdown(result[2], 1)
        };
      }),
      share());
    this.pregnatMothersUseDropdownItems$ = source.pipe(pluck('pregnatMothersUseList'));
    this.medicalConditionsDropdownItems$ = source.pipe(pluck('medicalConditionsList'));
    this.diseasesDropdownItems$ = source.pipe(pluck('diseasesList'));
    const under5Ddsource = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '151' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '90' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '337' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'delete_sw': 'N', 'picklist_type_id': '53' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.StateListUrl + '?filter'
      ),
      this._commonHttpService.create(
        {
          nolimit: true,
          order: 'countyname asc'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CountyList
      ),
      this._commonDropdownService.getDropownsByTable('whenbegun'),
      this._commonDropdownService.getDropownsByTable('parity'),
    ]).pipe(
      map((result) => {
        return {
          prenatalCareList:  this.returnNewDropdown(result[0], 2),
          gestationList: this.returnNewDropdown(result[1], 2),
          deliveryTypeList: this.returnNewDropdown(result[2], 2),
          complicationTypeList:this.returnNewDropdown(result[3], 2),
          states: result[4].map(
            (res: { statename: any; stateabbr: any; }) =>
              new DropdownModel({
                text: res.statename,
                value: res.stateabbr
              })
          ),
          counties: result[5].map(
            (res: { countyname: any; }) =>
              new DropdownModel({
                text: res.countyname,
                value: res.countyname
              })
          ),
          whenbegun: this.returnNewDropdown(result[6], 3),
          parity:this.returnNewDropdown(result[7], 3)
        };
      }),
      share());
    this.prenatalCareDropdownItems$ = under5Ddsource.pipe(pluck('prenatalCareList'));
    this.gestationDropdownItems$ = under5Ddsource.pipe(pluck('gestationList'));
    this.deliveryTypeDropdownItems$ = under5Ddsource.pipe(pluck('deliveryTypeList'));
    this.complicationTypeDropdownItems$ = under5Ddsource.pipe(pluck('complicationTypeList'));
    this.stateDropdownItems$ = under5Ddsource.pipe(pluck('states'));
    this.countyDropDownItems$ = under5Ddsource.pipe(pluck('counties'));
    this.whenBegunItems$ = under5Ddsource.pipe(pluck('whenbegun'));
    this.parityItems$ = under5Ddsource.pipe(pluck('parity'));

  }

  returnNewDropdown(result: any, type: any) {
    let resultDropDown;
    if (type == 1) {
      resultDropDown = result.map(
        (res: { description_tx: any; value_tx: any; }) =>
          new DropdownModel({
            text: res.description_tx,
            value: res.value_tx
          }));
    } else if (type == 2) {
      resultDropDown = result.map(
        (res: { description_tx: any; picklist_value_cd: any; }) =>
          new DropdownModel({
            text: res.description_tx,
            value: res.picklist_value_cd
          }));
    }
    else if (type == 3) {
      resultDropDown = result.map(
        (res: { description: any; }) =>
          new DropdownModel({
            text: res.description,
            value: res.description
          }));
    }

    return resultDropDown;
  }

  calculateAge(dob: any) {
    let age = -1;
    if (dob && moment(new Date(dob), 'MM/DD/YYYY', true).isValid()) {
      const rCDob = moment(new Date(dob), 'MM/DD/YYYY').toDate();
      age = moment().diff(rCDob, 'years');
    }
    return age;
  }

}
