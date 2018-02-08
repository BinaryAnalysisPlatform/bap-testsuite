;; for the invoke-procedure we need a type of the invoked function
;; so, the function must be present in the static representation of a program.

(require pointers)
(require memory)
(require string)
(require putchar)
(require primus)

(defun malloc (n)
  "allocates a memory region of size N"
  (declare (external "malloc"))
  (if (= n 0) brk
    (let ((ptr brk)
          (failed (memory-allocate ptr n)))
      (if failed 0
        (set brk (+ brk n))
        ptr))))

;; in our simplistic malloc implementation, free is just a nop
(defun free (p)
  "frees the memory region pointed by P"
  (declare (external "free")))

(defun init (main argc argv auxv)
  "GNU libc initialization stub"
  (declare (external "__libc_start_main")
           (context (abi "mips64")))
  (set T9 main)
  (msg "we are here $main")
  (exit-with (invoke-subroutine main argc argv)))

;; Although CRT statically adds its stuff to each binary we will stub it,
;; since CRT uses segmented memory model to access TLS data, and the this
;; model is not currently supported by our lifter. Until we add a support
;; at least partial, we need to bypass this function.
