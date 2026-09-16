import { Component, OnInit, Input } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { PersonService } from '../../../../in-home-service/person.service';
import { AlertService, DataStoreService } from '../../../../../../../@core/services';

@Component({
    selector: 'short-term-goals',
    templateUrl: './short-term-goals.component.html',
    styleUrls: ['./short-term-goals.component.scss'],
    standalone: false
})
export class ShortTermGoalsComponent implements OnInit {

  @Input() goals!: any;
  selectedGoal: any;
  goalForm!: FormGroup;
  persons: any = [];
  addEditLabel!: string;
  selectedIndex!: number;
  selectedAction!: number;
  maxDate = new Date();
  ytpData: any;
  deletepopupid = '#delete-popup';
  constructor(private formBuilder: FormBuilder,
    private _personService: PersonService,
    private _dataStoreService: DataStoreService,
    private _alertService: AlertService) { }

  ngOnInit() {
    this.ytpData = this._dataStoreService.getData('YTPDATA');
    this.loadResponsiblePersons();
    
  }
  loadResponsiblePersons() {
    this._personService.getPersonsList().subscribe((item) => {

      if (item && item.hasOwnProperty('data') && item.data && item.data.length) {
        this.persons = item.data.map(data => {
          return {
            personid: data.personid,
            firstname: data.firstname,
            lastname: data.lastname
          };
        }); // apply filter if any need
      } else {
        this.persons = [];
      }

    });
  }

  addAction(item: any){
    if(item.actions && Array.isArray(item.actions)){
      item.actions.push({action_plan : ''});
    } else {
      item.actions = [];
      item.actions.push({action_plan : ''});
    }
  }

  addGoal() {
    // this.addEditLabel = 'Add';
    // (<any>$('#add-edit-goal-modal')).modal('show');
    const actionList=[];
    actionList.push({action_plan : ''});
    this.goals.push({
      goal: '',
      actions: actionList,
      responsible_parties: null,
      projected_date: null,
    });
  }

  editGoal(goal: any, index: any) {
    this.goalForm.patchValue(goal);
    this.goalForm.patchValue({projected_date: new Date(goal.projected_date)})
    this.selectedIndex = index;
    this.addEditLabel = 'Edit';
    (<any>$('#add-edit-goal-modal')).modal('show');
  }

  confirmDelete() {
    this.goals.splice(this.selectedIndex, 1);
    (<any>$(this.deletepopupid)).modal('hide');
  }

  declineDelete() {
    (<any>$(this.deletepopupid)).modal('hide');
  }

  deleteGoal(index: any) {
    this.selectedIndex = index;
    (<any>$(this.deletepopupid)).modal('show');
  }

  deleteAction(index: any, action: any) {
    this.selectedAction = index;
    action.splice(index, 1);
  }

  compareObjects(o1: any, o2: any): boolean {
    return o1.lastname === o2.lastname && o1.firstname === o2.firstname;
  }

  saveOrUpdate() {
    if (this.goalForm.invalid) {
      this._alertService.error('Please fill the required fields');
      return false;
    }
    const goalForm = this.goalForm.getRawValue();
    if (this.addEditLabel === 'Add') {
      if (this.isGoalExist(goalForm.goal)) {
        this._alertService.error('Goal already added');
        return false;
      }
      this.goals.push(goalForm);
    } else {
      this.goals[this.selectedIndex] = goalForm;
    }
    this.hidePopup();
  }

  isGoalExist(goalName: string) {
    const goal = this.goals.find((item: { goal: string; }) => item.goal === goalName);
    if (goal) {
      return true;
    } else {
      return false;
    }
  }

  hidePopup() {
    (<any>$('#add-edit-goal-modal')).modal('hide');
    this.goalForm.reset();
  }

  clearItem() {
    this.goalForm.reset();
  }

}
