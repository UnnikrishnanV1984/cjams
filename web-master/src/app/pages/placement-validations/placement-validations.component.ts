import { Component, OnInit } from '@angular/core';
import { AuthService, CommonHttpService, AlertService } from '../../@core/services';
import { FormBuilder } from '@angular/forms';
import { ActivatedRoute } from '@angular/router';
import { UserProfile } from '../../@core/entities/authDataModel';
import { PlacementValidationsResolverService } from './placement-validations-resolver-service';

@Component({
    // tslint:disable-next-line: component-selector
    selector: 'placement-validations',
    templateUrl: './placement-validations.component.html',
    styleUrls: ['./placement-validations.component.scss'],
    standalone: false
})
export class PlacementValidationsComponent implements OnInit {
  tabDetails:any = [];
  loggedInUser!: UserProfile;
  totalcount: number=0;
  moduleview: any;
  ipaduser: boolean = false;
  placementvalidation = 'Placement Validation';

  constructor(private _commonService: CommonHttpService, private formBuilder: FormBuilder,
    private route: ActivatedRoute, private _alertService: AlertService, private _authService: AuthService,private placementValidationsResolverService: PlacementValidationsResolverService) { 
    //   this.route.data.subscribe(data => {
    //     if (data && data.hasOwnProperty('result')) {
    //       _authService.setAuthDetail(this.placementvalidation,data.result);
    //     }
    // });
    }

  ngOnInit() {
    this.placementValidationsResolverService.getPlacementValidation().subscribe({
        next: (data: any) => {
            this._authService.setAuthDetail(this.placementvalidation,data);
        }
    })
    this.loggedInUser = this._authService.getCurrentUser().user.userprofile;
    this.moduleview = this._authService.isModuleAccessable(this.placementvalidation, this.placementvalidation);
    this.initTabs();
    if(navigator.userAgent.match(/(iPod|iPhone|iPad|Android)/)) {
      this.ipaduser = true;
  }
  }

  initTabs() {
    this.tabDetails = [
        {
            id: 'pending',
            title: 'pending',
            name: 'pending',
            route: 'pending'
        },
        {
          id: 'approved',
          title: 'approved',
          name: 'approved',
          route: 'approved'
      }
    ];
  }
}
