
import {pluck, map, share, debounceTime, distinctUntilChanged} from 'rxjs/operators';
import { Component, OnInit, ViewChild, Injector, OnDestroy } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormControl } from '@angular/forms';
// tslint:disable-next-line:import-blacklist
import { Observable, forkJoin, Subject } from 'rxjs';
import { MedicalConditions, Health } from '../../../../../@core/common/models/involvedperson.data.model';
import { InvolvedPersonsConstants } from '../../../involved-persons/_entities/involvedPersons.constants';
import { DropdownModel } from '../../../../../@core/entities/common.entities';
import { AlertService, DataStoreService, CommonHttpService, AuthService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { PersonInfoService } from '../../person-info.service';
import { PersonHealthService } from '../person-health.service';
import { DocumentUploadListSharedComponent } from '../../../../../../../src/app/shared/shared-components/document-upload-list-shared/document-upload-list-shared.component';
import { ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import { HttpClient } from '@angular/common/http';
import moment from 'moment';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'medical-conditions-cw',
    templateUrl: './medical-conditions-cw.component.html',
    styleUrls: ['./medical-conditions-cw.component.scss'],
    standalone: false
})
export class MedicalConditionsCwComponent implements OnInit, OnDestroy {
    medicalconditionForm!: FormGroup;
    modalInt!: number;
    editMode!: boolean;
    reportMode!: string;
    minDate = new Date();
    maxDate = new Date();
    isCustomMedicalCondition!: boolean;
    medicalcondition: MedicalConditions[] = [];
    caseId!: string;

    health: Health = {};
    uploadedFiles = [];
    uploadNumber = '123434';
    constants = InvolvedPersonsConstants.Intake.PersonsInvolved.Health;
    medicalConditionType$!: Observable<DropdownModel[]>;
    allergiesTypeDropdownItems$!: Observable<DropdownModel[]>;
    isAddEdit = false;
    personId!: string;
    hasFamilyAccessToCase: boolean = false;
    id: string;
    dtDisable = false;
    deleteItem: any;
    @ViewChild(DocumentUploadListSharedComponent)
    documentuploaded!: DocumentUploadListSharedComponent;
    load:boolean = false;
    isClosed = false;
    deletepopupid = '#delete-popup';
    displayValidationMessages = false;
    medicalConditionsApiUrl: any;
    medicalConditionTypeData: any[] = [];
    medicalConditionSelectedData = [];
    noteIfOldData: boolean = false;
    private searchDecouncer$: Subject<string> = new Subject();

    private formbulider: FormBuilder;
    private _alertSevice: AlertService;
    private _dataStoreService: DataStoreService;
    private _commonHttpService: CommonHttpService;
    public _personInfoService: PersonInfoService;
    private _healthService: PersonHealthService;
    public _authService: AuthService;
    private route: ActivatedRoute;
    private http: HttpClient
    retrydoc: any = false;
    personmedicalconditionCheck: any;
    personmedicalconditionid: any;

