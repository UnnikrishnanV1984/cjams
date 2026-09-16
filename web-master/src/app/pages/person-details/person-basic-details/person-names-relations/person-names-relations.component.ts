import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute} from '@angular/router';
import { GenericService, AlertService} from '../../../../@core/services';
import { InvolvedPerson } from '../../../case-worker/dsds-action/service-plan/_entities/service-plan.model';
import { PersonDetailsService } from '../../person-details.service';
import { PersonBasicDetailsService } from '../person-basic-details.service';

@Component({
    selector: 'person-names-relations',
    templateUrl: './person-names-relations.component.html',
    styleUrls: ['./person-names-relations.component.scss'],
    standalone: false
})
export class PersonNamesRelationsComponent implements OnInit {

  addNameForm!: FormGroup;

  isNickName!: boolean;
  personid!: string | null | undefined;
  nickNames: Array<any> = [];
  aliasNames: Array<any> = [];
  primaryRelations: any[] = [];
  secondaryRelaltions: any[] = [];
  isNameEdit!: boolean;
  nickname: any;
  aliasname: any;

  constructor(private _service: GenericService<InvolvedPerson>,
    private route: ActivatedRoute,
    private _alertService: AlertService,
    private _formBuilder: FormBuilder,
    public personService: PersonDetailsService,
    private _basicDetailsService: PersonBasicDetailsService
  ) { }

  ngOnInit() {
    this.personid = this.route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
    this.isNameEdit = false;
    this.initiateNameFormGroup();
    this.isNickName = false;

    this.loadNickNames();
    this.loadAliasNames();
    this.loadRelations();
  }


  private loadRelations() {
    if (this.personService.person.personrelation) {
      this.primaryRelations = this.personService.person.personrelation.filter(person => person.relationcategory === 'P');
      this.secondaryRelaltions = this.personService.person.personrelation.filter(person => person.relationcategory === 'S');
    }

  }

  private loadNickNames() {
    this._basicDetailsService.getNickNames(this.personid).subscribe(nicknames => {
      this.nickNames = nicknames;
    });
  }

  editNickName(nickname: any) {
    this.addNameForm.patchValue(nickname);
    this.addNameForm.patchValue({ type: 'n' });
    this.addNameForm.updateValueAndValidity();
    this.isNickName = true;
    this.isNameEdit = true;
    this.nickname = nickname;
  }

  updateName() {
    const nameForm = this.addNameForm.getRawValue();
    if (nameForm.type === 'n') {
      const nickname = {
        personid: this.personid,
        nickname: nameForm.nickname,
        personnicknameid: this.nickname.personnicknameid
      };

      this._basicDetailsService.updateNickName(nickname).subscribe(res => {
        if (res.count) {
          this._alertService.success('Nickname updated successfully.');
          this.loadNickNames();
          this.resetNameForm();
        }
      });
    } else {
      const aliasName = {
        personid: this.personid,
        firstname: nameForm.firstname,
        lastname: nameForm.lastname,
        middlename: nameForm.middlename,
        aliasid: this.aliasname.aliasid
      };

      this._basicDetailsService.updateAliasName(aliasName).subscribe(res => {
        if (res.count) {
          this._alertService.success('Alias updated successfully.');
          this.loadAliasNames();
          this.resetNameForm();
        }
      });
    }
  }

  deleteNickName(nickname: any) {
    this._basicDetailsService.deleteNickName({ personnicknameid: nickname.personnicknameid }).subscribe(res => {
      if (res.count) {
        this._alertService.success('Nickname deleted successfully.');
        this.loadNickNames();
        this.resetNameForm();
      }
    });
  }

  resetNameForm() {
    this.addNameForm.reset();
    this.isNameEdit = false;
    this.isNickName = false;
  }

  initiateNameFormGroup() {
    this.addNameForm = this._formBuilder.group({
      lastname: ['', Validators.required],
      firstname: ['', Validators.required],
      middlename: [''],
      nickname: [''],
      type: ['']
    });
  }

  nameTypeChanged(type: any) {
    this.isNickName = (type === 'n');
    this.addNameForm.reset();
    this.addNameForm.controls['type'].setValue(type);
    if (this.isNickName) {
      this.addNameForm.controls['nickname'].setValidators(Validators.required);
      this.addNameForm.controls['lastname'].clearValidators();
      this.addNameForm.controls['firstname'].clearValidators();
      this.addNameForm.controls['nickname'].updateValueAndValidity();
      this.addNameForm.controls['lastname'].updateValueAndValidity();
      this.addNameForm.controls['firstname'].updateValueAndValidity();
    } else {
      this.addNameForm.controls['nickname'].clearValidators();
      this.addNameForm.controls['lastname'].setValidators(Validators.required);
      this.addNameForm.controls['firstname'].setValidators(Validators.required);
      this.addNameForm.controls['nickname'].updateValueAndValidity();
      this.addNameForm.controls['lastname'].updateValueAndValidity();
      this.addNameForm.controls['firstname'].updateValueAndValidity();
    }
  }

  addName() {
    const nameForm = this.addNameForm.getRawValue();
    if (nameForm.type === 'n') {
      const nickname = {
        personid: this.personid,
        nickname: nameForm.nickname
      };

      this._basicDetailsService.addNickName(nickname).subscribe(res => {
        if (res.personnicknameid) {
          this._alertService.success('Nickname added successfully.');
          this.loadNickNames();
          this.resetNameForm();
        }
      });
    } else {
      const aliasName = {
        personid: this.personid,
        firstname: nameForm.firstname,
        lastname: nameForm.lastname,
        middlename: nameForm.middlename
      };

      this._basicDetailsService.addAliasName(aliasName).subscribe(res => {
        if (res.aliasid) {
          this._alertService.success('Alias added successfully.');
          this.loadAliasNames();
          this.resetNameForm();
        }
      });
    }
  }

  loadAliasNames() {
    this._basicDetailsService.getAliasNames(this.personid).subscribe(aliasnames => {
      this.aliasNames = aliasnames;
    });
  }

  editAliasName(aliasname: any) {
    this.addNameForm.patchValue(aliasname);
    this.addNameForm.patchValue({ type: 'a' });
    this.addNameForm.updateValueAndValidity();
    this.isNickName = false;
    this.isNameEdit = true;
    this.aliasname = aliasname;
  }

  deleteAliasName(aliasname: any) {
    this._basicDetailsService.deleteAliasName({ aliasid: aliasname.aliasid }).subscribe(res => {
      if (res.count) {
        this._alertService.success('Aliasname deleted successfully.');
        this.loadAliasNames();
        this.resetNameForm();
      }
    });
  }
}
