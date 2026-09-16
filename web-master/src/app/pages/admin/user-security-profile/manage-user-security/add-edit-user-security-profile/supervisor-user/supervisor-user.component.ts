import { Component, OnInit, Input } from '@angular/core';
import { PaginationRequest } from '../../../../../../@core/entities/common.entities';
import { CommonHttpService, AlertService } from '../../../../../../@core/services';
import { FormGroup, FormBuilder } from '@angular/forms';
import { GLOBAL_MESSAGES } from '../../../../../../@core/entities/constants';
import { ActivatedRoute, Router } from '@angular/router';

@Component({
    selector: 'supervisor-user',
    templateUrl: './supervisor-user.component.html',
    standalone: false
})
export class SupervisorUserComponent implements OnInit {
  @Input()
  id!: string | undefined;
  supervisorList: any;
  addSupervisor!: FormGroup;
  constructor(private _commonService: CommonHttpService,private formBuilder: FormBuilder, private _alert: AlertService,private route: ActivatedRoute, private router: Router) { }
  teamID: any;
  ngOnInit() {
    this.addSupervisor = this.formBuilder.group({
      supervisorID: ['', []],
      id:['', []]
    });
    this.route.params.subscribe((item: any) => {
      this.addSupervisor.patchValue({id:item['id']});
      this.teamID = item['teamId'];
    });    
    this.loadSupervisor();
  }

  private loadSupervisor() {
    this._commonService
        .getPagedArrayList(
            new PaginationRequest({
                where: { appevent: 'ALL' ,teamid: this.teamID },
                method: 'post'
            }),
            'Intakedastagings/getroutingusers'
        )
        .subscribe(result => {
            this.supervisorList = result['data'];
           
        });
  }

  save(){
    this._commonService.create(this.addSupervisor.value, 'admin/userprofile/saveSupervisor').subscribe(
      res => {
          this._alert.success('Supervisor saved successfully');
      },
      err => {
          this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      }
    );
  }

}
