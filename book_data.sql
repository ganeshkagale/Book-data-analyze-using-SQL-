SELECT * FROM public."Book_data"
TRUNCATE public."Book_data"

-- What is the total number of books in the dataset?
SELECT "Book_Name", "Author" FROM public."Book_data"
WHERE "Book_Name" = ''
SELECT COUNT(*)
FROM public."Book_data"
WHERE "Book_Name" IS NULL

DELETE FROM public."Book_data"
WHERE "Book_Name" IS NULL
DELETE FROM public."Book_data"
WHERE "Publishing_Year" = -17,-,-,-,-,-


-- What is the total number of books in the dataset?
SELECT COUNT(*)
FROM public."Book_data"

-- Who are the top 5 authors with the highest rating for which book ?
SELECT "Author", "Book_Name" ,"Book_average_rating" FROM public."Book_data"
ORDER BY "Book_average_rating" DESC
LIMIT 5

-- How many books were published each year?
SELECT "Publishing_Year", COUNT(*) AS Books_Published
FROM public."Book_data"
GROUP BY "Publishing_Year"
ORDER BY "Publishing_Year"

-- - What is the best-selling book in terms of units sold?
SELECT  "Book_Name" , "units_sold" FROM public."Book_data"
ORDER BY "units_sold" DESC
LIMIT 1



CREATE OR REPLACE PROCEDURE GetAverageRatingForAuthor(
    p_author_name VARCHAR,
    p_avg_rating OUT numeric
)
language plpgsql
AS $$
BEGIN
    SELECT AVG(Author_Rating)
    INTO p_avg_rating
    FROM public."Book_data"
    WHERE "Author" = p_author_name;

    -- Display or log the result (optional)
--     RAISE NOTICE FORMAT('Average rating for ',p_author_name ': ', p_avg_rating);
	RAISE NOTICE 'Average rating for %:', p_author_name;
    RAISE NOTICE 'Rating: %', v_avg_rating;
END;
$$;
/
CALL GetAverageRatingForAuthor('Harper Lee')

DO $$
BEGIN
    SELECT * FROM GetAverageRatingForAuthor('Harper Lee');
END $$;

DROP PROCEDURE GetAverageRatingForAuthor

CREATE OR REPLACE FUNCTION GetAverageRatingForAuthor(
    p_author_name VARCHAR(255),
    OUT author_name VARCHAR(255),
    OUT avg_rating NUMERIC
)
AS $$
BEGIN
    SELECT p_author_name, AVG("Author_Rating")
    INTO author_name, avg_rating
    FROM public."Book_data"
    WHERE "Author" = p_author_name;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM GetBook_NameForAuthor('Victoria Aveyard');




DROP FUNCTION GetBook_NameForAuthor
CREATE OR REPLACE FUNCTION GetBook_NameForAuthor(
    p_author_name VARCHAR(255),
    OUT author_name VARCHAR(255),
    OUT Book_Name text,
	OUT Publishing_Year bigint,
	OUT units_sold numeric
)
AS $$
BEGIN
    SELECT p_author_name, "Book_Name", "Publishing_Year", "units_sold" 
    INTO author_name, Book_Name, Publishing_Year, units_sold
    FROM public."Book_data"
    WHERE "Author" = p_author_name;
END;
$$ LANGUAGE plpgsql;



