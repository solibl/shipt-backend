# Shipt-api backend App for Dev Take Home Project

## Installation Instructions

After unziping the folder with both the front-end and backend applications, you will need to install the gems/dependencies using the code below:

```
bundle install 
```

The next step would be to create the databases. This application uses Postgresql as it's database.

```
rails db:create
rails db:migrate
rails db:seed
```

There is a seed file that will generate some data that you can use for this application. 

Since the Shipt-frontend app will use the port 3000, you will need to set this rails server at port 3001 using the following command:

```
rails s -p 3001
```

This will setup the backend server that the frontend can use it's API end points to get data from our database.

There are also instructions in the Shipt-Frontend directory on how to access the app from the frontend with a username and password. These two can be found in the Readme file as well.

## Assumptions/Improvements

There were a few assumptions that I have made during the creation of this application. Through the stories I have made some associations where categories and products have a one to many relationship. A customer will have a one to many relationship with an order. The assumption for an order is to have a many to many relationship with products that I have generated a joins table for. An order also has a one to many association to a status. Story 5 was the biggest assumption that I have made. Since this is a very basic app, the assumption I have made is that the to make an order you need to have an account. However to view the search history page, I believe that it was very close to a "most popular" page where the user can query things that have been purchased during the time selected. This can also be viewed as an admin feature which I assumed is useful on both ends. 

There are many improvements that I would make. Since being under a time limit, I would have made tests / followed more of a TDD approach. I also did not get to implement the purchase by weight feature. The plan that I had before I ran out of time would have been to assume that each product has a specific weight attribute to it. I would have made a function to calculate how much quantity that the product can be bought by the user's weight input. 

## Additional Questions

> We want to give customers the ability to create lists of products for one-click ordering of bulk items. How would you design the tables, what are the pros and cons of your approach?

The first thing that I have thought of would be to create a list table that has a unique set of products per list. There would be a many to many association as the assumption can be made the a product can be in mulitple lists. The pros that I can think of with this approach would be that it would almost coincide with the current setup that I have made for this application. Since we are using rails, associations can be made to create sql queries that are made easier to find with ActiveRecord. A couple cons to this approach however is that there will be a lot of data storing to create each lists, if there is no limit of products. Also with the ordering, there may be some confusion with a products id through the already made joins table with the list table that has the products in it already. 

> If Shipt knew exact inventory of stores, and when facing a high traffic and limited supply of particular item, how do you distribute the inventory among customers checking out?

I believe the concept of threading will work best in this case. In order to have an asynchronous timing of when orders are made, we will have to have workers in the background taking care of the orders instead of making a form submission that I have implemented in this application. If however that the time for 2 users were exactly the same as the inventory was down to only one product. There are a couple of ways that I would think about handling this. The most obvious but hardest way is to contact the store to increase the inventory before we sell the last item. Since that is not the most suitable option as there is a limited supply of the item, another solution can be a customer loyalty feature. Either there can be a rewards program that gives users points when they purchase items that they can use to jump up in the que of the potential buyer of the last item. The 2nd option would be to calculate the user that has been with the company for the longest to give him/her priority. This may cause some conflicts however as we wouldn't want to have favoritism to certain customers.
