import { Component, OnInit, Input } from '@angular/core';
import { Subject, Observable } from 'rxjs';
import { UpdateProfileDetails} from '../../../_entites/user-security-profile.data.modal';
import { CommonHttpService, AlertService, DataStoreService } from '../../../../../../@core/services';
import { FormGroup, FormBuilder } from '@angular/forms';

import { Router, ActivatedRoute } from '@angular/router';

@Component({
    selector: 'roles-and-position',
    templateUrl: './roles-and-position.component.html',
    styleUrls: ['./roles-and-position.component.scss'],
    standalone: false
})
export class RolesAndPositionComponent implements OnInit {
  @Input() userRoles!: Subject<UpdateProfileDetails>;
  id: any;
  activePositions: any;
  roleList$!: Observable<any>;
  permissiongroup: any;
  rolePosition!: FormGroup;
  selectedpermissions: any;
  constructor(
    private _commonService: CommonHttpService,
    private _fb: FormBuilder,
    private router: Router,
    private activeroute: ActivatedRoute,
    private alertify: AlertService,
    private _dataStore: DataStoreService
  ) { }

  ngOnInit() {
    this.rolePosition = this._fb.group({
      roleid: [''],
      pg: ['']
    })
    this.activeroute.params.subscribe(res => {
      this.id = res.id;
    });
    this.loaddropdowns();
  }
  loaddropdowns() {
    this.userRoles.subscribe(res => {
      if (res && res.role && res.role.roleid) {
        this.rolePosition.get('roleid')?.patchValue(res.role.roleid);
        this._dataStore.setData('Role_Id', res.role.roleid);
       }
      this.activePositions = res.userresource.map(c => c.permissiongroupid);
      this._commonService.getArrayList({ method: 'get', nolimit: true }, 'Permissiongroups?filter').subscribe(r => {
        this.permissiongroup = r.map(v => {
          v['selected'] = false;
          return v;
        });
        this.fillpermission();
      });
      this.roleList$ = this._commonService.getArrayList({
        method: 'get',
        where: {
          teamtypekey: null
        },
        nolimit: true
      }, 'role/getagencyrole?filter');
    });
  }
  fillpermission() {
    if (this.activePositions && this.activePositions.length && this.permissiongroup && this.permissiongroup.length) {
      this.activePositions.map((c: any) => {
        this.permissiongroup.filter((v: { permissiongroupid: any; }) => v.permissiongroupid === c).map((v: { selected: boolean; }) => {
          v.selected = true;
        });
      });
      this._dataStore.setData('Selected_Groups', this.permissiongroup);
    }
  }
  permissiongroupChange(val: any) {
    const data = val.selectedOptions.selected.map((item: any) => item.value);
    this.rolePosition.get('pg')?.patchValue(data);
  }
  onSubmit() {
    const data = this.rolePosition.value;
    data['userid'] = this.id;
    this._commonService.updateWithoutid(data, 'admin/userprofile/pgrolemapping').subscribe(r => {
      if (r === null || r.length && r[0].errormsg) {
        this.alertify.error('Some thing went wrong please try again');
      } else {
        this.alertify.success('Role and permission updated success fully');
        this._dataStore.setData('Update_List', true);
      }
      this.closeUserProfile();
    })
  }

  closeUserProfile() {
    (<any>$('#add-newusers-popup')).modal('hide');
    const currentUrl = 'pages/admin/user-security-profile';
    this.router.navigateByUrl(currentUrl).then(() => {
      this.router.navigated = false;
      this.router.navigate([currentUrl]);
    });
  }
  roleChanges(event: any) {
    if (event.value !== this._dataStore.getData('Role_Id')) {
      this.permissiongroup = this.permissiongroup.map((v: any) => {
        v['selected'] = false;
        return v;
      });
    } else {
     this.fillpermission();
    }
  }
}
