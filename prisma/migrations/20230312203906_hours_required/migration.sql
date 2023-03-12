/*
  Warnings:

  - Added the required column `hoursRequired` to the `ProjectItem` table without a default value. This is not possible if the table is not empty.
  - Added the required column `hoursRequired` to the `TemplateItem` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ProjectItem" ADD COLUMN     "hoursRequired" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "TemplateItem" ADD COLUMN     "hoursRequired" INTEGER NOT NULL;
