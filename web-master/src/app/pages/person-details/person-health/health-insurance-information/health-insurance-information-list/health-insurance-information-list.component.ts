
import {pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { HealthInsuranceInformation } from '../../../../../@core/common/models/involvedperson.data.model';
import { AlertService } from '../../../../../@core/services';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
import { Observable ,  Subject } from 'rxjs';
import { HealthInsuranceInformationService } from '../health-insurance-information.service';
import { PersonDetailsService } from '../../../person-details.service';
import { Router, ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'health-insurance-information-list',
    templateUrl: './health-insurance-information-list.component.html',
    styleUrls: ['./health-insurance-information-list.component.scss'],
    standalone: false
})
export class HealthInsuranceInformationListComponent implements OnInit {

  id!: string | null;
  healthinsurance: HealthInsuranceInformation[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageStream$ = new Subject<number>();
  healthinsurance$ = new Observable<HealthInsuranceInformation[]>();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  resourceID!: string | null;
  deletehealthinsinfopopup = '#delete-healthInsInfo-popup';


  constructor(private _alertSevice: AlertService,
    public _personDetailService: PersonDetailsService,
    private _healthInsInfoService: HealthInsuranceInformationService,
    private router: Router,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.id = this.route.snapshot?.parent?.parent?.parent?.parent?.parent?.params['id'];
    this.pageStream$.subscribe((pageNumber) => {
      this.paginationInfo.pageNumber = pageNumber;
      this.getPage(this.paginationInfo.pageNumber);
    });
    this.getPage(1);
  }

  getPage(page: number) {
    const source = this._healthInsInfoService.getHealthInsInfo(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this._personDetailService.person.personid },
        page: this.paginationInfo.pageNumber,
        limit: this.paginationInfo.pageSize,
      }), this.paginationInfo.pageSize);

    this.healthinsurance$ = source.pipe(pluck('data'));
    if (page === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
    }
  }

  view(id: any) {
    this.router.navigate([ '../create-edit', { id: id, reportMode: 'view' } ], { relativeTo: this.route });
  }

  edit(id: any) {
    this.router.navigate([ '../create-edit', { id: id, reportMode: 'edit' } ], { relativeTo: this.route });
  }

  showDeletePop(resourceid: any) {
    this.resourceID = resourceid;
    (<any>$(this.deletehealthinsinfopopup)).modal('show');
  }

  delete() {
    this._healthInsInfoService.delete(this.resourceID).subscribe(
      response => {
        this.getPage(1);
        this.resourceID = null;
        this._alertSevice.success('Health Insurance Information deleted successfully');
        (<any>$(this.deletehealthinsinfopopup)).modal('hide');
      },
      error => {
        this.resourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletehealthinsinfopopup)).modal('hide');
      }
    );
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageStream$.next(this.paginationInfo.pageNumber);
  }


}
