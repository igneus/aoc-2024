class DAY02
-- https://adventofcode.com/2024/day/2
-- Reads stdin, prints the result.

create {ANY}
   main

feature {ANY}
   main
      local
         total: INTEGER
         report: REPORT
      do
         total := 0
         create report.make_default

         from
            io.read_line
         until
            io.end_of_input
         loop
            report.parse_string (io.last_string)
            if report.is_safe then
               total := total + 1
            end

            io.read_line
         end

         io.put_integer (total)
         io.put_new_line
      end
end
