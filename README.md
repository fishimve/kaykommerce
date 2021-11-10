# kaykommerce
An eCommerce app using ASOS.com API.

## Requirements
- Make sure you have Flutter SDK 2.12.0 and over
- Add your ASOS RapidApi key to lib/services/ApiService class
- Create a [Firebase](https://firebase.google.com/docs/flutter/setup?platform=android) project and add an Android/iOS app
- Download the configuration file containing keys and identifiers for your app add then to your app. [Follow instructions](https://firebase.google.com/docs/flutter/setup?platform=android)


## Demo
- Every app user(client) login anonymously to Firebase and he is given an id
- This id is used to store cart and orders data
- The main screen shows all ASOS brand categories and subcategories given by the API
  ![Brand Categories Screen](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158368.png)
- Clicking on the brand category opens its subcategories
  ![Brand sub categories expanded](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158378.png)
- Clicking on a subcategory opens a list of products inside a category. You can modify the params in lib/services/ApiService class for other queries
  ![Billabong category products](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158408.png)
  ![Casio category products](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158418.png)
  ![Fred Perry category products](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158428.png)
  ![Lamoda category products](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158438.png)
- Clicking on the cart icon adds the product to the cart. Clicking twice increments the quantity of product in the cart
  ![Add to cart](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158553.png)
  ![Add to cart](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158573.png)
- Clicking on the product opens the product details screen
  ![product details](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158441.png)
  ![product details](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158462.png)
  ![product details](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158509.png)
  ![product details](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158533.png)
- Go back, and go to Cart screen and place an order. Go back and repeat the process
  ![Cart products](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158577.png)
  ![Remove from cart](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158585.png)
  ![Confirm remove](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158591.png)
  ![Updated cart product](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158594.png)
- Go to the Orders screen to see order history and details
  ![Orders Screen](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158602.png)
  ![Orders Screen details](https://github.com/fishimve/kaykommerce/blob/635ab56551d5e9202cf45740a05c854a35ce390c/demo/Screenshot_1629158611.png)
