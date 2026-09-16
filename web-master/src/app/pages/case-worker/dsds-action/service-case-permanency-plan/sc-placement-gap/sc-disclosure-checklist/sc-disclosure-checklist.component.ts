import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { AppUser } from '../../../../../../@core/entities/authDataModel';
import { GapDetails, DisclosureCheckList, RouteToSupervisor } from '../../../placement/_entities/placement.model';
import { AuthService, CommonHttpService, DataStoreService, AlertService } from '../../../../../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';

@Component({
    selector: 'sc-disclosure-checklist',
    templateUrl: './sc-disclosure-checklist.component.html',
    styleUrls: ['./sc-disclosure-checklist.component.scss'],
    standalone: false
})
export class ScDisclosureChecklistComponent implements OnInit {
  providerSearch = [];
  
  placement: any;
  id: string;
  daNumber: string;
  disclosureCheklistForm: FormGroup;
  approvalStatusForm: FormGroup;
  roleId: AppUser;
  disClosure: GapDetails[];
  disClosuseCheckList: DisclosureCheckList = new DisclosureCheckList();
  isSupervisor = false;
  isExistRecord = false;
  submitStatus: RouteToSupervisor;
  isApproved = false;
  isEnableComments = false;
  isInitialized = false;
  isViewForm: boolean;

  constructor(
      private _authService: AuthService,
      private _httpService: CommonHttpService,
      private _formBuilder: FormBuilder,
      private route: ActivatedRoute,
      private _dataStoreService: DataStoreService,
      private _alertService: AlertService
  ) {}

  ngOnInit() {
      this.initFormGroup();
      this.roleId = this._authService.getCurrentUser();
      if (this.roleId.role.name === 'apcs') {
          this.isSupervisor = true;
          this.disclosureCheklistForm.disable();
      }
      this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.disclosureCheklistForm.patchValue({servicecaseid: this.id});

      this.disclosureCheklistForm.patchValue({ enteredby: this.roleId.user.username });
      this.isInitialized = true;
      this._dataStoreService.currentStore.subscribe(store => {
          if (this.isInitialized && store['placement_child']) {
              this.placement = store['placement_child'];
              if (this.placement) {
                this.getPage();
                  this.disclosureCheklistForm.patchValue({
                      guardianoneid: this.placement.providerdetails.providername,
                      guardianoneproviderid: this.placement.providerdetails.provider_id,
                      permanencyplanid: this.placement.permanencyplanid

                  });

                    this.isInitialized = false;
              }
          }
      });
      if (this.roleId.role.name === 'apcs') {
        this.getPageforSupervisor();
      }
  }

  processCheckList(checkList) {
    if (checkList.data && checkList.data.length) {
        this.disClosure = checkList.data[0];
        this.patchDisclosureCheckList(this.disClosure);
    } else if (this.roleId.role.name === 'apcs' && checkList.data.length === 0) {
        this._alertService.warn('Please fill disclosure checklist');
        this.isApproved = true;
    }
  }

  getPageforSupervisor() {
    this._httpService
        .getPagedArrayList(
            new PaginationRequest({
                 page: 1,
                 limit: 10,
                where: {
                  objectid: this.id,
                  objecttype: 'disclosure'
                },
                method: 'get'
            }),
            'gapdisclosure/getguardianship' + '?filter'
        )
        .subscribe(
            (checkList) => this.processCheckList(checkList)
        );
}
  getPage() {
      this._httpService
          .getPagedArrayList(
              new PaginationRequest({
                  where: {
                      permanencyplanid: this.placement.permanencyplanid
                  },
                  method: 'get'
              }),
              'gapdisclosure/getguardianship' + '?filter'
          )
          .subscribe(
              (checkList) => this.processCheckList(checkList)
          );
  }

  patchDisclosureCheckList(model) {
    if (model.gapdisclosure && model.gapdisclosure.length > 0) {
        this.disClosuseCheckList = model.gapdisclosure[0];
        this.approvalStatusForm.patchValue({
            routingstatus: this.disClosuseCheckList.routingstatus ? this.disClosuseCheckList.routingstatus : '',
            comments: this.disClosuseCheckList.comments ? this.disClosuseCheckList.comments : ''
        });
        if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Rejected') {
            this.isApproved = true;
            this.rejectComments(this.approvalStatusForm.value.routingstatus);
        }
        if (this.approvalStatusForm.value.routingstatus === 'Approved' || this.approvalStatusForm.value.routingstatus === 'Review') {
            this.isExistRecord = true;
            this.disclosureCheklistForm.disable();
        }
    } else {
        this.disClosuseCheckList = Object.assign({});
        this.isExistRecord = false;
    }
    
