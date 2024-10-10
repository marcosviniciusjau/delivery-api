/*
  Warnings:

  - You are about to alter the column `expires_in` on the `session` table. The data in that column could be lost. The data in that column will be cast from `DateTime2` to `Date`.
  - Added the required column `deliveriesId` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `delivery_id` to the `users` table without a default value. This is not possible if the table is not empty.
  - Added the required column `session_id` to the `users` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[deliveries] DROP CONSTRAINT [deliveries_user_id_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[session] DROP CONSTRAINT [session_user_id_fkey];

-- AlterTable
ALTER TABLE [dbo].[session] DROP CONSTRAINT [session_expires_in_df];
ALTER TABLE [dbo].[session] ALTER COLUMN [expires_in] DATE NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[users] ADD [deliveriesId] INT NOT NULL,
[delivery_id] INT NOT NULL,
[session_id] INT NOT NULL;

-- AddForeignKey
ALTER TABLE [dbo].[users] ADD CONSTRAINT [users_session_id_fkey] FOREIGN KEY ([session_id]) REFERENCES [dbo].[session]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[users] ADD CONSTRAINT [users_deliveriesId_fkey] FOREIGN KEY ([deliveriesId]) REFERENCES [dbo].[deliveries]([id]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
