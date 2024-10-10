/*
  Warnings:

  - You are about to drop the column `deliveriesId` on the `users` table. All the data in the column will be lost.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[users] DROP CONSTRAINT [users_deliveriesId_fkey];

-- AlterTable
ALTER TABLE [dbo].[session] ALTER COLUMN [expires_in] DATETIME2 NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[users] DROP COLUMN [deliveriesId];

-- AddForeignKey
ALTER TABLE [dbo].[users] ADD CONSTRAINT [users_delivery_id_fkey] FOREIGN KEY ([delivery_id]) REFERENCES [dbo].[deliveries]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
