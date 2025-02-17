function add(a, b) {
    return a + b;
}

function subtract(a, b) {
    return a - b;
}

function multiply(a, b) {
    return a * b;
}

function performCalculation(operation) {
    let num1 = parseFloat(document.getElementById("num1").value);
    let num2 = parseFloat(document.getElementById("num2").value);

    if (isNaN(num1) || isNaN(num2)) {
        alert("Please enter valid numbers!");
        return;
    }

    let result;
    switch (operation) {
        case 'add':
            result = add(num1, num2);
            break;
        case 'subtract':
            result = subtract(num1, num2);
            break;
        case 'multiply':
            result = multiply(num1, num2);
            break;
        default:
            result = "Invalid Operation";
    }

    document.getElementById("result").textContent = "Result: " + result;
}

// ✅ Export functions for Jest testing (Outside `performCalculation()`)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { add, subtract, multiply };
}
