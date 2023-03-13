/*
  Warnings:

  - Added the required column `title` to the `ProjectItemCommandsIssues` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "ProjectItemCommandsIssues" ADD COLUMN     "title" TEXT NOT NULL,
ALTER COLUMN "resolvesIssue" SET DEFAULT false;
