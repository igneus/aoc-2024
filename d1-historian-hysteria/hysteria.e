class HYSTERIA
-- https://adventofcode.com/2024/day/1
-- Standalone program.
-- Reads stdin, prints the result.

create {ANY}
   main

feature {ANY}
   main
      local
         data: LOCATION_ID_LISTS
         i, total: INTEGER
      do
         create data.make

         total := 0
         from
            i := data.a.lower
         until
            i > data.a.upper
         loop
            total := total + (data.a.item (i) - data.b.item (i)).abs

            i := i + 1
         end

         io.put_integer (total)
         io.put_new_line
      end

end
