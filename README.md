<<<<<<< HEAD
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="Recipe Garage/Assets.xcassets/logo.imageset/logo.png">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Recipe Garage</h3>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
	<li><a href="#problem">Problem</a></li>
    <li><a href="#member">Member</a></li>
    
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This is an iOS app Recipe Garage project, which offering a personalized menu of recipes that use the ingredients you have.

Here are what our App do:
* Enter what ingredients you have, we provide recipes for you.
* Have no idea what to eat, we recommend some special for you.
* Curious about some ingredients you not familiar with, we search them for you.
* Write down what you need for shopping, we recorded for you.



### Built With

Here are what we use in the development of our project
* [Xcode](https://developer.apple.com/xcode/)    iOS Deployment Target: 14.2
* [Firebase](https://firebase.google.com/)
* [Create ML](https://developer.apple.com/documentation/createml)


<!-- GETTING STARTED -->
## Getting Started

How to run our APP.

### Prerequisi

* Download the Xcode.
* iPhone (Since the physical iPhone test we use iPhone7 and iPhone11, it will be good if you test with this two models.)

### Installation

1. Clone the project
   ```sh
   git clone https://github.com/LanJinUC/FoodSearchApp.git
   ```
2. Either could run our APP onto a physical iPhone or iPad device or could use the Xcode Simulator which creates a simulalted iOS device on your Mac.
   
3. For Xcode Simulator
    * Open touristLocation.xcworkspace from the .zip.
    * Go up into the top left corner, click on the app name, and then in the dropdown list, you can select the simulator that you want to use (we use iPhone11, so iPhone11 might be the perfect model to test our app). So the simulator device that you want to run our app on.
    * Hit the play button on the top left corner.

4. For Physical iPhone
    * Check Xcode and iOS versions match.<br>
        -> If you head over to Xcode and go to About Xcode, you should see the version of your Xcode.<br>
        -> So for Xcode version 12.2, you should have a physical device that is running 14.2. Go to your physical device, click the Settings and then General and About, then you can see your Software Version.
    * Add an Apple developer account.<br>
        -> You can simply just use your free Apple ID.<br>
        -> Go into Xcode and click on Preferences. Then here, you should be able to add a Apple ID by clicking on the Add button, select Apple ID. Enter your Apple ID which is usually an e-mail and then your password. Once you've successfully logged in, you should be able to see your app ID show up right here inside.
    * Sign the app.<br>
        -> Back to our project, select the top blue file touristLocation on the left top.<br>
        -> Target selected, and then head over to Signing & Capabilities tab and make sure that the Automatically managed signing checkbox is checked.<br>
        -> Click on the Team dropdown list and then select the account that you've added just now.<br>
        -> Once you've selected your team, all the errors on this page should go away.<br>
        -> But if it does not and you see an error that says Fail to create Provisioning profile, then it might be because you haven't got your device connected using a USB cable. 
    * Connect physical device.<br>
        -> Grab your USB cable and connect your physical device, your iPhone or your iPad to your Mac.
    * Trust yourself.<br>
        -> You might see a pop up show up on your phone which asked you whther if you trust this computer. So go ahead and tap on the Trust button and it might also require you to type in the phone device passkey and follow the on-screen instructions to complete that process.
    * Build and run your app. <br>
        -> Go back to Xcode, click on the top bar here and select your physical phone as the device that you want to run your app onto.<br>
        -> Now you might get a warning here saying something like device iOS version lower than deployment target. You need to update your iPhone to the latest version of iOS(14.2)



<!-- USAGE EXAMPLES -->
## Usage
* Ingredients Identification(The camera icon): Clicking on the camera icon will bring up a new page with an add image button in the middle of the page. You can select a picture from your album or you can take a picture with your phone camera. When you have successfully added an image, the button "Start Analyse!" will appear. By tapping the button, our app will run the machine learning model and give you the ingredient's name. Then, you can click on the returned ingredient name, and our app will search for everything about the ingredient directly in Google for you. We only trained 4 ingredients for now. There is one issue about the web view is: if you click into a recipe website, you can't go back to the google search result but you can go back to the ingredient identification page. 
* Recipe Search: Enter ingredients you already have in the TextField, then click search. Our app will provide recipes for you based on your ingredients. Since we are using RESTful API from othre website as a free user, the website would allow us to query the database too often and will only return 10 recipes as a result. And the HTTP responses are sometimes not complete(because the API provider might not have enough infomation in their database). Therefore, you might encounter a blank page when you click the recipe and want to see the details. The problems can be solved by several ways, we could switch to another website's API or web scraping all the major recipe website and build up our own database or pay for the API we are currently using.
* Today's popular recipes: This is a daily recommentdation funtion. Idealy, it should run a machine learning algorithm to generate top 10 recipes that other users most searched or liked on a daily bases. For now there are only 5 stored testing data. If you click on the picture, the App will lead to the recipe's website.
* Google Search: In the upper left corner of our app, you can more easily do some searches without having to exit the app.
* In addition to the main function of the main page, our app now also has a shopping list function. By clicking on the shopping list icon in the tab bar, you will reach a new page. In this new page, you can enter the items you want to shop for in the TextField and tap the Add button, then your input will be recorded as a list on the page so that you can check the items you need while shopping. Of course, you can edit the list at any time.
* Since our app is not yet fully developed, we have not fully implemented the features in the tab bar.

<!-- Problem -->
## Things need to notice when testing
* Since the API we are using will only allow a limited times of search. We will get warning emails from the API if we "above 80% limit utilization of Hits per minutes: 4/5". We don't know what exactly does that mean, but we guess it's because we click into recipe details page too often. So just a head up, the API account might get banned during the testing(We only got annoying emails when we were testing though).
* In addition, our shopping list & recipe input features are not connected to firebase, so user input will not be recorded after exiting the program.
* Our app is not fully developed, it still has three blank pages to be developed.



<!-- MEMBER -->
## Member

* Lan Jin - lan.jin@ucalgary.ca
* Sijia Yin - sijia.yin@ucalgary.ca

Project Link: [https://github.com/LanJinUC/FoodSearchApp.git](https://github.com/LanJinUC/FoodSearchApp.git)
=======
<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/LanJinUC/FoodSearchApp/blob/main/Recipe%20Garage/Assets.xcassets/logo.imageset/logo.png">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Recipe Garage</h3>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
	<li><a href="#problem">Problem</a></li>
    <li><a href="#member">Member</a></li>
    
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

This is an iOS app Recipe Garage project, which offering a personalized menu of recipes that use the ingredients you have.

Here are what our App do:
* Enter what ingredients you have, we provide recipes for you.
* Have no idea what to eat, we recommend some special for you.
* Curious about some ingredients you not familiar with, we search them for you.
* Write down what you need for shopping, we recorded for you.



### Built With

Here are what we use in the development of our project
* [Xcode](https://developer.apple.com/xcode/)    iOS Deployment Target: 14.2
* [Firebase](https://firebase.google.com/)
* [Create ML](https://developer.apple.com/documentation/createml)


<!-- GETTING STARTED -->
## Getting Started

How to run our APP.

### Prerequisites

* Download the Xcode.
* iPhone (Since the physical iPhone test we use iPhone7 and iPhone11, it will be good if you test with this two models.)

### Installation

1. Clone the project
   ```sh
   git clone https://github.com/LanJinUC/FoodSearchApp.git
   ```
2. Either could run our APP onto a physical iPhone or iPad device or could use the Xcode Simulator which creates a simulalted iOS device on your Mac.
   
3. For Xcode Simulator
    * Open touristLocation.xcworkspace from the .zip.
    * Go up into the top left corner, click on the app name, and then in the dropdown list, you can select the simulator that you want to use (we use iPhone11, so iPhone11 might be the perfect model to test our app). So the simulator device that you want to run our app on.
    * Hit the play button on the top left corner.

4. For Physical iPhone
    * Check Xcode and iOS versions match.<br>
        -> If you head over to Xcode and go to About Xcode, you should see the version of your Xcode.<br>
        -> So for Xcode version 12.2, you should have a physical device that is running 14.2. Go to your physical device, click the Settings and then General and About, then you can see your Software Version.
    * Add an Apple developer account.<br>
        -> You can simply just use your free Apple ID.<br>
        -> Go into Xcode and click on Preferences. Then here, you should be able to add a Apple ID by clicking on the Add button, select Apple ID. Enter your Apple ID which is usually an e-mail and then your password. Once you've successfully logged in, you should be able to see your app ID show up right here inside.
    * Sign the app.<br>
        -> Back to our project, select the top blue file touristLocation on the left top.<br>
        -> Target selected, and then head over to Signing & Capabilities tab and make sure that the Automatically managed signing checkbox is checked.<br>
        -> Click on the Team dropdown list and then select the account that you've added just now.<br>
        -> Once you've selected your team, all the errors on this page should go away.<br>
        -> But if it does not and you see an error that says Fail to create Provisioning profile, then it might be because you haven't got your device connected using a USB cable. 
    * Connect physical device.<br>
        -> Grab your USB cable and connect your physical device, your iPhone or your iPad to your Mac.
    * Trust yourself.<br>
        -> You might see a pop up show up on your phone which asked you whther if you trust this computer. So go ahead and tap on the Trust button and it might also require you to type in the phone device passkey and follow the on-screen instructions to complete that process.
    * Build and run your app. <br>
        -> Go back to Xcode, click on the top bar here and select your physical phone as the device that you want to run your app onto.<br>
        -> Now you might get a warning here saying something like device iOS version lower than deployment target. You need to update your iPhone to the latest version of iOS(14.2)



<!-- USAGE EXAMPLES -->
## Usage

* Once you run our APP, you can see our recommendations for today's special recipe. If you are the one who have no idea what to eat, then our app might give you a good suggestion.
* You can enter what ingredients you have in the TextField, then click search. Our app will provide recipes for you based on your ingredients. 
* If you suddenly forget what you need, there is a quick link to Google in the upper left corner of our app, so you can more easily do some searches without having to exit the app.
* So in the top right corner of our app there is a camera icon and that's where we apply machine learning to our app. Clicking on the camera icon will bring up a new page with an add image button in the middle of the page. By clicking the button, you can select a picture from your album or you can also take a picture with your phone camera. When you have successfully added an image, the button Recognition This Ingredient will appear. By tapping the button, our app will recognize the ingredient's name for you. Of course, you can also click on the ingredient name, and our app will search for everything about the ingredient directly in Google for you.
* Since our app is not yet fully developed, we have not fully implemented the features in the tab bar. In addition to the main function of the main page, our app now also has a shopping list function. By clicking on the shopping list icon in the tab bar, you will reach a new page. In this new page, you can enter the items you want to shop for in the TextField and tap the Add button, then your input will be recorded as a list on the page so that you can check the items you need while shopping. Of course, you can edit the list at any time.

<!-- Problem -->
## Problem
* When you test our app, you'll notice that some recipes leave a blank page when you click on them. But this is not a problem with our program, it's because the URL returned by our API is empty.
* Please also do not test the recipes with multiple clicks, as the API we found has a limited number of uses. It is now beyond what we can use. So we will keep getting warning emails from the API.
* In addition, our shopping list feature is not connected to firebase, so user input will not be recorded after exiting the program.
* Our app is not fully developed, it still has three blank pages to be developed and hopefully we will be able to improve it even more in the future.
* In subsequent development, we will store the machine learning content in a local database so that users can search for ingredients without having to connect to the network, and we will present details for all ingredients.


<!-- MEMBER -->
## Member

* Lan Jin - lan.jin@ucalgary.ca
* Sijia Yin - sijia.yin@ucalgary.ca

Project Link: [https://github.com/LanJinUC/FoodSearchApp.git](https://github.com/LanJinUC/FoodSearchApp.git)
>>>>>>> 3bb63ccf002bdb51cf4d2ec024585a345792d106
