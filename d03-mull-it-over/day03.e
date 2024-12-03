class DAY03
-- https://adventofcode.com/2024/day/2
-- Reads stdin, prints the result.

create {ANY}
   main

feature {ANY}
   main
      local
         re: REGULAR_EXPRESSION
         builder: REGULAR_EXPRESSION_BUILDER
         total: INTEGER
         line: STRING
         is_match: BOOLEAN
      do
         total := 0
         re := builder.convert_python_pattern ("mul\((\d{1,3}),(\d{1,3})\)")

         from
            io.read_line
         until
            io.end_of_input
         loop
            line := io.last_string

            from
               is_match := re.match (line)
            until
               not is_match
            loop
               total :=
                  total +
                  (line.substring (re.ith_group_first_index (1), re.ith_group_last_index (1)).to_integer *
                  line.substring (re.ith_group_first_index (2), re.ith_group_last_index (2)).to_integer)

               is_match := re.match_next (line)
            end

            io.read_line
         end

         io.put_integer (total)
         io.put_new_line
      end

end
