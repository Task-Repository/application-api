-- AlterTable
ALTER TABLE "TemplateItemCommand" ADD COLUMN     "description" TEXT,
ADD COLUMN     "references" TEXT;

-- CreateTable
CREATE TABLE "ProjectItemCommands" (
    "id" SERIAL NOT NULL,
    "projectItemId" INTEGER NOT NULL,
    "description" TEXT,
    "command" TEXT NOT NULL,
    "references" TEXT,
    "expectedResult" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectItemCommands_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ProjectItemCommands" ADD CONSTRAINT "ProjectItemCommands_projectItemId_fkey" FOREIGN KEY ("projectItemId") REFERENCES "ProjectItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
