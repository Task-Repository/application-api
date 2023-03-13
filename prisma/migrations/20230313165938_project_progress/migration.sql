/*
  Warnings:

  - You are about to drop the column `itemTypeId` on the `ProjectItem` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "ProjectItem" DROP COLUMN "itemTypeId",
ADD COLUMN     "projectItemTypeId" INTEGER;

-- AlterTable
ALTER TABLE "ProjectItemCommandsComments" ADD COLUMN     "isPrivate" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "ProjectLifeCycle" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "projectId" INTEGER NOT NULL,
    "index" INTEGER NOT NULL,
    "notStartedColor" TEXT NOT NULL DEFAULT '#FF0000',
    "inProgressColor" TEXT NOT NULL DEFAULT '#FFFF00',
    "completedColor" TEXT NOT NULL DEFAULT '#00FF00',
    "startedProgressDate" TIMESTAMP(3),
    "completedDate" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectLifeCycle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DefaultProjectLifeCycle" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "index" INTEGER NOT NULL,
    "notStartedColor" TEXT NOT NULL DEFAULT '#FF0000',
    "inProgressColor" TEXT NOT NULL DEFAULT '#FFFF00',
    "completedColor" TEXT NOT NULL DEFAULT '#00FF00',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DefaultProjectLifeCycle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectLifeCycleComments" (
    "id" SERIAL NOT NULL,
    "projectLifeCycleId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectLifeCycleComments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectItemType" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectItemType_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ProjectLifeCycle_name_key" ON "ProjectLifeCycle"("name");

-- CreateIndex
CREATE UNIQUE INDEX "DefaultProjectLifeCycle_name_key" ON "DefaultProjectLifeCycle"("name");

-- CreateIndex
CREATE UNIQUE INDEX "ProjectItemType_name_key" ON "ProjectItemType"("name");

-- AddForeignKey
ALTER TABLE "ProjectLifeCycleComments" ADD CONSTRAINT "ProjectLifeCycleComments_projectLifeCycleId_fkey" FOREIGN KEY ("projectLifeCycleId") REFERENCES "ProjectLifeCycle"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectLifeCycleComments" ADD CONSTRAINT "ProjectLifeCycleComments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItem" ADD CONSTRAINT "ProjectItem_projectItemTypeId_fkey" FOREIGN KEY ("projectItemTypeId") REFERENCES "ProjectItemType"("id") ON DELETE SET NULL ON UPDATE CASCADE;
