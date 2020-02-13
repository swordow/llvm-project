; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -vector-combine -S -mtriple=x86_64-- | FileCheck %s

define i8 @ext0_ext0_add(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext0_ext0_add(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = add i8 %e0, %e1
  ret i8 %r
}

define i8 @ext1_ext1_add_flags(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_add_flags(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 1
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = add nuw nsw i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = add nsw nuw i8 %e0, %e1
  ret i8 %r
}

define i8 @ext1_ext1_shl(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext1_ext1_shl(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 1
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = shl i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 1
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = shl i8 %e0, %e1
  ret i8 %r
}

define i8 @ext13_ext13_mul(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext13_ext13_mul(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 13
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 13
; CHECK-NEXT:    [[R:%.*]] = mul i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 13
  %e1 = extractelement <16 x i8> %y, i32 13
  %r = mul i8 %e0, %e1
  ret i8 %r
}

define i8 @ext0_ext0_sdiv(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext0_ext0_sdiv(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 0
; CHECK-NEXT:    [[R:%.*]] = sdiv i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 0
  %r = sdiv i8 %e0, %e1
  ret i8 %r
}

define double @ext0_ext0_fadd(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext0_ext0_fadd(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <2 x double> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <2 x double> [[Y:%.*]], i32 0
; CHECK-NEXT:    [[R:%.*]] = fadd double [[E0]], [[E1]]
; CHECK-NEXT:    ret double [[R]]
;
  %e0 = extractelement <2 x double> %x, i32 0
  %e1 = extractelement <2 x double> %y, i32 0
  %r = fadd double %e0, %e1
  ret double %r
}

define double @ext1_ext1_fsub(<2 x double> %x, <2 x double> %y) {
; CHECK-LABEL: @ext1_ext1_fsub(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <2 x double> [[X:%.*]], i32 1
; CHECK-NEXT:    [[E1:%.*]] = extractelement <2 x double> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = fsub fast double [[E0]], [[E1]]
; CHECK-NEXT:    ret double [[R]]
;
  %e0 = extractelement <2 x double> %x, i32 1
  %e1 = extractelement <2 x double> %y, i32 1
  %r = fsub fast double %e0, %e1
  ret double %r
}

define i8 @ext0_ext1_add(<16 x i8> %x, <16 x i8> %y) {
; CHECK-LABEL: @ext0_ext1_add(
; CHECK-NEXT:    [[E0:%.*]] = extractelement <16 x i8> [[X:%.*]], i32 0
; CHECK-NEXT:    [[E1:%.*]] = extractelement <16 x i8> [[Y:%.*]], i32 1
; CHECK-NEXT:    [[R:%.*]] = add i8 [[E0]], [[E1]]
; CHECK-NEXT:    ret i8 [[R]]
;
  %e0 = extractelement <16 x i8> %x, i32 0
  %e1 = extractelement <16 x i8> %y, i32 1
  %r = add i8 %e0, %e1
  ret i8 %r
}
