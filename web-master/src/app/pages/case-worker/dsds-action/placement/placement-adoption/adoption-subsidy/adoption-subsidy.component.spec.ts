import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionSubsidyComponent } from './adoption-subsidy.component';

describe('AdoptionSubsidyComponent', () => {
  let component: AdoptionSubsidyComponent;
  let fixture: ComponentFixture<AdoptionSubsidyComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionSubsidyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionSubsidyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
