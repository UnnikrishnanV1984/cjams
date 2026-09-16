import { Component, OnInit } from '@angular/core';
import { RelationshipService } from '../relationship.service';
import { PersonRelation } from '../../../../@core/common/models/involvedperson.data.model';
import { CommonDropdownsService, AlertService } from '../../../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { PersonDetailsService } from '../../person-details.service';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'relative-person-grid',
    templateUrl: './relative-person-grid.component.html',
    styleUrls: ['./relative-person-grid.component.scss'],
    standalone: false
})
export class RelativePersonGridComponent implements OnInit {

  relativePersons: PersonRelation[] = [];
  relationShipDropdownItems: any[] = [];
  relationshipTypeKey: string | null =null;
  personid: string | null | undefined;
  deleteRelativePersonid!: string;
  isEditable: boolean;
  action: string | null | undefined;
  relationshipType!: string | null | undefined;
  inCustody!: boolean;
  livingWith!: boolean;
  relationshipTypeListMain: any [] = [
    {key : 'P', text: 'Primary' },
    {key : 'S', text: 'Secondary' },
    {key : 'O', text: 'Other' }
  ];
  relationshipTypeList: any[] = [];
  constructor(private dropdownService: CommonDropdownsService,
    private relationshipService: RelationshipService,
    public personService: PersonDetailsService,
    private route: ActivatedRoute,
    private alertService: AlertService) {
    this.route.data.subscribe(res => {
      relationshipService.relativePersons = res.relations;
      this.relativePersons = relationshipService.relativePersons;
    });
    this.personid = this.route.snapshot.parent?.parent?.parent?.paramMap.get('personid');
    this.action = this.route.snapshot.parent?.parent?.parent?.paramMap.get('action');
    this.isEditable = (this.action === 'edit') ? true : false;
  }

  ngOnInit() {
    this.loadDropdowns();
    this.getRelationshipinOrder();
  }

  getRelationshipinOrder() {
    let relationShipList = [...this.relativePersons];
    const findPrimary = relationShipList.find(data => data.relationcategory === 'P');
    const findSecondary = relationShipList.find(data => data.relationcategory === 'S');
    this.relativePersons = [];
    if (findPrimary) {
      this.relativePersons.push(findPrimary);
    }
    if (findSecondary) {
      this.relativePersons.push(findSecondary);
    }
    relationShipList = relationShipList.filter(data => (data.relationcategory !== 'P' && data.relationcategory !== 'S'));
    this.relativePersons = [...this.relativePersons, ...relationShipList];
  }

  private loadDropdowns() {
    if (!this.dropdownService.personRelations) {
      this.dropdownService.getRelations().subscribe(relations => {
        this.dropdownService.personRelations = relations;
        this.relationShipDropdownItems = this.dropdownService.personRelations;
      });
    } else {
      this.relationShipDropdownItems = this.dropdownService.personRelations;
    }
  }

  editRelation(index: number, person: PersonRelation) {
    this.resetRelativePerson();
    if (person.relationcategory === 'P') {
      const secondary = this.relativePersons.find(data => (data.relationcategory === 'S'));
      if (secondary) {
        this.relationshipTypeList = this.relationshipTypeListMain.filter(data => data.key !== secondary.relationcategory);
      }
    } else if (person.relationcategory === 'S') {
      const primary = this.relativePersons.find(data => (data.relationcategory === 'P'));
      if (primary) {
        this.relationshipTypeList = this.relationshipTypeListMain.filter(data => data.key !== primary.relationcategory);
      }
    } else {
      this.relationshipTypeList = this.relationshipTypeListMain;
    }
    this.relativePersons[index].onEdit = true;
  }

  resetRelativePerson() {
    this.relationshipTypeKey = null;
    this.livingWith = false;
    this.inCustody = false;
    this.relationshipType = null;
    this.relativePersons.forEach(rp => {
      rp.onEdit = false;
    });
  }

  deleteRelation(personRelation: PersonRelation) {
    this.deleteRelativePersonid = personRelation.personrelationid;
  }

  updateRelatedPerson(personRelation: PersonRelation) {
    const relation: PersonRelation = new PersonRelation();
    relation.personid = this.personService.person.personid;
    relation.personrelationid = personRelation.personrelationid;
    relation.personrelativeid = personRelation.personrelativeid;
    relation.actorrelationshipkey = this.relationshipTypeKey;
    relation.relationcategory = this.relationshipType;
    relation.livingwith = this.livingWith;
    relation.incustody = this.inCustody;
    this.relationshipService.updateRelation(relation)
      .subscribe((_response: any) => {
        this.alertService.success('Person relationship updated sucessfully');
        this.resetRelativePerson();
        this.reloadPersonRelations(this.personid);
      }, (_error: any) => {
        this.alertService.error('Person relationship not updated');
      });

  }

  deleteRelationshipConfirm() {
    this.relationshipService.deleteRelation(this.deleteRelativePersonid)
      .subscribe(() => {
        this.alertService.success('Person relationship deleted sucessfully');
        this.resetRelativePerson();
        this.reloadPersonRelations(this.personid);
      }, (_error: any) => {
        this.alertService.error('Person relationship not deleted');
      });
  }

  reloadPersonRelations(personid: string | null | undefined) {
    this.relationshipService.getPersonRelations(personid).subscribe(response => {
      this.relativePersons = response;
    });
  }

}
