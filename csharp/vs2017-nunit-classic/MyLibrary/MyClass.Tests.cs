using NFluent;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Text;

namespace MyLibrary
{
    [TestFixture]
    class MyClass_should
    {
        [Test]
        public void Say_true()
        {
            var myObject = new MyClass();
            var actual = myObject.SayTrue();
            Check.That(actual).IsEqualTo(true);
        }

    }
}
