module EFIValidate
  class EALFHeader < IOStruct.new 'a4LLC',
                                  :ealf_magic,
                                  :ealf_rows,
                                  :ealf_size,
                                  :ealf_hash_function,
                                  :ealf_zeros,
                                  :ealf_row_offset,
                                  :ealf_signature_size

    EALF_MAGIC = 'EALF'.freeze

    EALF_ROW_SIZE = 28

    EALF_HASH_FUNCTIONS = { 0 => { size: 20, function: nil }, 1 => { size: 32, funciton: nil } }

    EALF_HASH_SHA1 = 0
    EALF_HASH_SHA256 = 1

    def row_size
      EALF_ROW_SIZE + self.hash_size
    end

    def hash_size
      EFIValidate::EALFHeader::EALF_HASH_FUNCTIONS[self.ealf_hash_function][:size]
    end
  end
end