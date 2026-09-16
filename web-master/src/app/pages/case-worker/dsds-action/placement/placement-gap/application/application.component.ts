import { Component, OnInit, ViewChild, Injector } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { AlertService, CommonHttpService, DataStoreService, AuthService, SessionStorageService, CommonDropdownsService, GenericService } from '../../../../../../@core/services';
import { DropdownModel, PaginationRequest, PaginationInfo } from '../../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { PlacementGapService } from '../placement-gap.service';
import { RouteToSupervisor } from '../../_entities/placement.model';
import moment from 'moment';
import { NgxfUploaderService, FileError } from 'ngxf-uploader';
import { HttpHeaders } from '@angular/common/http';
import { AppConfig } from '../../../../../../app.config';
import { config } from '../../../../../../../environments/config';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import jsPDF from 'jspdf';
import { Observable, forkJoin } from 'rxjs';
import { AttachmentUpload } from '../../../../../provider-applicant/new-public-applicant/_entities/newApplicantModel';
import { ActivatedRoute, Router } from '@angular/router';
import { Attachment } from '../../../attachment/_entities/attachment.data.models';
import { map, share, pluck } from 'rxjs/operators';
import { DocumentUploadListSharedComponent } from '../../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

@Component({
    selector: 'application',
    templateUrl: './application.component.html',
    styleUrls: ['./application.component.scss'],
    standalone: false
})
export class ApplicationComponent implements OnInit {

  id!: string;
  applicationForm!: FormGroup;
  approvalStatusForm!: FormGroup;
  agreementRateForm!: FormGroup;
  providerSearchForm!: FormGroup;
  guardiandetails: any;
  parent1providerid: string = '';
  //selectedparent: any;
  //selectedparent: any;
  adoptiveparent1!: string;
  adoptiveparent2!: string;
  oldproviderid!: string;
  newproviderid!: string;
  mandatoryField=false;
  currProcess = 'search';
  fcProviderSearch!: any[];
  showSwitchButton: boolean = false;
  fcTotal!: number;
  paginationInfo: PaginationInfo = new PaginationInfo();
  fcpaginationInfo: PaginationInfo = new PaginationInfo();
  selectedProvider: any;
  showTitle4eFields: any;
  showSsnMask: boolean = true;
  isApproved!: boolean;
  guardianshipplacementstructure:any;
  isExistRecord!: boolean;
  applicationData: any;
  isEnableComments!: boolean;
  isSupervisor!: boolean;
  submitStatus!: RouteToSupervisor;
  store: any;
  maxDate = new Date();
  relationShipToRADropdownItems!: DropdownModel[];
  uploadedFile: any = [];
  deleteAttachmentIndex!: number;
  token: any;
  daNumber!: string;
  pvtProvider: boolean = false;
  newApplication: boolean = true;
  childCharacteristics!: any[];
  otherLocalDeptmntType!: any[];
  placementStrType!: any[];
  bundledPlcmntServicesType!: any[];
  userInfo!: AppUser;
  county: any;
  guardainTwoId: any;
  minDate : any;

  // Upload Attachments
  fileToSave: any[] = [];
  attachmenttype= 'case';
  isAttachType = '';
  showInfo = true;
  attachmentTypeDropdown$!: Observable<DropdownModel[]>;
  attachmentClassificationtypelookup = [];
  attachmentClassificationtype: any[] = [];
  isCW!: boolean;
  isCate = '';
  issubCate= '';
  personid= '';
  curDate!: Date;
  attachmentResponse!: AttachmentUpload;
  isAdoptionCase: boolean;
  uploadedFiles: any = [];
  showSwitchAdoptiveParentReason: boolean = false;
  providerAuditInfo: any = [];
  objectId:any = '';
  @ViewChild(DocumentUploadListSharedComponent)
  documentuploaded!: DocumentUploadListSharedComponent;
  dtformat = 'MM/DD/YYYY';
  deleteattachmentpopupid = '#delete-attachment-popup';
  genderDropdownItems: any[] = [];
  isSuccessorGuardianExists: any;

  private _store: DataStoreService;
  private _formBuilder: FormBuilder;
  private _alertService: AlertService;
  private _httpService: CommonHttpService;
  private _gapService: PlacementGapService;
  private _authservice: AuthService;
  private _session: SessionStorageService;
  private _ddservice: CommonDropdownsService;
  private _uploadService: NgxfUploaderService;
  private route: ActivatedRoute;
  private router: Router;
  private _service: GenericService<Attachment>;
  retrydoc: boolean = false;

