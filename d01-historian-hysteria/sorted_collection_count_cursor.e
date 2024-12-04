-- Finds how many times an element appears in a collection.
-- Assumes that the collection is sorted in an ascending order
-- and that the inquiries are sorted likewise.
-- Supports multiple inquiries concerning the same value.
class SORTED_COLLECTION_COUNT_CURSOR[T -> COMPARABLE]

create {ANY}
   make

feature {}
   collection: COLLECTION[T]
   i: INTEGER
   previous_item: T

feature {ANY}
   make (c: COLLECTION[T])
      do
         collection := c
         i := collection.lower
      end

   count (item: T) : INTEGER
      require
         input_is_sorted: previous_item = Void or item >= previous_item
      local
         j: INTEGER
      do
         previous_item := item

         from
         until
            i = collection.upper or item <= collection.item (i)
         loop
            i := i + 1
         end

         if item /= collection.item (i) then
            Result := 0
         else
            from
               j := 0
            until
               collection.item (i + j) /= item
            loop
               j := j + 1
            end

            Result := j
         end
      end

invariant
   collection.valid_index (i)

end
