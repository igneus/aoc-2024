class DAY03
-- https://adventofcode.com/2024/day/3
-- Reads stdin, prints the result.

create {ANY}
   main

feature {ANY}
   main
      local
         total_1, total_2: INTEGER
      do
         process_muls := True
         total_1 := 0
         total_2 := 0

         from
            io.read_line
         until
            io.end_of_input
         loop
            total_1 := total_1 + parse_simple (io.last_string)
            total_2 := total_2 + parse_with_switches (io.last_string)

            io.read_line
         end

         io.put_string ("Part 1:")
         io.put_new_line
         io.put_integer (total_1)
         io.put_new_line

         io.put_string ("Part 2:")
         io.put_new_line
         io.put_integer (total_2)
         io.put_new_line
      end

feature {}
   process_muls : BOOLEAN

   re : REGULAR_EXPRESSION
      local
         builder: REGULAR_EXPRESSION_BUILDER
      once
         Result := builder.convert_python_pattern ("mul\((\d{1,3}),(\d{1,3})\)")
      end

   last_match_value (subject: STRING): INTEGER
      do
         Result :=
            (subject.substring (re.ith_group_first_index (1), re.ith_group_last_index (1)).to_integer *
            subject.substring (re.ith_group_first_index (2), re.ith_group_last_index (2)).to_integer)
      end

   parse_simple (line: STRING) : INTEGER
      local
         is_match: BOOLEAN
      do
         Result := 0

         from
            is_match := re.match (line)
         until
            not is_match
         loop
            Result := Result + last_match_value (line)

            is_match := re.match_next (line)
         end
      end

   parse_with_switches (line: STRING) : INTEGER
      local
         switch_pos: INTEGER
         switch_token: STRING
      do
         Result := 0

         switch_token := if process_muls then "don't()" else "do()" end
         switch_pos := line.substring_index (switch_token, line.lower)

         if line.valid_index (switch_pos) then
            Result := Result + parse_with_switches (line.substring (line.lower, switch_pos))
            process_muls := not process_muls
            Result := Result + parse_with_switches (line.substring (switch_pos + 2, line.upper))
         elseif process_muls then
            Result := Result + parse_simple (line)
         end
      end

end
