const { add, subtract, multiply } = require("./calculator");

test("adds two numbers", () => {
    expect(add(3, 5)).toBe(8);
});

test("subtracts two numbers", () => {
    expect(subtract(10, 4)).toBe(6);
});

test("multiplies two numbers", () => {
    expect(multiply(6, 7)).toBe(42);
});
