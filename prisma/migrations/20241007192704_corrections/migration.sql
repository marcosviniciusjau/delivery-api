/*
  Warnings:

  - You are about to drop the column `final_latitude` on the `deliveries` table. All the data in the column will be lost.
  - You are about to drop the column `final_longitude` on the `deliveries` table. All the data in the column will be lost.
  - You are about to drop the column `initial_latitude` on the `deliveries` table. All the data in the column will be lost.
  - You are about to drop the column `initial_longitude` on the `deliveries` table. All the data in the column will be lost.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[deliveries] DROP COLUMN [final_latitude],
[final_longitude],
[initial_latitude],
[initial_longitude];

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
