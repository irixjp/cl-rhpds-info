(defpackage cl-rhpds-info/tests/main
  (:use :cl
        :cl-rhpds-info
        :rove))
(in-package :cl-rhpds-info/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-rhpds-info)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
