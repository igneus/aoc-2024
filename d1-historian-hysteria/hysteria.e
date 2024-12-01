class HYSTERIA
-- https://adventofcode.com/2024/day/1
-- Standalone program.
-- Reads stdin, prints the result.

create {ANY}
   main

feature {ANY}
   main
      local
         a, b: ARRAY[INTEGER]
         sorter: COLLECTION_SORTER[INTEGER]
         str: STRING
         i, total: INTEGER
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

         total := 0
         from
            i := 1
         until
            i > a.count
         loop
            total := total + (a.item (i) - b.item (i)).abs

            i := i + 1
         end

         io.put_integer (total)
         io.put_new_line
      end

end
