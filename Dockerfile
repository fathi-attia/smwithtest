# Use .NET SDK for building and testing
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Install Node.js 20
RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy everything
COPY . .

# Build, test, and publish .NET
RUN dotnet build src/SimpleCalculator.csproj
RUN dotnet test tests/CalculatorTests.csproj
RUN dotnet publish src/SimpleCalculator.csproj -c Debug -o /app/publish

# Run Jest tests
WORKDIR /app/src/wwwroot/js
RUN npm install --legacy-peer-deps
RUN npm test

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app

COPY --from=build /app/publish .
COPY --from=build /app/src/wwwroot ./wwwroot

EXPOSE 80

ENTRYPOINT ["dotnet", "SimpleCalculator.dll"]