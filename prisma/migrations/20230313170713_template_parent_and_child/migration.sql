/*
  Warnings:

  - Added the required column `templateParentId` to the `Template` table without a default value. This is not possible if the table is not empty.
  - Added the required column `language` to the `TemplateItemCommand` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Template" ADD COLUMN     "templateParentId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "TemplateItemCommand" ADD COLUMN     "language" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "TemplateItemCommandLanuage" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "TemplateItemCommandLanuage_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "TemplateItemCommandLanuage_name_key" ON "TemplateItemCommandLanuage"("name");

-- AddForeignKey
ALTER TABLE "Template" ADD CONSTRAINT "Template_templateParentId_fkey" FOREIGN KEY ("templateParentId") REFERENCES "Template"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
