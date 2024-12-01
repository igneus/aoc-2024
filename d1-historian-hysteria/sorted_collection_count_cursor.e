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

feature {ANY}
   make (c: COLLECTION[T])
      do
         collection := c
         i := collection.lower
      end

   count (item: T) : INTEGER
      local
         j: INTEGER
      do
         from
         until
            i > collection.upper or else item <= collection.item (i)
         loop
            i := i + 1
         end

         if i > collection.upper or else item < collection.item (i) then
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

end
