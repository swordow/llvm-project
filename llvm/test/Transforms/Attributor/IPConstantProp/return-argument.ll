; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --function-signature --scrub-attributes
; RUN: opt -S -passes=attributor -aa-pipeline='basic-aa' -attributor-disable=false -attributor-max-iterations-verify -attributor-max-iterations=8 < %s | FileCheck %s

;; This function returns its second argument on all return statements
define internal i32* @incdec(i1 %C, i32* %V) {
; CHECK-LABEL: define {{[^@]+}}@incdec
; CHECK-SAME: (i1 [[C:%.*]], i32* noalias nofree nonnull returned align 4 dereferenceable(4) [[V:%.*]])
; CHECK-NEXT:    [[X:%.*]] = load i32, i32* [[V]], align 4
; CHECK-NEXT:    br i1 [[C]], label [[T:%.*]], label [[F:%.*]]
; CHECK:       T:
; CHECK-NEXT:    [[X1:%.*]] = add i32 [[X]], 1
; CHECK-NEXT:    store i32 [[X1]], i32* [[V]], align 4
; CHECK-NEXT:    ret i32* [[V]]
; CHECK:       F:
; CHECK-NEXT:    [[X2:%.*]] = sub i32 [[X]], 1
; CHECK-NEXT:    store i32 [[X2]], i32* [[V]], align 4
; CHECK-NEXT:    ret i32* [[V]]
;
  %X = load i32, i32* %V
  br i1 %C, label %T, label %F

T:              ; preds = %0
  %X1 = add i32 %X, 1
  store i32 %X1, i32* %V
  ret i32* %V

F:              ; preds = %0
  %X2 = sub i32 %X, 1
  store i32 %X2, i32* %V
  ret i32* %V
}

;; This function returns its first argument as a part of a multiple return
;; value
define internal { i32, i32 } @foo(i32 %A, i32 %B) {
; CHECK-LABEL: define {{[^@]+}}@foo
; CHECK-SAME: (i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[X:%.*]] = add i32 [[A]], [[B]]
; CHECK-NEXT:    [[Y:%.*]] = insertvalue { i32, i32 } undef, i32 [[A]], 0
; CHECK-NEXT:    [[Z:%.*]] = insertvalue { i32, i32 } [[Y]], i32 [[X]], 1
; CHECK-NEXT:    ret { i32, i32 } [[Z]]
;
  %X = add i32 %A, %B
  %Y = insertvalue { i32, i32 } undef, i32 %A, 0
  %Z = insertvalue { i32, i32 } %Y, i32 %X, 1
  ret { i32, i32 } %Z
}

define void @caller(i1 %C) personality i32 (...)* @__gxx_personality_v0 {
; CHECK-LABEL: define {{[^@]+}}@caller
; CHECK-SAME: (i1 [[C:%.*]]) #2 personality i32 (...)* @__gxx_personality_v0
; CHECK-NEXT:    [[Q:%.*]] = alloca i32
; CHECK-NEXT:    [[W:%.*]] = call align 4 i32* @incdec(i1 [[C]], i32* noalias nofree nonnull align 4 dereferenceable(4) [[Q]])
; CHECK-NEXT:    [[S1:%.*]] = call { i32, i32 } @foo(i32 1, i32 2)
; CHECK-NEXT:    [[X1:%.*]] = extractvalue { i32, i32 } [[S1]], 0
; CHECK-NEXT:    [[S2:%.*]] = invoke { i32, i32 } @foo(i32 3, i32 4)
; CHECK-NEXT:    to label [[OK:%.*]] unwind label [[LPAD:%.*]]
; CHECK:       OK:
; CHECK-NEXT:    [[X2:%.*]] = extractvalue { i32, i32 } [[S2]], 0
; CHECK-NEXT:    [[Z:%.*]] = add i32 [[X1]], [[X2]]
; CHECK-NEXT:    store i32 [[Z]], i32* [[W]], align 4
; CHECK-NEXT:    br label [[RET:%.*]]
; CHECK:       LPAD:
; CHECK-NEXT:    [[EXN:%.*]] = landingpad { i8*, i32 }
; CHECK-NEXT:    cleanup
; CHECK-NEXT:    br label [[RET]]
; CHECK:       RET:
; CHECK-NEXT:    ret void
;
  %Q = alloca i32
  ;; Call incdec to see if %W is properly replaced by %Q
  %W = call i32* @incdec(i1 %C, i32* %Q )             ; <i32> [#uses=1]
  ;; Call @foo twice, to prevent the arguments from propagating into the
  ;; function (so we can check the returned argument is properly
  ;; propagated per-caller).
  %S1 = call { i32, i32 } @foo(i32 1, i32 2)
  %X1 = extractvalue { i32, i32 } %S1, 0
  %S2 = invoke { i32, i32 } @foo(i32 3, i32 4) to label %OK unwind label %LPAD

OK:
  %X2 = extractvalue { i32, i32 } %S2, 0
  ;; Do some stuff with the returned values which we can grep for
  %Z  = add i32 %X1, %X2
  store i32 %Z, i32* %W
  br label %RET

LPAD:
  %exn = landingpad {i8*, i32}
  cleanup
  br label %RET

RET:
  ret void
}

declare i32 @__gxx_personality_v0(...)
