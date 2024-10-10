/*
  Warnings:

  - Added the required column `user_id` to the `deliveries` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[deliveries] ADD [user_id] INT NOT NULL;

-- AddForeignKey
ALTER TABLE [dbo].[deliveries] ADD CONSTRAINT [deliveries_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
