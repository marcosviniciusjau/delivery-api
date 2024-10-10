BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[users] (
    [id] INT NOT NULL IDENTITY(1,1),
    [created_at] DATETIME2 NOT NULL CONSTRAINT [users_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [username] VARCHAR(255) NOT NULL,
    [password] VARCHAR(255) NOT NULL,
    CONSTRAINT [users_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [users_username_key] UNIQUE NONCLUSTERED ([username])
);

-- CreateTable
CREATE TABLE [dbo].[deliveries] (
    [id] INT NOT NULL IDENTITY(1,1),
    [created_at] DATETIME2 NOT NULL CONSTRAINT [deliveries_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    [donor_name] VARCHAR(255) NOT NULL,
    [initial_address] VARCHAR(255) NOT NULL,
    [final_address] VARCHAR(255) NOT NULL,
    [is_on_delivering] BIT NOT NULL CONSTRAINT [deliveries_is_on_delivering_df] DEFAULT 0,
    CONSTRAINT [deliveries_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [deliveries_donor_name_key] UNIQUE NONCLUSTERED ([donor_name])
);

-- CreateTable
CREATE TABLE [dbo].[session] (
    [id] INT NOT NULL IDENTITY(1,1),
    [expires_in] DATETIME2 NOT NULL CONSTRAINT [session_expires_in_df] DEFAULT CURRENT_TIMESTAMP,
    [refresh_token] VARCHAR(255) NOT NULL,
    [user_id] INT NOT NULL,
    [created_at] DATETIME2 NOT NULL CONSTRAINT [session_created_at_df] DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT [session_pkey] PRIMARY KEY CLUSTERED ([id]),
    CONSTRAINT [session_refresh_token_key] UNIQUE NONCLUSTERED ([refresh_token])
);

-- AddForeignKey
ALTER TABLE [dbo].[session] ADD CONSTRAINT [session_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
