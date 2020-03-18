using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace UnitTestProject1
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void Test1()
        {
            Assert.IsFalse(false);
        }

        [TestMethod]
        public void Test2()
        {
            Assert.IsTrue(true);
        }
    }
}
