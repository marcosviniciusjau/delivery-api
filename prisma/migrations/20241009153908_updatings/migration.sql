/*
  Warnings:

  - Added the required column `initial_latitude` to the `deliveries` table without a default value. This is not possible if the table is not empty.
  - Added the required column `initial_longitude` to the `deliveries` table without a default value. This is not possible if the table is not empty.

*/
BEGIN TRY

BEGIN TRAN;

-- AlterTable
ALTER TABLE [dbo].[deliveries] ADD [final_latitude] FLOAT(53),
[final_longitude] FLOAT(53),
[initial_latitude] FLOAT(53) NOT NULL,
[initial_longitude] FLOAT(53) NOT NULL;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
