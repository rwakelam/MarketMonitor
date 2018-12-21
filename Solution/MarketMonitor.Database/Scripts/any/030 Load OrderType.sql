SET NOCOUNT ON;
SET QUOTED_IDENTIFIER OFF;

PRINT 'Starting merge of static members into OrderType...';

-- Create an output table to cache the results.  
DECLARE @Result TABLE
( 
    [Action] NVARCHAR(10) NOT NULL  
);

-- Insert the data into a temporary source table.
DECLARE @Member TABLE 
(
	[OrderTypeId] [tinyint] NOT NULL,
	[Name] [nvarchar](25) NOT NULL
);
INSERT INTO
	@Member
    (
		[OrderTypeId],
        [Name]
	)
    VALUES
		(1,	'Limit'),
		(2,	'Market on Close'),
		(3,	'Limit on Close');

-- Merge the source data into the target table.
MERGE INTO 
	[dbo].[OrderType] AS t
USING
	(
		SELECT	
			[OrderTypeId],
			[Name]
		FROM
			@Member	
	) AS s
ON
	(
		t.[OrderTypeId] = s.[OrderTypeId]
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
		[OrderTypeId],
		[Name]
	)
	VALUES
	(
		s.[OrderTypeId],
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
PRINT FORMATMESSAGE('Finished merge of static members into OrderType. Compared: %i. Updated: %i. Inserted: %i.', @ComparedCount, @UpdatedCount, @InsertedCount);

SET QUOTED_IDENTIFIER ON;
SET NOCOUNT OFF;
GO