
import { pluck, share, map } from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { forkJoin, Observable } from 'rxjs';
import { AlertService, DataStoreService, CommonHttpService, AuthService } from '../../../../../@core/services';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { PersonHealthService } from '../person-health.service';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { InvolvedPerson } from '../../../involved-persons/_entities/involvedperson.data.model';
import { InvolvedPersonsService } from '../../../involved-persons/involved-persons.service';
import { PersonInfoService } from '../../person-info.service';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';

@Component({
    selector: 'feeding-info-cw',
    templateUrl: './feeding-info-cw.component.html',
    styleUrls: ['./feeding-info-cw.component.scss'],
    standalone: false
})
export class FeedingInfoCwComponent implements OnInit {

  FeedingInfoForm!: FormGroup;
  FeedingPositionList$!: Observable<DropdownModel[]>;
  DietTypeList$!: Observable<DropdownModel[]>;
  EaterTypeList$!: Observable<DropdownModel[]>;
  LiquidList$!: Observable<DropdownModel[]>;
  SolidFood$!: Observable<DropdownModel[]>;
  uploadedFiles = [];
  personRoles: Array<any> = [];
  uploadNumber = '123434';
  isAddEdit: boolean = false;
  OtherNeedsList$!: Observable<DropdownModel[]>;
  feedingInfoList: any[] = [];
  editMode!: boolean;
  selectedItem: any;
  reportMode!: string;
  dietTypeList!: DropdownModel[];
  feedingPositionList!: DropdownModel[];
  eaterTypeList!: DropdownModel[];
  personhlthfeedingid!: string;
  load: boolean = false;
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  checkrequired: boolean = false;
  isClosed = false;

  private formbuilder: FormBuilder;
  private _alertSevice: AlertService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _healthService: PersonHealthService;
  private _involvedPersonService: InvolvedPersonsService;
  public _personInfoService: PersonInfoService;
  public _authService: AuthService;
  private route: ActivatedRoute;
  retrydoc: any = false;
  feedingCheck: any;
  feedingid: any;

