SET NOCOUNT ON;
SET QUOTED_IDENTIFIER OFF;

PRINT 'Starting merge of static members into OrderStatus...';

-- Create an output table to cache the results.  
DECLARE @Result TABLE
( 
    [Action] NVARCHAR(10) NOT NULL  
);

-- Insert the data into a temporary source table.
DECLARE @Member TABLE 
(
	[OrderStatusId] [tinyint] NOT NULL,
	[Name] [nvarchar](25) NOT NULL
);
INSERT INTO
	@Member
    (
		[OrderStatusId],
        [Name]
	)
    VALUES
		(1,	'Executable'),
		(2,	'Completed');

-- Merge the source data into the target table.
MERGE INTO 
	[dbo].[OrderStatus] AS t
USING
	(
		SELECT	
			[OrderStatusId],
			[Name]
		FROM
			@Member	
	) AS s
ON
	(
		t.[OrderStatusId] = s.[OrderStatusId]
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
		[OrderStatusId],
		[Name]
	)
	VALUES
	(
		s.[OrderStatusId],
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
PRINT FORMATMESSAGE('Finished merge of static members into OrderStatus. Compared: %i. Updated: %i. Inserted: %i.', @ComparedCount, @UpdatedCount, @InsertedCount);

SET QUOTED_IDENTIFIER ON;
SET NOCOUNT OFF;
GO