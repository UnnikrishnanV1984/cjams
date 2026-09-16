
import {pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Medication } from '../../../../../@core/common/models/involvedperson.data.model';
import { AlertService } from '../../../../../@core/services';
import { MedicationIncludingPsychotropicService } from '../medication-including-psychotropic.service';
import { PaginationInfo, PaginationRequest } from '../../../../../@core/entities/common.entities';
// tslint:disable-next-line:import-blacklist
import { Subject, Observable } from 'rxjs';
import { PersonDetailsService } from '../../../person-details.service';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'medication-including-psychotropic-list',
    templateUrl: './medication-including-psychotropic-list.component.html',
    styleUrls: ['./medication-including-psychotropic-list.component.scss'],
    standalone: false
})

export class MedicationIncludingPsychotropicListComponent implements OnInit {
  id!: string | null;
  paginationInfo: PaginationInfo = new PaginationInfo();
  private pageStream$ = new Subject<number>();
  medication$ = new Observable<Medication[]>();
  canDisplayPager$!: Observable<boolean>;
  totalRecords$!: Observable<number>;
  resourceID!: string | null;
  deletemedationpopup = '#delete-medation-popup';

  constructor(private _alertSevice: AlertService,
    public _personDetailService: PersonDetailsService,
    private _medicationService: MedicationIncludingPsychotropicService,
    private router: Router,
    private route: ActivatedRoute) { }

  ngOnInit() {
    this.id = this.route.snapshot.parent?.parent?.parent?.parent?.parent?.params['id'];
    this.pageStream$.subscribe((pageNumber) => {
      this.paginationInfo.pageNumber = pageNumber;
      this.getPage(this.paginationInfo.pageNumber);
    });
    this.getPage(1);
  }

  getPage(page: number) {
    const source = this._medicationService.getmedication(new PaginationRequest(
      {
        method: 'get',
        where: { personid: this._personDetailService.person.personid },
        page: this.paginationInfo.pageNumber,
        limit: this.paginationInfo.pageSize,
      }), this.paginationInfo.pageSize);

    this.medication$ = source.pipe(pluck('data'));
    if (page === 1) {
      this.totalRecords$ = source.pipe(pluck('count'));
      this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
    }
  }

  view(id: string) {
    this.router.navigate(['../create-edit', { id: id, reportMode: 'view' }], { relativeTo: this.route });
  }

  edit(id: string) {
    this.router.navigate(['../create-edit', { id: id, reportMode: 'edit' }], { relativeTo: this.route });
  }

  showDeletePop(resourceid: any) {
    this.resourceID = resourceid;
    (<any>$(this.deletemedationpopup)).modal('show');
  }

  delete() {
    this._medicationService.delete(this.resourceID).subscribe(
      response => {
        this.getPage(1);
        this.resourceID = null;
        this._alertSevice.success('Medications deleted successfully');
        (<any>$(this.deletemedationpopup)).modal('hide');
      },
      error => {
        this.resourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletemedationpopup)).modal('hide');
      }
    );
  }

  pageChanged(pageInfo: any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.paginationInfo.pageSize = pageInfo.itemsPerPage;
    this.pageStream$.next(this.paginationInfo.pageNumber);
  }
}
