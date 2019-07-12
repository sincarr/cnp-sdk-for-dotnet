using Cnp.Sdk;
using Moq;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;


namespace ASP.NETDemo
{
   [TestFixture]
    class Test
    {
        private CnpOnline cnp;

        [TestFixtureSetUp]
        public void SetUpCnp()
        {
            cnp = new CnpOnline();
        }

        [Test]
        public void testProcessAuth() {
            var auth = new authorization();
            auth.orderId = "12344";
            auth.amount = 2;
            auth.orderSource = orderSourceType.ecommerce;
            auth.reportGroup = "Planets";
            var card = new cardType
            {
                type = methodOfPaymentTypeEnum.MC,
                number = "540000000000000000",
                expDate = "1210"
            };

            auth.card = card;

            var mock = new Mock<Communications>();

            mock.Setup(Communications => Communications.HttpPost(It.IsRegex(".*<orderId>12344</orderId>.*", RegexOptions.Singleline), It.IsAny<Dictionary<string, string>>()))
                .Returns("<cnpOnlineResponse xmlns='http://www.vantivcnp.com/schema' version='12.8' response='0' message='Valid Format'><captureResponse id='1' reportGroup='Default Report Group'><cnpTxnId>123</cnpTxnId><response>000</response><responseTime>2019-07-11T15:48:48.295</responseTime><message>Approved</message></captureResponse></cnpOnlineResponse>");

            var mockedCommunication = mock.Object;
            cnp.SetCommunication(mockedCommunication);
            var authorizationResponse = cnp.Authorize(auth);

            Assert.NotNull(authorizationResponse);
            Assert.AreEqual(123, authorizationResponse.cnpTxnId);
            Assert.AreEqual(000, authorizationResponse.response);

        }

        [Test]
        public void testProcessCapture()
        {
            capture capture = new capture();
            capture.cnpTxnId = 3;
            capture.amount = 2;
            capture.payPalNotes = "note";
            capture.reportGroup = "Planets";
            capture.pin = "1234";

            var mock = new Mock<Communications>();

            mock.Setup(Communications => Communications.HttpPost(It.IsRegex(".*<amount>2</amount>\r\n<payPalNotes>note</payPalNotes>\r\n<pin>1234</pin>.*", RegexOptions.Singleline), It.IsAny<Dictionary<String, String>>()))
                .Returns("<cnpOnlineResponse version='8.14' response='0' message='Valid Format' xmlns='http://www.vantivcnp.com/schema'><captureResponse><cnpTxnId>123</cnpTxnId></captureResponse></cnpOnlineResponse>");

            Communications mockedCommunication = mock.Object;
            cnp.SetCommunication(mockedCommunication);
            cnp.Capture(capture);

        }
    }
}