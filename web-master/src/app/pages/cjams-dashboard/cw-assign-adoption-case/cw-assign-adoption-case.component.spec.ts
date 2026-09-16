import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CwAssignAdoptionCaseComponent } from './cw-assign-adoption-case.component';

describe('CwAssignAdoptionCaseComponent', () => {
  let component: CwAssignAdoptionCaseComponent;
  let fixture: ComponentFixture<CwAssignAdoptionCaseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CwAssignAdoptionCaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CwAssignAdoptionCaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
