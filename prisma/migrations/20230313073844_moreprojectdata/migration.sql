-- AlterTable
ALTER TABLE "ProjectItemCommands" ADD COLUMN     "assignedToId" INTEGER,
ADD COLUMN     "completedById" INTEGER,
ADD COLUMN     "completedDate" TIMESTAMP(3);

-- CreateTable
CREATE TABLE "ProjectMetaData" (
    "id" SERIAL NOT NULL,
    "projectId" INTEGER NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectMetaData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectDefaultMetaData" (
    "id" SERIAL NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectDefaultMetaData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectItemCommandsIssues" (
    "id" SERIAL NOT NULL,
    "commandId" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "resolvesIssue" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectItemCommandsIssues_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectItemCommandsIssuesComments" (
    "id" SERIAL NOT NULL,
    "issueId" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectItemCommandsIssuesComments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProjectItemCommandsComments" (
    "id" SERIAL NOT NULL,
    "commandId" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ProjectItemCommandsComments_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "ProjectMetaData" ADD CONSTRAINT "ProjectMetaData_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommands" ADD CONSTRAINT "ProjectItemCommands_completedById_fkey" FOREIGN KEY ("completedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommands" ADD CONSTRAINT "ProjectItemCommands_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommandsIssues" ADD CONSTRAINT "ProjectItemCommandsIssues_commandId_fkey" FOREIGN KEY ("commandId") REFERENCES "ProjectItemCommands"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommandsIssues" ADD CONSTRAINT "ProjectItemCommandsIssues_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommandsIssuesComments" ADD CONSTRAINT "ProjectItemCommandsIssuesComments_issueId_fkey" FOREIGN KEY ("issueId") REFERENCES "ProjectItemCommandsIssues"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommandsIssuesComments" ADD CONSTRAINT "ProjectItemCommandsIssuesComments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommandsComments" ADD CONSTRAINT "ProjectItemCommandsComments_commandId_fkey" FOREIGN KEY ("commandId") REFERENCES "ProjectItemCommands"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProjectItemCommandsComments" ADD CONSTRAINT "ProjectItemCommandsComments_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
