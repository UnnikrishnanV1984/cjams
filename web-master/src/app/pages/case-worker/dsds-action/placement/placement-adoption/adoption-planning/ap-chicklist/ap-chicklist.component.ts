import { Component, Injector, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';

import { DynamicObject, PaginationRequest } from '../../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { AlertService } from '../../../../../../../@core/services/alert.service';
import { CommonHttpService } from '../../../../../../../@core/services/common-http.service';
import { DataStoreService } from '../../../../../../../@core/services/data-store.service';
import { CheckList } from '../../_entities/adoption.model';

import { AuthService } from '../../../../../../../@core/services/auth.service';
import { AppConstants } from '../../../../../../../@core/common/constants';
import { PlacementAdoptionService } from '../../placement-adoption.service';
import { CaseWorkerUrlConfig } from '../../../../../case-worker-url.config';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'ap-chicklist',
    templateUrl: './ap-chicklist.component.html',
    styleUrls: ['./ap-chicklist.component.scss'],
    standalone: false
})
export class ApChicklistComponent implements OnInit {
    apCheckListForm!: FormGroup;
    reviewCheckList!: CheckList[];
    store: DynamicObject;
    isSupervisor!: boolean;
    approvalStatus!: string | null;
    private id: string;
    submitby!: string;
    tosecurityusersid!: string;
    submiton: any;
    approvedby!: string;
    approvedon: any;
    daNumber: string;
    adoptionplanstr = 'Adoption Plan ';
    effortDetailSaved!: boolean;
    narrativesaved!: boolean;
    emotionalTiesSaved!: boolean;
    alreadySaved!: boolean;
    acastatus: any;
    hasAdoptionApplicabilityInfo: any;
    displayValidationMessages = false;
    private readonly route: ActivatedRoute;
    private readonly _store: DataStoreService;
    private readonly _commonHttp: CommonHttpService;
    private readonly _formBuilder: FormBuilder;
    private readonly _alertService: AlertService;
    private readonly _router: Router;

    constructor(private readonly injector : Injector, public _authService: AuthService, private readonly _PlacementAdoptionService: PlacementAdoptionService) {
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this._commonHttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this._router = this.injector.get<Router>(Router);

        this.store = this._store.getCurrentStore();
        this.id = this.store['CASEUID'];
        this.daNumber = this.store['DANUMBER'];
    }

    ngOnInit() {
        const userInfo = this._authService.getCurrentUser();        
        this.alreadySaved = false;
        this.isSupervisor = userInfo.role.name === AppConstants.ROLES.SUPERVISOR;
        this.apCheckListForm = this._formBuilder.group({
            disclosuredate: [null, [Validators.required]],
            personinfomation: ['', [Validators.required]],
            siblingage: [null],
            siblinginformation: [''],
            remarks: [''],
            checklistid: [''],
            isselected: [null],
            worker: ['', [Validators.required]],
            nonstaffmember: [''],
            localdepartment: [''],
            adoptionchecklistid: [null]
        });
        this.getCheckList();
        this.getEmotionalTieList();
        this.effortListing();
        this.preFillApCheckListForm();
        this._PlacementAdoptionService.storeDataPatched$.subscribe(data => {
            if (data === 'TRPList_a') {
        this.getCheckList();
        this.preFillApCheckListForm();
        this.getEmotionalTieList();
        this.effortListing();
            }
        });
        this.getacastatus();
    }

    getacastatus() {
        const clientIDInput = this.store['childforGAP'];
        const removalIDInput = this.store['childremovalid'];
        if (clientIDInput && removalIDInput) {
            this._commonHttp.getSingle(
                {},
                'iveadoption/adoption/adoption-aca-worksheet/' + clientIDInput + '/' + removalIDInput
            ).subscribe(response => {
                if (response && response.adoptionAcaInfo && response.adoptionAcaInfo.length > 0 && response.adoptionAcaInfo[0].ivestatus) {
                    this.acastatus = response.adoptionAcaInfo[0].ivestatus;
                }
            });
        }
    }

    navigateTo() {
        const redirectUrl = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/placement-menu/placement/adoption/planning/aca-form';
        this._router.navigate([redirectUrl]);
    }