    if (this.disClosuseCheckList) {
        this.disclosureCheklistForm.patchValue({
            guardianoneactorid: model.guardianoneactorid,
            guardiantwoactorid: model.guardiantwoactorid,
            guardianone: model.guardianoneactorid + '~' + model.guardianoneid,
            guardiantwo: model.guardiantwoactorid + '~' + model.guardiantwoid,
            enteredby: model.enteredby,
            gapid: this.nullCheck(model.gapid),
            gapdisclosureid: this.disClosuseCheckList.gapdisclosureid,
            disclosuredate: this.disClosuseCheckList.disclosuredate,
            ischildplacedsixmonths: this.disClosuseCheckList.ischildplacedsixmonths,
            isproviderapprovedgap: this.disClosuseCheckList.isproviderapprovedgap,
            iscourthearingcustody: this.disClosuseCheckList.iscourthearingcustody,
            isreunificationremoved: this.disClosuseCheckList.isreunificationremoved,
            isadoptionremoved: this.disClosuseCheckList.isadoptionremoved,
            iscgprovidesafe: this.disClosuseCheckList.iscgprovidesafe,
            isothergapfinsupport: this.disClosuseCheckList.isothergapfinsupport,
            iscgattendedorientation: this.disClosuseCheckList.iscgattendedorientation,
            orientationmeetingdate: this.disClosuseCheckList.orientationmeetingdate,
            isrequirementdiscussed: this.disClosuseCheckList.isrequirementdiscussed,
            iscgparticipategap: this.disClosuseCheckList.iscgparticipategap,
            iscgenteredagreement: this.disClosuseCheckList.iscgenteredagreement,
            iscgcompleteauthorization: this.disClosuseCheckList.iscgcompleteauthorization,
            iscgaftercareservice: this.disClosuseCheckList.iscgaftercareservice,
            isneedadditionalservices: this.disClosuseCheckList.isneedadditionalservices,
            iscgcompleteannualreview: this.disClosuseCheckList.iscgcompleteannualreview,
            issuspendedfromguardian: this.disClosuseCheckList.issuspendedfromguardian
        });
    } else {
        this.disclosureCheklistForm.patchValue({
            guardianoneactorid: model.guardianoneactorid,
            guardiantwoactorid: model.guardiantwoactorid,
            guardianone: model.guardianoneactorid + '~' + model.guardianoneid,
            guardiantwo: model.guardiantwoactorid + '~' + model.guardiantwoid,
            enteredby: model.enteredby,
            gapid: this.nullCheck(model.gapid),
            gapdisclosureid: null,
            disclosuredate: null,
            ischildplacedsixmonths: null,
            isproviderapprovedgap: null,
            iscourthearingcustody: null,
            isreunificationremoved: null,
            isadoptionremoved: null,
            iscgprovidesafe: null,
            isothergapfinsupport: null,
            iscgattendedorientation: null,
            orientationmeetingdate: null,
            isrequirementdiscussed: null,
            iscgparticipategap: null,
            iscgenteredagreement: null,
            iscgcompleteauthorization: null,
            iscgaftercareservice: '',
            isneedadditionalservices: null,
            iscgcompleteannualreview: null,
            issuspendedfromguardian: null
        });
    }
}

nullCheck(inputData){
    return inputData ? inputData : null;
}

rejectComments(status) {
  if (status === 'Rejected') {
      this.isEnableComments = true;
  } else {
      this.isEnableComments = false;
      this.approvalStatusForm.patchValue({ comments: '' });
  }
}

  initFormGroup() {

      this.disclosureCheklistForm = this._formBuilder.group({
          servicecaseid: [null],
          gapdisclosureid: [null],
          gapid: [null],
          permanencyplanid: [null],
          guardianoneid: [null],
          guardiantwoid: [null],
          guardianoneproviderid: [null],
          guardiantwoproviderid: [null],
          disclosuredate:  [new Date()],
          ischildplacedsixmonths: [null, Validators.required],
          isproviderapprovedgap: [null, Validators.required],
          iscourthearingcustody: [null, Validators.required],
          isreunificationremoved: [null, Validators.required],
          isadoptionremoved: [null, Validators.required],
          iscgprovidesafe: [null, Validators.required],
          isothergapfinsupport: [null, Validators.required],
          iscgattendedorientation: [null, Validators.required],
          orientationmeetingdate: [null],
          isrequirementdiscussed: [null, Validators.required],
          iscgparticipategap: [null, Validators.required],
          iscgenteredagreement: [null, Validators.required],
          iscgcompleteauthorization: [null, Validators.required],
          iscgaftercareservice: [null, Validators.required],
          isneedadditionalservices: [null, Validators.required],
          iscgcompleteannualreview: [null, Validators.required],
          issuspendedfromguardian: [null, Validators.required],
          enteredby: [null]

      });


      this.approvalStatusForm = this._formBuilder.group({
          routingstatus: [''],
          comments: ['']
      });


  }
  addDislosureChecklist(checklist) {
      const saveDisclose = this.conditionValidation();
      if (saveDisclose) {
          const dislosureChecklistDetails = Object.assign(
              {
                  servicecaseid: this.id,
              },
              checklist
          );
          delete dislosureChecklistDetails.guardiantwo;
          delete dislosureChecklistDetails.guardianone;
          this._httpService.create(dislosureChecklistDetails, 'gapdisclosure/add').subscribe(
              res => {
                  if (res === 'Guardianship Already Exist') {
                      this._alertService.error('Guardianship Already Exist');
                  } else {
                      this._alertService.success('Disclosure Checklist Submitted for Supervisor Approval!');
                  }
                  this.getPage();
              },
              error => {
                  this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
              }
          );
      }
  }
  conditionValidation(): boolean {
      if (!this.placement.placementid) {
          this._alertService.warn('Please select child');
          return false;
      } else if (!this.disclosureCheklistForm.value.orientationmeetingdate && this.disclosureCheklistForm.value.iscgattendedorientation) {
          this._alertService.warn('Please fill orientation meeting date');
          return false;
      }
      return true;
  }
}
