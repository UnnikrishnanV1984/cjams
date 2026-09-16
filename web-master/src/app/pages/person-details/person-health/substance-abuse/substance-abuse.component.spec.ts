import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SubstanceAbuseComponent } from './substance-abuse.component';

describe('SubstanceAbuseComponent', () => {
  let component: SubstanceAbuseComponent;
  let fixture: ComponentFixture<SubstanceAbuseComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SubstanceAbuseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SubstanceAbuseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
