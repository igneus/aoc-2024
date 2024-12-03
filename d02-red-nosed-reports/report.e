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
         sign, i: INTEGER
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
               if not adjacent_levels_are_safe(sign, item (i), item (i + 1)) then
                  Result := False
               end

               i := i + 1
            end
         end
      end

   is_safe_with_dampener: BOOLEAN
      do
         -- TODO replace this brute force solution by an
         -- efficient way of determining the sign
         Result := check_with_dampener(1) or check_with_dampener(-1)
      end

feature {}

   adjacent_levels_are_safe(sign, a, b: INTEGER): BOOLEAN
      local
         difference: INTEGER
      do
         Result := True

         if (a - b).sign /= sign then
            Result := False
         else
            difference := (a - b).abs
            if difference < 1 or difference > 3 then
               Result := False
            end
         end
      end

   check_with_dampener(sign: INTEGER): BOOLEAN
      local
         dampener_used: BOOLEAN
         i: INTEGER
      do
         Result := True
         dampener_used := False

         from
            i := lower
         until
            i + 1 > upper
         loop
            if not adjacent_levels_are_safe(sign, item (i), item (i + 1)) then
               if dampener_used then
                  Result := False
               elseif valid_index (i - 1) and then adjacent_levels_are_safe(sign, item (i - 1), item (i + 1)) then
                  -- skip i
                  dampener_used := True
               elseif valid_index (i + 2) and then adjacent_levels_are_safe(sign, item (i), item (i + 2)) then
                  -- skip i + 1
                  dampener_used := True
                  i := i + 1
               elseif not valid_index (i - 1) then
                  -- skip i which is first entry in the list
                  dampener_used := True
               elseif not valid_index (i + 2) then
                  -- skip i + 1 which is last entry in the list
                  dampener_used := True
               else
                  Result := False
               end
            end

            i := i + 1
         end
      end

end
