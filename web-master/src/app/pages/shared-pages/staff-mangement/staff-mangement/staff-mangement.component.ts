
import {mergeMap, startWith, map, debounceTime, share, pluck} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { Subject ,  Observable, merge } from 'rxjs';
import { ColumnSortedEvent } from '../../../../shared/modules/sortable-table/sort.service';
import { DynamicObject, PaginationInfo, PaginationRequest } from '../../../../@core/entities/common.entities';
import { GenericService, DataStoreService, AuthService, AlertService, CommonHttpService } from '../../../../@core/services';
import { ProfileUser, PositionDetail, UpdateProfileDetails } from '../../../admin/user-security-profile/_entites/user-security-profile.data.modal';
import { AdminUrlConfig } from '../../../admin/admin-url.config';
import { FormGroup, FormBuilder } from '@angular/forms';

@Component({
    selector: 'staff-mangement',
    templateUrl: './staff-mangement.component.html',
    styleUrls: ['./staff-mangement.component.scss'],
    standalone: false
})
export class StaffMangementComponent implements OnInit {

    securityusersid!: string;
    isAddMode!: boolean;
    emailSubject: Subject<string> = new Subject<string>();
    sUserid: Subject<string> = new Subject<string>();
    positionTeammember$: Subject<PositionDetail> = new Subject<PositionDetail>();
    editUserRoles: Subject<UpdateProfileDetails> = new Subject<UpdateProfileDetails>();
    isClosed = false;
  totalRecords$!: Observable<number>;
  canDisplayPager$!: Observable<boolean>;
  usersList$!: Observable<ProfileUser[]>;
  private dynamicObject!: DynamicObject;
  private searchTermStream$ = new Subject<DynamicObject>();
  private pageStream$ = new Subject<number>();
  paginationInfo: PaginationInfo = new PaginationInfo();
  constructor(  private _alertService: AlertService, 
    private _httpService: CommonHttpService,
    private formBuilder: FormBuilder,private _service: GenericService<ProfileUser>, private _dataStore: DataStoreService,public _authService: AuthService ) {}
  department: any;
  countyId: string | null = null;
  user: any;
  teamList: any;
  userForm!: FormGroup;
  supervisorList: any[] = [];
  displayName!: string;
  seectedUser: any;
  ngOnInit() {
    this.user = this._authService.getCurrentUser();
    this.countyId = '';
    const actualuser = this.user.user;
    if (actualuser.userprofile
            && actualuser.userprofile.teammemberassignment
            && actualuser.userprofile.teammemberassignment.teammember.team
            &&  actualuser.userprofile.teammemberassignment.teammember.team.countyid ) {
            this.countyId = actualuser.userprofile.teammemberassignment.teammember.team.countyid;
    }
      this.paginationInfo.sortBy = 'displayname asc';
      this.getCountyList();
     
      this._dataStore.currentStore.subscribe((item: { [x: string]: any; }) => {
          if (item['Update_List']) {
              this.getPage();
              this._dataStore.setData('Update_List', false);
          }
      });
      this.userForm = this.formBuilder.group({
        ssn: [''],
        teamid:[''],
        supervisoid:[''],
        userId:[''],
        teammemberid:['']
    });
    this._authService.readonlyPage("staff-mangement-read-only",'',[this.userForm]);
  }

openUserPopup(user: any){
    this.displayName = user.displayname;
    this.seectedUser = user.supervisorid;
    this.userForm.patchValue({userId : user.securityusersid,
        teammemberid : user.teammemberid,
        supervisoid : user.supervisorid,
        teamid: user.teamid,
        ssn : user.ssn
    });
    this.loadSupervisor(user.teamid, user.supervisorid);
    (<any>$('#iframe-update-user')).modal('show');
}

 loadSupervisor(val: any, supervisoid: any) {
    let id: any = this.returnIdOnLoadFn(val);
    const obj: any = {
        teamid: '',
        filtertypekey: ''
    };
    obj.teamid = id === '' ? null : id;
    obj.filtertypekey = 'unit';
    this._service.getPagedArrayList(new PaginationRequest({
        where: obj,
        method: 'get',
        nolimit: true
    }), 'manage/team/getteamusers?filter').subscribe((result: any) => {
        this.supervisorList = result;
        this.supervisorList = this.supervisorList && this.supervisorList.length ? 
        this.supervisorList.filter(ele => ele.issupervisor) : [];
        this.userForm.patchValue({
            supervisoid : supervisoid,
        });
    });
}

    private returnIdOnLoadFn(val: any) {
        let id: any = null;
        if (typeof val === 'string') {
            id = val;
        } else {
            id = (val.target as HTMLInputElement).value;
        }
        return id;
    }

