const functions = require("firebase-functions");
const axios = require("axios");
const { Configuration, OpenAIApi } = require("openai");
const configuration = new Configuration({
  apiKey: "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",
});
const openai = new OpenAIApi(configuration);

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const stripe = require("stripe")(
  "sk_test_51MVKzaFMHgIHiJBNhbunl13sRkOpR40ZitBAHRu3C7DI14Cvsg0YLBEnlGjUCzNJFCh1Tz4atjQEadZm5shKNiOJ00oq9j75C8"
);

exports.createPaymentIntent = functions.https.onCall(async (data, context) => {
  try {
    return await stripe.paymentIntents.create({
      amount: 1099,
      currency: "usd",
      payment_method_types: ["card"],
    });
  } catch (error) {
    return error;
    // console.error(error);
    // res.status(500).send({ error: 'An error occurred while creating the PaymentIntent.' });
  }
});

exports.createImages = functions.https.onCall(async (data, context) => {
  try {
    functions.logger.log("Hit createImages function");
    const response = await openai.createImage({
      prompt: "a cat sitting on a couch",
      n: 1,
      size: "1024x1024",
    });
    functions.logger.log("response.data: ", response.data);
    functions.logger.log(
      "response.data.data[0].url: ",
      response.data.data[0].url
    );
    functions.logger.log("success: ", response.data.data[0].url);
    return response.data.data[0].url;
  } catch (error) {
    functions.logger.log("error: ", error);
    return error;
  }
});
