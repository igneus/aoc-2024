class DAY04
-- https://adventofcode.com/2024/day/4
-- Reads stdin, prints the result.

-- Part 2 is unfinished - produces correct result for the example
-- input, but not for the actual one.

create {ANY}
   main

feature {ANY}
   main
      local
         search, reverse_search, search_2, reverse_search_2: STRING
         total_1, total_2, i, x: INTEGER
         reader: BUFFERED_LINE_READER
      do
         search := "XMAS"

         create reverse_search.copy(search)
         reverse_search.reverse

         search_2 := "MAS"
         reverse_search_2 := "SAM"

         total_1 := 0
         total_2 := 0

         create reader.make (search.count)

         from
            io.put_string ("initial read started")
            reader.read_line
            io.put_string ("initial read finished")
         until
            reader.end_of_input
         loop
            total_1 := total_1 +
               word_search_occurrences (search, reader) +
               word_search_occurrences (reverse_search, reader)

            total_2 := total_2 +
               cross_occurrences_top (search_2, reverse_search_2, reader)

            io.put_string (io.last_string)
            io.put_new_line
            io.put_integer (total_1)
            io.put_string (" ")
            io.put_integer (total_2)
            io.put_new_line

            reader.read_line
         end

         -- only horizontal occurrences possible in the remaining lines
         from
            i := reader.lower_y + 1
         until
            i > reader.upper_y
         loop
            from
               x := reader.lower_x
            until
               x > reader.upper_x
            loop
               total_1 := total_1 +
                  check_occurrence (search, reader, x, i, 1, 0) +
                  check_occurrence (reverse_search, reader, x, i, 1, 0)

               x := x + 1
            end

            i := i + 1
         end

         -- `search_2' is shorter than `search', there are unprocessed lines in the buffer
         from
            i := reader.lower_y + 1
         until
            i + search_2.count - 1 > reader.upper_y
         loop
            from
               x := reader.lower_x
            until
               x > reader.upper_x
            loop
               total_2 := total_2 +
                  cross_occurrences (search_2, reverse_search_2, reader, i)

               x := x + 1
            end

            i := i + 1
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

   word_search_occurrences (search: STRING; reader: BUFFERED_LINE_READER): INTEGER
         -- Count word-search-puzzle-like occurrences
         -- (horizontal, downward, downward
         -- diagonal) of string `search' in `reader'
         -- beginning on the first line of `reader'
      local
         x, y : INTEGER
      do
         Result := 0

         from
            x := reader.lower_x
            y := reader.lower_y
         until
            x > reader.upper_x
         loop
            Result := Result +
               check_occurrence (search, reader, x, y, 1, 0) + -- horizontal
               check_occurrence (search, reader, x, y, 0, 1) + -- vertical
               check_occurrence (search, reader, x, y, 1, 1) + -- diagonal SE
               check_occurrence (search, reader, x, y, -1, 1)  -- diagonal SW

            x := x + 1
         end
      end

   cross_occurrences_top (search, reverse_search: STRING; reader: BUFFERED_LINE_READER): INTEGER
         -- Count crossed occurrences
         -- of string `search' or `reverse_search' in `reader'
         -- beginning on the first line of `reader'
      do
         Result := cross_occurrences (search, reverse_search, reader, reader.lower_y)
      end

   cross_occurrences (search, reverse_search: STRING; reader: BUFFERED_LINE_READER; y: INTEGER): INTEGER
         -- Count crossed occurrences
         -- of string `search' or `reverse_search' in `reader'
         -- beginning on line `y'
      require
         search.count = reverse_search.count
         search.count \\ 2 = 1
      local
         x, found : INTEGER
      do
         Result := 0

         from
            x := reader.lower_x
         until
            x > reader.upper_x
         loop
            found :=
               -- diagonal SE
               check_occurrence (search,         reader, x, y, 1, 1) +
               check_occurrence (reverse_search, reader, x, y, 1, 1) +
               -- diagonal SW
               check_occurrence (search,         reader, x + search.count - 1, y, -1, 1) +
               check_occurrence (reverse_search, reader, x + search.count - 1, y, -1, 1)

            if found = 2 then
               Result := Result + 1
            end

            x := x + 1
         end
      end

   check_occurrence (search: STRING; reader: BUFFERED_LINE_READER; x, y, x_increment, y_increment: INTEGER): INTEGER
         -- Check that string `search' occurs in `reader'
         -- at position `x', `y' in the direction specified
         -- by `x_increment' and `y_increment'.
         -- Returns  if it does, 0 otherwise.
      local
         i: INTEGER
      do
         Result := 1
         from
            i := 0
         until
            Result = 0 or else search.lower + i > search.upper
         loop
            if (not reader.valid_index (x + i * x_increment, y + i * y_increment))
               or else reader.item (x + i * x_increment, y + i * y_increment) /= search.item (search.lower + i) then
                  Result := 0
            end

            i := i + 1
         end
      end

end
