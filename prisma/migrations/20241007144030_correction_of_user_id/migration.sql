/*
  Warnings:

  - You are about to drop the column `delivery_id` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `session_id` on the `users` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[user_id]` on the table `session` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `final_latitude` to the `deliveries` table without a default value. This is not possible if the table is not empty.
  - Added the required column `final_longitude` to the `deliveries` table without a default value. This is not possible if the table is not empty.
  - Added the required column `initial_latitude` to the `deliveries` table without a default value. This is not possible if the table is not empty.
  - Added the required column `initial_longitude` to the `deliveries` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- DropForeignKey
ALTER TABLE [dbo].[users] DROP CONSTRAINT [users_delivery_id_fkey];

-- DropForeignKey
ALTER TABLE [dbo].[users] DROP CONSTRAINT [users_session_id_fkey];

-- AlterTable
ALTER TABLE [dbo].[deliveries] ADD [final_latitude] FLOAT(53) NOT NULL,
[final_longitude] FLOAT(53) NOT NULL,
[initial_latitude] FLOAT(53) NOT NULL,
[initial_longitude] FLOAT(53) NOT NULL;

-- AlterTable
ALTER TABLE [dbo].[users] DROP COLUMN [delivery_id],
[session_id];

-- CreateIndex
ALTER TABLE [dbo].[session] ADD CONSTRAINT [session_user_id_key] UNIQUE NONCLUSTERED ([user_id]);

-- AddForeignKey
ALTER TABLE [dbo].[deliveries] ADD CONSTRAINT [deliveries_user_id_fkey] FOREIGN KEY ([user_id]) REFERENCES [dbo].[users]([id]) ON DELETE CASCADE ON UPDATE CASCADE;

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
