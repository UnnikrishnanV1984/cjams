import { ComponentFixture, TestBed } from '@angular/core/testing';
import { FamilyFindingsComponent } from './family-findings.component';
import { describe, beforeEach, it } from 'node:test';

describe('FamilyFindingsComponent', () => {
  let component: FamilyFindingsComponent;
  let fixture: ComponentFixture<FamilyFindingsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FamilyFindingsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(FamilyFindingsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});