    preFillApCheckListForm() {
        const workerName = this._authService.getCurrentUser().user.userprofile.fullname;
        this.apCheckListForm.patchValue({ 'worker': workerName });
    }
    onCheckListChange(event: any, index: any) {
        const element = document.getElementById(this.reviewCheckList[index].checklistid);
        if (element) {
            element.innerHTML = '';
        }
        this.reviewCheckList[index].isselected = event;      
        this.apCheckListForm.markAsDirty();        
    }
    onRemarksSave(event: any, index: any) {
        if (event.target.value) {
            this.reviewCheckList[index].remarks = event.target.value;
            this.apCheckListForm.markAsDirty();
            this.reviewCheckList[index].isRemarksValid = false;
        } else {
            this.reviewCheckList[index].isRemarksValid = true;
        }
    }

    saveCheckList(model: any) {
        if(!this.effortDetailSaved || !this.narrativesaved || !this.emotionalTiesSaved) {
            $('#planning-validation').modal('show');
            return false;
        }
        if (!model.adoptionchecklistid) {
            delete model.adoptionchecklistid;
        }
        model.adoptionchecklist = [];
        model.intakeserviceid = this.id;
        model.servicecaseid = this.id;
        model.isDraft = true;
        this.reviewCheckList.forEach(item => {
            model.adoptionchecklist.push({ checklistid: item.checklistid, isselected: Number(item.isselected), remarks: item.remarks });
        });
        model.adoptionplanningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
        this._commonHttp.create(model, 'adoptionchecklist/addupdate').subscribe(
            result => {
                this._alertService.success('Adoption Checklist Saved Successfully!!');
               this.getAdoption();
            },
            error => {
                this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                this.approvalStatus = null;
            }
        );
    }

    addCheckList(model: any) {
        this.displayValidationMessages =false;
        this.handleReviewCheckListFn();
        const checkListInalid = this.reviewCheckList.filter(item => item.isselected !== '0' && item.isselected !== '1');
        if(checkListInalid && checkListInalid.length || this.apCheckListForm.invalid) {
            return;
        }
        if(!this.effortDetailSaved || !this.narrativesaved || !this.emotionalTiesSaved) {
            $('#planning-validation').modal('show');
            return false;
        }
        this.hasAdoptionApplicabilityInfo = this._store.getData('hasAdoptionApplicabilityInfo');
        if(!this.acastatus && !this.hasAdoptionApplicabilityInfo) { 
            $('#ap-checklist').modal('show');
            return false;
        }   
        if(!this.checkReviewList()) {
            return;
        }
        
        if (!model.adoptionchecklistid) {
            delete model.adoptionchecklistid;
        }
        model.adoptionchecklist = [];
        model.intakeserviceid = this.id;
        model.servicecaseid = this.id;
        model.isDraft = false;
        this.reviewCheckList.forEach(item => {
            model.adoptionchecklist.push({ checklistid: item.checklistid, isselected: Number(item.isselected), remarks: item.remarks });
        });
        model.adoptionplanningid = this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null;
        this.approvalStatus = 'Review';
        this._commonHttp.create(model, 'adoptionchecklist/addupdate').subscribe(() => {
            this._alertService.success('Adoption Checklist Submitted for Approval Successfully!!');
            this.getAdoption();
        }, () => {
            this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
            this.approvalStatus = null;
        });
    }
    // Assosaiated with addCheckList method
    private handleReviewCheckListFn() {
        if (this.apCheckListForm.invalid) {
            this.displayValidationMessages = true;
            this.apCheckListForm.markAllAsTouched();
        }
        if (this.reviewCheckList && this.reviewCheckList.length > 0) {
            this.reviewCheckList.forEach(data => {
                const element1 = document.getElementById(data.checklistid);
                if (element1) {
                    element1.innerHTML = '';
                }
                if (data.isselected && parseInt(data.isselected) === 2) {
                    const element2 = document.getElementById(data.checklistid);
                    if (element1) {
                        element1.innerHTML = 'Please select Yes/No';
                    }
                }
            });
        }
    }

    checkReviewList() {
        if (this.reviewCheckList && this.reviewCheckList.length) {
            const checkListInalidCheck = this.reviewCheckList.filter(item => item.isselected !== '0' && item.isselected !== '1');
            const remarksValid = this.reviewCheckList.filter(item => item.isselected === '0' && !item.remarks);
            if(checkListInalidCheck && checkListInalidCheck.length) {
                this._alertService.error('Please fill required fields to proceed');
                return false;
            }
            
            if (remarksValid && remarksValid.length) {
                this.reviewCheckList.forEach(item => {
                    item.isRemarksValid = item.isselected === '0' && !item.remarks ? true : false;
                });
                this._alertService.error('Please fill remarks to proceed');
                return false;
            }
        }
        return true
    }

