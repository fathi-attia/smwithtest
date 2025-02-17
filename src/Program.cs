var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.UseStaticFiles(); // Allows serving static files (HTML, JS)

app.MapGet("/", () => Results.Redirect("/html/index.html")); // Redirect to index.html

app.Run();
//test 3