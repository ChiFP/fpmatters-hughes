output = title ++ captions ++ concat (map line [1..20])

title = cjustify 60 "A TABLE OF POWERS" ++ "\n\n"

captions = format "N" ++ concat (map caption [2..5]) ++ "\n"

caption i = format ("N^" ++ shownum i)

format = rjustify 12

line n = concat [format (show(n^i)) | i<-[1..5]] ++ "\n"