  constructor(private injector: Injector) {
    this.formbuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._alertSevice = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._involvedPersonService = this.injector.get<InvolvedPersonsService>(InvolvedPersonsService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
       this.route.queryParams.subscribe(params => {
      this.retrydoc = params['retrydocument'];
      this.feedingid = params['retryid'];
    });
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personhealth');
    this.FeedingInfoForm = this.formbuilder.group({
      personfeedinginfoid: null,
      infoprovidedby: [null, Validators.required],
      clientlist: '',
      Collaterallist: '',
      provided_name: ['', Validators.required],
      relationship: '',
      isfeedinginfoknown: [null],
      diettype: [null],
      eatertype: [null],
      liquids: [null],
      typeofformula: '',
      amountperfeeding: '',
      schedule: '',
      solidfood: [null],
      feeding_position: [null],
      otherneeds: [null],
      comments: ''
    });
    this.loadDropDowns();
    this.getInvolvedPerson();
    this.getFeedingInfo();
    if (this.isClosed || !this._authService.isPersonSubTabViewable('person', 'person.Health.feedingadd')) {
      this.FeedingInfoForm.disable();
    }
    this.reportMode = 'add';
    this.route.queryParams.subscribe(params => {
      const status = params['feedingInfo'];
      if (status) {
        const feedingInfo = JSON.parse(this._dataStoreService.getData('feedingInfo-health-summary'));
        if (feedingInfo.ishousehold.toLowerCase() === 'household') {
          feedingInfo.ishousehold = true;
          feedingInfo.iscollateral = false;
        } else if (feedingInfo.ishousehold.toLowerCase() === 'collateral') {
          feedingInfo.iscollateral = true;
          feedingInfo.ishousehold = false;
        }
        this.view(feedingInfo);
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

  private loadDropDowns() {
    const source = forkJoin([
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '81', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '229', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '219', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '114', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '202', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      ),
      this._commonHttpService.getArrayList(
        {
          method: 'get',
          nolimit: true,
          where: { 'active_sw': 'Y', 'picklist_type_id': '130', 'delete_sw': 'N' }
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
      )]).pipe(
        map((result) => {
          return {
            FeedingPositionList: this.createDropdown(result[0]),
            DietTypeList: this.createDropdown(result[1]),
            EaterTypeList: this.createDropdown(result[2]),
            LiquidList: this.createDropdown(result[3]),
            SolidFood: this.createDropdown(result[4]),
            OtherNeedsList: this.createDropdown(result[5])
          };
        }),
        share());
    this.FeedingPositionList$ = source.pipe(pluck('FeedingPositionList'));
    this.DietTypeList$ = source.pipe(pluck('DietTypeList'));
    this.EaterTypeList$ = source.pipe(pluck('EaterTypeList'));
    this.LiquidList$ = source.pipe(pluck('LiquidList'));
    this.SolidFood$ = source.pipe(pluck('SolidFood'));
    this.OtherNeedsList$ = source.pipe(pluck('OtherNeedsList'));
    source.pipe(pluck('DietTypeList')).subscribe((item) => {
      this.dietTypeList = item;
    });
    source.pipe(pluck('FeedingPositionList')).subscribe((item) => {
      this.feedingPositionList = item;
    });
    source.pipe(pluck('EaterTypeList')).subscribe((item) => {
      this.eaterTypeList = item;
    });
  }

  createDropdown(result: any) {
    return result.map(
      (res: { description_tx: any; picklist_value_cd: any; }) =>
        new DropdownModel({
          text: res.description_tx,
          value: res.picklist_value_cd
        }));
  }

  addFeeding() {
    this.checkrequired = true;
    if (this.FeedingInfoForm.valid) {
      const FeedingData = this.FeedingInfoForm.getRawValue();
      if (FeedingData && FeedingData.infoprovidedby && FeedingData.infoprovidedby === 1) {
        FeedingData.ishousehold = true;
        FeedingData.iscollateral = false;
      } else if (FeedingData && FeedingData.infoprovidedby && FeedingData.infoprovidedby === 2) {
        FeedingData.ishousehold = false;
        FeedingData.iscollateral = true;
      } else {
        FeedingData.ishousehold = false;
        FeedingData.iscollateral = false;
      }
      const uploadInfo: any = {};
      uploadInfo['uploadpath'] = this.uploadedFiles;

      const data = { ...FeedingData, ...uploadInfo };
      let isNew = 1;
      let message = 'Feeding Information Saved Successfully';
      if (this.editMode) {
        data.personhlthfeedingid = this.personhlthfeedingid;
        isNew = 0;
        message = 'Feeding Information Updated Successfully';
      }
      this._healthService.saveHealth({ 'feedingInfo': [data] }, isNew).subscribe(response => {
        this._alertSevice.success(message);
        this.getFeedingInfo();
      });
      this.resetFeeding();
    }
    else {
      this._alertSevice.error("Please fill all required fields");
    }
  }

  resetFeeding() {
    this.FeedingInfoForm.reset();
    this.editMode = false;
    this.reportMode = 'add';
    this.FeedingInfoForm.enable();
    this.uploadedFiles = [];
    this.isAddEdit = false;
    this.checkrequired = false;
  }

  getFeedingInfo() {
    this._healthService.getFeedingInfo().subscribe(res => {
      this.feedingInfoList = res ? res.data : [];
      this.feedingCheck = (this.feedingInfoList as any[]).find(item => item.personhlthfeedingid === this.feedingid);
          if (this.feedingCheck && this.feedingid) {
              this.edit(this.feedingCheck);
              this.feedingid = null;
          }
    });
  }
  private getInvolvedPerson() {
    let isExpungementSuperUser= this._authService.isExpungementSuperUser();
    let url = '';

    if(isExpungementSuperUser=== 1) {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
    } else {
        url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
    }
    forkJoin([
      this._commonHttpService
        .getPagedArrayList(
          {
            where: this._involvedPersonService.getRequestParam(),
            page: 1,
            limit: 20,
            method: 'get'
          },
          url + '?filter'
        )]).subscribe((result) => {
          if (result[0].data) {
            this.personRoles = [];
            result[0].data.forEach((list: InvolvedPerson) => {
              return this.personRoles.push({
                intakeservicerequestactorid: list.intakeservicerequestactorid,
                displayname: list.firstname + ' ' + list.lastname,
                personname: list.firstname + ' ' + list.lastname,
                role: list.roles
              });
            });
          }
        });
  }

  addFeedingInfo() {
    this.isAddEdit = true;
  }

  edit(data: any, i?: any) {
    this.reportMode = 'edit';
    this.isAddEdit = true;
    this.editMode = true;
    this.personhlthfeedingid = data.personhlthfeedingid;
    const iscollateralData = (data && data.iscollateral) ? 2 : null;
    const infoprovidedby = (data && data.ishousehold) ? 1 : iscollateralData ;
    data.infoprovidedby = infoprovidedby;
    this.FeedingInfoForm.patchValue(data);
    this.uploadedFiles = data.uploadpath ? data.uploadpath : [];
    this.FeedingInfoForm.enable();
  }

  view(modal: any) {
    this.reportMode = 'edit';
    const isCollateralModel = ((modal && modal.iscollateral) ? 2 : null);
    const infoprovidedby = (modal && modal.ishousehold) ? 1 : isCollateralModel;
    modal.infoprovidedby = infoprovidedby;
    this.FeedingInfoForm.patchValue(modal);
    this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
    this.isAddEdit = true;
    this.editMode = false;
    this.FeedingInfoForm.disable();
  }

  deleteConfirm(item: any, index: any) {
    (<any>$('#delete-popup')).modal('show');
    this.selectedItem = item;
  }

  delete() {
    const data = {
      'personhlthfeedingid': this.selectedItem.personhlthfeedingid,
    };
    this._healthService.saveHealth({ 'feedingInfo': [data] }, 2).subscribe(_ => {
      this._alertSevice.success('Feeding Information Deleted Successfully');
      this.resetFeeding();
      this.getFeedingInfo();
    });
  }

  getDietType(value: any) {
    if (this.dietTypeList) {
      const diettype = this.dietTypeList.filter(data => data.value === value);
      if (diettype[0]) {
        return diettype[0].text;
      }
    }
    return '';
  }

  getFeedingPostion(value: any) {
    if (this.feedingPositionList) {
      const diettype = this.feedingPositionList.filter(data => data.value === value);
      if (diettype[0]) {
        return diettype[0].text;
      }
    }
    return '';
  }

  getEaterType(value: any) {
    if (this.eaterTypeList) {
      const diettype = this.eaterTypeList.filter(data => data.value === value);
      if (diettype[0]) {
        return diettype[0].text;
      }
    }
    return '';
  }

}
