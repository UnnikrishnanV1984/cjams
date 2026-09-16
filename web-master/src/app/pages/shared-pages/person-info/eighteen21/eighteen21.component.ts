import { Component } from '@angular/core';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { PersonInfoService } from '../person-info.service';
import {orderBy as _orderBy } from 'lodash';  //SonarQube fix -Remove this unused import of '_uniq', '_uniqBy'.

@Component({
    selector: 'eighteen21',
    templateUrl: './eighteen21.component.html',
    styleUrls: ['./eighteen21.component.scss'],
    standalone: false
})
export class Eighteen21Component {
  secondarySchool:any= [];
  vocational:any= [];
  activity:any= [];
  employer:any= [];
  personDisabilities :any= [];
  answers:any= {};
  answerloaded:boolean= false;
  programsloaded:boolean= false;
  narrativeInfo:any=[];
  personid: string='';
  narrativeuniqueInfo:any=[];
  education = {
    'secondary' : false,
    'postSecondary': false
  };
  yesDisablities = [];
  constructor(
    private readonly _commonHttpService: CommonHttpService, //SonarQube - Members are never reassigned; marked it as `readonly`.
    private readonly _personInfoService: PersonInfoService

    ) {

      if (this._personInfoService.personInfo && this._personInfoService.personInfo.personbasicdetails) {
        this.personid = this._personInfoService.personInfo.personbasicdetails.personid;
        this.load18to21Details(this.personid);

      }
      const _self = this; //SonarQube - revrted back the _self assignment changes
      this._personInfoService.personInfoListener$.subscribe(personInfo => {
        if (!_self.personid || _self.personid === '') {
          this.personid = personInfo.personbasicdetails.personid;
          this.load18to21Details(this.personid);

        }
      });
    }

  loadNarrativeDetails(personid:any) {
    this.getNarrativeDetails(personid).subscribe(workdetails => {
      this.programsloaded = true;
      this.narrativeInfo = workdetails;
      this.narrativeuniqueInfo = [];
   
      //SonarQube fix - used single for-of loop instead of the 2 for loops above
      for(const i of this.narrativeInfo){
        const promotedemploymentprogramname = i.promotedemploymentprogramname;
        if (promotedemploymentprogramname) {
          this.narrativeuniqueInfo.push(i);
        }
      }
    });

    this.getEducation(personid).subscribe((response:any) =>{
      this.education['secondary'] = false;
      this.education['postSecondary'] = false;
      const secondaryList  = ['GDSI','GDSE','GDEI','GDNI','GDTE','GDEL','GDTWL'];
      const personEdu =  _orderBy( response['personEducation'], ['startdate'],['desc']);
      if(personEdu && personEdu.length > 0){
        personEdu.forEach(e => {
          if(secondaryList.includes(e.currentgradetypekey)){
            this.education['secondary'] = true;
          }
          if('COLLG' === e.schoolenrolltypekey || e.schoolenrolltypekey ==='PSEOT'){
            this.education['postSecondary'] = true;
          }
        });
      }
    });
    this.getDisablity(personid).subscribe(response =>{
      if (response && Array.isArray(response) && response.length) {
        this.personDisabilities = response;
        this.yesDisablities = this.personDisabilities.filter((pd:any )=> pd.disabilityconditiontypekey === 'Yes');
      }
    });
  }
  load18to21Details(personid:any) {
    this.load18to21answer(personid).subscribe(answer  => {
      this.answers = answer;
      this.answerloaded = true;

    });
    this.loadNarrativeDetails(personid);
  }
  getEducation(personid:any){
    return this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        method: 'get',
        where: { personid: personid },
        page: 1, 
        limit: 10
      }),
    'personeducation/educationlist' + '?filter'
    );
  }
  getDisablity(personid:any){
    return this._commonHttpService
    .getPagedArrayList(
      new PaginationRequest({
        page: 1,
        limit: 20,
        method: 'get',
        where: { personid: personid }
      }),
      'People/getpersondisability?filter'
    );
  }
  load18to21answer(personid:any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personid }
        }),
        'People/get18to21answer?filter'
      );
  }
  getNarrativeDetails(personid:any) {
    return this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          method: 'get',
          where: { personid: personid }
        }),
        'People/getpersonworknarrative?filter'
      );
  }
}
