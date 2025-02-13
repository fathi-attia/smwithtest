using NUnit.Framework;
using SimpleCalculator.Services;

namespace CalculatorServiceTests
{
    [TestFixture]
    public class CalculatorServiceTests
    {
        private CalculatorService _calculatorService;

        [SetUp]
        public void Setup()
        {
            _calculatorService = new CalculatorService();
        }

        [Test]
        public void Add_WhenCalled_ReturnsSum()
        {
            int result = _calculatorService.Add(3, 5);
            Assert.AreEqual(8, result);
        }

        [Test]
        public void Subtract_WhenCalled_ReturnsDifference()
        {
            int result = _calculatorService.Subtract(10, 4);
            Assert.AreEqual(6, result);
        }

        [Test]
        public void Multiply_WhenCalled_ReturnsProduct()
        {
            int result = _calculatorService.Multiply(6, 7);
            Assert.AreEqual(42, result);
        }
    }
}
