
import {map} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { Observable } from 'rxjs';

import { DropdownModel, PaginationInfo, PaginationRequest, TreeViewModel } from '../../../@core/entities/common.entities';
import { CommonHttpService } from '../../../@core/services';
import { GenericService } from '../../../@core/services/generic.service';
import { AdminUrlConfig } from '../../admin/admin-url.config';
import { ManageTeamConfig, ManageTeamUserConfig } from '../_entities/manage.data.models';
import { ManageUrlConfig } from '../manage-url.config';
import { TeamDetails } from '../../admin/team-position/_entities/teamposition.data.model';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'team-manage',
    templateUrl: './team-manage.component.html',
    styleUrls: ['./team-manage.component.scss'],
    standalone: false
})
export class TeamManageComponent implements OnInit {
  zipAssign: ManageTeamUserConfig[] = [];
  userprofile$: Observable<ManageTeamUserConfig> = new Observable<ManageTeamUserConfig>();
  treeComponentId!: string;
  teamDetails$!: Observable<TeamDetails>;
  teamTreeview$!: Observable<TreeViewModel[]>;
  statusLists: DropdownModel[] = [];
  statusUpdateForm!: FormGroup;
  totalRecords$!: Observable<number>;
  paginationInfo: PaginationInfo = new PaginationInfo();
  // tslint:disable-next-line:max-line-length
  constructor(private _teamTreeViewService: GenericService<TreeViewModel>, private _service: CommonHttpService, private _daActionService: GenericService<ManageTeamConfig>, private _manageUserService: GenericService<ManageTeamUserConfig>, private formBuilder: FormBuilder) {
    this._daActionService.endpointUrl = ManageUrlConfig.EndPoint.Manage.Team.TeamDetailsUrl;
  }

  ngOnInit() {
    this.statusUpdateForm = this.formBuilder.group({
      userworkstatustypekey: [''],
      isavailable: ['']
    });
    this.teamTreeview$ = this._teamTreeViewService.getArrayList({}, AdminUrlConfig.EndPoint.EquipmentMgmt.TeamUrl);
  }

  teamTreeSubComp(model: any) {
    this.treeComponentId = model.node.id;
    this.teamMembers();
    this.teamContact();
  }


  teamMembers() {
    this.teamDetails$ = this._daActionService.getPagedArrayList(new PaginationRequest({
      page: 1,
      limit: 10,
      method: 'get'
    }), ManageUrlConfig.EndPoint.Manage.Team.TeamDetailsUrl + '/' + this.treeComponentId + '?filter').pipe(
      map((result: any) => {
        return result.data;
      }));
  }
  teamContact() {
    this.userprofile$ = this._manageUserService
    .getArrayList({}, ManageUrlConfig.EndPoint.Manage.Team.TeamMemberDetailsUrl + '/' + this.treeComponentId).pipe(
    map((result: any) => {
        return result;
      }));
  }

  statusList() {
    this._service.getArrayList({}, AdminUrlConfig.EndPoint.TeamPosition.GetUserWorkStatusTypeUrl).subscribe((result: any) => {
      this.statusLists = result.map((res: { typedescription: any; userworkstatustypekey: any; }) => new DropdownModel({ text: res.typedescription, value: res.userworkstatustypekey }));
    });
  }
  saveStatus() {
    this._daActionService.endpointUrl = ManageUrlConfig.EndPoint.Manage.Team.TeamUserUpdateUrl;
    // tslint:disable-next-line:max-line-length
    this._daActionService.patch('', { 'Teammemberid': this.treeComponentId, 'userworkstatustypekey': this.statusUpdateForm.value.userworkstatustypekey, 'isavailable': this.statusUpdateForm.value.isavailable }).subscribe((response: any) => {
      // No content to add or call
     }, (_error: any) => {
    });
  }
  zipAssignment() {
      this._manageUserService.getArrayList({}, ManageUrlConfig.EndPoint.Manage.Team.ZipAssignmentUrl + '/' + this.treeComponentId)
      .subscribe(result => {
        this.zipAssign = result;
      });
  }

}
