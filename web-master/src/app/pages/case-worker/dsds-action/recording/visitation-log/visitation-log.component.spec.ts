import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { VisitationLogComponent } from './visitation-log.component';

describe('VisitationLogComponent', () => {
  let component: VisitationLogComponent;
  let fixture: ComponentFixture<VisitationLogComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ VisitationLogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(VisitationLogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
