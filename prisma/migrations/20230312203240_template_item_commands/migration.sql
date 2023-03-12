/*
  Warnings:

  - You are about to drop the column `commands` on the `TemplateItem` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "TemplateItem" DROP COLUMN "commands";

-- CreateTable
CREATE TABLE "TemplateItemCommand" (
    "id" SERIAL NOT NULL,
    "templateItemId" INTEGER NOT NULL,
    "command" TEXT NOT NULL,
    "expectedResult" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TemplateItemCommand_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "TemplateItemCommand" ADD CONSTRAINT "TemplateItemCommand_templateItemId_fkey" FOREIGN KEY ("templateItemId") REFERENCES "TemplateItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
