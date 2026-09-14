# =========================
# Stage 1: Build .NET
# =========================
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /app

COPY . .

RUN dotnet build src/SimpleCalculator.csproj

RUN dotnet test tests/CalculatorTests.csproj

RUN dotnet publish src/SimpleCalculator.csproj \
    -c Debug \
    -o /app/publish


# =========================
# Stage 2: Run Jest tests
# =========================
FROM node:20 AS js-test

WORKDIR /app

COPY src/wwwroot/js/ .

RUN npm install --legacy-peer-deps

RUN npm test


# =========================
# Stage 3: Runtime
# =========================
FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app

COPY --from=build /app/publish .

EXPOSE 80

ENTRYPOINT ["dotnet", "SimpleCalculator.dll"]