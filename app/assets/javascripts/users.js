$(document).ready(function() {
    Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content')); // Retrieve Stripe Public Key for permission to interact with Stripe    
    // Watch for a form submission:
    $("#form-submit-btn").click(function(event) {
        event.preventDefault(); // Prevent form's default bethavior so that it doesn't submit yet
        $('input[type=submit]').prop('disabled', true); // Disable the button to prevent additional clicks
        var error = false; 
        var ccNum = $('#card_number').val(), // Grab the values from CC fields and store them each in variables
            cvcNum = $('#card_code').val(),
            expMonth = $('#card_month').val(),
            expYear = $('#card_year').val();
            
        if (!error) {
        // Get the Stripe token:
        Stripe.createToken({ // Send cc information to Stripe via the variable that we've just created
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            expYear: expYear
        }, stripeResponseHandler); // once Stripe comes back with a card token we run the funtion responsehandler
    }
    return false;
    }); // form submission
    
    function stripeResponseHandler(status, response) {
        // Get a reference to the form:
        var f = $("#new_user"); // f = the entire form
        
        // Get the token to the form:
        var token = response.id; // coming from Stripe
    
        // Add the token to the form:
        f.append('<input type="hidden" name="user[stripe_card_token]" value="' + token + '" />'); // add a hidden field
        
        // Submit the form:
        f.get(0).submit(); // submit the form to our servers: only the name, password, card token
    }
});