    approveAdoption(approvalStatus: any) {
        this._commonHttp
            .create(
                {
                    objectid: this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null,
                    eventcode: 'ADPR',
                    status: approvalStatus,
                    comments: this.adoptionplanstr + approvalStatus,
                    notifymsg: this.adoptionplanstr + approvalStatus,
                    routeddescription: this.adoptionplanstr + approvalStatus,
                    servicecaseid: this.id,
                    tosecurityusersid: this?.tosecurityusersid
                },
                'routing/routingupdate'
            )
            .subscribe(
                res => {
                    this._alertService.success('Adoption Planning is ' + approvalStatus + ' successfully!');
                    this.approvalStatus = approvalStatus;
                    this.getAdoption();
                },
                err => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                }
            );
    }
    private effortListing() {
        const placement = this.store['placement_child'];
        const permanencyplanid = (placement) ? placement.permanencyplanid : null;
        this._commonHttp
            .getSingle(
                new PaginationRequest({
                    where: {
                         permanencyplanid: permanencyplanid
                        // intakeserviceid: this.id,
                        //  intakeservicerequestactorid: this.childActorId ? this.childActorId : null
                    },
                    method: 'get',
                    page : 1,
                    limit: 10
                }),
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEffortList + '?filter'
            )
            .subscribe(res => {
                if (res && res.length && res[0].getadoptionplanning) {
                    this.effortDetailSaved = (res[0].getadoptionplanning[0].adoptioneffortsdetails || res[0].getadoptionplanning[0].isnoeffort) ? true : false;
                    this.narrativesaved = (res[0].getadoptionplanning[0].narrative) ? true : false;
                   
                }
            });
    }

    private getEmotionalTieList() {
        this._commonHttp
            .getArrayList(
                {
                    where: { adoptionplanningid: this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null },
                    method: 'get'
                },
                CaseWorkerUrlConfig.EndPoint.DSDSAction.Placement.Adoption.AdoptionEmotionalTieList + '?filter'
            )
            .subscribe(res => {
                if (res && res.length) {
                    this.emotionalTiesSaved = true;
                }
            });
    }
    private getCheckList() {
        this._commonHttp
            .getArrayList(
                new PaginationRequest({
                    where: { checklisttypekey: 'ADOPT', order: 'displayorder ASC' },
                    method: 'get'
                }),
                'checklist?filter'
            )
            .subscribe(result => {
                result.forEach(item => {
                    item.isselected = 2;
                });
                this.reviewCheckList = result;
                this.getAdoption();
            });
    }

    private getAdoption() {
        this._commonHttp
            .getArrayList(
                new PaginationRequest({
                    where: { adoptionplanningid: this.store['adoptionEffort'] ? this.store['adoptionEffort'].adoptionplanningid : null },
                    method: 'get'
                }),
                'adoptionchecklist/getadoptionchecklist?filter'
            )
            .subscribe(result => {
                if (result && result.length) {
                    this.handleGetadoptionchecklistResponseFn(result);
                } else {
                    this.reviewCheckList.forEach((item: any) => {
                        item.remarks = null;
                        item.isRemarksValid = false;
                    });
                }
            });
    }
    // Assosiated with getAdoption method
    private handleGetadoptionchecklistResponseFn(result: any[]) {
        this.reviewCheckList.forEach(item => {
            result[0].adoptionchecklist.map((selItem: any) => {
                if (selItem.checklistid === item.checklistid) {
                    item.isselected = selItem.isselected + '';
                    item.remarks = selItem.remarks ? selItem.remarks : null;
                    item.isRemarksValid = false;
                }
            });
        });
        if (result[0]) {
            this.alreadySaved = true;
            this.approvalStatus = result[0].status;
            this.submitby = result[0].submitby;
            this.tosecurityusersid = result[0]?.tosecurityusersid;
            this.submiton = result[0].submiton;
            this.approvedby = result[0].approvedby;
            this.approvedon = result[0].approvedon;
            this.apCheckListForm.patchValue(result[0]);
        }
    }

    getErrorsMessage(ControlName: any, displayName: any){
        if(this.apCheckListForm.controls[ControlName].status =='INVALID' ){
        return 'Please enter valid ' + displayName
        }
    }
}
