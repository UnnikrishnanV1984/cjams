import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonHttpService } from '../../../../../../../@core/services/common-http.service';
import { PaginationRequest } from '../../../../../../../@core/entities/common.entities';
import { DataStoreService, AlertService, AuthService, SessionStorageService } from '../../../../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../../../../@core/entities/constants';
import { AppUser } from '../../../../../../../@core/entities/authDataModel';

@Component({
    selector: 'adoption-annual-reviews',
    templateUrl: './adoption-annual-reviews.component.html',
    standalone: false
})
export class AdoptionAnnualReviewsComponent implements OnInit {

    annualReviewAdoptionForm!: FormGroup;
    approvalStatusForm!: FormGroup;
    isFormDisplay = false;
    isEditReview = false;
    disableBtn = false;
    mandatoryFields=false;
    adoptioniverenewalid!: string;
    store: any;
    id: string;
    annualReviewList!: any[];
    submitStatus: any;
    roleId: AppUser;
    placementAnnualReviewID: any;
    isApproved!: boolean;
    isSupervisor!: boolean;
    isEnableComments!: boolean;
    agreement: any;
    isinValidAnnualReview!: boolean;
    maxdate: any;
    constructor(
        private formBuilder: FormBuilder,
        private _commonHttpService: CommonHttpService,
        private _store: DataStoreService,
        private _alertService: AlertService,
        public _authService: AuthService,
        private _session: SessionStorageService
    ) {
        this.store = this._store.getCurrentStore();
        this.id = this.store['CASEUID'];
        this.roleId = this._authService.getCurrentUser();
    }

    ngOnInit() {
        this.annualReviewInitialform();
        this.getReviews();
        this.getAgreementListing();
        if (this.roleId.role.name === 'apcs') {
            this.isSupervisor = true;
            this.placementAnnualReviewID = this._session.getItem('Placement-Review-Id');
            this._session.setItem('Placement-Review-Id', null);
            this.getReviews();
        }
    }

    annualReviewInitialform() {
        this.annualReviewAdoptionForm = this.formBuilder.group({
            adoptionid: [null],
            adoptioniverenewalid: [null],
            assessmentdate: [null],
            parentsupportflag:  [null],
            schoolenrollflag:  [null],
            immunizationflag:  [null],
            mededuvoccertflag: [null],
            paytill22educhkflag:  [null],
            paytill22enrollchkflag:  [null],
            paytill22emppgmchkflag:  [null],
            paytill22emp80hrchkflag:  [null],
            paytill22medchkflag:  [null],
            ischilddisability: [null],
            ischildspecialneed:  [null],
            isparentlegalresponsible:  [null],
            isrenewalsigned:  [null],
            fatheragreementdate:  [null, Validators.required],
            motheragreementdate:  [null],
            designeeagreementdate:  [null, Validators.required],
            paytill22medchk:  [null],
            comments:  [null],
            disabilitynotes:  [null],
            enteredby: [null]
        });

        this.approvalStatusForm = this.formBuilder.group({ 
            routingstatus: [null],
            comments: [null]
        });
    }

    formAccess(reviewMode: any) {
        this.annualReviewAdoptionForm.enable();
        if (reviewMode === 0) {
            if (!this._authService.hasSupervisor()) {
                return false;
            }
            const { enddate, startdate } = this.returnStartAndEndDateFn();
            if(enddate < startdate) {
                this._alertService.warn(' Agreement Rate is less than 364 days , So you cant add annual review');
                return;
            }
            this.isFormDisplay = true;
            this.isEditReview = false;
            this.formClear();
            this.setReviewDate();
        } else {
            this.isFormDisplay = true;
            this.isEditReview = false;
        }
    }
    // Assosiated with formAccess method
    private returnStartAndEndDateFn() {
        let startdate = this.agreement && this.agreement.startdate ? this.agreement.startdate : null;
        let enddate = this.agreement && this.agreement.enddate ? this.agreement.enddate : null;
        if (startdate) {
            startdate = new Date(startdate);
            startdate.setDate(startdate.getDate() + 364);
        }
        if (enddate) {
            enddate = new Date(enddate);
        }
        return { enddate, startdate };
    }

    setReviewDate() {
        let startdate = this.agreement && this.agreement.startdate ? this.agreement.startdate : null;
        let enddate = this.agreement && this.agreement.enddate ? this.agreement.enddate : null;
        if(startdate) {
            startdate = new Date(startdate);
            startdate.setDate(startdate.getDate() + 364);
        } 
        if(enddate) {
            enddate = new Date(enddate);
        }
        const existingAnnualReviw =  this.annualReviewList && this.annualReviewList.length ? this.annualReviewList.filter( review => { return  review.status === 'Approved';  }) : [];
        if(existingAnnualReviw && existingAnnualReviw.length) {
            startdate =  existingAnnualReviw[existingAnnualReviw.length-1].assessmentdate;
            startdate = new Date(startdate);
            startdate.setDate(startdate.getDate() + 364);
        }
        this.annualReviewAdoptionForm.patchValue({ assessmentdate : startdate});
        this.maxdate = enddate;
    }

    formClear() {
        this.annualReviewAdoptionForm.reset();
    }

    editAnnualReview(reviewModal: any) {
        this.formAccess(1);
        if(reviewModal && reviewModal.status === 'Review') {
            this.isApproved = false;
        } else {
            this.isApproved = true;
        }
        this.approvalStatusForm.patchValue({
           routingstatus : reviewModal.status
        });
        this.annualReviewAdoptionForm.patchValue(reviewModal);
        this.adoptioniverenewalid = reviewModal.adoptioniverenewalid;
    }

