import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SpecificHealthIssuesComponent } from './specific-health-issues.component';

describe('SpecificHealthIssuesComponent', () => {
  let component: SpecificHealthIssuesComponent;
  let fixture: ComponentFixture<SpecificHealthIssuesComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SpecificHealthIssuesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SpecificHealthIssuesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
