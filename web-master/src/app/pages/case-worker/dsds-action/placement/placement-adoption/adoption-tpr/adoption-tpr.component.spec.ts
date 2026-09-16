import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionTprComponent } from './adoption-tpr.component';

describe('AdoptionTprComponent', () => {
  let component: AdoptionTprComponent;
  let fixture: ComponentFixture<AdoptionTprComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionTprComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionTprComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
