
import {map, pluck} from 'rxjs/operators';
import { Component, OnInit, Input } from '@angular/core';
import { AdminUrlConfig } from '../../../admin-url.config';
import { GenericService, CommonHttpService, DataStoreService, AlertService } from '../../../../../@core/services';
import { Observable ,  Subject } from 'rxjs';
import { FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { PaginationInfo } from '../../../../../@core/entities/common.entities';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import { TeamDetails } from '../../../team-position/_entities/teamposition.data.model';

@Component({
    selector: 'resource-new-details',
    templateUrl: './resource-new-details.component.html',
    styleUrls: ['./resource-new-details.component.scss'],
    standalone: false
})
export class ResourceNewDetailsComponent implements OnInit {
  @Input() teamMemeberDetails: TeamDetails = new TeamDetails();
  @Input() totalCount$ = new Subject<any>();
  @Input() teamDetails$: Observable<any> = new Observable<any>();
  @Input() pageChangedRequest$ = new Subject<any>();
  resourcesTypes$: Observable<any> = new Observable<any>();
  resourcesModule$: Observable<any> = new Observable<any>();
  resourcesParent$: Observable<any> =new Observable<any>();
  totalRecordCount!: number;
  paginationInfo = new PaginationInfo();
  resourseFormGroup!: FormGroup; 
  teamDetailLabel: string | undefined;
  teamDetailData: any;
  @Input() selectedTreeSubject = new Subject();
  @Input() reloadTreeSubject = new Subject();
  @Input() selectedResourceId = new Subject<string>();

  constructor(
    private formBuilder: FormBuilder,
    private _service: GenericService<any>,
    private _commonService: CommonHttpService,
    private _alertService: AlertService,
    private _dataStoreService: DataStoreService
  ) {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.TeamPosition.TeamDetailsUrl;
  }
  deletepopupid = '#delete-popup';
  ngOnInit() {
    this.getResourcesTypes();
    this.getModulesList();
    this.getParentsList();
    this.totalCount$.subscribe((item) => {
      this.totalRecordCount = item;
    });
    this._dataStoreService.currentStore.subscribe((item) => {
      if (item['Pagination_Reset']) {
        this.paginationInfo.pageNumber = 1;
      }
    });
    this.resourseFormGroup = this.formBuilder.group(
      {
        parentid: null,
        name: ['', [Validators.required]],
        description: [''],
        modulekey: [''],
        parentkey: [''],
        resourceid: [{value: '', disabled: true}, Validators.required],
        resourcetype: [null, [Validators.required]]
      }
    );
  }

  resourcetypechange(event: any){
    if(event && (event.value === '2')) {
    this.resourseFormGroup.get('modulekey')?.disable();
    this.resourseFormGroup.get('parentkey')?.disable();
    } else {
     this.resourseFormGroup.get('modulekey')?.enable();
     this.resourseFormGroup.get('parentkey')?.enable();
    }
  }

  setresourceid(){
    let resourceid = '';
    resourceid = this.resourseFormGroup.controls['name'].value ? this.resourseFormGroup.controls['name'].value : '';
    if (resourceid) {
      if (this.resourseFormGroup.controls['modulekey'].value && this.resourseFormGroup.controls['modulekey'].value != '' ) {
        if (this.resourseFormGroup.controls['parentkey'].value) {
          resourceid = (this.resourseFormGroup.controls['modulekey'].value + '.' +
          this.resourseFormGroup.controls['parentkey'].value + '.' + resourceid);
        } else {
          resourceid = (this.resourseFormGroup.controls['modulekey'].value + '.' + resourceid);
        }
      }
    }
    this.resourseFormGroup.patchValue({resourceid: resourceid});
  }


  pageChanged(event: any) {
    this.pageChangedRequest$.next(event);
  }

  getResourcesTypes() {
    this.resourcesTypes$ = this._commonService
      .getArrayList(
        {
          nolimit: true,
          method: 'get',
          where: {
            referencetypeid: '344',
            teamtypekey: 'CW'
          }
        },
        AdminUrlConfig.EndPoint.resources.ResourcesTypeListUrl + '/gettypes?filter'
      ).pipe(
      map((result) => {
        return result;
      }));
  }

  getModulesList() {
    const moduleslist = this._commonService.getArrayList(
      {
        nolimit: true,
        method: 'get',
        where: {
          resourcetype: '2'
        }
      },
      AdminUrlConfig.EndPoint.resources.ResourcesTreeListUrl + '?filter'
    ).pipe(map(response => {
      return response;
    }));
    this.resourcesModule$ = moduleslist.pipe(pluck('data'));
  }

  getParentsList() {
    const parentslist = this._commonService.getArrayList(
      {
        nolimit: true,
        method: 'get',
        where: {
          resourcetype: '{2,3,6}'
        }
      },
      AdminUrlConfig.EndPoint.resources.ResourcesTypeTreeListUrl + '?filter'
    ).pipe(map(response => {
      return response;
    }));
    this.resourcesParent$ = parentslist.pipe(pluck('data'));
  }

  clearFormGroup() {
    this.teamDetailLabel = 'Add';
    this.resourseFormGroup.reset();
    this.resourseFormGroup.patchValue({
      name: [''],
      description: [''],
      modulekey: [''],
      parentkey:[''],
      resourceid: [''],
      resourcetype: null
    });
  }

  saveResourse() {
    if (!this.resourseFormGroup.dirty && !this.resourseFormGroup.valid) {
      return false;
    }
    this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.Add;
    this._service.create(this.resourseFormGroup.getRawValue()).subscribe(
      (response: any) => {
        if (response) {
          this._alertService.success('Resourse setup details saved successfully');
          (<any>$('#myModal-new-resource')).modal('hide');
          const data1 = {
            id: this.resourseFormGroup.get('modulekey') ? this.resourseFormGroup.get('modulekey')?.value : this.resourseFormGroup.get('name')?.value,
            pageNo: 1
          };
          this.selectedTreeSubject.next(data1);
          this.paginationInfo.pageNumber = 1;
          this.reloadTreeSubject.next(null); // left side data refresh
          this.clearFormGroup();
        }
      },
      (_error: any) => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }
  deleteItem() {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesAdd;
    this._service.patch(this.teamDetailData.id, { 'activeflag': 0 }).subscribe(
      (response: any) => {
        if (response) {
          this._alertService.success('Resource deleted successfully');
          this.reloadTreeSubject.next(null);
          const data1 = {
            id: response.parentid,
            pageNo: 1
          };
          this.selectedTreeSubject.next(data1);
          this.paginationInfo.pageNumber = 1;
          (<any>$(this.deletepopupid)).modal('hide');
        }
      },
      (_error: any) => {
        (<any>$(this.deletepopupid)).modal('hide');
        this._alertService.error('Cannot delete a Resource');
      }
    );
  }
  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }
  confirmDelete(requestdataDelete: any) {
    if (requestdataDelete.id) {
      this.resourseFormGroup.patchValue({
        parentid: requestdataDelete.parentid,
      });
      this.teamDetailData = requestdataDelete;
      this.teamDetailData.id = requestdataDelete.id;
      (<any>$(this.deletepopupid)).modal('show');
    }
  }

  editTeamItem(requestdata: any) {
    if (requestdata) {
      this.teamDetailData = requestdata;
      this.resourseFormGroup.patchValue({
        parentid: requestdata.parentid,
        name: requestdata.name,
        description: requestdata.description,
        modulekey: requestdata.modulekey,
        parentkey: requestdata.parentkey,
        resourceid: requestdata.resourceid,
        resourcetype: String(requestdata.resourcetype)
      });
      const event = {
            value: String(requestdata.resourcetype)
          };
      this.resourcetypechange(event);
    }
    this.teamDetailLabel = 'Edit';
  }

  updateResourse() {
    this._service.endpointUrl = AdminUrlConfig.EndPoint.resources.ResourcesAdd;
      this._service.patch(this.teamDetailData.id, this.resourseFormGroup.value).subscribe(
        (response: any) => {
          if (response) {
            this._alertService.success('Resource updated successfully');
            (<any>$('#myModal-new-resource')).modal('hide');
            const data = {
              id: response.parentid,
              pageNo: this.paginationInfo.pageNumber,
            };
            this.selectedTreeSubject.next(data); // right side data refresh
            this.reloadTreeSubject.next(null);
          }
        },
        (_error: any) => {
          this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        }
      );

  }

  getControlByIndexFn(index: string): FormControl {
    return this.resourseFormGroup.controls[index] as FormControl;
  }
}