    viewAnnualReview(reviewModal: any) {
        this.formAccess(1);
        if(reviewModal && reviewModal.status === 'Review') {
            this.isApproved = false;
        } else {
            this.isApproved = true;
        }
        this.approvalStatusForm.patchValue({
           routingstatus : reviewModal.status
        });
        this.annualReviewAdoptionForm.patchValue(reviewModal);
        this.adoptioniverenewalid = reviewModal.adoptioniverenewalid;
        this.annualReviewAdoptionForm.disable();
    }

    onChangeDisability(key: any) {
        if(key !== 1 && !this.annualReviewAdoptionForm.getRawValue().ischilddisability ) {
        this.annualReviewAdoptionForm.patchValue({
          
            disabilitynotes: null
        });
        }
        if(key !== 1  ) {
            this.annualReviewAdoptionForm.patchValue({
                paytill22medchkflag: null
            });
            }
    }

    onChangeDisabilityCheckbox2(key: any) {
        if(key !== 1 && !this.annualReviewAdoptionForm.getRawValue().ischilddisability ) {
            this.annualReviewAdoptionForm.patchValue({
                disabilitynotes: null
            });
            }
    }

    onChangeDisabilityCheckbox1(key: any) {
        if(key !== 1 && !this.annualReviewAdoptionForm.getRawValue().paytill22medchkflag ) {
            this.annualReviewAdoptionForm.patchValue({
                disabilitynotes: null
            });
            }
    }

    getAgreementListing() {
        let url = 'adoptioncaseagreement/list?filter';
        const obj = { adoptioncaseid: this.id };
    
        this._commonHttpService
          .getSingle(
            new PaginationRequest({
              where: obj,
              method: 'get',
              page: 1,
              limit: 10
            }),
            url
          )
          .subscribe(res => {
            if (res && res.length && Array.isArray(res)) {
              const obcj = res[0];
              const agreementList =  obcj.getadoptioncaseagreementlist ;
              if (agreementList && agreementList.length) {
                const length = agreementList.length - 1;
                this.agreement = agreementList[length];
              }
            }
          });
    }

    getReviews() {
        this._commonHttpService.getArrayList(
            new PaginationRequest({
                page: 1,
                limit: 10,
                where: {
                    adoptioncaseid: this.id },
                method: 'get'
            }),
            'adoptioniverenewal/list' + '?filter'
        ).subscribe(
            (resp) => {
                this.annualReviewList = resp;
                if(this.annualReviewList && this.annualReviewList.length) {
                   const forApproval  = this.annualReviewList.filter( review => { return review.status === 'Review';});
                     this.isinValidAnnualReview = forApproval && forApproval.length ?  true : false;
                    }
            },
            (error) => {
                // No data or function to call or add
            }
        );
    }

    routingUpdate() {
        if(!this.validateRoutingStatus()){
            this.mandatoryFields = true;
            return;
        }
        this.disableBtn = true;
        const statustypeid = (this.approvalStatusForm.value.routingstatus == 'Approved') ? 16 : 17;
        
        this.submitStatus = Object.assign({
            adoptioniverenewalid: this.placementAnnualReviewID && this.placementAnnualReviewID !== 'null' ? this.placementAnnualReviewID : this.returnAdoptioniverenewalidFn(),
            status: statustypeid,
            adoptionid: this.id,
            v_securityusersid: this.roleId.user.userprofile.securityusersid
        });

        if (this.roleId.role.name === 'apcs' && this.approvalStatusForm.value.routingstatus === '') {
            return this._alertService.error('Please select review status!');
        } else {
            this._commonHttpService.create(this.submitStatus, 'adoptioniverenewal/addupdate').subscribe(
                (res) => {
                    this._alertService.success('Annual Review ' + this.approvalStatusForm.value.routingstatus + ' Successfully!');
                    this.isApproved = true;
                    this.getReviews();
                    this.formClear();
                    this.isFormDisplay = false;
                    this.disableBtn = false;
                },
                (err) => {
                    this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    this.disableBtn = false;
                }
            );
        }
    }
    // Assosiated with routingUpdate method
    private returnAdoptioniverenewalidFn() {
        return (this.adoptioniverenewalid ? this.adoptioniverenewalid : null);
    }

    validateRoutingStatus() {
        if (this.approvalStatusForm.controls['routingstatus'].touched) {
            return this.approvalStatusForm.controls['routingstatus'].value === "Approved" || "Rejected" ? true : false;
        } else {
            return false;
        }
    }

    rejectComments(status: any) {
        if (status === 'Rejected') {
            this.isEnableComments = true;
        } else {
            this.isEnableComments = false;
            this.approvalStatusForm.patchValue({ comments: '' });
        }
    }

    addEditAnnualReview(annualreview: any, editmode: any) {
        this.mandatoryFields=true;
        if (this.annualReviewAdoptionForm.status=='INVALID' ) {
           
return;
        }
            
        this.disableBtn = true;
        if (!this._authService.hasSupervisor()) {
            return false;
        }
        let modal;
        if (editmode === 0) {
             modal = Object.assign(
                {
                    adoptionid: this.id
                },
                annualreview
            );
        } else {
            modal = Object.assign(
                {
                    adoptionid: this.id,
                    v_securityusersid: this.roleId.user.userprofile.securityusersid
                },
                annualreview
            );
        }

        if (this.annualReviewAdoptionForm.valid) {
            modal.adoptionid = this.id;
            modal.status = 15;
            this._commonHttpService.create(modal,
                'adoptioniverenewal/addupdate').subscribe(
                (res) => {
                    this._alertService.success('Annual Review Saved Successfully');
                    this.getReviews();
                    this.formClear();
                    this.isFormDisplay = false;
                    this.disableBtn = false;
                },
                (error) => {
                    this.disableBtn = false;
                }
            );
        }
    }
}
