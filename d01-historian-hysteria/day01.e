class DAY01
-- https://adventofcode.com/2024/day/1
-- Standalone program.
-- Reads stdin, prints the result.

create {ANY}
   main

feature {}
   data: LOCATION_ID_LISTS

feature {ANY}
   main
      do
         create data.make

         io.put_string ("Part 1:")
         io.put_new_line
         io.put_integer (part_1)
         io.put_new_line

         io.put_string ("Part 2:")
         io.put_new_line
         io.put_integer (part_2)
         io.put_new_line
      end

feature {}
   part_1: INTEGER
      local
         i, total: INTEGER
      do
         total := 0
         from
            i := data.a.lower
         until
            i > data.a.upper
         loop
            total := total + (data.a.item (i) - data.b.item (i)).abs

            i := i + 1
         end

         Result := total
      end

   part_2: INTEGER
      local
         i, total: INTEGER
         cursor: SORTED_COLLECTION_COUNT_CURSOR[INTEGER]
      do
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

         Result := total
      end
end
