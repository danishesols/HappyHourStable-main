const functions = require("firebase-functions");

const stripe = require("stripe")(functions.config().stripe.testkey);


exports.registerCustomer = functions.https.onCall(async (data, context) => {
    try{
        const name = data.name;
        const email = data.email;
        const phone = data.phone;

        const customer = await stripe.customers.create({
            name: name,
            email: email,
            phone: phone,
        });

        return customer.id;
    } catch (error) {
        return "customer error: " + error;
    }
});

exports.retrieveCustomer = functions.https.onCall(async (data, context) => {
    try{
        const customer = await stripe.customers.retrieve(
            data.customer_id, 
            {
                expand: ['subscriptions'],
            }
        );

        return customer;

    } catch (error) {
        return "customer error: " + error;
    }
});


exports.cancelSubscription = functions.https.onCall(async (data, context) => {
    try{
        const deleted = await stripe.subscriptions.del(
            data.subscription_id,
        );

        return deleted;
    } catch (error) {
        return "cancel subscribe error: " + error;
    }
});

exports.createSession = functions.https.onCall(async (data, context) => {
    try{
        const session = await stripe.checkout.sessions.create({
            success_url: 'https://success.com/{CHECKOUT_SESSION_ID}',
            cancel_url: 'https://cancel.com/',
            line_items: [
                {
                    price: 'price_1KO33pKsz4NtnSwNaGHuhSP4', 
                    quantity: 1,
                },
            ],
            mode: 'subscription',
            customer: data.customer_id,
        });

        return session.id;
    } catch (error) {
        return "create session error: " + error;
    }
});
