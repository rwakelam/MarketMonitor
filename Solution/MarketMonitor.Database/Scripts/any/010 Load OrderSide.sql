SET NOCOUNT ON;
SET QUOTED_IDENTIFIER OFF;

PRINT 'Starting merge of static members into OrderSide...';

-- Create an output table to cache the results.  
DECLARE @Result TABLE
( 
    [Action] NVARCHAR(10) NOT NULL  
);

-- Insert the data into a temporary source table.
DECLARE @Member TABLE 
(
	[OrderSideId] [tinyint] NOT NULL,
	[Name] [nchar](3) NOT NULL
);
INSERT INTO
	@Member
    (
		[OrderSideId],
        [Name]
	)
    VALUES
		(1,	'Bid'),
		(2,	'Ask');

-- Merge the source data into the target table.
MERGE INTO 
	[dbo].[OrderSide] AS t
USING
	(
		SELECT	
			[OrderSideId],
			[Name]
		FROM
			@Member	
	) AS s
ON
	(
		t.[OrderSideId] = s.[OrderSideId]
	)
WHEN MATCHED AND 
(
	t.[Name] <> s.[Name]
) THEN
	UPDATE SET
		[Name] = s.[Name]
WHEN NOT MATCHED THEN
	INSERT
	(
		[OrderSideId],
		[Name]
	)
	VALUES
	(
		s.[OrderSideId],
		s.[Name]
	)
OUTPUT 
	$Action INTO @Result;

-- Report a summary of the results.
DECLARE 
	@ComparedCount INT,
	@UpdatedCount INT,
	@InsertedCount INT;
SELECT
	@ComparedCount = COUNT(*) 
FROM 
	@Member;
SELECT
	@UpdatedCount = COUNT(*) 
FROM 
	@Result 
WHERE 
	[Action] = 'UPDATE';
SELECT
	@InsertedCount = COUNT(*) 
FROM 
	@Result 
WHERE 
	[Action] = 'INSERT';
PRINT FORMATMESSAGE('Finished merge of static members into OrderSide. Compared: %i. Updated: %i. Inserted: %i.', @ComparedCount, @UpdatedCount, @InsertedCount);

SET QUOTED_IDENTIFIER ON;
SET NOCOUNT OFF;
GO