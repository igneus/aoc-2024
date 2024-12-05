class BUFFERED_LINE_READER
-- reads input line by line, holds a specified number of lines in a
-- buffer

create {ANY}
   make

feature {}
   lines: INTEGER
   buffer: ARRAY[STRING]

feature {ANY} -- creation
   make (n: INTEGER)
      do
         io.put_integer (n)
         lines := n
         create buffer.with_capacity(lines + 1, 1)
      end

feature {ANY} -- IO
   read_line
      local
         i: INTEGER
      do
         if buffer.is_empty then
            from
               i := 1
            until
               i > lines or else io.end_of_input
            loop
               read_append_line

               i := i + 1
            end
         else
            read_append_line
            if not end_of_input then
               buffer.remove_first
            end
         end
      end

   end_of_input : BOOLEAN
      do
         Result := io.end_of_input
      end

feature {}
   read_append_line
      local
         s: STRING
      do
         io.read_line
         if not io.end_of_input then
            create s.copy (io.last_string)
            buffer.add_last (s)
         end
      end

feature {ANY} -- buffer content queries
   valid_index (x, y: INTEGER): BOOLEAN
      do
         Result := buffer.valid_index (y) and then buffer.item (y).valid_index (x)
      end

   item (x, y: INTEGER): CHARACTER
      require
         valid_index (x, y)
      do
         Result := buffer.item (y).item (x)
      end

   lower_y: INTEGER
      do
         Result := buffer.lower
      end

   upper_y: INTEGER
      do
         Result := buffer.upper
      end

   lower_x: INTEGER
      do
         Result := buffer.item (lower_y).lower
      end

   upper_x: INTEGER
      do
         Result := buffer.item (lower_y).upper
      end
end
