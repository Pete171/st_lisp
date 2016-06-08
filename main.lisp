(defpackage :st
  (:use :common-lisp))

(in-package :st)

(defclass <request> () (
  (data 
   :initform (make-hash-table :test 'equal)
   :reader request-data)))

(defclass <requests> () (
  (requests
    :initform ()
    :reader requests)))

(defgeneric add-request (request requests))

(defmethod add-request ((request <request>) (requests <requests>))
  (when (gethash "datacenterurl" (request-data request))
    (error "Request cannot contain the datacenterurl when using the Requests object."))
  (push request (slot-value requests 'requests)))

;;;; START CLIENT CODE EXAMPLE

(defparameter *request* (make-instance '<request>))
(defparameter *requests* (make-instance '<requests>))

(print (request-data *request*))
(setf (gethash "key" (request-data *request*)) "value")
;(setf (gethash "datacenterurl" (request-data *request*)) "value2")
(print (request-data *request*))

(add-request *request* *requests*)
(print (requests *requests*))
