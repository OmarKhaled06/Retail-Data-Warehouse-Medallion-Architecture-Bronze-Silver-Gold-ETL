USE DW;
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'silver')
BEGIN
    EXEC('CREATE SCHEMA silver');
END
GO

CREATE OR ALTER PROCEDURE silver.load_silver
AS
BEGIN

    SET NOCOUNT ON;

    DECLARE @start_time DATETIME;
    DECLARE @end_time DATETIME;
    DECLARE @rows INT;
    DECLARE @table_name NVARCHAR(200);

    BEGIN TRY

        -- CUSTOMERS CLEANING

        SET @table_name = 'silver.CUSTOMERS';
        SET @start_time = GETDATE();

        TRUNCATE TABLE silver.CUSTOMERS;

        INSERT INTO silver.CUSTOMERS
        (
            Customer_ID,
            First_Name,
            Last_Name,
            Full_Name,
            Gender,
            City,
            Loyalty_Level,
            Email
        )
        SELECT
            Customer_ID,
            TRIM(First_Name),
            TRIM(Last_Name),
            TRIM(First_Name) + ' ' + TRIM(Last_Name),
            TRIM(Gender),
            TRIM(City),
            TRIM(Loyalty_Level),
            TRIM(Email)
        FROM
        (
            SELECT *,
                   ROW_NUMBER() OVER (
                       PARTITION BY Email
                       ORDER BY Customer_ID ASC
                   ) AS rn
            FROM bronze.CUSTOMERS
        ) x
        WHERE rn = 1;

        -- PROMOTIONS CLEANING

        TRUNCATE TABLE silver.PROMOTIONS;

        INSERT INTO silver.PROMOTIONS
        (
            Promotion_ID,
            Promo_Type,
            Discount_Percent,
            Start_Date,
            End_Date
        )
        SELECT
            Promotion_ID,
            TRIM(Promo_Type),
            ISNULL(Discount_Percent, 0.00),
            CASE
                WHEN End_Date < Start_Date
                    THEN End_Date
                ELSE Start_Date
            END,
            CASE
                WHEN End_Date < Start_Date
                    THEN Start_Date
                ELSE End_Date
            END
        FROM bronze.PROMOTIONS;

        -- TRANSACTION ITEMS

        TRUNCATE TABLE silver.TRANSACTION_ITEMS;

        INSERT INTO silver.TRANSACTION_ITEMS
        (
            Line_ID,
            Transaction_ID,
            Product_ID,
            Promotion_ID,
            Quantity,
            Unit_Price,
            Line_Total
        )
        SELECT
            Line_ID,
            TRIM(Transaction_ID),
            Product_ID,
            Promotion_ID,
            ISNULL(Quantity, 0),
            ISNULL(Unit_Price, 0.00),
            ISNULL(Quantity, 0) * ISNULL(Unit_Price, 0.00)
        FROM bronze.TRANSACTION_ITEMS;

        -- PAYMENTS VALIDATION

        TRUNCATE TABLE silver.PAYMENTS;

        INSERT INTO silver.PAYMENTS
        (
            Payment_ID,
            Order_ID,
            Payment_Method,
            Payment_Amount,
            Payment_Time,
            Is_Valid
        )
        SELECT
            p.Payment_ID,
            p.Order_ID,
            TRIM(p.Payment_Method),
            ISNULL(p.Payment_Amount, 0.00),
            p.Payment_Time,
            CASE
                WHEN ABS(
                    ISNULL(p.Payment_Amount, 0)
                    - ISNULL(o.Order_Total, 0)
                ) > 0.01
                THEN 0
                ELSE 1
            END
        FROM bronze.PAYMENTS p
        LEFT JOIN bronze.ONLINE_ORDERS o
            ON p.Order_ID = o.Order_ID;

    END TRY

    BEGIN CATCH

        PRINT ERROR_MESSAGE();

    END CATCH

END;
GO