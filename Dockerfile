# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
# Add NodeJS for Jest tests
RUN apt-get update && apt-get install -y nodejs npm

WORKDIR /src

# Copy csproj and package.json files first
COPY ["src/SimpleCalculator.csproj", "src/"]
COPY ["tests/CalculatorTests.csproj", "tests/"]
COPY ["src/wwwroot/js/package.json", "src/wwwroot/js/"]

# Restore packages for both .NET and Node
RUN dotnet restore "src/SimpleCalculator.csproj"
RUN dotnet restore "tests/CalculatorTests.csproj"
WORKDIR /src/src/wwwroot/js
RUN npm install

# Copy the rest of the code
WORKDIR /src
COPY . .

# Build and run both .NET and Jest tests
RUN dotnet build "src/SimpleCalculator.csproj" -c Release
RUN dotnet test "tests/CalculatorTests.csproj" -c Release
WORKDIR /src/src/wwwroot/js
RUN npm test

# Publish
FROM build AS publish
WORKDIR /src
RUN dotnet publish "src/SimpleCalculator.csproj" -c Release -o /app/publish

# Final stage
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SimpleCalculator.dll"]