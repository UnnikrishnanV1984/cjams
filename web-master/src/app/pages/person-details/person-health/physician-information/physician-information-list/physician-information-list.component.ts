
import {pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Physician } from '../../../../../@core/common/models/involvedperson.data.model';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';

import { FormBuilder } from '@angular/forms';
import { AlertService, CommonHttpService } from '../../../../../@core/services';
import { PersonDetailsService } from '../../../person-details.service';
import { PhysicianInformationService } from '../physician-information.service';
import { Router, ActivatedRoute } from '@angular/router';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { Subject ,  Observable } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'physician-information-list',
    templateUrl: './physician-information-list.component.html',
    styleUrls: ['./physician-information-list.component.scss'],
    standalone: false
})
export class PhysicianInformationListComponent implements OnInit {

  id!: string | null | undefined;
  physician: Physician[] = [];
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageStream$ = new Subject<number>();
  physician$ = new Observable<Physician[]>();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  resourceID!: string | null | undefined;
  deletephysicalinfopopup = '#delete-physicalinfo-popup';
  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    public _personDetailService: PersonDetailsService,
    private _physicalInfoService: PhysicianInformationService,
    private router: Router,
    private _commonHttpService: CommonHttpService,
    private route: ActivatedRoute) {

  }

  ngOnInit() {
    this.id = this.route.snapshot.parent?.parent?.parent?.parent?.parent?.params['id'];
    this.pageStream$.subscribe((pageNumber) => {
      this.paginationInfo.pageNumber = pageNumber;
      this.getPage(this.paginationInfo.pageNumber);
    });
    this.getPage(1);
  }

  getPage(page: number) {
    const source = this._physicalInfoService.getPhysicianInfo(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this._personDetailService.person.personid },
        page: this.paginationInfo.pageNumber,
        limit: this.paginationInfo.pageSize,
      }), this.paginationInfo.pageSize);

    this.physician$ = source.pipe(pluck('data'));
    if (page === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
    }
  }

  view(id: any) {
    this.router.navigate(['../create-edit', { id: id, reportMode: 'view' }], { relativeTo: this.route });
  }

  edit(id: any) {
    this.router.navigate(['../create-edit', { id: id, reportMode: 'edit' }], { relativeTo: this.route });
  }

  showDeletePop(resourceid: any) {
    this.resourceID = resourceid;
    (<any>$(this.deletephysicalinfopopup)).modal('show');
  }

  delete() {
    this._physicalInfoService.delete(this.resourceID).subscribe(
      response => {
        this.getPage(1);
        this.resourceID = null;
        this._alertSevice.success('Physician Information deleted successfully');
        (<any>$(this.deletephysicalinfopopup)).modal('hide');
      },
      error => {
        this.resourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletephysicalinfopopup)).modal('hide');
      }
    );
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageStream$.next(this.paginationInfo.pageNumber);
  }


}
