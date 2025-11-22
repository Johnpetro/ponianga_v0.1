-- CreateTable
CREATE TABLE "visitors" (
    "id" SERIAL NOT NULL,
    "ipAddress" VARCHAR(45) NOT NULL,
    "userAgent" VARCHAR(500),
    "page" VARCHAR(255) NOT NULL,
    "referrer" VARCHAR(500),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "visitors_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "visitors_ipAddress_idx" ON "visitors"("ipAddress");

-- CreateIndex
CREATE INDEX "visitors_createdAt_idx" ON "visitors"("createdAt");
