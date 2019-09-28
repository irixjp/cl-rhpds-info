(defsystem "cl-rhpds-info"
  :version "0.1.0"
  :author ""
  :license ""
  :depends-on ("cl-ppcre"
               "dexador"
               "plump"
               "clss")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "cl-rhpds-info/tests"))))

(defsystem "cl-rhpds-info/tests"
  :author ""
  :license ""
  :depends-on ("cl-rhpds-info"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-rhpds-info"
  :perform (test-op (op c) (symbol-call :rove :run c)))
