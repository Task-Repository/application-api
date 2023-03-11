-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "sub" TEXT NOT NULL,
    "name" TEXT,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_sub_key" ON "User"("sub");
