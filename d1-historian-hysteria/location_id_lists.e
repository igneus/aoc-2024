-- encapsulates the input data
class LOCATION_ID_LISTS

create {ANY}
   make

feature {ANY}
   a, b: ARRAY[INTEGER]

feature {ANY}
   make -- read input data from stdin
      local
         sorter: COLLECTION_SORTER[INTEGER]
         str: STRING
      do
         create a.make (1, 500)
         create b.make (1, 500)
         create str.make (6)

         from
            io.read_line
         until
            io.end_of_input
         loop
            str.copy_substring (io.last_string, 1, 5)
            a.add_last (str.to_integer)

            str.copy_substring (io.last_string, 9, 13)
            b.add_last (str.to_integer)

            io.read_line
         end

         sorter.sort (a)
         sorter.sort (b)
      end

end

