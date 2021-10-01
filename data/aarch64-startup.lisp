(defconstant +symexec-crc32-channels+ 0x10fd0)

(defmethod init ()
  (let ((stdin (malloc (sizeof ptr_t))))
    (write-word ptr_t +symexec-crc32-channels+ stdin)
    (write-word ptr_t stdin 0)))
