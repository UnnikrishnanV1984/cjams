import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { CommonHttpService } from '../../../../../@core/services/common-http.service';
import { CommonUrlConfig } from '../../../../../@core/common/URLs/common-url.config';
import { Education } from '../../../../admin/general/_entities/general.data.models';
import { PersonInfoService } from '../../person-info.service';
import { EducationInfoService } from '../education.service';
import { AlertService, AuthService, DataStoreService } from '../../../../../@core/services';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

import moment from 'moment';
import { CASE_STORE_CONSTANTS } from '../../../../../pages/case-worker/_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import _ from 'lodash';
import { ActivatedRoute } from '@angular/router';
declare let $: any;

@Component({
    selector: 'list-education',
    templateUrl: './list-education.component.html',
    styleUrls: ['./list-education.component.scss'],
    standalone: false
})
export class ListEducationComponent implements OnInit {
  personId: any;
  educationPersonList:any[] = [];
  @Output() cachedEducationalInfo = new EventEmitter<any>();
  deleteEducationId: any;
  store: any;
  educationinfo: string | undefined;
  isClosed= false;
  infopopupid = '#info-popup';
  deletepopupid = '#delete-popup';
  sid: string;
  @Output() childRemovalDate = new EventEmitter<any>();
  retrydoc: any = false;
  educationListCheck: any;
  educationid: any;
  constructor(private _commonHttpService: CommonHttpService,
    private _educationService: EducationInfoService,
    private _personService: PersonInfoService,
    public _authService: AuthService,
    private _alertService: AlertService,
    private route: ActivatedRoute,
    private _dataStoreService: DataStoreService) { 
      this.store = this._dataStoreService.getCurrentStore();
      this.sid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.route.queryParams.subscribe(params => {
        this.retrydoc = params['retrydocument'];
        this.educationid = params['retryid'];
      });
    }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personeducation');
    this.personId = (this._personService.getPersonId()) ? this._personService.getPersonId() : '';
    this._personService.getPersonDetails().subscribe(response => {
      this.store = this._dataStoreService.getCurrentStore();
      this.sid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
      this.getRemovalHistoryOfPerson(this.sid, this.personId);
    });
    if (this.sid && this.personId) {
      this.getRemovalHistoryOfPerson(this.sid, this.personId);
    }
    this._educationService.getEducationList();
    this.listenEducationListChange();
    this.showAlert();
  }

  getRemovalHistoryOfPerson(servicecaseid:any, pid: string) {
    this._commonHttpService
    .getSingle(
      {
        where: { objectid: servicecaseid, 'objecttypekey': 'servicecase', 'isgroup':0 }, //objecttypekey":"servicecase","isgroup":0
        method: 'get'
      },
      'intakeservreqchildremoval/getchildremoval?filter'
    ).subscribe(async (resultvalue) => {
      let dates:any = [];
          let childR = resultvalue?.filter((record:any) => record?.personid === pid);
          if (childR && childR.length > 0) {
            childR.forEach((element:any) => {
              dates.push(element.removaldate);
            });
          }
          this._commonHttpService
          .getPagedArrayList(
              new PaginationRequest({
                  page: 1,
                  limit: 10,
                  method: 'get',
                  where: { servicecaseid: servicecaseid },
              }),
              'placement/getplacementbyservicecase?filter'
          ).subscribe((dataI: any) => {
            if (dataI.data && dataI.data.length > 0) {
              let placments = dataI.data.find((record:any) => record.personid === pid);
              if (placments && placments.placements.length > 0) {
                placments.placements.forEach((element:any) => {
                  dates.push(element.startdate);
                });
              }
            }
            if (dates && dates.length > 0) {
              dates = _.uniq(dates);
            }
            this.childRemovalDate.emit(dates);
          });
    },
    (error) => {
      console.error('Error fetching removal history:', error);
    }
    );
  }
  
  showAlert() {
    if(this.store?.PERSON_NAVIGATION_INFO?.data?.isActiveOoh) {
      const currentDt =  moment().format('MM-DD');
      if(currentDt === '08-15') {
        this.educationinfo = 'Please update the Education Information for the start of this School Year.';
        $(this.infopopupid).modal('show');
      } else if(currentDt === '11-15' || currentDt === '02-15') {
        this.educationinfo = 'Please update the Education Information for this Quarter and upload the report card.';
        $(this.infopopupid).modal('show');
      } else if(currentDt === '06-15') {
        this.educationinfo = 'Please update the Education Information for the end of this School Year. Also upload the report card.';
        $(this.infopopupid).modal('show');
      }
    }
  }

  listenEducationListChange() {
    this._educationService.educationPersonType$.subscribe( (data:any) => {
      this.educationPersonList = [];
      const changeInSchools :any= [];
      const placementIds :any= [];
     if (data['personEducation']?.length > 0) {
        data['personEducation'].sort((a:any,b:any) => a.startdate > b.startdate ? -1 : 1 );
        data['personEducation'].map((x:any,index:any)=>{this.educationPersonList[index]={personEducation:x}});
        data['personEducation'].sort((a:any,b:any) => a.startdate > b.startdate ? -1 : 1 );
        if (data['personEducation']?.length > 0) {
          this.placementEducationAfterSortFn(data, changeInSchools, placementIds);
        } else {
          this.cachedEducationalInfo.emit({
            latestChangeInSchool: null,
            placementIds: placementIds
          });
        }
        this.personId = data['Pid'];
      }

      if (data['personAccomplishment']?.length > 0) {
        data['personAccomplishment'].map((x:any,index:any)=>{this.educationPersonList[index].personAccomplishment = x});
        this.personId = data['Pid'];
      }

      if (data['personEducationTesting']?.length > 0 ) {
        data['personEducationTesting'].map((x:any,index:any)=>{this.educationPersonList[index].personEducationTesting = x});
        this.personId = data['Pid'];
      }
      this.educationListCheck = this.educationPersonList.find((item: any) => item.personEducation?.personeducationid === this.educationid);
      if (this.educationListCheck && this.educationid) {
          this.editEducation(this.educationListCheck);
          this.educationid = null;
      }
    });
    
  }

  private placementEducationAfterSortFn(data: any, changeInSchools: any[], placementIds: any[]) {
    data['personEducation'].forEach((detail:any) => {
      if (detail.bestdetermination && detail.bestdetermination.bestDeterminationList.length > 0) {
        const lastValue = detail.bestdetermination.bestDeterminationList[detail.bestdetermination.bestDeterminationList.length - 1];
        if (lastValue.determinationvalue === 1) {
          changeInSchools.push(lastValue);
        }
        detail.bestdetermination.bestDeterminationList.forEach((element :any)=> {
          placementIds.push(element.placementid);
        });
      }
    });
    if (changeInSchools.length > 0) {
      changeInSchools.sort((a, b) => new Date(a.updatedon).getTime() > new Date(b.updatedon).getTime() ? -1 : 1);
    }
    this.cachedEducationalInfo.emit({
      latestChangeInSchool: (changeInSchools.length > 0) ? changeInSchools[0] : null,
      placementIds: placementIds
    });
  }

  editEducation(modal:any) {
    this._educationService.isShowAddEducationEnabled(true);
    setTimeout( () => {
      this._educationService.getEducation(modal);
    }, 500);
  }

  confirmDelete(personaddressid:any) {
    this.deleteEducationId = personaddressid;
    $(this. deletepopupid).modal('show');
  }

  declineDelete() {
    this.deleteEducationId = null;
    $(this. deletepopupid).modal('hide');
  }

  deleteAddress() {
    if (this.deleteEducationId) {
      this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.EDUCATION.SCHOOL.DeleteSchool;
      this._commonHttpService.remove(this.deleteEducationId).subscribe(
        response => {
          $(this. deletepopupid).modal('hide');
          this._alertService.success('Education deleted successfully..');
          this._educationService.getEducationList();
          setTimeout( () => {
            this.listenEducationListChange();
          }, 1000);
        },
        error => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );
    } else {
      $(this. deletepopupid).modal('hide');
    }
  }
}