    constructor(private injector: Injector){
        this.formbulider = this.injector.get<FormBuilder>(FormBuilder);
        this._alertSevice = this.injector.get<AlertService>(AlertService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
        this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
        this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this.http = this.injector.get<HttpClient>(HttpClient);
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.route.queryParams.subscribe(params => {
        this.retrydoc = params['retrydocument'];
        this.personmedicalconditionid = params['retryid'];
    });
    }

    ngOnInit() {
        this.isClosed = this._authService.iscaseclosed('personhealth');
        this.personId =  this._personInfoService.getPersonId();
        this.loadDropDowns();
        this.editMode = false;
        this.caseId = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.isCustomMedicalCondition = false;
        this.modalInt = -1;
        this.reportMode = 'add';
        this.medicalconditionForm = this.formbulider.group({
            personmedicalconditionid: null,
            medical_condition: [null, Validators.required],
            medical_condition_icd: [null, Validators.required],
            start_Date: [null, Validators.required],
            End_Date: null,
            allergies_adverse_reactions: [],
            medication_client_allergies: '',
            notes: '',
            severitysymptomkey: '',
            ischronic: null,
            recordedby: ''
        });

        this.health = this._dataStoreService.getData(this.constants.Health);
        this.getAssignmentsList();
        this.getMedicalCondititonList();
        if (this.isClosed && !this._authService.isPersonSubTabViewable('person','person.Health.medconditionadd')) {
            this.medicalconditionForm.disable();
        }
        this.route.queryParams.subscribe(params => {
            const status = params['medicalCondition'];
            if (status) {
              const medicalCondition = JSON.parse(this._dataStoreService.getData('medicalCondition-health-summary'));
              this.view(medicalCondition);
            }
          });
        this.getSuggestedApinames();
        this.setupSearchDebouncer();
        if (this.hasFamilyAccessToCase) {
            this.addConditionsAudit('open-health-condition');
        }
    }

    ngOnDestroy() {
        if (this.hasFamilyAccessToCase) {
          this.addConditionsAudit('leave-from-health-condition');
        }
    }

    addConditionsAudit(key: any){
        let username;
        let refkey;
        const objectType = 'Person-profile';
        this._authService.currentUser.subscribe((userInfo) => {
            username = userInfo.user.securityusersid;
        });
        const comment = {
            securityusersid: username,
            logtype: key, 
            referenceid: this.personId, 
            objectype: objectType,
            objectid: this.caseId ? this.caseId : null, 
            description: key 
        };
        this._commonHttpService.create(comment, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddDetailedAudit).subscribe(
            (result) => {
                console.log(result);
            },
            (error) => {
                console.log(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    
    }

    getAssignmentsList() {
        this._commonHttpService.getArrayList(
            {
                where: { servicecaseid: this.id },
                method: 'get'
            },
            'Caseassignments/getworkload?filter'
        ).subscribe(data => {
            if (data) {
                this.checkCaseAccess(data);
            }
        });
    }

    
    checkCaseAccess(data: any) {
        const checkAccessList = data.filter((item: any) => (item.responsibilitytypekey === "child" || item.responsibilitytypekey === "family" || item.responsibilitytypekey === "administrative") && (item.enddate === null || moment(item.enddate) >= moment(new Date())))
        checkAccessList.forEach((element: { toworkerdetails: any[]; }) => {
            const familyAssignmentWorker = element.toworkerdetails?.filter(a => a.securityusersid === this._authService.getCurrentUser().user.securityusersid);
            if (familyAssignmentWorker.length > 0) {
                this.hasFamilyAccessToCase = true;
            }
        })
    }

    uploadclosed(event: any){
        if(event){
        this.documentuploaded.closeupload();
        this.load = true;
        }
      }

      updateLoad() {
        this.load = false;
      }

    setMedicalCondition(option: any) {
        const medicalcondition = this.medicalconditionForm.getRawValue();
        const conditions = medicalcondition.medicalconditiontypekey;
        const Index = conditions.findIndex((c: string) => c === 'Other ');
        if (Index !== -1) {
            this.isCustomMedicalCondition = true;
            this.medicalconditionForm.get('custommedicalcondition')?.setValidators([Validators.required]);
            this.medicalconditionForm.get('custommedicalcondition')?.updateValueAndValidity();
        } else {
            this.isCustomMedicalCondition = false;
            this.medicalconditionForm.get('custommedicalcondition')?.clearValidators();
            this.medicalconditionForm.get('custommedicalcondition')?.updateValueAndValidity();
        }
    }

    setmedicalconditionflag(opt: any) {
        if (opt) {
            this.isCustomMedicalCondition = true;
            this.medicalconditionForm.get('custommedicalcondition')?.setValidators([Validators.required]);
            this.medicalconditionForm.get('custommedicalcondition')?.updateValueAndValidity();
        } else {
            this.isCustomMedicalCondition = false;
            this.medicalconditionForm.get('custommedicalcondition')?.clearValidators();
            this.medicalconditionForm.get('custommedicalcondition')?.updateValueAndValidity();
        }
    }
    private loadDropDowns() {
        const source = forkJoin([
            this._commonHttpService.getArrayList(
                {
                    method: 'get',
                    nolimit: true
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.medicalconditiontype + '?filter'
            ),
            this._commonHttpService.getArrayList(
                {
                  method: 'get',
                  nolimit: true,
                  where: { 'active_sw': 'Y', 'picklist_type_id': '15', 'delete_sw': 'N' }
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.pickListUrl + '?filter'
            )
        ]).pipe(
            map((result) => {
                return {
                    medicalconditiontype: result[0].map(
                        (res) =>
                            new DropdownModel({
                                text: res.description,
                                value: res.description
                            })
                    ),
                    allergiesTypeList: result[1].map(
                     (res) =>
                        new DropdownModel({
                        text: res.description_tx,
                        value: res.value_tx
                        })
                    ),
                };
            }),
            share(),);
        this.medicalConditionType$ = source.pipe(pluck('medicalconditiontype'));
        this.allergiesTypeDropdownItems$ = source.pipe(pluck('allergiesTypeList'));
    }
    add() {
        this.noteIfOldData = false;
        this.displayValidationMessages = false;
        if(this.medicalconditionForm.invalid){
            this.medicalconditionForm.markAllAsTouched();
            this.displayValidationMessages = true;
            this._alertSevice.error('Please fill required fields');
            return;
        }
        const uploadInfo: any = {};
        uploadInfo['uploadpath'] = this.uploadedFiles;
        const data = this.handleToFormatmedCondDataFn(uploadInfo);
        this._healthService.saveHealth({ 'medicalConditions': [data] }).subscribe(_response => {
            this.addConditionsAudit('add-health-condition');
            this._alertSevice.success('Medical Conditions Added Successfully');
            this.resetForm();
            this.getMedicalCondititonList();
        });
    }

    private handleToFormatmedCondDataFn(uploadInfo: {}) {
        const data = { ...this.medicalconditionForm.getRawValue(), ...uploadInfo };

        if(!this.noteIfOldData) {
            data.medicalcondition_icd10_key_id = this.medicalConditionSelectedData.map((item: any) => item.value);
            data.medical_condition = null;
            data.medicalcondition_icd10_desc = this.medicalConditionSelectedData.map((item: any) => item.text);
        }
        return data;
    }

    resetForm() {
        this.medicalconditionForm.reset();
        this.modalInt = -1;
        this.editMode = false;
        this.reportMode = 'add';
        this.medicalconditionForm.enable();
        this.isAddEdit = false;
        this.uploadedFiles = [];
        this.dtDisable = false;
    }

    update() {
        if(this.medicalconditionForm.invalid){
            this.medicalconditionForm.markAllAsTouched();
            this.displayValidationMessages = false;
            this._alertSevice.error('Please fill required fields');
            return;
        }
        if (this.modalInt !== -1) {
            this.medicalcondition[this.modalInt] = this.medicalconditionForm.getRawValue();
        }
       const uploadInfo: any = {};
       uploadInfo['uploadpath'] = this.uploadedFiles;
       const data = this.handleToFormatmedCondDataFn(uploadInfo);
       this._healthService.saveHealth({ 'medicalConditions': [data] },0).subscribe(_response => {
        this._alertSevice.success('Added Medical Conditions Successfully');
        this.resetForm();
        this.getMedicalCondititonList();
    });
        this.addConditionsAudit('edit-health-condition');
        this._alertSevice.success('Updated Successfully');
    }

    view(modal: any) {
        this.medicalConditionSelectedData = [];
        this.noteIfOldData = false;
        this.isAddEdit = true;
        this.reportMode = 'edit';
        this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
        this.medicalconditionForm.controls['personmedicalconditionid'].setValue(modal.personmedicalconditionid);
        this.medicalconditionForm.controls['start_Date'].setValue(modal.begindate)
        this.medicalconditionForm.controls['End_Date'].setValue(modal.enddate);
        const medAllCon = JSON.parse(modal.allergies_adverse_reactions);
        this.medicalconditionForm.controls['allergies_adverse_reactions'].setValue(medAllCon);
        this.medicalconditionForm.controls['recordedby'].setValue(modal.recordedby);
        this.medicalconditionForm.controls['severitysymptomkey'].setValue(modal.severitysymptomkey);
        this.medicalconditionForm.controls['medication_client_allergies'].setValue(modal.medication_client_allergies);
        this.medicalconditionForm.controls['notes'].setValue(modal.notes);
        this.medicalconditionForm.controls['ischronic'].setValue(modal.ischronic);
        this.editMode = false;
        this.dtDisable = true;
        if (this.hasFamilyAccessToCase) {
            this.addConditionsAudit('view-health-condition');
        }
        this.reusableMedConDataFn(modal,'view');
        this.medicalconditionForm.disable();
    }

    edit(modal: any, i?: any) {
        this.medicalConditionSelectedData = [];
        this.noteIfOldData = false;
        this.isAddEdit = true;
        this.reportMode = 'edit';
        this.addConditionsAudit('edit-health-condition');
        this.editMode = true;
        this.modalInt = i;
        this.dtDisable = false;
        this.medicalconditionForm.enable();
        this.uploadedFiles = modal.uploadpath ? modal.uploadpath : [];
        this.medicalconditionForm.controls['personmedicalconditionid'].setValue(modal.personmedicalconditionid);
        this.medicalconditionForm.controls['start_Date'].setValue(modal.begindate)
        this.medicalconditionForm.controls['End_Date'].setValue(modal.enddate);
        const medAllCon = JSON.parse(modal.allergies_adverse_reactions);
        this.medicalconditionForm.controls['allergies_adverse_reactions'].setValue(medAllCon);
        this.medicalconditionForm.controls['recordedby'].setValue(modal.recordedby);
        this.medicalconditionForm.controls['severitysymptomkey'].setValue(modal.severitysymptomkey);
        this.medicalconditionForm.controls['medication_client_allergies'].setValue(modal.medication_client_allergies);
        this.medicalconditionForm.controls['notes'].setValue(modal.notes);
        this.medicalconditionForm.controls['ischronic'].setValue(modal.ischronic);
        this.reusableMedConDataFn(modal,'update');
    }

    private reusableMedConDataFn(modal: any, mode: string) {
        let medCond = JSON.parse(modal.medicalcondition);
        let medValue = [];
        if (!medCond) {
            medCond = JSON.parse(modal.medicalcondition_icd10_desc);
            medValue = medCond.map((item: any, index: any) => JSON.parse(modal.medicalcondition_icd10_key_id)[index]);
            this.medicalConditionTypeData = medCond.map((item: any, index: any) => ({ text: item, value: JSON.parse(modal.medicalcondition_icd10_key_id)[index] }));
            this.medicalConditionSelectedData = JSON.parse(JSON.stringify(this.medicalConditionTypeData));
            this.medicalconditionForm.addControl('medical_condition_icd', new FormControl(null));
            this.medicalconditionForm.controls['medical_condition_icd'].setValue(medValue);
            this.returnIfUpdateFn(mode,'medical_condition');
        } else {
            this.noteIfOldData = true;
            this.returnIfUpdateFn(mode,'medical_condition_icd');
            this.medicalconditionForm.addControl('medical_condition', new FormControl(null));
            this.medicalconditionForm.controls['medical_condition'].setValue(medCond);
            if (mode === 'update') {
                this.medicalconditionForm.get('medical_condition')?.disable();
            }
        }
    }

    private returnIfUpdateFn(mode: string,formControlValue:string) {
        if (mode === 'update' || mode === 'add') {
            this.medicalconditionForm.get(formControlValue)?.clearValidators();
            this.medicalconditionForm.get(formControlValue)?.updateValueAndValidity();
            this.medicalconditionForm.removeControl(formControlValue);
        }
    }

    public delete() {
        const modal = this.deleteItem;
        
        const data = {
        'personmedicalconditionid': modal.personmedicalconditionid,
        };
        this._healthService.saveHealth({ 'medicalConditions': [data] }, 2).subscribe(_ => {
            this._alertSevice.success('Medical Condition Info Deleted Successfully');
            this.resetForm();
            this.getMedicalCondititonList();
            (<any>$(this.deletepopupid)).modal('hide');
            this.deleteItem = null;
            this.addConditionsAudit('delete-health-condition');
        });

    }

    selectedCondition(data: any): void {
        this.searchDecouncer$.next(data.target.value);
      }
      onDdChange(data: any): void {
          this.medicalConditionSelectedData = data;
      }
    
      setupSearchDebouncer(): void {
        this.searchDecouncer$.pipe(
          debounceTime(500),
          distinctUntilChanged(),
        ).subscribe((term: string) => {
          this.searchData(term);
        });
      }
    
      searchData(term: string): void {
        this.medicalConditionTypeData = [];
          if(this.medicalConditionsApiUrl && term) {
              const url = `${this.medicalConditionsApiUrl}sf=primary_name&df=primary_name,key_id&terms=${term}`;
              this.http.get(`${url}`).subscribe(
                  (response: any) =>{ 
                    if(response?.[3]) {
                        let hhh = []
                        for(const element of response[3]){
                            hhh.push({text:element[0],value:element[1]})
                        }
                        this.medicalConditionTypeData = hhh;
                    }
                },(_error) => {
                    // No data or function to call
                })
            }
      }


    getSuggestedApinames() {
        this._commonHttpService.getSettings(['medical_conditions_api']).subscribe((result)=> {
            this.medicalConditionsApiUrl = result.settings[0]?.settingvalue
        })
    }

    cancel() {
        this.resetForm();
    }

    startDateChanged() {
        this.medicalconditionForm.patchValue({ End_Date: '' });
        const empForm = this.medicalconditionForm.getRawValue();
        this.maxDate = new Date(empForm.begindate);
    }
    endDateChanged() {
        this.medicalconditionForm.patchValue({ begindate: '' });
        const empForm = this.medicalconditionForm.getRawValue();
        this.minDate = new Date(empForm.End_Date);
    }
    patchForm(modal: MedicalConditions) {
        this.medicalconditionForm.patchValue(modal);
    }

    addMedicalCondition() {
        this.medicalConditionTypeData=[];
        this.returnIfUpdateFn('add','medical_condition');
        this.isAddEdit = true;
    }

    getMedicalCondititonList() {
        this._commonHttpService.getPagedArrayList({
          page: 1,
          limit: 20,
          method: 'get',
          where: { personid: this.personId}
        }, 'personmedicalcondition/list?filter').subscribe(res => {
           this.medicalcondition = res ? res.data : [];
            this.personmedicalconditionCheck = (this.medicalcondition as any[]).find(item => item.personmedicalconditionid === this.personmedicalconditionid);
          if (this.personmedicalconditionCheck && this.personmedicalconditionid) {
              this.edit(this.personmedicalconditionCheck);
              this.personmedicalconditionid = null;
          }
        });
      }
      getMedicalCondition(medicalCondition: any,icdDesc: any) {
        if (medicalCondition && medicalCondition !== 'null') {
            return JSON.parse(medicalCondition).join();
        } else if (icdDesc && icdDesc !== 'null') {
            return JSON.parse(icdDesc).join();
        }
        return '';
      }
      declineDelete() {
        (<any>$(this.deletepopupid)).modal('hide');
      }
      confirmDelete(modal: any){
        this.deleteItem = modal;
        (<any>$(this.deletepopupid)).modal('show');
      }

}
