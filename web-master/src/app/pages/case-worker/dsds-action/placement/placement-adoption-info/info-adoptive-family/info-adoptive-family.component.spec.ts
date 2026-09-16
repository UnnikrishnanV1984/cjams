import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { InfoAdoptiveFamilyComponent } from './info-adoptive-family.component';

describe('InfoAdoptiveFamilyComponent', () => {
  let component: InfoAdoptiveFamilyComponent;
  let fixture: ComponentFixture<InfoAdoptiveFamilyComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ InfoAdoptiveFamilyComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(InfoAdoptiveFamilyComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