    constructor(private injector : Injector,private html2canvas:Html2CanvasService){
        this._store = injector.get<DataStoreService>(DataStoreService);
        this._formBuilder = injector.get<FormBuilder>(FormBuilder);
        this._alertService = injector.get<AlertService>(AlertService);
        this._httpService = injector.get<CommonHttpService>(CommonHttpService);
        this._gapService = injector.get<PlacementGapService>(PlacementGapService);
        this._authservice = injector.get<AuthService>(AuthService);
        this._session = injector.get<SessionStorageService>(SessionStorageService);
        this._ddservice = injector.get<CommonDropdownsService>(CommonDropdownsService);
        this._uploadService = injector.get<NgxfUploaderService>(NgxfUploaderService);
        this.route = injector.get<ActivatedRoute>(ActivatedRoute);
        this.router = injector.get<Router>(Router);
        this._service = injector.get<GenericService<Attachment>>(GenericService);
        if (this.route.snapshot.params) {
          this.attachmenttype = this.route.snapshot.params['attachmenttype'] || 'case';
          this.personid = this.route.snapshot.params['personid'] || '';
        }
        this.store = this._store.getCurrentStore();
        const caseType = this._store.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
          this.isAdoptionCase = true;
        } else {
          this.isAdoptionCase = false;
        }
    }

  ngOnInit() {
    this.route.queryParams.subscribe(params => {
      if(params['retrydocument']) {
        this.retrydoc = true;   
      }
    });
    this._gapService.checkDataAvailability();
    this.id = this._store.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._store.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    this.token = this._authservice.getCurrentUser();
    if (this._authservice.selectedRoleIs('apcs')) {
      this.isSupervisor = true;
    }
    this.isCW = this._authservice.isCW();
    this.curDate = new Date();
    this.loadAttachmentDropdown()
    this.initform();
    this.getPage();
    this.getRelationList();
    this.userInfo = this._authservice.getCurrentUser();
    this.getChildCharacteristics();
    this.getOtherLocalDeptmntType();
    this.getPlacementStrType(null);
    this.getBundledPlcmntServicesType();
    this.loadAttachmentDropDown();
  }

  initform() {

    this.applicationForm = this._formBuilder.group({
      guardianonedate: [new Date()],
      guardiantwodate: [''],
      ldssdirectordate: [null],
      servicecaseid: [null],
      guardian1signature: [null],
      guardian2signature: [null],
      ldssdirectorsignature: [null],
      gapapplicationid: [null],
      gapid: [null],
      permanencyplanid: [null],
      guardianoneid: [{value:'', disabled:true}],
      guardiantwoid: [{value:'', disabled:true}],
      guardianonename: [{value:'', disabled:true}],
      guardiantwoname: [{value:'', disabled:true}],
      isrcgunderstandpurpose: [null],
      isrcgacknowledgedruledoutplans: [null],
      isrcgapprovedhomeforsixmonths: [null],
      isrcgcomprehensivestudycompleted: [null],
      isrcgcompletedprotectiveclearance: [null],
      isrcgauthorizedmentalinfo: [null],
      isrcgshowpermanentcommitment: [null],
      isrcgwillstablehome: [null],
      isrcgprovidesupervision: [null],
   //   iscgcompletedannualreconsideration: [null],
      isrcghavefinancialsupport: [null],
      isrcgagreestoapplyssn: [null],
      isrcgnotifybehalfofchild: [null],
      isrcgnotifylocaldeptforchanges: [null],
      isrcgguardianshipassistancepayment: [null],
      isrcgunderstandgacanbeterminated: [null],
      iscgenteredagreement : [null],
      isrcgandcwdiscussedrequirements: [null],
      guardianoneproviderid: [null],
      guardiantwoproviderid: [null],
      disclosuredate: [new Date()],
      iscgattendedorientation: [null],
      enteredby: [null],
      issuccessorguardianexists: [null],
      successionaddendumdate: [null],
      successorguardianname: [null],
      primaryrelationshipkey: [null],
      secondaryrelationshipkey: [null],
      planmeetingdate: [null],
      guardoneaddress: [null],
      guardtwoaddress: [null],
      guardonessnno: [null],
      guardtwossnno: [null],
      guardonedob: [null],
      guardtwodob: [null],
      isapprovedresourceparent: [null],
      isapprovedkinshipplacement: [null],
      documentsigned: [null],
      effectiveswitchdate: [null],
      switchproviderreason:[null],
      switchprovider: [true],
    });

    this.approvalStatusForm = this._formBuilder.group({
      routingstatus: [''],
      comments: ['']
    });

    this.providerSearchForm = this._formBuilder.group({
      childcharacteristics: [null],
      bundledplacementservices: [null],
      otherLocalDeptmntTypeId: [null],
      placementstructures: [null],
      zipcode: null,
      isLocalDpt: [true],
      firstname: null,
      middlename: null,
      lastname: null,
      isgender: [false],
      isAge: [false],
      providerid: null,
      agemin: null,
      agemax: null,
      gender: null
    });



  }

  getChildCharacteristics() {
    this._httpService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '43'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.childCharacteristicsUrl).subscribe(result => {
      this.childCharacteristics = result;
    });
  }

  getOtherLocalDeptmntType() {
    this._httpService.getArrayList(new PaginationRequest({
      where: {
        'picklist_type_id': '104'
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.otherLocalDeptmntTypeUrl).subscribe(result => {
      this.otherLocalDeptmntType = result;
      this.county = this.userInfo.user.userprofile.primarycountycd.trim();
      this.providerSearchForm.controls['otherLocalDeptmntTypeId'].setValue([this.county]);
    });
  }

  getPlacementStrType(providerId: any) {
    this._httpService.getArrayList(new PaginationRequest({
      where: {
        'structure_service_cd': 'P',
        'provider_id': providerId
      },
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.placementStrTypeUrl).subscribe(result => {
      this.placementStrType = result;
    });
  }

  getBundledPlcmntServicesType() {
    this._httpService.getArrayList(new PaginationRequest({
      nolimit: true,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.bundledPlcmntServicesTypeUrl).subscribe(result => {
      this.bundledPlcmntServicesType = result;
    });
  }

  private getAge(dateValue: any) {
    if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
      const rCDob = moment(new Date(dateValue), this.dtformat).toDate();
      return moment().diff(rCDob, 'years');
    } else {
      return '';
    }
  }
  onSearchParents() {
    const child = this.store['placed_child'];
    if(child) {
      const childage = this.getAge(child.dob);
      const min = 0;
      const max = childage;
      this.providerSearchForm.patchValue({
        isgender: true,
        isAge: true,
        agemin: min,
        agemax: max,
        gender: child.gender
      });
    }
    this.currProcess = 'search';
    (<any>$('#searchProvider')).modal('show');

  }
  getRelationList() {
    this._httpService.getArrayList(
      {
        where: { activeflag: 1, teamtypekey: this._authservice.getAgencyName() },
        method: 'get',
        nolimit: true
      },
      CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
        .RelationshipTypesUrl + '?filter'
    ).subscribe(data => {
      if (data && data.length) {
        this.setRelationList(data);
      }
    });
  }
  setRelationList(data: any) {
    if (data && data.length) {
      this.relationShipToRADropdownItems = data.map((res: { description: any; relationshiptypekey: any; }) => {
        return new DropdownModel({
          text: res.description,
          value: res.relationshiptypekey
        });
      });
    }
  }

  getFcProviderSearch() {
    if (this.providerSearchForm.invalid) {
      this._alertService.error('Please fill required fields');
      return false;
    }

    const child = this.store['placed_child'];
    if(child) {
      const childage = this.getAge(child.dob);
      const min = 0;
      const max = childage;
      this.providerSearchForm.patchValue({
        isgender: this.providerSearchForm.getRawValue().isgender ? true : null,
        isAge: this.providerSearchForm.getRawValue().isAge ? true : null,
        agemin: min,
        agemax: max,
        gender: child.gender
      });
    }
    const formValues = this.providerSearchForm.getRawValue();
    if (formValues.isgender && !formValues.gender) {
      this._alertService.error('Please select gender');
      return false;
    }
    formValues.gender = (formValues?.isgender) ? (formValues?.gender) : null;

    Object.keys(this.providerSearchForm.controls).forEach(key => {
      formValues[key] = this.CheckFormControlValue(formValues[key]);
    });
    const body: any = {};
    Object.assign(body, formValues);
    body['isLocalDpt'] = true;
    body['localdepartmenthomecaregiver'] = true;
    body['childcharacteristics'] = formValues.childcharacteristics ? formValues.childcharacteristics[0] : null;
    body['otherLocalDeptmntTypeId'] = formValues.otherLocalDeptmntTypeId ? formValues.otherLocalDeptmntTypeId[0] : null;
    body['placementstructures'] = formValues.placementstructures ? formValues.placementstructures[0] : null;
    body['bundledplacementservices'] = formValues.bundledplacementservices ? formValues.bundledplacementservices[0] : null;
    body['guardian'] = true;
    this._httpService.getPagedArrayList(new PaginationRequest({
      where: body,
      page: this.paginationInfo.pageNumber,
      limit: 10,
      method: 'get'
    }), CaseWorkerUrlConfig.EndPoint.DSDSAction.foster_care.fcProviderSearchUrl).subscribe(result => {
      this.fcProviderSearch = result.data;
      this.fcTotal = result.count;
      (<any>$('#fc_list')).click();
      this.currProcess = 'select';
    });
  }

  CheckFormControlValue(formControl: any) {
    return (formControl && formControl !== '') ? formControl : null;
  }
  resetproviderSearchForm() {
    this.providerSearchForm.reset();
    this.currProcess = 'search';
  }

  getRangeArray(n: number): any[] {
    return Array(n);
  }

  selectedProv(provId: any) {
    this.selectedProvider = provId;
  }

  maskSSN(value: any): string {
		if (value != null || value === '') {
			value = String(value).replace(/-/g, '');
		}
		if (this.showSsnMask === true) {
			if (String(value).startsWith('*') && String(value).length < 9) {
				return '';
			}
			if (String(value).match('^[/d]{9}$')) {
				return '***-**-' + String(value).substring(String(value).length - 4);
			}
		} else {
			if (String(value).startsWith('*')) {
				return '';
			}
			if (String(value).match('^[/d]{9}$')) {
				return (String(value).substring(0, 3) + '-' + String(value).substring(3, 5) + '-' + String(value).substring(5, 9));
			} else { return ''; }
		}
		return value;
  }

  backToSearch() {
    const child = this.store['placed_child'];
    if(child) {
      const childage = this.getAge(child.dob);
      const min = 0;
      const max = childage;
      this.providerSearchForm.patchValue({
        isgender: true,
        isAge: true,
        agemin: min,
        agemax: max,
        gender: child.gender
      });
    }
    this.currProcess = 'search';
    this.selectedProvider = null;
  }

  fcPageChanged(pageEvent: any) {
    this.paginationInfo.pageNumber = pageEvent.page;
    this.getFcProviderSearch();
  }

  getFullName(firstName: any, lastName: any){
    return ''+
    (firstName? firstName+' ' : '') +
    (lastName? lastName+' ' : '');
  }
  selectProvider() {
    if(this.selectedProvider && this.selectedProvider.provider_id){
      this._httpService.getArrayList(
        {
          method: 'get',
          where: { provider_id: this.selectedProvider.provider_id}
        },
        'tb_provider?filter'
      ).subscribe(res => {
        this.applicationForm.markAsDirty();
        this.isExistRecord = false;
        if (res && res.length && res[0]) {
          this.parent1providerid = res[0].provider_id;
          this.applicationForm.patchValue({
            'guardianoneproviderid': res[0].provider_id,
            'guardoneaddress': this.selectedProvider.providerdetails[0].address,
            'guardonedob': res[0].dob_dt ? new Date(res[0].dob_dt) : null,
            'guardonessnno': res[0].tax_id_no,
            'guardtwodob': res[0].co_dob_dt ? new Date(res[0].co_dob_dt) : null,
            'guardtwossnno': res[0].co_ssn_no
          });
          this.applicationForm.get('ldssdirectordate')?.enable();
          this.applicationForm.get('guardianonedate')?.enable();
          this.applicationForm.get('documentsigned')?.enable();
          this.applicationForm.get('guardiantwodate')?.enable();
        }
      });
      this.patchGuardians(this.selectedProvider.provider_id);
      this.pvtProvider = false; //this provider search always returns Local Department Homes list
    }
    (<any>$('#searchProvider')).modal('hide');
    this.resetproviderSearchForm();

  }

  patchGuardians(provider_id: any) {
    this._httpService.getArrayList(
      {
        where: { provider_id: provider_id },
        method: 'get'
      },
      'tb_provider/getproviderguardians?filter'
    ).subscribe(res => {
      if (res[0]) {
        const getproviderguardians = res[0].getadoptiveparents;
          this.guardianshipplacementstructure=getproviderguardians[0]?.guardianshipplacementstructure1;
        if (getproviderguardians.length) {
          this.guardiandetails = getproviderguardians[0];
          if (this.guardiandetails.providerid && this.guardiandetails.provider2id && this.guardiandetails.providerid !== this.guardiandetails.provider2id && this.isApproved) {
            this.showSwitchButton = true;
          }
          this.applicationForm.patchValue({
            guardianoneproviderid: this.guardiandetails.providerid,
            guardianoneid : this.guardiandetails.adoptiveparent1id,
            guardiantwoid : this.guardiandetails.adoptiveparent2id,
            guardianonename : this.guardiandetails.adoptiveparent1,
            guardiantwoname : this.guardiandetails.adoptiveparent2,
            guardiantwoproviderid : this.guardiandetails.provider2id,
          });
        }
      }
    });
  }

  patchSwitchGuardians(provider_id: any) {
    this._httpService.getArrayList(
      {
        where: { provider_id: provider_id },
        method: 'get'
      },
      'tb_provider/getproviderguardians?filter'
    ).subscribe(res => {
      if (res[0]) {
        const getproviderguardians = res[0].getadoptiveparents;
        if (getproviderguardians.length) {
          this.guardiandetails = getproviderguardians[0];
          this.showSwitchButton = false;
          this.guardainTwoId = false;
          this.applicationForm.patchValue({
            guardianoneproviderid: this.guardiandetails.providerid,
            guardianoneid : this.guardiandetails.adoptiveparent1id,
            guardiantwoid : this.guardiandetails.adoptiveparent2id,
            guardianonename : this.guardiandetails.adoptiveparent1,
            guardiantwoname : this.guardiandetails.adoptiveparent2,
            guardiantwoproviderid : this.guardiandetails.provider2id,
            switchprovider: true
          });
        }
      }
    });
  }
  
  addDislosureChecklist() {
    this.mandatoryField = true;
    if (this.applicationForm.status == 'INVALID') {
      return;
    }
    const dislosureChecklistDetails = Object.assign({}, this.applicationForm.getRawValue());

    if (!this.handleIfDocumentsignedFn(dislosureChecklistDetails)) {
      return;
    }

    if (!this.handleIfGuardiantwoprovideridFn(dislosureChecklistDetails)) {
      return;
    }

    if (!this.handleIfGuardainTwoIdFn(dislosureChecklistDetails)) {
      return;
    }


    if (this.guardianshipplacementstructure !== 'Y') {

      this._alertService.warn('Please connect with Placement resource worker to get the Home Approval and Guardianship Placement Structure.');
      return;
    }
    dislosureChecklistDetails.servicecaseid = this.id;
    dislosureChecklistDetails.oldproviderid = this.oldproviderid ? this.oldproviderid : null;
    dislosureChecklistDetails.newproviderid = this.newproviderid ? this.newproviderid : null;
    dislosureChecklistDetails.gapapplicationid = this.applicationData && this.applicationData.gapapplicationid ? this.applicationData.gapapplicationid : null
    dislosureChecklistDetails.permanencyplanid = this._store.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
    dislosureChecklistDetails.guardiantwodate = dislosureChecklistDetails.guardiantwodate === "" ? null : dislosureChecklistDetails.guardiantwodate;

    this._httpService.create(dislosureChecklistDetails, 'gapapplication/add').subscribe(
      res => {
        if (res === 'Guardianship Already Exist') {
          this._alertService.error('Guardianship Already Exist');
        } else {
          this.isExistRecord = true;
          setTimeout(() => {
            this.getPage();
          }, 3000);
          this._alertService.success('Application Submitted for Supervisor Approval!');
          this._store.setData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID, dislosureChecklistDetails.permanencyplanid);
        }
      },
      _error => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );

  }
  // Assosiated with addDislosureChecklist method
  private handleIfGuardainTwoIdFn(dislosureChecklistDetails: any) {
    if(this.guardainTwoId){
      if (dislosureChecklistDetails.guardiantwodate && !dislosureChecklistDetails.guardian2signature && !dislosureChecklistDetails.documentsigned) {
          this._alertService.error('Enter Guardian two Signature');
          return false;
     }
     if (!dislosureChecklistDetails.guardiantwodate) {
      this._alertService.error('Enter Guardian two Date');
      return false;
     }
    }
    return true;
  }
  // Assosiated with addDislosureChecklist method
  private handleIfGuardiantwoprovideridFn(dislosureChecklistDetails: any) {
    if(dislosureChecklistDetails.guardiantwoproviderid) {
      if (!dislosureChecklistDetails.guardiantwodate) {
       this._alertService.error('Enter Guardian Two Date');
       return false;
     }
      if (!dislosureChecklistDetails.documentsigned && !dislosureChecklistDetails.guardian2signature) {
        this._alertService.error('Enter Guardian Two Signature');
        return false;
      }
     } 
    return true;
  }
  // Assosiated with addDislosureChecklist method
  private handleIfDocumentsignedFn(dislosureChecklistDetails: any) {
    if(!dislosureChecklistDetails.documentsigned) {
      if (!dislosureChecklistDetails.guardian1signature) {
        this._alertService.error('Enter Guardian One Signature');
        return false;
      }
      if (!dislosureChecklistDetails.ldssdirectorsignature) {
        this._alertService.error('Enter LDSS Director Signature');
        return false;
      }
    }
    return true;
   }

  getPage() {
    let permanencyplanid = '';
    if (this._authservice.selectedRoleIs('apcs') || this.retrydoc) {
      permanencyplanid = this._session.getItem(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
      const storeplanid = this._store.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
      this._session.removeItem('Placement-Agreement-Rate-Id');
      permanencyplanid = (permanencyplanid) ? permanencyplanid : storeplanid;
    } else {
      permanencyplanid = this._store.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID);
    }
    const reqParam = {
      permanencyplanid: permanencyplanid
    };
    this._gapService.getGapDisclosureDetails(reqParam)
      .subscribe(
        (result) => {
          if (result.data && result.data.length) {
            this.handleGetGapDisclosureDetailsRespFn(result);
          } else if (this._authservice.selectedRoleIs('apcs') && result.data.length === 0) {
            this._alertService.warn('Please fill Application');
            this.isApproved = true;
          } else {
            this.handleGuardCondFn();
          }
        }
      );
  }
  // Assosiated to getPage method
  private handleGuardCondFn() {
    const guard = this._store.getData('placement_child');
    if (guard && guard.providerdetails) {
      this.applicationForm.patchValue({
        guardianoneproviderid: guard.providerdetails.provider_id,
        guardoneaddress: guard.providerdetails.address
      });
      this.patchGuardians(guard.providerdetails.provider_id);
      this.validateProviderType(guard.providerdetails);
    }

    const placed_child = this._store.getData('placed_child');
    if (placed_child && placed_child.placements && placed_child.placements.length) {
      const cpa_home = placed_child.placements.filter((p: { cpahomeproviderdetails: null; }) => {
        if (p.cpahomeproviderdetails !== null) { return p; }
      });
      if (cpa_home && cpa_home.length > 0 && cpa_home[0].cpahomeproviderdetails) {
        this.applicationForm.patchValue({
          guardianoneproviderid: cpa_home[0].cpahomeproviderdetails.provider_id,
          guardoneaddress: cpa_home[0].cpahomeproviderdetails.address
        });
        this.patchGuardians(cpa_home[0].cpahomeproviderdetails.provider_id);
        this.pvtProvider = true;
      }
    }
  }

  // Assosiated to getPage method
  private handleGetGapDisclosureDetailsRespFn(result: any) {
    const data = result.data[0];
    if (data && data.gapapplication && data.gapapplication.length) {
      this.newApplication = false;
    }
    if (result.data[0].guardiantwoproviderid || result.data[0].guardiantwoid) {
      this.guardainTwoId = true;
    }
    if (result.data[0].guardiantwoproviderid && result.data[0].guardianoneproviderid && result.data[0].guardianoneproviderid !== result.data[0].guardiantwoproviderid && this.isApproved) {
      this.showSwitchButton = true;
    } else if (result.data[0].guardianoneproviderid) {
      this.patchGuardians(result.data[0].guardianoneproviderid);
    }
    if (result.data[0].switchprovider) {
      this.showSwitchAdoptiveParentReason = true;
    }
    if (result.data[0].auditinfo) {
      this.providerAuditInfo = result.data[0].auditinfo;
    }
    this.patchDisclosureCheckList(data);
    this._gapService.setGapId(data.gapid);
    this.getAgreement();
  }

  patchDisclosureCheckList(model: any) {
    if (model.gapapplication && model.gapapplication.length > 0) {
      this.handleIfGapApplicationFn(model);
    } else {
      this.applicationData = Object.assign({});
      this.isExistRecord = false;
    }

    this.objectId = this.applicationData ? this.applicationData.gapapplicationid : '';

    const placement = this._store.getData('placement_child');
    let provider = { guardianoneproviderid: null };
    if (placement && placement.providerdetails) {
      provider = {
        guardianoneproviderid: placement.providerdetails.provider_id
      };
    }

    if(model.guardianoneproviderid || provider.guardianoneproviderid) {
      this.patchGuardians(model.guardianoneproviderid ? model.guardianoneproviderid : provider.guardianoneproviderid);
      model.guardianoneproviderid ? this.validateProviderType(model) : this.validateProviderType(placement.providerdetails);      
    }

    this.applicationForm.patchValue({
      ...this.returnApplicationFormPatchGuardDataFn(model, provider),
      ...this.returnApplicationFormPatchIsrcgDataFn(model),
      ...this.returnApplicationFormPatchCommonDataFn(model)
    });
    if(model.effectiveswitchdate){
      this.showSwitchAdoptiveParentReason = true
    }
    
  }
  // Assosiated to patchDisclosureCheckList method
  private handleIfGapApplicationFn(model: any) {
    model.gapapplication.sort((a: any, b: any) =>
      new Date(b.insertdate).getTime() - new Date(a.insertdate).getTime()
    );
    this.applicationData = model.gapapplication[0];
    this.uploadedFiles = (this.applicationData && this.applicationData.attachments) ? this.applicationData.attachments : [];
    this.approvalStatusForm.patchValue({
      routingstatus: this.applicationData ? this.applicationData.routingstatus : '',
      comments: this.applicationData ? this.applicationData.comments : ''
    });
    if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Rejected') {
      this.isApproved = true;
      this.rejectComments(this.approvalStatusForm.value.routingstatus);
    }
    if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Review') {
      this.isExistRecord = true;
      this.applicationForm.disable();
    }
  }

  // Assosiated to patchDisclosureCheckList method
  private returnApplicationFormPatchCommonDataFn(model: any) {
    return {
      permanencyplanid: this._store.getData(CASE_STORE_CONSTANTS.GAP_PERMANENCYPLANID),
      enteredby: model.applicationenteredby,
      gapid: model.gapapplication ? model.gapid : null,
      gapapplicationid: model ? model.gapapplicationid : null,
      disclosuredate: model ? model : null,
      orientationmeetingdate: model ? model.orientationmeetingdate : null,
      successionaddendumdate: model.successionaddendumdate,
      cofinaldate: model.cofinaldate,
      successorguardianname: model.successorguardianname,
      empprogramstartdate: model.empprogramstartdate,
      empprogramname: model.empprogramname,
      fosterhomeapprover: model.fosterhomeapprover,
      primaryrelationshipkey: model.primaryrelationshipkey,
      secondaryrelationshipkey: model.secondaryrelationshipkey,
      guardiantwodate: this._ddservice.getValidDate(this.applicationData.guardiantwodate),
      guardianonedate: this._ddservice.getValidDate(this.applicationData.guardianonedate),
      ldssdirectordate: this._ddservice.getValidDate(this.applicationData.ldssdirectordate),
      guardian1signature: this.applicationData.guardian1signature,
      guardian2signature: this.applicationData.guardian2signature,
      ldssdirectorsignature: this.applicationData.ldssdirectorsignature,
      planmeetingdate: this._ddservice.getValidDate(this.applicationData.planmeetingdate),
      isapprovedresourceparent: model.isapprovedresourceparent,
      isapprovedkinshipplacement: model.isapprovedkinshipplacement,
      documentsigned: model.documentsigned,
      effectiveswitchdate: model.effectiveswitchdate,
      switchproviderreason: model.switchproviderreason,
      switchprovider: model.switchprovider
    };
  }
  // Assosiated to patchDisclosureCheckList method
  private returnApplicationFormPatchIsrcgDataFn(model: any) {
    return {
      isrcgapprovedhomeforsixmonths: model.isrcgapprovedhomeforsixmonths ? model.isrcgapprovedhomeforsixmonths : false,
      isrcgcomprehensivestudycompleted: model.isrcgcomprehensivestudycompleted ? model.isrcgcomprehensivestudycompleted : false,
      isrcgcompletedprotectiveclearance: model.isrcgcompletedprotectiveclearance ? model.isrcgcompletedprotectiveclearance : false,
      isrcgauthorizedmentalinfo: model.isrcgauthorizedmentalinfo ? model.isrcgauthorizedmentalinfo : false,
      isrcgshowpermanentcommitment: model.isrcgshowpermanentcommitment ? model.isrcgshowpermanentcommitment : false,
      isrcgwillstablehome: model.isrcgwillstablehome ? model.isrcgwillstablehome : false,
      isrcgprovidesupervision: model.isrcgprovidesupervision ? model.isrcgprovidesupervision : false,
      //   iscgcompletedannualreconsideration: model.iscgcompletedannualreconsideration ? model.iscgcompletedannualreconsideration : false,
      isrcghavefinancialsupport: model.isrcghavefinancialsupport ? model.isrcghavefinancialsupport : false,
      isrcgagreestoapplyssn: model.isrcgagreestoapplyssn ? model.isrcgagreestoapplyssn : false,
      isrcgnotifybehalfofchild: model.isrcgnotifybehalfofchild ? model.isrcgnotifybehalfofchild : false,
      isrcgnotifylocaldeptforchanges: model.isrcgnotifylocaldeptforchanges ? model.isrcgnotifylocaldeptforchanges : false,
      isrcgguardianshipassistancepayment: model.isrcgguardianshipassistancepayment ? model.isrcgguardianshipassistancepayment : false,
      isrcgunderstandgacanbeterminated: model.isrcgunderstandgacanbeterminated ? model.isrcgunderstandgacanbeterminated : false,
      iscgenteredagreement: model.iscgenteredagreement ? model.iscgenteredagreement : false,
      isrcgandcwdiscussedrequirements: model.isrcgandcwdiscussedrequirements ? model.isrcgandcwdiscussedrequirements : false
    };
  }
  // Assosiated to patchDisclosureCheckList method
  private returnApplicationFormPatchGuardDataFn(model: any, provider: any) {
    return {
      guardianoneproviderid: model.guardianoneproviderid ? model.guardianoneproviderid : provider.guardianoneproviderid,
      guardiantwoproviderid: model.guardiantwoproviderid ? model.guardiantwoproviderid : null,
      guardianonename: model.guardianoneprovidername ? model.guardianoneprovidername : null,
      guardiantwoname: model.guardiantwoprovidername ? model.guardiantwoprovidername : null,
      guardianoneid: model.guardianoneid ? model.guardianoneid : null,
      guardiantwoid: model.guardiantwoid ? model.guardiantwoid : null,
      guardoneaddress: model.oneaddress ? model.oneaddress : null,
      guardtwoaddress: model.twoaddress ? model.twoaddress : null,
      guardonessnno: model.one_ssno ? model.one_ssno : null,
      guardtwossnno: model.two_ssno ? model.two_ssno : null,
      guardonedob: model.one_dob_dt ? moment(model.one_dob_dt).format(this.dtformat) : null,
      guardtwodob: model.two_dob_dt ? moment(model.two_dob_dt).format(this.dtformat) : null,
      isrcgunderstandpurpose: model.isrcgunderstandpurpose ? model.isrcgunderstandpurpose : false,
      isrcgacknowledgedruledoutplans: model.isrcgacknowledgedruledoutplans ? model.isrcgacknowledgedruledoutplans : false
    };
  }

  rejectComments(status: any) {
    if (status === 'Rejected') {
      this.isEnableComments = true;
    } else {
      this.isEnableComments = false;
      this.approvalStatusForm.patchValue({ comments: '' });
    }
  }

  routingUpdate() {
   if (this.isEnableComments && !this.approvalStatusForm.value.comments) {
      this._alertService.error('Enter the comments');
      return;
    }
    
    if(this.guardianshipplacementstructure!=='Y'){

      this._alertService.warn('Please connect with Placement resource worker to get the Home Approval and Guardianship Placement Structure.');
      return;
    }
    let comment = 'Guardianship Submitted for review';

    if (this.approvalStatusForm.value.routingstatus === 'Rejected') {
      comment = 'Guardianship Application Rejected '
    } else if (this.approvalStatusForm.value.routingstatus === 'Approved') {
      comment = 'Guardianship Application Approved '
    }
    this.submitStatus = Object.assign({
      objectid: this.applicationData ? this.applicationData.gapapplicationid : '',
      eventcode: 'GAAP',
      status: this.approvalStatusForm.value.routingstatus,
      comments: this.approvalStatusForm.value.comments,
      notifymsg: comment,
      routeddescription: comment,
      servicecaseid: this.id
    });

    if (!this.applicationData.gapapplicationid) {
      return this._alertService.error('Please select child');
    } else if (this._authservice.selectedRoleIs('apcs') && this.approvalStatusForm.value.routingstatus === 'Review') {
      return this._alertService.error('Please select review status!');
    } else {
      this._httpService.create(this.submitStatus, 'routing/routingupdate').subscribe(
        _res => {
          this._alertService.success('Application ' + this.submitStatus.status + ' successfully!');
          this.isApproved = true;
           this.getPage();
        },
        _err => {console.log(_err); }
      );
    }
  }

  validateProviderType(provider: any) { //CDM-12217 - Disable submission for Private provider
    if (provider && provider.provider_category_cd !== '1783') {
      (<any>$('#private-provider-validation')).modal('show');
      this.pvtProvider = true;
    } else {
      this.pvtProvider = false;
    }
  }

  uploadFile(file: any): void {
    if (!(file instanceof Array)) {
        return;
    }
    if(this.newApplication){
      this._alertService.error("Please click on 'Submit for Approval' before uploading a file");
      return; 
    }
    file.map((item, index) => {
        const size = this.humanizeBytes(item.size);
        const fileExt = item.name
            .toLowerCase()
            .split('.')
            .pop();
        if (this.checkFileExtFn(fileExt)) {
            if (item.size <= config.uploadMaxSizeLimit) {
            this.uploadedFile.push(item);
            index = this.uploadedFile.length - 1;
            this.uploadAttachment(index);
            const audio_ext = ['mp3', 'ogg' , 'wav', 'acc', 'flac', 'aiff'];
            const video_ext = ['mp4', 'avi' , 'mov', '3gp', 'wmv', 'mpeg-4'];
            if ( audio_ext.indexOf(fileExt) >= 0) {
                this.uploadedFile[index].attachmenttypekey = 'Audio'
            } else if ( video_ext.indexOf(fileExt) >= 0) {
                this.uploadedFile[index].attachmenttypekey = 'Video';
            } else {
                this.uploadedFile[index].attachmenttypekey = 'Document';
            }
            this.isAttachType = this.uploadedFile[index].attachmenttypekey;
            }
            else{
                this._alertService.error("Uploaded file size "+ size+ " exceeds the maximum file size limit of "+Math.floor(config.uploadMaxSizeLimit/1048576)+"MB.");
            }
        } else {
            // tslint:disable-next-line:quotemark
            this._alertService.error(fileExt + " format can't be uploaded. Accepted file formats are mp3, ogg, wav, acc, flac, aiff, mp4, mov, avi, 3gp, wmv, mpeg-4, pdf, txt, docx, doc, xls, xlsx, jpeg, jpg, png, ppt, pptx, gif, cr2, rtf.");
        }
    });
  }
  // Assosiated to uploadFile method
  private checkFileExtFn(fileExt: any) {
    return (fileExt === 'mp3' ||
      fileExt === 'ogg' ||
      fileExt === 'wav' ||
      fileExt === 'acc' ||
      fileExt === 'flac' ||
      fileExt === 'aiff' ||
      fileExt === 'mp4' ||
      fileExt === 'mov' ||
      fileExt === 'avi' ||
      fileExt === '3gp' ||
      fileExt === 'wmv' ||
      fileExt === 'mpeg-4' ||
      fileExt === 'pdf' ||
      fileExt === 'txt' ||
      fileExt === 'docx' ||
      fileExt === 'doc' ||
      fileExt === 'xls' ||
      fileExt === 'xlsx' ||
      fileExt === 'jpeg' ||
      fileExt === 'jpg' ||
      fileExt === 'png' ||
      fileExt === 'ppt' ||
      fileExt === 'pptx' ||
      fileExt === 'gif' ||
      fileExt === 'cr2' ||
      fileExt === 'rtf');
  }

  humanizeBytes(bytes: number): string {
      if (bytes === 0) {
          return '0 Byte';
      }
      const k = 1024;
      const sizes: string[] = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB'];
      const i: number = Math.floor(Math.log(bytes) / Math.log(k));
      return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
  }

  uploadclosed(event: any){
    if(event){
        this.documentuploaded.closeupload();
    }
  }

  uploadAttachment(index: any) {
    let uploadUrl = '';
    const gapapplicationid = this.applicationData ? this.applicationData.gapapplicationid : '';
    uploadUrl = AppConfig.baseUrl + '/' + CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadAttachmentUrl + '?srno=' + this.daNumber+ '&objecttypekey=' + 'gapapplication' + '&objectid=' + gapapplicationid + '&servicecaseid=' + this.id;
    this._uploadService
        .upload({
            url: uploadUrl,
            headers: new HttpHeaders().set('ctype', 'file'),
            filesKey: ['file'],
            files: this.uploadedFile[index],
            process: true,
        })
        .subscribe(
            (response) => {
                if (response.status) {
                    this.uploadedFile[index].percentage = response.percent;
                }
                if (response.status === 1 && response.data) {
                    const doucumentInfo = response.data;
                    doucumentInfo.documentdate = doucumentInfo.date;
                    doucumentInfo.title = doucumentInfo.originalfilename;
                    doucumentInfo.name = doucumentInfo.originalfilename;
                    doucumentInfo.objecttypekey = 'gapapplication';
                    doucumentInfo.rootobjecttypekey = 'gapapplication';
                    doucumentInfo.servicerequestid = null;
                    this.uploadedFile[index] = { ...this.uploadedFile[index], ...doucumentInfo };
                    this.fileToSave[index] = this.uploadedFile[index];
                    this._alertService.success('File Upload successful.');
                }
            }, (err) => {
                this._alertService.error('Upload failed due to Server error, please try again later.');
                this.uploadedFile.splice(index, 1);
            }
        );
  }

  generatePDF_html() {
    const doc = new jsPDF('p', 'mm', 'a4');
    const formIdDataFn: any = document.getElementById('application-Form');
    this.html2canvas.capture(formIdDataFn).then(function(
        canvas
    ) {
        const imgData = canvas.toDataURL('image/png');
        const pageHeight = 300;
        const imgWidth = 205;
        const imgHeight = (canvas.height * imgWidth) / canvas.width;
        let heightLeft = imgHeight;
        let position = 0;

        doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
        heightLeft -= pageHeight;

        while (heightLeft >= 0) {
            position = heightLeft - imgHeight;
            doc.addPage();
            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;
        }

        doc.save('GAP-application.pdf');
    });
  }

  generatePDF() { 
      const req = {
          ...this.store  
      };

      const payload = {
          method: 'post',
          count: -1,
          page: 1,
          limit: 20,
          where: req,
          documntkey: [
                  'gapagreementappl'
              ]
        };

      this._httpService.create(payload, 'gapapplication/getgappdftoprint').subscribe(
          response => {
            if (response) {
              setTimeout(() => {
                  window.open(response.data.documentpath);
              }, 2000);
            } else {
                this._alertService.error('Error in processing, please try again later.');
            }
      });
 
  } 

  deleteAttachment() { 
    const workEnv = config.workEnvironment;
    const documentPropertiesId = this.uploadedFiles[this.deleteAttachmentIndex].documentpropertiesid;
    const documentId = this.uploadedFiles[this.deleteAttachmentIndex].filename;
    if(!documentPropertiesId || documentPropertiesId == undefined) {
        this.uploadedFiles.splice(this.deleteAttachmentIndex, 1);
        (<any>$(this.deleteattachmentpopupid)).modal('hide');
        return;
    } 
    if (workEnv === 'state') {
      this._removeAttachment(documentPropertiesId + '&' + documentId);
    } else {
      this._removeAttachment(documentPropertiesId);
    }
}

_removeAttachment(_id: any) {
  this._service.endpointUrl =
  CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
  this._service.remove(_id).subscribe(
    _result => {
        this._alertService.success('Attachment Deleted successfully!');
        this.uploadedFiles.splice(this.deleteAttachmentIndex, 1);
        (<any>$(this.deleteattachmentpopupid)).modal('hide');
    },
    _err => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    }
  );
}

  downloadFile(s3bucketpathname: any) {
    s3bucketpathname = s3bucketpathname.replace(/,/g, '');
    const downldSrcURL =  '/api' + s3bucketpathname;
    window.open(downldSrcURL, '_blank');
  }

  confirmDeleteAttachment(index: number) {
    (<any>$(this.deleteattachmentpopupid)).modal('show');
    this.deleteAttachmentIndex = index;
  }

  // upload attachment 
  clearAllUpload() {
    (<any>$('#upload-attachment-gap')).modal('hide');
    this.uploadedFile = [];
    this.fileToSave = [];
  }

  switchInfo() {
      this.showInfo = !this.showInfo;
  }

  titleUpdate(event: any, index: any) {
      this.uploadedFile[index].title = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidTitle = false;
      } else {
          this.uploadedFile[index].invalidTitle = true;
      }
  }

  typeUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.isAttachType  = event.target.value;
      }
      this.uploadedFile[index].attachmenttypekey = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidAttachmentType = false;
      } else {
          this.uploadedFile[index].invalidAttachmentType = true;
      }
  }

  private loadAttachmentDropdown() {
      this._httpService
      .getSingle(
          {},
          CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentClassificationTypeUrl + '?filter={"nolimit": true}'
      )
      .subscribe(data => {
          const dp_att_arr: any[] = [];
          if (data && data.length > 0) {
              this.attachmentClassificationtypelookup = data;
              this?.attachmentClassificationtypelookup?.forEach(e => {
                this.checkRoleLoopFn(e, dp_att_arr);
              });
          }
      });
      const source = forkJoin([
          this._httpService.getArrayList(
              {
                  nolimit: true
              },
              CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.AttachmentTypeUrl + '?filter={"nolimit": true}'
          )]
      ).pipe(map((result: any) => {
              return {
                  attachmentType: result[0].map(
                      (res: { typedescription: any; attachmenttypekey: any; }) =>
                          new DropdownModel({
                              text: res.typedescription,
                              value: res.attachmenttypekey
                          })
                  ),
              };
          }),
          share(),);
      this.attachmentTypeDropdown$ = source.pipe(pluck('attachmentType'));
  }
  // Assosiated to loadAttachmentDropdown method
  private checkRoleLoopFn(e: any, dp_att_arr: any[]) {
    if (e?.typedescription && dp_att_arr?.indexOf(e?.typedescription) < 0) {
      if (this.isCW) {
        if (e?.typedescription?.startsWith('CW-')) {
          this?.attachmentClassificationtype?.push({ typedescription: e?.typedescription });
          dp_att_arr?.push(e?.typedescription);
        }
      } else {
        this?.attachmentClassificationtype?.push({ typedescription: e?.typedescription });
        dp_att_arr?.push(e?.typedescription);
      }
    }
  }

  categoryUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.isCate  = event.target.value;
      }
      this.issubCate  = '';
      this.uploadedFile[index].attachmentclassificationsubtypekey = '';
      this.uploadedFile[index].attachmentClassificationsubtype = [];
      this.uploadedFile[index].attachmentclassificationtypekey = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidAttachmentClassify = false;
          this?.attachmentClassificationtypelookup?.forEach((e: any) => {
            if (e?.typedescription === this.uploadedFile[index]?.attachmentclassificationtypekey) {
              this?.uploadedFile[index]?.attachmentClassificationsubtype?.push({subcategory: e?.subcategory});
          }
          });
      } else {
          this.uploadedFile[index].invalidAttachmentClassify = true;
      }
  }

  subcategoryUpdate(event: any, index: any) {
      if (event.target.value !== '')  {
          this.issubCate  = event.target.value;
      }
      this.uploadedFile[index].attachmentclassificationsubtypekey = event.target.value;
      if (event.target.value) {
          this.uploadedFile[index].invalidAttachmentsubClassify = false;
      } else {
          this.uploadedFile[index].invalidAttachmentsubClassify = true;
      }
  }

  descUpdate(event: any, index: any) {
      this.uploadedFile[index].description = event.target.value;
  }
  otherUpdate(event: any, index: any) {
    this.uploadedFile[index].other = event.target.value;
  }
  docDateUpdate(event: any, index: any) {
      this.uploadedFile[index].docDate = event.target.value;
  }

  docDateAddUpdate(event: any, index: any) {
      this.uploadedFile[index].actualdocumentdate = event;
  }

  deleteUpload(index: any) {
      this.uploadedFile.splice(index, 1);
      this.fileToSave.splice(index, 1);
  }

  saveAttachmentDetails() {
    if (this.uploadedFile.length !== this.fileToSave.length) {
        this._alertService.error('Please wait till files get uploaded');
    } else {
        var checkMandatory = this.uploadedFile.filter((item: any) => (!item.other && item.enableOtherTxt) || !item.actualdocumentdate ||  !item.attachmentclassificationsubtypekey ||  !item.attachmentclassificationtypekey)
        if(checkMandatory.length > 0) {
            this._alertService.error('Please fill all mandatory fields');
        } else {
            const attachment = Object.assign({
              servicecaseid: this.id,
              gapapplicationid: (this.applicationData) ? this.applicationData.gapapplicationid : null,
              attachment: this.uploadedFile
            });
            this._httpService.create(attachment, 'gapapplication/addAttachment').subscribe(
              _res => {
                this.uploadedFile.map((element: any) => {
                  this.uploadedFiles.push(element);
                })
                this.uploadedFile = [];
                this.fileToSave = [];
                this._alertService.success('Attachment Uploaded Successfully');
                this.getPage();
              },
              _err => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              }
            );
            (<any>$('#upload-attachment-gap')).modal('hide');
        }
    }
  }

  switchAdoptiveParent() {
    const formDetails = this.applicationForm.getRawValue();
    this.oldproviderid =formDetails.guardianoneproviderid;
    this.newproviderid = formDetails.guardiantwoproviderid;
    this.showSwitchAdoptiveParentReason = true; 
    if(formDetails.guardiantwoproviderid) {
      this.patchSwitchGuardians(formDetails.guardiantwoproviderid);
      this.parent1providerid = formDetails.guardiantwoproviderid;
    }
    this.applicationForm.get('effectiveswitchdate')?.enable();
    this.applicationForm.get('switchproviderreason')?.enable();
    this.applicationForm.patchValue({
      'guardiantwodate': null,
      'guardian2signature': null,
      'guardtwodob': null,
      'guardtwossnno': null,
    });
  }
  
  
  attachmentDropDownList_parent: any[] = [];
  attachmentDropDownList_child: any[] = [];
  loadAttachmentDropDown() {
      this._httpService.getArrayList(
              {
                  method: 'get',
                  where: {
                      referencetypeid: 1000,
                      teamtypekey: 'CW',
                      order: 'displayorder ASC'
                  }
              },
              'referencetype/gettypes' + '?filter'
          )
          .subscribe((item) => {
            item?.forEach(i => {
              if(i?.parentkey) {
                this.attachmentDropDownList_child.push(i);
              } else {
                this.attachmentDropDownList_parent.push(i);
              }
            });
          });
  }

  childArray: any[] = [];
  parentVal = '';
  seletedVal = ''
  enablOtherTxt = false;
  openChildMenu(parentVal: any, ref_key: any) {
      this.parentVal = parentVal;
      this.childArray = [];
      const isExist = this.attachmentDropDownList_child.filter((item: any) => (item.parentkey === ref_key));
      if (isExist) {
          this.childArray = [...isExist];
      }
  }
  
  selectChildMenu(childVal: any, index: any) {
      this.enablOtherTxt = false;
      this.uploadedFile[index].enableOtherTxt = false;
      const parentEvent = {
          'target': {
              'value': this.parentVal
          }
      }
      this.categoryUpdate(parentEvent, index);
      const childEvent = {
          'target': {
              'value': childVal
          }
      }
      this.subcategoryUpdate(childEvent, index);
      this.uploadedFile[index].title = this.uploadedFile[index].attachmentclassificationsubtypekey;

      if(childVal.includes('Other','other')){
          this.enablOtherTxt = true;
          this.uploadedFile[index].enableOtherTxt = true;
    }
  }

  selectedItem(index: any) {
      if (!this.uploadedFile[index].attachmentclassificationtypekey) {
          this.seletedVal = 'Title';
      } else {
          this.seletedVal = this.uploadedFile[index].attachmentclassificationsubtypekey;
      }
      return this.seletedVal
  }

  getAgreement() {
    this._httpService
        .getArrayList(
            {
                method: 'get',
                page: 1,
                limit: 10,
                where: { gapid: this._gapService.getGapId() }
            },
            'gapagreement/list?filter'
        )
        .subscribe(res => {
            if (res && (res instanceof Array)) {
              const agreement = res[0];
              if (agreement.agreementrate && Array.isArray(agreement.agreementrate) && agreement.agreementrate.length > 0) {
                  const latestAgreementRate = agreement.agreementrate[agreement.agreementrate.length - 1];
                  if (latestAgreementRate && latestAgreementRate.ratestartdate) {
                      this.minDate = latestAgreementRate.ratestartdate;
                  }
                }
            }
        });
}

  switchDateValidation(){
    if (new Date(this.applicationForm.value.effectiveswitchdate).setHours(0,0,0,0) < new Date(this.minDate).setHours(0,0,0,0)) {
      this._alertService.error('Effective Date can not be selected prior to the Current Subsidy Rate Slab Start Date. Please raise a contact support ticket if the Switch Effective Date is prior to Current Subsidy Rate Slab Start Date for Data fix');
      return false;
    }
  }

  listMap(_item: any) {
    // No data or function to add or call
  }

  selectedViewProv(_item: any) {
    // No data or function to add or call
  }

  onNativeDrop(event: DragEvent) {
        event.preventDefault();
        if (event.dataTransfer?.files) {
            const droppedFiles: File[] = Array.from(event.dataTransfer.files);
            this.uploadFile(droppedFiles); 
        }
    }
}