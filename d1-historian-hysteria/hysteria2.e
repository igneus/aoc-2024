class HYSTERIA2
-- https://adventofcode.com/2024/day/1 , part 2
-- Standalone program.
-- Reads stdin, prints the result.

create {ANY}
   main

feature {ANY}
   main
      local
         data: LOCATION_ID_LISTS
         i, total: INTEGER
         cursor: SORTED_COLLECTION_COUNT_CURSOR[INTEGER]
      do
         create data.make
         create cursor.make (data.b)

         total := 0
         from
            i := data.a.lower
         until
            i > data.a.upper
         loop
            total := total + (data.a.item (i) * cursor.count (data.a.item (i)))

            i := i + 1
         end

         io.put_integer (total)
         io.put_new_line
      end

end
