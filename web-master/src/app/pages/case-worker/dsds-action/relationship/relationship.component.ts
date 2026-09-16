import { Component, OnInit, ElementRef, ViewChild, AfterViewInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
// import * as go from 'gojs';
import { GenogramLayout } from './genogramlayout';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { DropdownModel } from '../../../../@core/entities/common.entities';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { FormGroup, FormBuilder } from '@angular/forms';
import { AuthService } from '../../../../@core/services/auth.service';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { SessionStorageService } from '../../../../@core/services/storage.service';


interface Data {
    key: number;
    n: string;
    s: string;
    m: number;
    f: number;
    o: number;
    ux: number;
    vir: number;
    a: string;
}

export class Persondetails {
    cjamspid!: number;
    firstname!: string;
    lastname!: string;
    gendertypekey!: string;
    userphoto?: any;
    dob!: Date;
    typedescription!: string;
    age!: string;
    address!: {
        address: any;
        address2: any;
        city: any;
        country: any;
        county: any;
        zipcode: any;
    };
    phone!: {phonenumber: any;}
}

export class Relation {
    intakeservicerequestactorid!: string;
    relationshiptypekey!: string;
    description!: string;
    servicecaseid!: string;
    firstname!: string;
    lastname!: string;
}

export class Relationship {
    rownum!: string;
    personid!: string;
    intakeserviceid!: string;
    key!: string;
    fn!: string;
    ln!: string;
    s!: string;
    k!: string;
    ux?: number;
    vir?: number;
    f?: number;
    m?: number;
    o?: number;
    source!: string;
    dob!: Date;
    iscaseclient!: number;
    ishouseholdmember!: number;
    persondetails!: Persondetails;
    relation!: Relation[];
}
export class RelationUpdate {
    intakeservicerequestactorid!: string;
    personid!: string;
    relationshiptypekey!: string;
}

@Component({
    // tslint:disable-next-line: component-selector
    selector: 'relationship',
    templateUrl: './relationship.component.html',
    styleUrls: ['./relationship.component.scss'],
    standalone: false
})
export class RelationshipComponent implements OnInit, AfterViewInit {
    // private diagram: go.Diagram = new go.Diagram();
    private go!: typeof import('gojs');
    private diagram!: any;
    private id!: string;
    relationshipData: Relationship[] = [];
    personData?: Relationship[] ;
    relationShipToRADropdownItems!: DropdownModel[];
    selectedPersonsage!: number;
    relationshipForm!: FormGroup;
    RelationSaveObject!: RelationUpdate;
    diagramObj: any;
    intakeNumber: any;
    idType : any;

    @ViewChild('diagramDiv')
    private diagramRef!: ElementRef;
    constructor(private route: ActivatedRoute, private _commonHttpService: CommonHttpService,
        private _dataStoreService: DataStoreService, private formBuilder: FormBuilder, private _authService: AuthService
        , private _sessionStorage: SessionStorageService) {}
    fontstyle1 = 'bold 18px sans-serif';
    fontstyle2 = 'bold 10px sans-serif';
    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        if(this.id){
            this.initAll();
        } else {
            this.id = this._dataStoreService.getObj('intake').number;
            this.idType = 'intakenumber';
            this.initAll();
        }

    }
    initAll(){
        this.personData = [];
        // this.initializeGenograph();
        this.getRelationShip();
        this.getRelationList();
        // this.diagram.div = this.diagramRef.nativeElement;
        this.relationshipForm = this.formBuilder.group({
            actorrelationshipid: [''],
            intakeservicerequestactorid: [''],
            relationshiptypekey: [''],
            person1id: [''],
            person2id: [''],
            servicecaseid: [this.id]
        });
    }
    
    async ngAfterViewInit() {
        this.go = await import('gojs');
        
        this.initializeGenograph();
        this.diagram.div = this.diagramRef.nativeElement;
        
        document.querySelector('relationship')?.querySelector('canvas')?.style.setProperty('outline', 'none');
    }

    getRelationList() {
      this._commonHttpService.getArrayList(
          {
              where: { activeflag: 1, teamtypekey: this._authService.getAgencyName() },
              method: 'get',
              nolimit: true
          },
          CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson
              .RelationshipTypesUrl + '?filter'
      ).subscribe(data => {
          if (data && data.length) {
              this.setRelationList(data);
          }
      });
  }
    setRelationList(data: any) {
      if (data && data.length) {
          this.relationShipToRADropdownItems = data.map((res: { description: any; relationshiptypekey: any; }) => {
              return new DropdownModel({
                  text: res.description,
                  value: res.relationshiptypekey
              });
          });
      }
  }
    UpdatePersonId(relation: any) {
        this.relationshipForm.patchValue({
            actorrelationshipid: relation.actorrelationshipid,
            intakeservicerequestactorid: relation.intakeservicerequestactorid,
            person1id: relation.person1id,
            person2id: relation.person2id
        });
    }
    updateRelation() {
        this._commonHttpService.create(this.relationshipForm.value, 'Actorrelationships/addupdate').subscribe(
            (res) => {
          this.getRelationShip();
        });
    }
    filterRoles(item: { rolegrp: string | null; }) {
        if (this.selectedPersonsage === -1) {
            return false;
        } else if (this.selectedPersonsage < 18) {
            if (item.rolegrp === 'C' || item.rolegrp === null) {
                return true;
            } else {
                return false;
            }
        } else if (this.selectedPersonsage >= 18) {
            if (item.rolegrp === 'A' || item.rolegrp === null) {
                return true;
            } else {
                return false;
            }
        }
    }
    getRelationShip() {
        const isServicecase = this._dataStoreService.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        let url = '';
        let param = {};
        if (isServicecase) {
            url = 'servicecase/getpersonrelation?filter';
            param = { servicecaseid: this.id };
        } else {
            url = 'servicecase/getpersonrelationbyintakeservice?filter';
            param = { intakeserviceid: this.id,idType : this.idType };
        }

        this._commonHttpService
            .getArrayList(
                {
                    where: param,
                    method: 'get'
                },
                url
            )
            .subscribe((item) => {
                this.personData = item[0];
                this.relationshipData = item;
                this.diagramObj = item.map(values => {
                  for (const propName in values) {
                    if (values[propName] === null || values[propName] === undefined) {
                      delete values[propName];
                    }
                  }
                  return values;
                });
                this.setupDiagram(this.diagram, [...this.diagramObj], item[0].key);
            });
            const _self = this;
            this.diagram.addDiagramListener('ChangedSelection', function(e: any) {
                e.diagram.selection.each(function(node: any) {
                
                    _self.personData = _self.relationshipData.filter(itam =>  itam.key === node.key );
                });
            });
    }

    initializeGenograph() {
        const go = this.go;
        const $ = go.GraphObject.make;
        // Place GoJS license key here:
        // (go as any).licenseKey = '...'
        this.diagram = new go.Diagram();
        this.diagram.initialContentAlignment = go.Spot.Center;
        this.diagram.initialAutoScale = go.Diagram.Uniform;
        this.diagram.undoManager.isEnabled = true;
        this.diagram.nodeSelectionAdornmentTemplate = $(
            go.Adornment,
            'Auto',
            { layerName: 'Grid' }, // the predefined layer that is behind everything else
            $(go.Shape, 'RoundedRectangle', { fill: '#a6cb12', strokeWidth: 8, stroke: '#a6cb12  ' }),
            $(go.Placeholder)
        );

        this.diagram.layout = $(GenogramLayout, { direction: 90, layerSpacing: 30, columnSpacing: 10 });

        // determine the color for each attribute shape
        function attrFill(a: string): string {
            switch (a) {
                case 'A':
                    return 'green';
                case 'B':
                    return 'orange';
                case 'C':
                    return 'red';
                case 'D':
                    return 'cyan';
                case 'E':
                    return 'gold';
                case 'F':
                    return 'pink';
                case 'G':
                    return 'blue';
                case 'H':
                    return 'brown';
                case 'I':
                    return 'purple';
                case 'J':
                    return 'chartreuse';
                case 'K':
                    return 'lightgray';
                case 'L':
                    return 'magenta';
                case 'S':
                    return 'red';
                default:
                    return 'transparent';
            }
        }

        // determine the geometry for each attribute shape in a male;
        // except for the slash these are all squares at each of the four corners of the overall square
        const tlsq = go.Geometry.parse('F M1 1 l19 0 0 19 -19 0z');
        const trsq = go.Geometry.parse('F M20 1 l19 0 0 19 -19 0z');
        const brsq = go.Geometry.parse('F M20 20 l19 0 0 19 -19 0z');
        const blsq = go.Geometry.parse('F M1 20 l19 0 0 19 -19 0z');
        const slash = go.Geometry.parse('F M38 0 L40 0 40 2 2 40 0 40 0 38z');
        function maleGeometry(a: string): go.Geometry {
            switch (a) {
                case 'A':
                    return tlsq;
                case 'B':
                    return tlsq;
                case 'C':
                    return tlsq;
                case 'D':
                    return trsq;
                case 'E':
                    return trsq;
                case 'F':
                    return trsq;
                case 'G':
                    return brsq;
                case 'H':
                    return brsq;
                case 'I':
                    return brsq;
                case 'J':
                    return blsq;
                case 'K':
                    return blsq;
                case 'L':
                    return blsq;
                case 'S':
                    return slash;
                default:
                    return tlsq;
            }
        }

        // determine the geometry for each attribute shape in a female;
        // except for the slash these are all pie shapes at each of the four quadrants of the overall circle
        const tlarc = go.Geometry.parse('F M20 20 B 180 90 20 20 19 19 z');
        const trarc = go.Geometry.parse('F M20 20 B 270 90 20 20 19 19 z');
        const brarc = go.Geometry.parse('F M20 20 B 0 90 20 20 19 19 z');
        const blarc = go.Geometry.parse('F M20 20 B 90 90 20 20 19 19 z');
        function femaleGeometry(a: string): go.Geometry {
            switch (a) {
                case 'A':
                    return tlarc;
                case 'B':
                    return tlarc;
                case 'C':
                    return tlarc;
                case 'D':
                    return trarc;
                case 'E':
                    return trarc;
                case 'F':
                    return trarc;
                case 'G':
                    return brarc;
                case 'H':
                    return brarc;
                case 'I':
                    return brarc;
                case 'J':
                    return blarc;
                case 'K':
                    return blarc;
                case 'L':
                    return blarc;
                case 'S':
                    return slash;
                default:
                    return tlarc;
            }
        }

        this.diagram.nodeTemplateMap.add(
            'M', // female
            $(
                go.Node,
                'Auto',
                $(go.Shape, 'RoundedRectangle', { fill: '#113f67', stroke: '#65c6c4', strokeWidth: 1, margin: 2 }),
                $(
                    go.Panel,
                    'Vertical',
                    { width: 210 },
                    $(
                        go.Panel,
                        'Horizontal',
                        { height: 70, width: 210 },
                        $(go.Picture, { margin: 3, width: 50, height: 60 }, new go.Binding('source')),
                        $(
                            go.Panel,
                            'Vertical',
                            $(go.TextBlock, { alignment: go.Spot.Left, margin: 5, width: 140, stroke: 'whitesmoke', font: this.fontstyle1 }, new go.Binding('text', 'fn')),
                            $(go.TextBlock, { alignment: go.Spot.Left, margin: 5, width: 140, stroke: 'whitesmoke', font: this.fontstyle1 }, new go.Binding('text', 'ln'))
                        )
                    ),
                    $(
                        go.Panel,
                        'Horizontal',
                        { height: 28, width: 210, background: '#65c6c4' },
                        $(go.TextBlock, { alignment: go.Spot.Left, margin: 5, stroke: '#34699a', font: this.fontstyle2 }, 'Age: '),
                        $(go.TextBlock, { position: new go.Point(35, 0), width: 24, margin: 2, stroke: '#233142', font: 'bold 14px sans-serif' }, new go.Binding('text', 'k')),
                        $(go.TextBlock, { margin: 0, stroke: '#233142', width: 30, font: this.fontstyle2 }, 'Yrs'),
                        $(go.TextBlock, { position: new go.Point(90, 0), width: 30, margin: 2, stroke: '#34699a', font: this.fontstyle2 }, 'Dob: '),
                        $(go.TextBlock, { width: 100, margin: 2, stroke: '#233142', font: 'bold 12px sans-serif' }, new go.Binding('text', 'reciprocal'))
                    )
                  )
                )
            );

        this.diagram.nodeTemplateMap.add(
            'F', // female
            $(
                go.Node,
                'Auto',
                $(go.Shape, 'RoundedRectangle', { fill: '#f6b8d1', stroke: '#65c6c4', strokeWidth: 1, margin: 2 }),
                $(
                    go.Panel,
                    'Vertical',
                    { width: 210 },
                    $(
                        go.Panel,
                        'Horizontal',
                        { height: 70, width: 210 },
                        $(go.Picture, { margin: 3, width: 50, height: 60 }, new go.Binding('source')),
                        $(
                            go.Panel,
                            'Vertical',
                            $(go.TextBlock, { alignment: go.Spot.Left, margin: 5, width: 140, stroke: '#d52484', font: this.fontstyle1 }, new go.Binding('text', 'fn')),
                            $(go.TextBlock, { alignment: go.Spot.Left, margin: 5, width: 140, stroke: '#d52484', font: this.fontstyle1 }, new go.Binding('text', 'ln'))
                        )
                    ),
                    $(
                        go.Panel,
                        'Horizontal',
                        { height: 30, width: 210, background: '#d84c73' },
                        $(go.TextBlock, { alignment: go.Spot.Left, margin: 5, stroke: '#ffd3de', font: this.fontstyle2 }, 'Age: '),
                        $(go.TextBlock, { position: new go.Point(35, 0), width: 24, margin: 2, stroke: '#fefcdb', font: 'bold 14px sans-serif' }, new go.Binding('text', 'k')),
                        $(go.TextBlock, { margin: 0, stroke: '#fefcdb', width: 30, font: this.fontstyle2 }, 'Yrs'),
                        $(go.TextBlock, { position: new go.Point(90, 0), width: 30, margin: 2, stroke: '#ffd3de', font: this.fontstyle2 }, 'Dob: '),
                        $(go.TextBlock, { width: 100, margin: 2, stroke: '#fefcdb', font: 'bold 12px sans-serif' }, new go.Binding('text', 'dob'))
                    )
                )
            )
        );

        this.diagram.nodeTemplateMap.add('LinkLabel', $(go.Node, { selectable: false, width: 1, height: 1, fromEndSegmentLength: 20 }));

        this.diagram.linkTemplate = $( // for parent-child relationships
            go.Link,
            {
                routing: go.Link.Orthogonal,
                curviness: 10,
                layerName: 'Background',
                selectable: false,
                fromSpot: go.Spot.Bottom,
                toSpot: go.Spot.Top
            },
            $(go.Shape, { strokeWidth: 2 })
        );

        this.diagram.linkTemplateMap.add(
            'Marriage', // for marriage relationships
            $(go.Link, { selectable: false }, $(go.Shape, { strokeWidth: 4, stroke: '#ff5733' }))
        );
    }

    // create and initialize the Diagram.model given an array of node data representing people
    setupDiagram(diagram: go.Diagram, array: Array<Object>, focusId: number) {
        const go = this.go;
        diagram.model = go.GraphObject.make(go.GraphLinksModel, {
            // declare support for link label nodes
            linkLabelKeysProperty: 'labelKeys',
            // this property determines which template is used
            nodeCategoryProperty: 's',
            // create all of the nodes for people
            nodeDataArray: array
        });
        this.setupMarriages(diagram);
        this.setupParents(diagram);

        const node = diagram.findNodeForKey(focusId);
        if (node !== null) {
            diagram.select(node);
        }
    }

    findMarriage(diagram: go.Diagram, a: number, b: number) {
        // A and B are node keys
        const nodeA = diagram.findNodeForKey(a);
        const nodeB = diagram.findNodeForKey(b);
        if (nodeA !== null && nodeB !== null) {
            const it = nodeA.findLinksBetween(nodeB); // in either direction
            while (it.next()) {
                const link = it.value;
                // Link.data.category === 'Marriage' means it's a marriage relationship
                if (link.data !== null && link.data.category === 'Marriage') {
                    return link;
                }
            }
        }
        return null;
    }

    // now process the node data to determine marriages
    setupMarriages(diagram: go.Diagram) {
        const model = diagram.model as go.GraphLinksModel;
        const nodeDataArray = model.nodeDataArray;
    
        for (const i in nodeDataArray) {
            const data = nodeDataArray[i] as Data;
            const key = data.key;
    
            // Handle ux (wives) if defined
            this.handleWivesFn(data, key, diagram, model);
    
            // Handle vir (husbands) if defined
            this.handleHusbandsFn(data, key, diagram, model);
        }
    }
    // Assosiated with setupMarriages method
    private handleWivesFn(data: Data, key: number, diagram: go.Diagram, model: go.GraphLinksModel) {
        if (data.ux !== undefined) {
            const uxs: number[] = (typeof data.ux === 'number') ? [data.ux] : data.ux as number[];
            for (const wife of uxs) {
                if (key !== wife) {
                    this.handleReusableLinkFn(diagram, key, wife, model);
                }
            }
        }
    }
    // Assosiated with setupMarriages method
    private handleHusbandsFn(data: Data, key: number, diagram: go.Diagram, model: go.GraphLinksModel) {
        if (data.vir !== undefined) {
            const virs: number[] = (typeof data.vir === 'number') ? [data.vir] : data.vir as number[];
            for (const husband of virs) {
                if (key !== husband) {
                    this.handleReusableLinkFn(diagram, key, husband, model);
                }
            }
        }
    }
    // Assosiated with setupMarriages method
    private handleReusableLinkFn(diagram: go.Diagram, key: number, to: any, model: go.GraphLinksModel) {
        const link = this.findMarriage(diagram, key, to);
        if (link === null) {
            // add a label node for the marriage link
            const mlab = { s: 'LinkLabel' } as Data;
            model.addNodeData(mlab);
            // add the marriage link itself, also referring to the label node
            const mdata = { from: key, to: to, labelKeys: [mlab.key], category: 'Marriage' };
            model.addLinkData(mdata);
        }
    }

    // process parent-child relationships once all marriages are known
    setupParents(diagram: go.Diagram) {
        const model = diagram.model as go.GraphLinksModel;
        const nodeDataArray = model.nodeDataArray;
        for(let element of nodeDataArray){
            const data = element as Data;     
            const key = data.key;
            const mother = data.m;
            const father = data.f;
            if (!this.checkIfMotherOrFatherFn(mother, father)) {
                this.checkElseLinkIsNullFn(data, model);
                continue;
            }
            const link = this.findMarriage(diagram, mother, father);
            if (link === null) {
                // or warn no known mother or no known father or no known marriage between them
                this.checkIfLinkIsNullFn(mother, father, data, model);
                continue;
            }
            const mdata = link.data;
            const mlabkey = mdata.labelKeys[0];
            const cdata = { from: mlabkey, to: key };
            model.addLinkData(cdata);
            // } else {
            // }
        }
    }
    // Assosiated with setupParents method
    private checkElseLinkIsNullFn(data: Data, model: go.GraphLinksModel) {
        let sData = {};
        if (data.m > 0) {
            sData = { from: data.m, to: data.key };
            model.addLinkData(sData);
        }
        if (data.f > 0) {
            sData = { from: data.f, to: data.key };
            model.addLinkData(sData);
        }
        if (data.o > 0) {
            sData = { from: data.o, to: data.key };
            model.addLinkData(sData);
        }
    }
    // Assosiated with setupParents method
    private checkIfLinkIsNullFn(mother: number, father: number, data: Data, model: go.GraphLinksModel) {
        if (window.console) {
            window.console.log('unknown marriage: ' + mother + ' & ' + father);
        }
        let sData = {};
        if (data.m > 0) {
            sData = { from: data.m, to: data.key };
            model.addLinkData(sData);
        }
        if (data.f > 0) {
            sData = { from: data.f, to: data.key };
            model.addLinkData(sData);
        }
    }
    // Assosiated with setupParents method
    private checkIfMotherOrFatherFn(mother: number, father: number) {
        return (mother !== undefined && father !== undefined);
    }
}
