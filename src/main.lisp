(defpackage cl-rhpds-info
  (:use :cl)
  (:import-from :cl-ppcre)
  (:import-from :dexador)
  (:import-from :plump)
  (:import-from :clss)
  (:export :make-ansible-inventory
           :students-info-list))
(in-package :cl-rhpds-info)

(defun node-text (node)
  "retrive text data from elements"
  (let ((text-list nil))
    (plump:traverse node
                    (lambda (node) (push (plump:text node) text-list))
                    :test #'plump:text-node-p)
    (apply #'concatenate 'string (nreverse text-list))))

(defun stundet-info (student)
  (let ((name
         (multiple-value-bind (q r)
             (ppcre:scan-to-strings "username:\\n +([a-zA-Z]+[0-9]+)" student)
           (aref r 0)))
        (password
         (multiple-value-bind (q r)
             (ppcre:scan-to-strings "password:\\n +([a-zA-Z0-9]+)" student)
           (aref r 0)))
        (ip_addr
         (multiple-value-bind (q r)
             (ppcre:scan-to-strings "IP Address:\\n +([0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+)" student)
           (aref r 0))))
    (list :name name :password password :ip_addr ip_addr)))

(defun students-info-list (url)
  (let ((root-element (plump:parse (dex:get url))))
    (mapcar
     (lambda (node) (stundet-info
                     (node-text
                      (aref (clss:select ".content" node) 0))))
     (coerce (clss:select ".student_logins" root-element) 'list))))

(defun make-ansible-inventory (list)
  (loop :for i :in list
     :do
       (format t "~A ansible_user=~A ansible_password=~A~%"
               (getf i :ip_addr)
               (getf i :name)
               (getf i :password))))

;; blah blah blah.
