class DAY02
-- https://adventofcode.com/2024/day/2
-- Reads stdin, prints the result.

create {ANY}
   main

feature {ANY}
   main
      local
         safe_1, safe_2, total: INTEGER
         report: REPORT
      do
         safe_1 := 0
         safe_2 := 0
         total := 0
         create report.make_default

         from
            io.read_line
         until
            io.end_of_input
         loop
            report.parse_string (io.last_string)
            if report.is_safe then
               safe_1 := safe_1 + 1
            end
            if report.is_safe_with_dampener then
               safe_2 := safe_2 + 1
            end
            total := total + 1

            io.read_line
         end

         io.put_string ("Part 1:")
         io.put_new_line
         io.put_integer (safe_1)
         io.put_new_line

         io.put_string ("Part 2:")
         io.put_new_line
         io.put_integer (safe_2)
         io.put_new_line

         io.put_integer (total)
         io.put_string (" records total")
         io.put_new_line
      end
end
