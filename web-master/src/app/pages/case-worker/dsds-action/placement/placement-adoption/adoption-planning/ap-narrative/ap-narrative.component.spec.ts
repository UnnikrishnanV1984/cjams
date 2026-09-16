import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApNarrativeComponent } from './ap-narrative.component';

describe('ApNarrativeComponent', () => {
  let component: ApNarrativeComponent;
  let fixture: ComponentFixture<ApNarrativeComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApNarrativeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApNarrativeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
