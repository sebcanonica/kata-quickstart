using System;
using Xunit;

namespace XUnitTestProject
{
    public class MyClass_should
    {
        [Fact]
        public void Say_true()
        {
            var myObject = new MyClass();
            var actual = myObject.SayTrue();
            Assert.Equal(true, actual);
        }
    }
}
