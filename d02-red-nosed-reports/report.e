class REPORT

inherit ARRAY[INTEGER]

create {ANY}
   -- TODO: try to make 'make' work with a changed signature
   make_default

feature {ANY}
   make_default
      do
         with_capacity(10, 1)
      end

   parse_string (str: STRING)
      local
         start, i: INTEGER
         sub: STRING
      do
         clear_count
         start := str.lower
         create sub.make (10)

         from
            i := str.lower
         until
            i = str.upper
         loop
            if str.item (i) = ' ' then
               sub.copy_substring (str, start, i - 1)
               add_last (sub.to_integer)
               start := i + 1
            end
            i := i + 1
         end

         sub.copy_substring (str, start, i)
         add_last (sub.to_integer)
      end

   is_safe : BOOLEAN
      local
         sign, difference, i: INTEGER
      do
         Result := True

         if count < 2 then
            Result := False
         else
            sign := (item (lower) - item (lower + 1)).sign

            from
               i := lower
            until
               i + 1 > upper
            loop
               if (item (i) - item (i + 1)).sign /= sign then
                  Result := False
               else
                  difference := (item (i) - item (i + 1)).abs
                  if difference < 1 or difference > 3 then
                     Result := False
                  end
               end

               i := i + 1
            end
         end
      end

end
