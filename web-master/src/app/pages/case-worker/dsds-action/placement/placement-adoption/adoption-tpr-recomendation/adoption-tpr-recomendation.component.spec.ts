import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionTprRecomendationComponent } from './adoption-tpr-recomendation.component';

describe('AdoptionTprRecomendationComponent', () => {
  let component: AdoptionTprRecomendationComponent;
  let fixture: ComponentFixture<AdoptionTprRecomendationComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionTprRecomendationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionTprRecomendationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
