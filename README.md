A project for the Mobile Application Development: iOS course in Hogent. The app consists of a kind of social media app in which 
users that are verified as content creators can post claimables across the world and people can claim them by going to the location
of where the claimable was placed. 

The project was meant to be connected to WEB 3.0, concretely to the Ethereum blockchain, but due to the lack of time, the project descalated,
therefore this functionality was posponed.

The sing-up process and login they both work, but because of the nature of the project (content creator verification) credentials for a verified
content creator will be given. Do know that when registering a new user, a real email needs to be provided, a system with code verification
has been implemented. By default, the registered user will not be a content creator and it's capacities will be reduced.

A backend service was added using AWS Amplify libraries.

Content creator credentials:
username: prueba
password: Prueba123#



An API key is needed for the ehtereum to dollar transformation. It can be obtained from the following website: https://min-api.cryptocompare.com.
Once the api key is obtained, navigate through the ModelMain class, you will find a method called "ethPriceConversionAPI", the line that should be changed
is the following: let url = URL(string: "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=USD&api_key=\(ProcessInfo.processInfo.environment["CRYPTO_EXCHANGE_API_KEY"])")
you can either add a environment variable or add the key as a string manually deleting the "\(ProcessInfo.processInfo.environment["CRYPTO_EXCHANGE_API_KEY"])" part of code.
