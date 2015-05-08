wiki_raw = load '/home/phani/data/wikipedia/' as (raw:chararray)
wiki_count = foreach wiki_raw generate SUBSTRING(raw,0,INDEXOF(raw,'::::::',0)) as title, SIZE(raw) as size;
sorted_desc = ORDER wiki_count BY size DESC;
sorted_dlimit = LIMIT sorted_desc 1;
dump sorted_dlimit;

sorted_asc = ORDER wiki_count BY size;
sorted_alimit = LIMIT sorted_asc 1;
dump sorted_alimit;

words = foreach wiki_raw GENERATE FLATTEN(TOKENIZE(raw)) as word;
letters = foreach words GENERATE FLATTEN(TOKENIZE(raw)) as letter;
grouped = GROUP letters BY letter;
letter_count = foreach grouped GENERATE group, COUNT(letters);
DUMP letter_count;