  getPage() {
      const pageSource = this.pageStream$.pipe(map((pageNumber: any) => {
          this.paginationInfo.pageNumber = pageNumber;
          return { search: this.dynamicObject, page: pageNumber };
      }));

      const searchSource = this.searchTermStream$.pipe(debounceTime(1000),map((searchTerm: any) => {
          this.dynamicObject = searchTerm;
          return { search: searchTerm, page: 1 };
      }),);

      const source = merge(searchSource,pageSource).pipe(        
          startWith({
              search: this.dynamicObject,
              page: this.paginationInfo.pageNumber
          }),
          mergeMap((params: { search: DynamicObject; page: number }) => {
              return this._service
                  .getPagedArrayList(
                      {
                          limit: this.paginationInfo.pageSize,
                          order: this.paginationInfo.sortBy,
                          page: params.page,
                          count: this.paginationInfo.total,
                          method: 'get',
                          where: params.search
                      },
                      AdminUrlConfig.EndPoint.UserProfile.UsersListUrl + '?filter'
                  ).pipe(
                  map((result: {data: any; count: any;}) => {
                      let filter = [];
                      if (result && result.data && result.data.length) {
                        filter = result.data.filter((ele: { county: any; }) => ele.county === this.department.countyname);
                      }
                      return { data: filter, count: result.count, canDisplayPager: result.count > this.paginationInfo.pageSize };
                  }));
          }),
          share(),);

      this.usersList$ = source.pipe(pluck('data'));
      if (this.paginationInfo.pageNumber === 1) {
          this.totalRecords$ = source.pipe(pluck('count'));
          this.canDisplayPager$ = source.pipe(pluck('canDisplayPager'));
      }
  }

  pageChanged(pageInfo: any) {
      this.paginationInfo.pageNumber = pageInfo.page;
      this.paginationInfo.pageSize = pageInfo.itemsPerPage;
      this.pageStream$.next(this.paginationInfo.pageNumber);
  }

  onSorted($event: ColumnSortedEvent) {
      this.paginationInfo.sortBy = $event.sortColumn + ' ' + $event.sortDirection;
      this.pageStream$.next(this.paginationInfo.pageNumber);
  }

  onChangeTeam(field: string, val: Event) {
    const value = (val.target as HTMLInputElement).value;
    if (value) {
        this.onSearch(field, value);
    } else {
        this.onSearch('county', this.department.countyname);
    }
  }

  onSearch(field: string, val: any) {
        let value: any = this.returnIdOnLoadFn(val);
      this.dynamicObject =  {};
      value = value && value.indexOf('#') === -1 ? value : value.substring(0, value.indexOf('#'));
      this.dynamicObject[field] = { like: '%25' + value + '%25' };
      if (!value) {
          delete this.dynamicObject[field];
      }
      this.searchTermStream$.next(this.dynamicObject);
  }

  onSearchActive(field: string, val: any) {
    const value: any = this.returnIdOnLoadFn(val);
    this.dynamicObject =  {};
   
    this.dynamicObject[field] = {value };
    if (!value) {
        delete this.dynamicObject[field];
    }
    this.searchTermStream$.next(this.dynamicObject);
}

openUserDetails(user: any){
    this.displayName = user.displayname;
    this.seectedUser = user.supervisorid;
    this.sUserid.next(user.id);
    (<any>$('#add-user-profile')).modal('show');
}
  onGenderSearch(field: string,  val: Event) {
    const value = (val.target as HTMLInputElement).value;
    this.dynamicObject[field] = { like: value + '%25' };
    if (!value) {
        delete this.dynamicObject[field];
    }
    this.searchTermStream$.next(this.dynamicObject);
  }

  getCountyList() {
    this._httpService.create({
        where: {},
        order: 'countyname',
        nolimit: true
    }, 'admin/county/countylist').subscribe((item: any[]) => {
         this.department = item.find(ele => ele.countyid === this.countyId);
         if ( this.department ) {
            this.onSearch('county', this.department.countyname);
            this.getteamlist(this.department.countyid);
         }
   });
}
getteamlist(id: string | null | undefined) {
   const obj: any = {
        activeflag: 1
    };
    if (id !== '' && id !== undefined && id !== null) {
        obj['countyid'] = id;
    } else {
        obj['countyid'] = null;
    }
    obj['teamtypekey'] = (typeof this.user.teamtypekey === 'string') ? this.user.teamtypekey.toUpperCase() : this.user.teamtypekey;
    this._service.getPagedArrayList(new PaginationRequest({
        where: obj, method: 'get', nolimit: true
    }
    ), 'manage/team/list?filter')
        .subscribe((result: { data: any; }) => {
            this.teamList = result.data;
            this.getPage();
        });
}
get f() {
    return this.userForm.controls;
  }

updateUser() {
    if (this.userForm.valid) {
        this._service.create(this.userForm.getRawValue(), AdminUrlConfig.EndPoint.UserProfile.UserUpdate).subscribe(
            () => {
                alert('User updated successfully!');
                this.updateTeamDetails(this.userForm.getRawValue());
                this.userForm.reset();
                (<any>$('#iframe-update-user')).modal('hide');
                this.getPage();

            },
            (_error: any) => {
            }
        );
    }
}
    updateTeamDetails(rowval: any) {

        this._service.create(rowval, 'admin/teammember/updateuserposition').subscribe(
            (_item: any) => {
                // No content to add or call
            }, (_err: any) => {
                // No content to add or call
            });
    }
}

