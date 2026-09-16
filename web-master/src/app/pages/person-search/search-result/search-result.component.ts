
import {pluck, share, map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder } from '@angular/forms';
import { CommonHttpService, GenericService, AuthService, DataStoreService } from '../../../@core/services';
import {  Router } from '@angular/router';
import { ObjectUtils } from '../../../@core/common/initializer';
import { PaginationInfo, PaginationRequest } from '../../../@core/entities/common.entities';
import { Observable } from 'rxjs';
import { InvolvedPerson, InvolvedPersonSearchResponse, PersonDsdsAction, PriorAuditLog } from '../../../@core/common/models/involvedperson.data.model';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { NewUrlConfig } from '../../newintake/newintake-url.config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'search-result',
    templateUrl: './search-result.component.html',
    styleUrls: ['./search-result.component.scss'],
    standalone: false
})
export class SearchResultComponent implements OnInit {


  personSearchForm!: InvolvedPerson;
  paginationInfo: PaginationInfo = new PaginationInfo();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  personSearchResult$!: Observable<InvolvedPersonSearchResponse[]>;
  personDSDSActions$!: Observable<PersonDsdsAction[]>;
  private priorAuditLogRequest = new PriorAuditLog();
  intakeNumber!: string;

  showPersonDetail = -1;
  private EDITABLE_ROLES = [AppConstants.ROLES.CASE_WORKER, AppConstants.ROLES.SUPERVISOR];
  isEditable = false;
  constructor(private _formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService,
    private router: Router,
    private _involvedPersonSeachService: GenericService<InvolvedPersonSearchResponse>,
    private _authService: AuthService,
    private _dataStoreService: DataStoreService) {
      this.isEditable = this.hasEditAccess();
    }

  ngOnInit() {
    this.personSearchForm = this._dataStoreService.getData('PERSON_SEARCH_FORM');
    if (this.personSearchForm) {
      this.getPage(1);
    } else {
      this.router.navigate(['/pages/person-search/search']);
    }


  }

  hasEditAccess() {
    const user: AppUser = this._authService.getCurrentUser();
    let hasAccess = false;
    const found = this.EDITABLE_ROLES.indexOf(user.role.name);
    if (found !== -1) {
      hasAccess = true;
    }
    return hasAccess;



  }

  private getPage(pageNumber: number) {
    ObjectUtils.removeEmptyProperties(this.personSearchForm);
    const source = this._involvedPersonSeachService
      .getPagedArrayList(
        {
          limit: this.paginationInfo.pageSize,
          order: this.paginationInfo.sortBy,
          page: pageNumber,
          count: this.paginationInfo.total,
          where: this.personSearchForm,
          method: 'post'
        },
        'globalpersonsearches/getEnhancedPersonSearchData'
      ).pipe(
      map((result) => {
        return {
          data: result.data,
          count: result.count,
          canDisplayPager: result.count > this.paginationInfo.pageSize
        };
      }),
      share(),);
    this.personSearchResult$ = source.pipe(pluck('data'));
    if (pageNumber === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
    }
  }

  searchPersonDetailsRow(id: number, model: any) {
    this.searchPersonDetails(id);
    this.getPersonDSDSAction(model);
  }

  getPersonDSDSAction(model: PersonDsdsAction) {
    const url = NewUrlConfig.EndPoint.Intake.IntakeServiceRequestsUrl + `?personid=` + model.personid + '&filter';
    const source = this._commonHttpService
        .getArrayList(
            new PaginationRequest({
                method: 'get',
                where: { intakerequestid: null }
            }),
            url
        ).pipe(
        share());
    this.personDSDSActions$ = source.pipe(
      pluck('data'),
      map((data: any) => data as PersonDsdsAction[])
    );
    this.personDSDSActions$.pipe(
        map((data) => {
            data.forEach((address) => {
                address.daDetails.forEach((addressdata) => {
                    if (addressdata.dasubtype === 'Peace Order') {
                        address.highLight = true;
                        return address;
                    }
                });
            });
            return data;
        })).subscribe();
}


  pageChanged(event: any) {
    this.paginationInfo.pageNumber = event.page;
    this.getPage(this.paginationInfo.pageNumber);
  }
  searchPersonDetails(id: number) {
    if (this.showPersonDetail !== id) {
      this.showPersonDetail = id;
    } else {
      this.showPersonDetail = -1;
    }
  }

  openPersonInDetail(person: any, action: any) {
    this.router.navigate(['/pages/person-details/' + action + '/' + person.personid + '/basic']);

  }

  getPrimaryRelationname(listdata: any) {
    const finddata = listdata.find((data: any) => data.relationcategory === 'Primary');
    if (finddata) {
        return (finddata.relationtype + ': ' + finddata.personname);
    }
    return '';
  }
  priorAuditLog(item: any) {
    window.open('#/pages/case-worker/' + item.intakeserviceid + '/' + item.danumber + '/dsds-action/report-summary', '_blank');
    const url = NewUrlConfig.EndPoint.Intake.PriorAuditLogUrl;
    this.priorAuditLogRequest = Object.assign({}, item);
    this.priorAuditLogRequest.priordanumber = item.danumber;
    this.priorAuditLogRequest.danumber = this.intakeNumber;
    const obj = this.priorAuditLogRequest;
    this._commonHttpService
        .getArrayList(
            {
                method: 'post',
                obj
            },
            url
        )
        .subscribe();
}


}
